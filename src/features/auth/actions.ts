'use server'

import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'

export async function signUpParent(prevState: any, formData: FormData) {
  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const fullName = formData.get('fullName') as string
  const consent = formData.get('consent') === 'on'

  if (!email || !password || !fullName) {
    return { error: 'Semua kolom wajib diisi.' }
  }

  if (!consent) {
    return { error: 'Anda harus menyetujui Kebijakan Privasi (PDP) untuk melanjutkan.' }
  }

  const supabase = await createClient()

  const { error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: {
        full_name: fullName,
      },
    },
  })

  if (error) {
    return { error: error.message }
  }

  redirect('/profil/setup')
}

export async function signInParent(prevState: any, formData: FormData) {
  const email = formData.get('email') as string
  const password = formData.get('password') as string

  if (!email || !password) {
    return { error: 'Email dan password wajib diisi.' }
  }

  const supabase = await createClient()

  const { error } = await supabase.auth.signInWithPassword({
    email,
    password,
  })

  if (error) {
    return { error: error.message }
  }

  redirect('/beranda')
}

export async function signOutParent() {
  const supabase = await createClient()
  await supabase.auth.signOut()
  redirect('/masuk')
}
