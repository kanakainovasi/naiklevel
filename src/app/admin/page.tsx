import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { Database } from '@/types/database'

export const revalidate = 0

async function getAdminStats() {
  const cookieStore = await cookies()
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

  const supabase = createServerClient<Database>(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll() {},
      },
    }
  )

  // Fetch counts in parallel
  const [
    { count: pageViewsCount },
    { count: parentsCount },
    { count: childrenCount },
    { count: sessionsCount },
    { count: questionsCount },
    { count: unvalidatedQuestionsCount },
  ] = await Promise.all([
    supabase.from('page_views').select('*', { count: 'exact', head: true }),
    supabase.from('parents').select('*', { count: 'exact', head: true }),
    supabase.from('children').select('*', { count: 'exact', head: true }),
    supabase.from('quiz_sessions').select('*', { count: 'exact', head: true }),
    supabase.from('questions').select('*', { count: 'exact', head: true }),
    supabase.from('questions').select('*', { count: 'exact', head: true }).eq('needs_curriculum_validation', true),
  ])

  // Fetch recent pageviews for traffic table
  const { data: recentPageViews } = await supabase
    .from('page_views')
    .select('*')
    .order('created_at', { ascending: false })
    .limit(10)

  // Fetch top topics with question count
  const { data: topTopics } = await supabase
    .from('topics')
    .select('id, name, slug')
    .limit(5)

  return {
    pageViewsCount: pageViewsCount || 0,
    parentsCount: parentsCount || 0,
    childrenCount: childrenCount || 0,
    sessionsCount: sessionsCount || 0,
    questionsCount: questionsCount || 0,
    unvalidatedQuestionsCount: unvalidatedQuestionsCount || 0,
    recentPageViews: recentPageViews || [],
    topTopics: topTopics || [],
  }
}

export default async function AdminDashboardPage() {
  const stats = await getAdminStats()

  return (
    <div>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px', marginBottom: '28px' }}>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            📊 Analitik Traffic & Status Platform
          </h1>
          <p style={{ color: '#64748b', marginTop: '6px', fontSize: '15px' }}>
            Pantau statistik aktivitas pengunjung, progres pembuatan soal, dan metrik aplikasi Naik Level.
          </p>
        </div>

        <div style={{ display: 'flex', gap: '12px' }}>
          <Link
            href="/admin/soal"
            style={{
              padding: '10px 18px',
              backgroundColor: '#0284c7',
              color: 'white',
              borderRadius: '10px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: '700',
            }}
          >
            📝 Kelola & Tambah/Hapus Soal
          </Link>

          <Link
            href="/admin/feedback"
            style={{
              padding: '10px 18px',
              backgroundColor: '#059669',
              color: 'white',
              borderRadius: '10px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: '700',
            }}
          >
            📩 Inbox Saran & Komplain
          </Link>
        </div>
      </div>

      {/* Grid Stat Cards */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
          gap: '20px',
          marginBottom: '32px',
        }}
      >
        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            👁️ Total Visitor Traffic
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#0284c7', marginTop: '8px' }}>
            {stats.pageViewsCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Pageviews tercatat</div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            👨‍👩‍👧 Total Akun Ortu
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#16a34a', marginTop: '8px' }}>
            {stats.parentsCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Orang tua terdaftar</div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            👧 Total Profil Anak
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#9333ea', marginTop: '8px' }}>
            {stats.childrenCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Profil anak aktif</div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            🎯 Sesi Kuis Dikerjakan
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#ea580c', marginTop: '8px' }}>
            {stats.sessionsCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Kuis & Olimpiade</div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            📝 Total Bank Soal
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#0f172a', marginTop: '8px' }}>
            {stats.questionsCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Soal terinput</div>
        </div>

        <div style={{ backgroundColor: 'white', padding: '20px', borderRadius: '12px', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div style={{ fontSize: '13px', fontWeight: '600', color: '#64748b', textTransform: 'uppercase' }}>
            ⚠️ Perlu Validasi Kurikulum
          </div>
          <div style={{ fontSize: '32px', fontWeight: '800', color: '#dc2626', marginTop: '8px' }}>
            {stats.unvalidatedQuestionsCount}
          </div>
          <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>Draft AI perlu direview</div>
        </div>
      </div>

      {/* Traffic Log & Quick Actions */}
      <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '24px' }}>
        {/* Recent Traffic */}
        <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '12px', border: '1px solid #e2e8f0' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
            <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
              📈 Log Kunjungan Terbaru
            </h3>
            <span style={{ fontSize: '12px', color: '#64748b' }}>Real-time updates</span>
          </div>

          {stats.recentPageViews.length === 0 ? (
            <div style={{ color: '#94a3b8', textAlign: 'center', padding: '32px 0', fontSize: '14px' }}>
              Belum ada traffic tercatat. Buka halaman web untuk mencatat kunjungan.
            </div>
          ) : (
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '14px' }}>
              <thead>
                <tr style={{ borderBottom: '2px solid #f1f5f9', textAlign: 'left' }}>
                  <th style={{ padding: '10px', color: '#475569' }}>Waktu</th>
                  <th style={{ padding: '10px', color: '#475569' }}>Halaman Path</th>
                  <th style={{ padding: '10px', color: '#475569' }}>Referrer</th>
                </tr>
              </thead>
              <tbody>
                {stats.recentPageViews.map((pv) => (
                  <tr key={pv.id} style={{ borderBottom: '1px solid #f1f5f9' }}>
                    <td style={{ padding: '10px', color: '#64748b', fontSize: '13px', whiteSpace: 'nowrap' }}>
                      {pv.created_at ? new Date(pv.created_at).toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit', second: '2-digit' }) : '-'}
                    </td>
                    <td style={{ padding: '10px', fontWeight: '600', color: '#0284c7' }}>
                      {pv.path}
                    </td>
                    <td style={{ padding: '10px', color: '#94a3b8', fontSize: '12px', maxWidth: '200px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                      {pv.referrer || 'Direct / Bookmark'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>

        {/* Quick Management Panel */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
          <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '12px', border: '1px solid #e2e8f0' }}>
            <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#0f172a', marginBottom: '16px' }}>
              ⚡ Aksi Cepat CMS
            </h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
              <Link
                href="/admin/soal"
                style={{
                  display: 'block',
                  textAlign: 'center',
                  padding: '12px',
                  backgroundColor: '#0284c7',
                  color: 'white',
                  borderRadius: '8px',
                  textDecoration: 'none',
                  fontWeight: '600',
                  fontSize: '14px',
                }}
              >
                ➕ Tambah / Edit Soal Manual
              </Link>
              <Link
                href="/admin/kurikulum"
                style={{
                  display: 'block',
                  textAlign: 'center',
                  padding: '12px',
                  backgroundColor: '#0f172a',
                  color: 'white',
                  borderRadius: '8px',
                  textDecoration: 'none',
                  fontWeight: '600',
                  fontSize: '14px',
                }}
              >
                📚 Kelola Elemen Kurikulum
              </Link>
              <Link
                href="/admin/badges"
                style={{
                  display: 'block',
                  textAlign: 'center',
                  padding: '12px',
                  backgroundColor: '#f59e0b',
                  color: 'white',
                  borderRadius: '8px',
                  textDecoration: 'none',
                  fontWeight: '600',
                  fontSize: '14px',
                }}
              >
                🏆 Kelola Lencana
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
