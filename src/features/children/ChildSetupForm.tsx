'use client'

import { useActionState, useState } from 'react'
import { createChildProfile } from './actions'

interface EducationLevel {
  id: string
  name: string
  level_type: 'tk' | 'sd'
}

interface ChildSetupFormProps {
  educationLevels: EducationLevel[]
}

const AVATARS = ['🦊', '🐯', '🐼', '🐨', '🦁', '🦄', '🦖', '🧑‍🎓', '🚀', '🎨', '⚽', '🎸']

const initialState = {
  error: '',
}

export function ChildSetupForm({ educationLevels }: ChildSetupFormProps) {
  const [state, formAction, isPending] = useActionState(createChildProfile, initialState)
  const [selectedAvatar, setSelectedAvatar] = useState('🧑‍🎓')

  return (
    <form action={formAction} className="flex flex-col gap-6">
      {state?.error && (
        <div style={{ color: 'var(--color-primary-red)', backgroundColor: 'var(--color-primary-red-soft)', padding: '12px', borderRadius: '8px', fontSize: '14px', border: '1px solid var(--color-primary-red)' }}>
          ⚠️ {state.error}
        </div>
      )}

      {/* Name Input */}
      <div className="form-group">
        <label className="form-label" htmlFor="name">
          Nama Panggilan Anak
        </label>
        <input
          id="name"
          name="name"
          type="text"
          placeholder="contoh: Andi, Rara, Dika"
          className="form-input"
          required
          disabled={isPending}
        />
      </div>

      {/* Education Level Selector */}
      <div className="form-group">
        <label className="form-label" htmlFor="educationLevelId">
          Jenjang / Kelas Sekolah
        </label>
        <select
          id="educationLevelId"
          name="educationLevelId"
          className="form-input"
          style={{ appearance: 'auto', cursor: 'pointer' }}
          required
          disabled={isPending}
        >
          <option value="">-- Pilih Kelas --</option>
          {educationLevels.map((level) => (
            <option key={level.id} value={level.id}>
              {level.name} ({level.level_type === 'tk' ? 'Taman Kanak-kanak' : 'Sekolah Dasar'})
            </option>
          ))}
        </select>
      </div>

      {/* Avatar Picker */}
      <div className="form-group">
        <label className="form-label">Pilih Avatar Favorit</label>
        <input type="hidden" name="avatarUrl" value={selectedAvatar} />
        <div className="flex flex-wrap gap-2" style={{ marginTop: '8px' }}>
          {AVATARS.map((avatar) => (
            <button
              key={avatar}
              type="button"
              onClick={() => setSelectedAvatar(avatar)}
              disabled={isPending}
              style={{
                fontSize: '28px',
                width: '52px',
                height: '52px',
                borderRadius: '50%',
                border: selectedAvatar === avatar ? '3px solid var(--color-primary-blue)' : '3px solid var(--color-border)',
                backgroundColor: selectedAvatar === avatar ? 'var(--color-primary-blue-soft)' : 'var(--color-bg-card)',
                cursor: 'pointer',
                transition: 'all 0.2s ease',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              {avatar}
            </button>
          ))}
        </div>
      </div>

      <button type="submit" className="btn btn-primary" style={{ width: '100%', marginTop: '12px' }} disabled={isPending}>
        {isPending ? 'Membuat Profil...' : 'Buat Profil Anak & Mulai Belajar! 🎯'}
      </button>
    </form>
  )
}
