import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { notFound, redirect } from 'next/navigation'
import { Database } from '@/types/database'
import QuizEngine from './QuizEngine'

export const revalidate = 0

interface Props {
  params: Promise<{
    subjectSlug: string
    topicSlug: string
  }>
}

async function getQuizData(topicSlug: string) {
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

  // Get active child
  const { data: childrenList } = await supabase
    .from('children')
    .select('*')
    .eq('parent_id', user.id)

  const activeChildId = cookieStore.get('active_child_id')?.value
  const activeChild = childrenList?.find((c) => c.id === activeChildId) || childrenList?.[0] || null

  if (!activeChild) {
    redirect('/profil/setup')
  }

  // Get Topic by slug
  const { data: topic } = await supabase
    .from('topics')
    .select('*')
    .eq('slug', topicSlug)
    .single()

  if (!topic) {
    return notFound()
  }

  // Get Questions for this topic
  const { data: questions } = await supabase
    .from('questions')
    .select('*')
    .eq('topic_id', topic.id)
    .eq('question_type', 'regular')
    .order('order_index')

  return {
    topic,
    questions: questions || [],
    activeChild,
  }
}

export default async function TopicQuizPage({ params }: Props) {
  const resolvedParams = await params
  const { topic, questions, activeChild } = await getQuizData(resolvedParams.topicSlug)

  return (
    <div className="container py-8" style={{ padding: '24px 16px' }}>
      <QuizEngine
        questions={questions}
        topic={topic}
        activeChild={activeChild}
        subjectSlug={resolvedParams.subjectSlug}
      />
    </div>
  )
}
