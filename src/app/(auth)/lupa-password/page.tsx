import ForgotPasswordForm from '@/features/auth/ForgotPasswordForm'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Lupa Password — Naik Level',
  description: 'Minta tautan reset/pemulihan password untuk akun Orang Tua atau Admin Naik Level.',
}

export default function ForgotPasswordPage() {
  return (
    <div className="container py-12" style={{ maxWidth: '600px', margin: '0 auto' }}>
      <ForgotPasswordForm />
    </div>
  )
}
