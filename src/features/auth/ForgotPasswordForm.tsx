'use client'

import { useActionState } from 'react'
import Link from 'next/link'
import { requestPasswordReset } from './actions'

export default function ForgotPasswordForm() {
  const [state, formAction, isPending] = useActionState(requestPasswordReset, null)

  return (
    <div style={{ maxWidth: '440px', margin: '0 auto', padding: '32px 24px', backgroundColor: 'white', borderRadius: '20px', border: '1px solid #e2e8f0', boxShadow: '0 10px 25px rgba(0,0,0,0.06)' }}>
      <div style={{ textAlign: 'center', marginBottom: '24px' }}>
        <div style={{ fontSize: '48px', marginBottom: '8px' }}>🔑</div>
        <h1 style={{ fontSize: '24px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
          Lupa Password?
        </h1>
        <p style={{ color: '#64748b', fontSize: '14px', marginTop: '6px' }}>
          Masukkan email terdaftar (Orang Tua / Admin). Kami akan mengirimkan tautan pemulihan password.
        </p>
      </div>

      {state?.error && (
        <div style={{ backgroundColor: '#fee2e2', color: '#b91c1c', padding: '12px 16px', borderRadius: '10px', fontSize: '14px', marginBottom: '16px' }}>
          ⚠️ {state.error}
        </div>
      )}

      {state?.success && (
        <div style={{ backgroundColor: '#dcfce7', color: '#15803d', padding: '12px 16px', borderRadius: '10px', fontSize: '14px', marginBottom: '16px' }}>
          ✅ {state.success}
        </div>
      )}

      <form action={formAction} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
        <div>
          <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#334155', marginBottom: '6px' }}>
            Email Terdaftar (Admin / Wali)
          </label>
          <input
            type="email"
            name="email"
            required
            placeholder="contoh: sulistianingdian@gmail.com"
            style={{
              width: '100%',
              padding: '12px 16px',
              borderRadius: '10px',
              border: '1.5px solid #cbd5e1',
              fontSize: '14px',
              outline: 'none',
            }}
          />
        </div>

        <button
          type="submit"
          disabled={isPending}
          className="btn btn-primary"
          style={{ width: '100%', padding: '14px', fontSize: '15px' }}
        >
          {isPending ? 'Mengirim Instruksi...' : 'Kirim Tautan Reset Password 📧'}
        </button>
      </form>

      <div style={{ textAlign: 'center', marginTop: '20px', fontSize: '14px', color: '#64748b' }}>
        Sudah ingat password?{' '}
        <Link href="/masuk" style={{ color: '#0284c7', fontWeight: '700', textDecoration: 'none' }}>
          Kembali ke Halaman Masuk
        </Link>
      </div>
    </div>
  )
}
