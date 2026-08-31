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

export async function requestPasswordReset(prevState: any, formData: FormData) {
  const email = formData.get('email') as string
  if (!email) {
    return { error: 'Email wajib diisi.' }
  }

  const supabase = await createClient()
  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'}/profil/pengaturan`,
  })

  if (error) {
    return { error: error.message }
  }

  return { success: 'Instruksi reset password telah dikirim ke email Anda! Silakan periksa kotak masuk.' }
}

export async function updatePassword(prevState: any, formData: FormData) {
  const newPassword = formData.get('newPassword') as string
  const confirmPassword = formData.get('confirmPassword') as string

  if (!newPassword || newPassword.length < 6) {
    return { error: 'Password baru minimal 6 karakter.' }
  }

  if (newPassword !== confirmPassword) {
    return { error: 'Konfirmasi password tidak cocok.' }
  }

  const supabase = await createClient()
  const { error } = await supabase.auth.updateUser({ password: newPassword })

  if (error) {
    return { error: error.message }
  }

  return { success: 'Password berhasil diperbarui! Silakan gunakan password baru ini.' }
}
