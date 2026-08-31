import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { Database } from '@/types/database'

export const revalidate = 3600 // Cache for 1 hour (SSG/ISR)

interface Props {
  params: Promise<{ subjectSlug: string; topicSlug: string }>
}

async function getPublicTopicData(subjectSlug: string, topicSlug: string) {
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

  // Fetch subject
  const { data: subject } = await supabase
    .from('subjects')
    .select('*, education_levels(name, phase)')
    .eq('slug', subjectSlug)
    .single()

  if (!subject) return null

  // Fetch topic
  const { data: topic } = await supabase
    .from('topics')
    .select('*, elements(name, description)')
    .eq('slug', topicSlug)
    .single()

  if (!topic) return null

  // Fetch sample preview questions (3 questions)
  const { data: sampleQuestions } = await supabase
    .from('questions')
    .select('*')
    .eq('topic_id', topic.id)
    .limit(3)

  return {
    subject,
    topic,
    sampleQuestions: sampleQuestions || [],
  }
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subjectSlug, topicSlug } = await params
  const data = await getPublicTopicData(subjectSlug, topicSlug)

  if (!data) {
    return {
      title: 'Materi Tidak Ditemukan',
    }
  }

  const { subject, topic } = data
  const levelName = (subject.education_levels as any)?.name || 'SD Kelas 1'

  const title = `Soal ${topic.name} — ${subject.name} ${levelName} Kurikulum Merdeka`
  const description = `Latihan soal gratis dan pembahasan materi ${topic.name} untuk ${subject.name} ${levelName} (Kurikulum Merdeka). Siapkan anak menjadi lebih berprestasi.`

  return {
    title,
    description,
    keywords: [
      `soal ${topic.name}`,
      `latihan ${subject.name} kelas 1`,
      `kurikulum merdeka ${levelName}`,
      topic.name,
      subject.name,
    ],
    openGraph: {
      title,
      description,
      type: 'article',
      url: `https://naiklevel.id/materi/${subjectSlug}/${topicSlug}`,
    },
    alternates: {
      canonical: `https://naiklevel.id/materi/${subjectSlug}/${topicSlug}`,
    },
  }
}

export default async function PublicTopicPage({ params }: Props) {
  const { subjectSlug, topicSlug } = await params
  const data = await getPublicTopicData(subjectSlug, topicSlug)

  if (!data) {
    notFound()
  }

  const { subject, topic, sampleQuestions } = data
  const levelName = (subject.education_levels as any)?.name || 'SD Kelas 1'
  const elementName = (topic.elements as any)?.name || 'Elemen Kurikulum'

  // JSON-LD Structured Data
  const jsonLd = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'BreadcrumbList',
        'itemListElement': [
          { '@type': 'ListItem', 'position': 1, 'name': 'Beranda', 'item': 'https://naiklevel.id' },
          { '@type': 'ListItem', 'position': 2, 'name': subject.name, 'item': `https://naiklevel.id/materi/${subjectSlug}` },
          { '@type': 'ListItem', 'position': 3, 'name': topic.name, 'item': `https://naiklevel.id/materi/${subjectSlug}/${topicSlug}` },
        ],
      },
      {
        '@type': 'LearningResource',
        'name': `Latihan Soal ${topic.name}`,
        'description': `Materi dan latihan soal ${topic.name} (${subject.name} ${levelName})`,
        'educationalLevel': levelName,
        'learningResourceType': 'Practice Problem',
        'inLanguage': 'id',
      },
    ],
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* Navigation Bar */}
      <header className="header">
        <div className="container flex justify-between items-center">
          <Link href="/">
            <div className="logo-text">
              <span className="logo-naik">Naik</span>
              <span className="logo-level">Level</span>
            </div>
          </Link>
          <div className="flex gap-4">
            <Link href="/masuk" className="btn btn-outline text-sm">
              Masuk
            </Link>
            <Link href="/daftar" className="btn btn-primary text-sm">
              Mulai Belajar Gratis
            </Link>
          </div>
        </div>
      </header>

      {/* Topic Hero Header */}
      <div style={{ background: 'linear-gradient(135deg, #0284c7 0%, #0369a1 100%)', color: 'white', padding: '48px 0' }}>
        <div className="container">
          <div style={{ fontSize: '13px', fontWeight: '700', textTransform: 'uppercase', opacity: 0.9, marginBottom: '8px' }}>
            {levelName} • {subject.name} • Elemen: {elementName}
          </div>
          <h1 style={{ fontSize: '32px', fontWeight: '900', marginBottom: '12px' }}>
            {topic.name}
          </h1>
          <p style={{ fontSize: '16px', opacity: 0.95, maxWidth: '700px' }}>
            Kumpulan soal latihan adaptif dan pembahasan lengkap sesuai Capaian Pembelajaran Kurikulum Merdeka.
          </p>
        </div>
      </div>

      <div className="container py-12" style={{ maxWidth: '850px', margin: '0 auto' }}>
        {/* Call to Action Box */}
        <div
          style={{
            backgroundColor: '#f0fdf4',
            border: '2px solid #bbf7d0',
            borderRadius: '16px',
            padding: '24px',
            marginBottom: '36px',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            flexWrap: 'wrap',
            gap: '16px',
          }}
        >
          <div>
            <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#15803d', margin: 0 }}>
              Siap Mengerjakan Kuis Interaktif?
            </h3>
            <p style={{ fontSize: '14px', color: '#166534', margin: '4px 0 0 0' }}>
              Dapatkan skor instan, XP prestasi, dan laporan penguasaan elemen untuk anak Anda.
            </p>
          </div>
          <Link href={`/belajar/${subjectSlug}/${topicSlug}`} className="btn btn-primary">
            Mulai Kuis Sekarang 🚀
          </Link>
        </div>

        {/* Sample Preview Questions Showcase */}
        <div style={{ marginBottom: '40px' }}>
          <h2 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
            👀 Contoh Soal & Pembahasan ({topic.name})
          </h2>

          {sampleQuestions.length === 0 ? (
            <p style={{ color: '#64748b' }}>Soal sedang disiapkan oleh tim kurikulum.</p>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
              {sampleQuestions.map((q, idx) => {
                const options = (q.options as any) || []
                return (
                  <div
                    key={q.id}
                    style={{
                      backgroundColor: 'white',
                      borderRadius: '16px',
                      padding: '24px',
                      border: '1px solid #e2e8f0',
                      boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
                    }}
                  >
                    <div style={{ fontSize: '13px', fontWeight: '700', color: '#0284c7', marginBottom: '8px' }}>
                      Soal #{idx + 1}
                    </div>
                    <h3 style={{ fontSize: '17px', fontWeight: '700', color: '#0f172a', marginBottom: '16px' }}>
                      {q.question_text}
                    </h3>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginBottom: '16px' }}>
                      {options.map((opt: any) => (
                        <div
                          key={opt.id}
                          style={{
                            padding: '10px 14px',
                            backgroundColor: '#f8fafc',
                            borderRadius: '8px',
                            fontSize: '14px',
                            color: '#334155',
                          }}
                        >
                          {opt.id.toUpperCase().replace('OPT_', '')}. {opt.text}
                        </div>
                      ))}
                    </div>
                    {q.explanation && (
                      <div style={{ backgroundColor: '#f0fdf4', padding: '12px 16px', borderRadius: '8px', fontSize: '13px', color: '#166534' }}>
                        💡 <strong>Pembahasan:</strong> {q.explanation}
                      </div>
                    )}
                  </div>
                )
              })}
            </div>
          )}
        </div>
      </div>
    </>
  )
}
