'use client'

import { useActionState } from 'react'
import { signInParent } from './actions'
import Link from 'next/link'

const initialState = {
  error: '',
}

export function LoginForm() {
  const [state, formAction, isPending] = useActionState(signInParent, initialState)

  return (
    <form action={formAction} className="flex flex-col gap-4">
      {state?.error && (
        <div style={{ color: 'var(--color-primary-red)', backgroundColor: 'var(--color-primary-red-soft)', padding: '12px', borderRadius: '8px', fontSize: '14px', border: '1px solid var(--color-primary-red)' }}>
          ⚠️ {state.error}
        </div>
      )}

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
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <label className="form-label" htmlFor="password">
            Password
          </label>
          <Link href="/lupa-password" style={{ fontSize: '12px', color: 'var(--color-primary-blue)', fontWeight: 'bold', textDecoration: 'none' }}>
            Lupa Password?
          </Link>
        </div>
        <input
          id="password"
          name="password"
          type="password"
          placeholder="Masukkan password Anda"
          className="form-input"
          required
          disabled={isPending}
        />
      </div>

      <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={isPending}>
        {isPending ? 'Memproses Masuk...' : 'Masuk 🚀'}
      </button>

      <p className="text-center text-sm" style={{ color: 'var(--color-text-muted)', marginTop: '8px' }}>
        Belum punya akun?{' '}
        <Link href="/daftar" style={{ color: 'var(--color-primary-blue)', fontWeight: 'bold' }}>
          Daftar Gratis
        </Link>
      </p>
    </form>
  )
}
