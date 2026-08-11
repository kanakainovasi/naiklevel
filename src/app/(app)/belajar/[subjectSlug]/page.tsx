import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { notFound, redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

interface Props {
  params: Promise<{
    subjectSlug: string
  }>
}

async function getSubjectTopicsData(subjectSlug: string) {
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

  // Get Subject by slug
  const { data: subject } = await supabase
    .from('subjects')
    .select('*')
    .eq('slug', subjectSlug)
    .single()

  if (!subject) {
    return notFound()
  }

  // Get Elements for this subject
  const { data: elements } = await supabase
    .from('elements')
    .select('*')
    .eq('subject_id', subject.id)
    .order('order_index')

  // Get Topics for these elements
  const elementIds = elements?.map((e) => e.id) || []

  let topics: any[] = []
  if (elementIds.length > 0) {
    const { data: topicsData } = await supabase
      .from('topics')
      .select('*')
      .in('element_id', elementIds)
      .order('order_index')

    // Get question counts per topic
    const { data: allQuestions } = await supabase
      .from('questions')
      .select('id, topic_id')

    topics = (topicsData || []).map((t) => ({
      ...t,
      questionCount: (allQuestions || []).filter((q) => q.topic_id === t.id).length,
    }))
  }

  return {
    subject,
    elements: elements || [],
    topics,
  }
}

export default async function SubjectTopicsPage({ params }: Props) {
  const resolvedParams = await params
  const { subject, elements, topics } = await getSubjectTopicsData(resolvedParams.subjectSlug)

  return (
    <div className="container py-8" style={{ maxWidth: '800px', margin: '0 auto', padding: '24px 16px' }}>
      {/* Back to Beranda */}
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

      {/* Header */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
        <div style={{ fontSize: '48px' }}>{subject.icon || '📘'}</div>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            {subject.name}
          </h1>
          <p style={{ color: '#64748b', marginTop: '4px', fontSize: '15px' }}>
            {subject.official_name || subject.description || 'Pilih topik untuk memulai latihan kuis.'}
          </p>
        </div>
      </div>

      {/* Topics Grouped by Elements */}
      {elements.map((elem) => {
        const elemTopics = topics.filter((t) => t.element_id === elem.id)
        return (
          <div key={elem.id} style={{ marginBottom: '32px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px' }}>
              <span style={{ backgroundColor: '#e0f2fe', color: '#0369a1', padding: '4px 10px', borderRadius: '12px', fontSize: '12px', fontWeight: '700' }}>
                ELEMEN / DOMAIN
              </span>
              <h2 style={{ fontSize: '18px', fontWeight: '700', color: '#334155', margin: 0 }}>
                {elem.name}
              </h2>
            </div>

            {elemTopics.length === 0 ? (
              <div style={{ backgroundColor: 'white', padding: '16px', borderRadius: '10px', color: '#94a3b8', fontSize: '13px' }}>
                Belum ada topik pada elemen ini.
              </div>
            ) : (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {elemTopics.map((topic) => {
                  const questionCount = topic.questionCount || 0
                  return (
                    <Link
                      key={topic.id}
                      href={`/belajar/${subject.slug}/${topic.slug}`}
                      style={{
                        backgroundColor: 'white',
                        borderRadius: '12px',
                        padding: '16px 20px',
                        border: '1px solid #e2e8f0',
                        textDecoration: 'none',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        boxShadow: '0 2px 4px rgba(0,0,0,0.03)',
                      }}
                    >
                      <div>
                        <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
                          {topic.name}
                        </h3>
                        <div style={{ fontSize: '12px', color: '#64748b', marginTop: '4px' }}>
                          📝 {questionCount} Soal Latihan
                        </div>
                      </div>

                      <div
                        style={{
                          backgroundColor: '#0284c7',
                          color: 'white',
                          padding: '8px 16px',
                          borderRadius: '8px',
                          fontSize: '13px',
                          fontWeight: '700',
                        }}
                      >
                        Mulai Latihan 🚀
                      </div>
                    </Link>
                  )
                })}
              </div>
            )}
          </div>
        )
      })}
    </div>
  )
}
