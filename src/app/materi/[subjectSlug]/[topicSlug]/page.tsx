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

  // Fetch topic
  const { data: topic } = await supabase
    .from('topics')
    .select('*, elements(name, description)')
    .eq('slug', topicSlug)
    .single()

  // Fetch sample preview questions (3 questions)
  let sampleQuestionsData: any[] = []
  if (topic) {
    const { data: sampleQuestions } = await supabase
      .from('questions')
      .select('*')
      .eq('topic_id', topic.id)
      .limit(3)
    sampleQuestionsData = sampleQuestions || []
  }

  // Format fallbacks if database record not found or unseeded
  let finalSubject: any = subject
  if (!finalSubject) {
    const formattedSubjectName = subjectSlug
      .split('-')
      .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ')

    finalSubject = {
      id: 'fallback-subject-id',
      education_level_id: 'sd1-id',
      name: formattedSubjectName || 'Matematika',
      official_name: formattedSubjectName || 'Matematika SD Kelas 1',
      slug: subjectSlug,
      icon: '🔢',
      description: 'Latihan soal dan pembahasan Kurikulum Merdeka',
      order_index: 1,
      education_levels: { name: 'SD Kelas 1', phase: 'A' },
    }
  }

  let finalTopic: any = topic
  if (!finalTopic) {
    const formattedTopicName = topicSlug
      .split('-')
      .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ')

    finalTopic = {
      id: 'fallback-topic-id',
      element_id: 'elem-1',
      name: formattedTopicName || 'Bilangan Cacah sampai 20',
      slug: topicSlug,
      description: 'Mengenal konsep bilangan, urutan angka, dan menghitung jumlah benda.',
      order_index: 1,
      is_published: true,
      elements: { name: 'Bilangan & Aljabar Dasar', description: 'Elemen capaian pembelajaran bilangan cacah' },
    }
  }

  if (sampleQuestionsData.length === 0) {
    sampleQuestionsData = [
      {
        id: 'fallback-q1',
        topic_id: finalTopic.id,
        question_type: 'regular',
        content_type: 'multiple_choice',
        question_text: 'Berapakah jumlah apel jika 3 apel ditambah 4 apel?',
        options: [
          { id: 'opt_1', text: '6 Apel' },
          { id: 'opt_2', text: '7 Apel' },
          { id: 'opt_3', text: '8 Apel' },
        ],
        correct_answer: { option_id: 'opt_2' },
        explanation: '3 ditambah 4 sama dengan 7 (3 + 4 = 7).',
        difficulty: 1,
        xp_reward: 10,
        time_limit_seconds: null,
        needs_curriculum_validation: false,
        order_index: 1,
        created_at: new Date().toISOString(),
      },
      {
        id: 'fallback-q2',
        topic_id: finalTopic.id,
        question_type: 'regular',
        content_type: 'multiple_choice',
        question_text: 'Urutan bilangan dari yang terkecil di bawah ini adalah...',
        options: [
          { id: 'opt_1', text: '5, 3, 8' },
          { id: 'opt_2', text: '3, 5, 8' },
          { id: 'opt_3', text: '8, 5, 3' },
        ],
        correct_answer: { option_id: 'opt_2' },
        explanation: 'Urutan dari terkecil: 3, lalu 5, lalu 8.',
        difficulty: 1,
        xp_reward: 10,
        time_limit_seconds: null,
        needs_curriculum_validation: false,
        order_index: 2,
        created_at: new Date().toISOString(),
      },
    ]
  }

  return {
    subject: finalSubject,
    topic: finalTopic,
    sampleQuestions: sampleQuestionsData,
  }
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { subjectSlug, topicSlug } = await params
  const data = await getPublicTopicData(subjectSlug, topicSlug)

  const subject = data.subject
  const topic = data.topic
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

  const subject = data.subject
  const topic = data.topic
  const sampleQuestions = data.sampleQuestions

  const levelName = (subject.education_levels as any)?.name || 'SD Kelas 1'
  const elementName = (topic.elements as any)?.name || 'Domain Utama'

  // Schema.org Structured Data (LearningResource & Course & BreadcrumbList)
  const jsonLd = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'BreadcrumbList',
        'itemListElement': [
          { '@type': 'ListItem', 'position': 1, 'name': 'Beranda', 'item': 'https://naiklevel.id' },
          { '@type': 'ListItem', 'position': 2, 'name': subject.name, 'item': `https://naiklevel.id/belajar/${subject.slug}` },
          { '@type': 'ListItem', 'position': 3, 'name': topic.name, 'item': `https://naiklevel.id/materi/${subject.slug}/${topic.slug}` },
        ],
      },
      {
        '@type': 'LearningResource',
        'name': `Materi & Soal ${topic.name}`,
        'description': topic.description || `Materi latihan ${topic.name} untuk ${subject.name} ${levelName}`,
        'learningResourceType': 'Practice Quiz',
        'educationalLevel': levelName,
        'inLanguage': 'id',
        'isAccessibleForFree': true,
        'provider': {
          '@type': 'Organization',
          'name': 'Naik Level',
          'url': 'https://naiklevel.id',
        },
      },
    ],
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* Header Navigation */}
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
              Daftar Gratis
            </Link>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <div style={{ backgroundColor: '#f0f9ff', padding: '40px 0', borderBottom: '1px solid #e0f2fe' }}>
        <div className="container" style={{ maxWidth: '800px' }}>
          <div style={{ fontSize: '13px', color: '#0284c7', fontWeight: '700', marginBottom: '8px' }}>
            📚 {subject.name} • {levelName} ({elementName})
          </div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: '0 0 12px 0' }}>
            {topic.name}
          </h1>
          <p style={{ fontSize: '15px', color: '#475569', margin: 0 }}>
            {topic.description || `Latihan soal interaktif Kurikulum Merdeka untuk topik ${topic.name}.`}
          </p>
        </div>
      </div>

      <div className="container py-8" style={{ maxWidth: '800px', margin: '0 auto' }}>
        {/* Sample Question Preview Card */}
        <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '24px', border: '1px solid #e2e8f0', marginBottom: '32px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
            <h2 style={{ fontSize: '18px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
              📝 Contoh Soal Latihan
            </h2>
            <span className="btn btn-outline text-xs" style={{ pointerEvents: 'none' }}>
              Mode Pratinjau
            </span>
          </div>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
            {sampleQuestions.map((q: any, idx: number) => {
              const options = (q.options as any) || []
              return (
                <div key={q.id} style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px', border: '1px solid #cbd5e1' }}>
                  <div style={{ fontSize: '14px', fontWeight: '700', color: '#0f172a', marginBottom: '12px' }}>
                    {idx + 1}. {q.question_text}
                  </div>

                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '8px', marginBottom: '12px' }}>
                    {options.map((opt: any) => (
                      <div
                        key={opt.id}
                        style={{
                          backgroundColor: 'white',
                          padding: '10px 14px',
                          borderRadius: '8px',
                          border: '1px solid #e2e8f0',
                          fontSize: '13px',
                          color: '#334155',
                        }}
                      >
                        {opt.text}
                      </div>
                    ))}
                  </div>

                  {q.explanation && (
                    <div style={{ fontSize: '12px', color: '#0284c7', backgroundColor: '#e0f2fe', padding: '8px 12px', borderRadius: '6px' }}>
                      💡 <strong>Pembahasan:</strong> {q.explanation}
                    </div>
                  )}
                </div>
              )
            })}
          </div>
        </div>

        {/* CTA Box */}
        <div style={{ backgroundColor: '#eff6ff', border: '2px solid #bfdbfe', borderRadius: '16px', padding: '32px', textAlign: 'center' }}>
          <h3 style={{ fontSize: '20px', fontWeight: '800', color: '#1e40af', margin: '0 0 8px 0' }}>
            Ingin Mengerjakan Kuis Interaktif & Dapatkan Skor XP?
          </h3>
          <p style={{ fontSize: '14px', color: '#1e3a8a', marginBottom: '20px' }}>
            Daftarkan anak Anda secara gratis untuk mendapatkan akses ke ribuan soal kuis Kurikulum Merdeka, Raport Bayangan, dan Latihan Olimpiade OSN.
          </p>
          <Link href="/daftar" className="btn btn-primary text-lg">
            Daftar Akun Belajar Gratis 🚀
          </Link>
        </div>
      </div>
    </>
  )
}
