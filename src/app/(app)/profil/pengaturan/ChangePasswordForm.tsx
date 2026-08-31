'use client'

import { useActionState } from 'react'
import { updatePassword } from '@/features/auth/actions'

export default function ChangePasswordForm() {
  const [state, formAction, isPending] = useActionState(updatePassword, null)

  return (
    <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '24px', border: '1px solid #e2e8f0', marginTop: '24px' }}>
      <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#0f172a', margin: '0 0 4px 0' }}>
        🔒 Ubah Password Akun
      </h3>
      <p style={{ color: '#64748b', fontSize: '13px', marginBottom: '20px' }}>
        Perbarui password akun Orang Tua / Admin Anda secara berkala.
      </p>

      {state?.error && (
        <div style={{ backgroundColor: '#fee2e2', color: '#b91c1c', padding: '10px 14px', borderRadius: '8px', fontSize: '13px', marginBottom: '16px' }}>
          ⚠️ {state.error}
        </div>
      )}

      {state?.success && (
        <div style={{ backgroundColor: '#dcfce7', color: '#15803d', padding: '10px 14px', borderRadius: '8px', fontSize: '13px', marginBottom: '16px' }}>
          ✅ {state.success}
        </div>
      )}

      <form action={formAction} style={{ display: 'flex', flexDirection: 'column', gap: '14px', maxWidth: '400px' }}>
        <div>
          <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#334155', marginBottom: '4px' }}>
            Password Baru
          </label>
          <input
            type="password"
            name="newPassword"
            required
            placeholder="Minimal 6 karakter"
            style={{
              width: '100%',
              padding: '10px 14px',
              borderRadius: '8px',
              border: '1.5px solid #cbd5e1',
              fontSize: '14px',
              outline: 'none',
            }}
          />
        </div>

        <div>
          <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#334155', marginBottom: '4px' }}>
            Konfirmasi Password Baru
          </label>
          <input
            type="password"
            name="confirmPassword"
            required
            placeholder="Ketik ulang password baru"
            style={{
              width: '100%',
              padding: '10px 14px',
              borderRadius: '8px',
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
          style={{ padding: '10px 16px', fontSize: '14px', alignSelf: 'flex-start' }}
        >
          {isPending ? 'Simpan Password...' : 'Simpan Password Baru 🔒'}
        </button>
      </form>
    </div>
  )
}
