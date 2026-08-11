import { SignUpForm } from '@/features/auth/SignUpForm'
import Link from 'next/link'

export default function DaftarPage() {
  return (
    <main
      className="flex items-center justify-center"
      style={{
        minHeight: '100vh',
        background: 'linear-gradient(135deg, var(--color-primary-blue-soft) 0%, var(--color-primary-red-soft) 100%)',
        padding: '24px',
      }}
    >
      <div className="card" style={{ maxWidth: '450px', width: '100%', padding: '32px' }}>
        <div className="text-center mb-6">
          <Link href="/">
            <div className="logo-text justify-center mb-2">
              <span className="logo-naik">Naik</span>
              <span className="logo-level">Level</span>
            </div>
          </Link>
          <h2 style={{ fontSize: '20px', color: 'var(--color-text-main)' }}>Daftar Akun Orang Tua</h2>
          <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '4px' }}>
            Satu akun untuk mengelola banyak profil anak secara privat
          </p>
        </div>
        <SignUpForm />
      </div>
    </main>
  )
}
