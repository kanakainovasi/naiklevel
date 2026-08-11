import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { Database } from '@/types/database'
import BadgeManager from './BadgeManager'

export const revalidate = 0

async function getBadgesData() {
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

  const { data: badges } = await supabase.from('badges').select('*').order('created_at', { ascending: false })
  return badges || []
}

export default async function AdminBadgesPage() {
  const badges = await getBadgesData()
  return <BadgeManager initialBadges={badges} />
}
