'use client'

import { useActionState, useState } from 'react'
import { uploadPhotoSubmission, PhotoSubmissionState } from './actions'

interface Props {
  childId: string
  topicId: string
  topicName: string
}

const initialState: PhotoSubmissionState = {}

export function PhotoUploadForm({ childId, topicId, topicName }: Props) {
  const [state, formAction, isPending] = useActionState(uploadPhotoSubmission, initialState)
  const [previewUrl, setPreviewUrl] = useState<string | null>(null)

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      const reader = new FileReader()
      reader.onloadend = () => {
        setPreviewUrl(reader.result as string)
      }
      reader.readAsDataURL(file)
    }
  }

  return (
    <div className="card card-pink" style={{ padding: '24px', backgroundColor: 'white' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '16px' }}>
        <span style={{ fontSize: '32px' }}>📸</span>
        <div>
          <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            Take a Picture — Karya Fisik
          </h3>
          <p style={{ fontSize: '13px', color: '#64748b', margin: 0 }}>
            Kirim foto hasil karya (kolase/gambar) untuk topik <strong>{topicName}</strong>
          </p>
        </div>
      </div>

      {state?.success ? (
        <div style={{ backgroundColor: '#f0fdf4', border: '1px solid #bbf7d0', padding: '16px', borderRadius: '12px', textAlign: 'center', color: '#15803d' }}>
          🎉 <strong>Foto Karya Berhasil Disimpan!</strong> Foto ini tersimpan secara privat di akun Anda.
        </div>
      ) : (
        <form action={formAction} className="flex flex-col gap-4">
          {state?.error && (
            <div style={{ color: 'var(--color-primary-red)', backgroundColor: 'var(--color-primary-red-soft)', padding: '12px', borderRadius: '8px', fontSize: '14px' }}>
              ⚠️ {state.error}
            </div>
          )}

          <input type="hidden" name="childId" value={childId} />
          <input type="hidden" name="topicId" value={topicId} />
          <input type="hidden" name="photoUrl" value={previewUrl || ''} />

          <div className="form-group">
            <label className="form-label">Upload / Ambil Foto Karya</label>
            <input
              type="file"
              accept="image/*"
              capture="environment"
              onChange={handleFileChange}
              className="form-input"
              required
              disabled={isPending}
            />
          </div>

          {previewUrl && (
            <div style={{ textAlign: 'center', marginTop: '8px' }}>
              <img
                src={previewUrl}
                alt="Preview Karya"
                style={{ maxWidth: '100%', maxHeight: '250px', borderRadius: '12px', border: '2px solid #e2e8f0', objectFit: 'cover' }}
              />
            </div>
          )}

          <div className="form-group">
            <label className="form-label" htmlFor="parentNote">Catatan / Keterangan (Opsional)</label>
            <input
              id="parentNote"
              name="parentNote"
              type="text"
              placeholder="contoh: Gambar kolase daun kering buatan Dika"
              className="form-input"
              disabled={isPending}
            />
          </div>

          <button
            type="submit"
            className="btn btn-pink"
            style={{ width: '100%' }}
            disabled={isPending || !previewUrl}
          >
            {isPending ? 'Mengunggah Foto...' : 'Simpan Foto Karya 🎨'}
          </button>
        </form>
      )}
    </div>
  )
}
