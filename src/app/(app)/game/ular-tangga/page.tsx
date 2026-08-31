import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import UlarTanggaGame from './UlarTanggaGame'
import { Database } from '@/types/database'

export const revalidate = 0

async function getGameData() {
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

  const { data: childrenList } = await supabase
    .from('children')
    .select('*')
    .eq('parent_id', user.id)

  const activeChildId = cookieStore.get('active_child_id')?.value
  const activeChild = childrenList?.find((c) => c.id === activeChildId) || childrenList?.[0] || null

  if (!activeChild) {
    redirect('/profil/setup')
  }

  // Fetch sample questions for game dice rolls
  const { data: questions } = await supabase
    .from('questions')
    .select('*')
    .limit(20)

  return {
    activeChild,
    questions: questions || [],
  }
}

export default async function UlarTanggaPage() {
  const { activeChild, questions } = await getGameData()

  return (
    <div className="container py-8" style={{ maxWidth: '850px', margin: '0 auto', padding: '24px 16px' }}>
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

      <UlarTanggaGame
        questions={questions}
        childName={activeChild.name}
        childAvatar={activeChild.avatar_url || '🧑‍🎓'}
      />
    </div>
  )
}
