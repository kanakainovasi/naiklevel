import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { Database } from '@/types/database'
import QuestionManager from './QuestionManager'

export const revalidate = 0

async function getQuestionData() {
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

  const [
    { data: questions },
    { data: educationLevels },
    { data: subjects },
    { data: topics },
  ] = await Promise.all([
    supabase.from('questions').select('*').order('created_at', { ascending: false }),
    supabase.from('education_levels').select('*').order('order_index'),
    supabase.from('subjects').select('*').order('order_index'),
    supabase.from('topics').select('*').order('order_index'),
  ])

  return {
    questions: questions || [],
    educationLevels: educationLevels || [],
    subjects: subjects || [],
    topics: topics || [],
  }
}

export default async function AdminQuestionsPage() {
  const data = await getQuestionData()

  return (
    <QuestionManager
      initialQuestions={data.questions}
      educationLevels={data.educationLevels}
      subjects={data.subjects}
      topics={data.topics}
    />
  )
}
