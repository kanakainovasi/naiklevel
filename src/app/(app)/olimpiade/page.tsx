import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getOlympiadData() {
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

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/masuk')
  }

  // Get olympiad questions
  const { data: rawOlympiadQuestions } = await supabase
    .from('questions')
    .select('id, topic_id, xp_reward')
    .eq('question_type', 'olympiad')

  const { data: topics } = await supabase.from('topics').select('id, name, slug')

  const olympiadQuestions = (rawOlympiadQuestions || []).map((q) => {
    const topic = topics?.find((t) => t.id === q.topic_id)
    return {
      ...q,
      topicName: topic?.name || 'Olimpiade Umum',
      topicSlug: topic?.slug || '',
    }
  })

  return {
    olympiadQuestions,
  }
}

export default async function OlympiadPage() {
  const { olympiadQuestions } = await getOlympiadData()

  return (
    <div className="container py-8" style={{ maxWidth: '800px', margin: '0 auto', padding: '24px 16px' }}>
      <Link
        href="/beranda"
        style={{
          display: 'inline-flex',
          alignItems: 'center',
          gap: '6px',
          color: '#64748b',
          textDecoration: 'none',
          fontSize: '14px',
          fontWeight: '600',
          marginBottom: '20px',
        }}
      >
        ← Kembali ke Beranda
      </Link>

      <div
        style={{
          background: 'linear-gradient(135deg, #d97706 0%, #f59e0b 100%)',
          borderRadius: '20px',
          padding: '28px',
          color: 'white',
          boxShadow: '0 10px 25px -5px rgba(217,119,6,0.3)',
          marginBottom: '32px',
        }}
      >
        <div style={{ fontSize: '48px', marginBottom: '12px' }}>🏆</div>
        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0 0 8px 0' }}>
          Tantangan Soal Olimpiade (OSN)
        </h1>
        <p style={{ margin: 0, opacity: 0.95, fontSize: '15px', lineHeight: '1.5' }}>
          Uji kecepatan berpikir analitis dengan timer berwaktu! Dapatkan XP 2.5x lebih besar dan lencana kebanggaan.
        </p>
      </div>

      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
        🔥 Daftar Tantangan Olimpiade Aktif
      </h2>

      {olympiadQuestions.length === 0 ? (
        <div style={{ backgroundColor: 'white', padding: '40px', borderRadius: '16px', textAlign: 'center', color: '#94a3b8' }}>
          Belum ada tantangan olimpiade aktif saat ini. Admin akan menambahkan soal olimpiade baru.
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
          {olympiadQuestions.map((q: any) => (
            <div
              key={q.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '14px',
                padding: '20px',
                border: '1px solid #fef3c7',
                boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
              }}
            >
              <div>
                <div style={{ fontSize: '12px', fontWeight: '700', color: '#d97706', textTransform: 'uppercase', marginBottom: '4px' }}>
                  Topik: {q.topicName}
                </div>
                <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
                  Tantangan Olimpiade Berwaktu
                </h3>
              </div>

              <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                <span style={{ fontSize: '14px', fontWeight: '800', color: '#16a34a' }}>
                  +{q.xp_reward || 25} XP
                </span>
                <span style={{ padding: '8px 16px', backgroundColor: '#d97706', color: 'white', borderRadius: '8px', fontSize: '13px', fontWeight: '700' }}>
                  Mulai ⏱️
                </span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
