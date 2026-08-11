'use server'

import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import { cookies } from 'next/headers'

export async function createChildProfile(prevState: any, formData: FormData) {
  const name = formData.get('name') as string
  const educationLevelId = formData.get('educationLevelId') as string
  const avatarUrl = (formData.get('avatarUrl') as string) || '🧑‍🎓'

  if (!name || !educationLevelId) {
    return { error: 'Nama dan Kelas/Jenjang wajib diisi.' }
  }

  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return { error: 'Sesi Anda telah habis. Silakan masuk kembali.' }
  }

  const { data: child, error } = await supabase
    .from('children')
    .insert({
      parent_id: user.id,
      name,
      education_level_id: educationLevelId,
      avatar_url: avatarUrl,
      xp_total: 0,
      current_level: 1,
      streak_days: 0,
    })
    .select()
    .single()

  if (error) {
    return { error: error.message }
  }

  const cookieStore = await cookies()
  cookieStore.set('active_child_id', child.id, {
    path: '/',
    maxAge: 60 * 60 * 24 * 30, // 30 days
  })

  redirect('/beranda')
}

export async function switchActiveChild(childId: string) {
  const cookieStore = await cookies()
  cookieStore.set('active_child_id', childId, {
    path: '/',
    maxAge: 60 * 60 * 24 * 30,
  })
}
