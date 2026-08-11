import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { Database } from '@/types/database'
import CurriculumManager from './CurriculumManager'

export const revalidate = 0

async function getCurriculumData() {
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
    { data: educationLevels },
    { data: subjects },
    { data: elements },
    { data: topics },
  ] = await Promise.all([
    supabase.from('education_levels').select('*').order('order_index'),
    supabase.from('subjects').select('*').order('order_index'),
    supabase.from('elements').select('*').order('order_index'),
    supabase.from('topics').select('*').order('order_index'),
  ])

  return {
    educationLevels: educationLevels || [],
    subjects: subjects || [],
    elements: elements || [],
    topics: topics || [],
  }
}

export default async function AdminCurriculumPage() {
  const data = await getCurriculumData()

  return (
    <CurriculumManager
      educationLevels={data.educationLevels}
      subjects={data.subjects}
      elements={data.elements}
      topics={data.topics}
    />
  )
}
