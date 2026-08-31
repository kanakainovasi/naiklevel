import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getAdminFeedbackData() {
  const cookieStore = await cookies()
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

  const supabase = createServerClient<Database>(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll()
      },
      setAll() {},
    },
  })

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/masuk')
  }

  // Verify admin role
  const { data: parent } = await supabase
    .from('parents')
    .select('role')
    .eq('id', user.id)
    .single()

  if (parent?.role !== 'admin') {
    redirect('/beranda')
  }

  // Fetch feedback inbox
  const { data: feedbackList } = await supabase
    .from('user_feedback')
    .select('*')
    .order('created_at', { ascending: false })

  // Metrics
  const { count: parentCount } = await supabase.from('parents').select('*', { count: 'exact', head: true })
  const { count: childCount } = await supabase.from('children').select('*', { count: 'exact', head: true })
  const { count: sessionCount } = await supabase.from('quiz_sessions').select('*', { count: 'exact', head: true })

  return {
    feedbackList: feedbackList || [],
    metrics: {
      totalParents: parentCount || 0,
      totalChildren: childCount || 0,
      totalSessions: sessionCount || 0,
      targetPaidThreshold: 500, // Threshold target 500-1000 users before activating paid tier
    },
  }
}

export default async function AdminFeedbackPage() {
  const { feedbackList, metrics } = await getAdminFeedbackData()

  return (
    <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '24px 16px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            📬 Admin CMS — Inbox Saran & Komplain
          </h1>
          <p style={{ color: '#64748b', fontSize: '14px', marginTop: '4px' }}>
            Pantau masukan pengguna, statistik trafik, dan progres pengguna baru.
          </p>
        </div>
        <Link
          href="/admin"
          style={{
            padding: '10px 18px',
            backgroundColor: '#0f172a',
            color: 'white',
            borderRadius: '10px',
            textDecoration: 'none',
            fontSize: '14px',
            fontWeight: '700',
          }}
        >
          ← Dashboard Admin CMS
        </Link>
      </div>

      {/* Traffic & User Threshold Metrics */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '16px', marginBottom: '32px' }}>
        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
          <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>TOTAL AKUN ORANG TUA</div>
          <div style={{ fontSize: '28px', fontWeight: '800', color: '#0284c7', marginTop: '4px' }}>
            {metrics.totalParents} <span style={{ fontSize: '14px', fontWeight: '500', color: '#94a3b8' }}>/ {metrics.targetPaidThreshold} Target</span>
          </div>
          <div style={{ fontSize: '11px', color: '#64748b', marginTop: '4px' }}>
            Target 500-1000 user baru sebelum mengaktifkan tier berbayar
          </div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
          <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>TOTAL PROFIL ANAK</div>
          <div style={{ fontSize: '28px', fontWeight: '800', color: '#16a34a', marginTop: '4px' }}>
            {metrics.totalChildren}
          </div>
          <div style={{ fontSize: '11px', color: '#64748b', marginTop: '4px' }}>
            Siswa aktif belajar TK - SD
          </div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
          <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>TOTAL PENGERJAAN KUIS</div>
          <div style={{ fontSize: '28px', fontWeight: '800', color: '#d97706', marginTop: '4px' }}>
            {metrics.totalSessions}
          </div>
          <div style={{ fontSize: '11px', color: '#64748b', marginTop: '4px' }}>
            Sesi latihan & olimpiade selesai
          </div>
        </div>
      </div>

      {/* Feedback List */}
      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
        📩 Pesan Masuk Dari User ({feedbackList.length})
      </h2>

      {feedbackList.length === 0 ? (
        <div style={{ backgroundColor: 'white', padding: '40px', borderRadius: '16px', textAlign: 'center', color: '#94a3b8' }}>
          Belum ada saran atau komplain dari pengguna saat ini.
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
          {feedbackList.map((item: any) => (
            <div
              key={item.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '14px',
                padding: '20px',
                border: '1px solid #e2e8f0',
                boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
              }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                <span
                  style={{
                    padding: '3px 10px',
                    borderRadius: '8px',
                    fontSize: '11px',
                    fontWeight: '700',
                    textTransform: 'uppercase',
                    backgroundColor: item.category === 'komplain' ? '#fee2e2' : item.category === 'saran' ? '#e0f2fe' : '#fef3c7',
                    color: item.category === 'komplain' ? '#b91c1c' : item.category === 'saran' ? '#0369a1' : '#b45309',
                  }}
                >
                  {item.category}
                </span>
                <span style={{ fontSize: '12px', color: '#94a3b8' }}>
                  {new Date(item.created_at || '').toLocaleDateString('id-ID')}
                </span>
              </div>
              <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: '0 0 6px 0' }}>
                {item.subject}
              </h3>
              <p style={{ fontSize: '14px', color: '#475569', margin: 0, lineHeight: '1.5' }}>
                {item.message}
              </p>
              {item.contact_email && (
                <div style={{ fontSize: '12px', color: '#0284c7', marginTop: '8px', fontWeight: '600' }}>
                  📧 Kontak: {item.contact_email}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
