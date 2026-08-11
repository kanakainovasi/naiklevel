'use client'

import { useActionState } from 'react'
import { signUpParent } from './actions'
import Link from 'next/link'

const initialState = {
  error: '',
}

export function SignUpForm() {
  const [state, formAction, isPending] = useActionState(signUpParent, initialState)

  return (
    <form action={formAction} className="flex flex-col gap-4">
      {state?.error && (
        <div style={{ color: 'var(--color-primary-red)', backgroundColor: 'var(--color-primary-red-soft)', padding: '12px', borderRadius: '8px', fontSize: '14px', border: '1px solid var(--color-primary-red)' }}>
          ⚠️ {state.error}
        </div>
      )}

      <div className="form-group">
        <label className="form-label" htmlFor="fullName">
          Nama Lengkap Orang Tua
        </label>
        <input
          id="fullName"
          name="fullName"
          type="text"
          placeholder="contoh: Budi Setiawan"
          className="form-input"
          required
          disabled={isPending}
        />
      </div>

      <div className="form-group">
        <label className="form-label" htmlFor="email">
          Alamat Email
        </label>
        <input
          id="email"
          name="email"
          type="email"
          placeholder="contoh: budi@gmail.com"
          className="form-input"
          required
          disabled={isPending}
        />
      </div>

      <div className="form-group">
        <label className="form-label" htmlFor="password">
          Password
        </label>
        <input
          id="password"
          name="password"
          type="password"
          placeholder="Minimal 6 karakter"
          className="form-input"
          required
          disabled={isPending}
        />
      </div>

      {/* Consent PDP (Kepatuhan UU PDP) */}
      <div className="flex items-center gap-2" style={{ padding: '8px 0' }}>
        <input
          id="consent"
          name="consent"
          type="checkbox"
          style={{ width: '18px', height: '18px', cursor: 'pointer' }}
          required
          disabled={isPending}
        />
        <label htmlFor="consent" style={{ fontSize: '13px', color: 'var(--color-text-muted)', cursor: 'pointer' }}>
          Saya menyetujui pengumpulan dan pemrosesan data progres belajar anak saya demi kebutuhan laporan akademis secara privat (Kepatuhan UU PDP).
        </label>
      </div>

      <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={isPending}>
        {isPending ? 'Mendaftarkan...' : 'Daftar Akun Baru 🚀'}
      </button>

      <p className="text-center text-sm" style={{ color: 'var(--color-text-muted)', marginTop: '8px' }}>
        Sudah punya akun?{' '}
        <Link href="/masuk" style={{ color: 'var(--color-primary-blue)', fontWeight: 'bold' }}>
          Masuk di sini
        </Link>
      </p>
    </form>
  )
}
