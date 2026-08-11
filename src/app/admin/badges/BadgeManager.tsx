'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Database } from '@/types/database'

type Badge = Database['public']['Tables']['badges']['Row']

interface Props {
  initialBadges: Badge[]
}

export default function BadgeManager({ initialBadges }: Props) {
  const supabase = createClient()
  const [badges, setBadges] = useState<Badge[]>(initialBadges)

  const [isModalOpen, setIsModalOpen] = useState(false)
  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const [iconUrl, setIconUrl] = useState('')

  const handleAddBadge = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!name) return

    const { data, error } = await supabase
      .from('badges')
      .insert({
        name,
        description,
        icon_url: iconUrl || '/badges/default.png',
        criteria: { type: 'custom' },
      })
      .select()
      .single()

    if (error) {
      alert('Gagal menambah badge: ' + error.message)
      return
    }

    setBadges([data, ...badges])
    setName('')
    setDescription('')
    setIconUrl('')
    setIsModalOpen(false)
  }

  const handleDeleteBadge = async (id: string) => {
    if (!confirm('Apakah Anda yakin ingin menghapus lencana ini?')) return
    const { error } = await supabase.from('badges').delete().eq('id', id)
    if (error) {
      alert('Gagal menghapus badge: ' + error.message)
      return
    }
    setBadges(badges.filter((b) => b.id !== id))
  }

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            🏆 Kelola Lencana (Badges) Gamifikasi
          </h1>
          <p style={{ color: '#64748b', marginTop: '4px', fontSize: '14px' }}>
            Atur lencana apresiasi dan kriteria pencapaian anak.
          </p>
        </div>

        <button
          onClick={() => setIsModalOpen(true)}
          style={{
            backgroundColor: '#f59e0b',
            color: 'white',
            border: 'none',
            padding: '12px 20px',
            borderRadius: '8px',
            fontWeight: '600',
            cursor: 'pointer',
            fontSize: '14px',
          }}
        >
          ➕ Tambah Lencana Baru
        </button>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '20px' }}>
        {badges.map((b) => (
          <div
            key={b.id}
            style={{
              backgroundColor: 'white',
              borderRadius: '12px',
              padding: '20px',
              border: '1px solid #e2e8f0',
              display: 'flex',
              flexDirection: 'column',
              justifyContent: 'space-between',
            }}
          >
            <div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '12px' }}>
                <div
                  style={{
                    width: '48px',
                    height: '48px',
                    borderRadius: '10px',
                    backgroundColor: '#fef3c7',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '24px',
                  }}
                >
                  🏆
                </div>
                <div>
                  <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
                    {b.name}
                  </h3>
                  <span style={{ fontSize: '12px', color: '#94a3b8' }}>ID: {b.id.slice(0, 8)}...</span>
                </div>
              </div>
              <p style={{ fontSize: '13px', color: '#64748b', margin: 0 }}>
                {b.description || 'Tidak ada deskripsi.'}
              </p>
            </div>

            <div style={{ marginTop: '16px', paddingTop: '12px', borderTop: '1px solid #f1f5f9', display: 'flex', justifyContent: 'flex-end' }}>
              <button
                onClick={() => handleDeleteBadge(b.id)}
                style={{
                  padding: '4px 10px',
                  backgroundColor: '#fee2e2',
                  color: '#b91c1c',
                  border: 'none',
                  borderRadius: '4px',
                  fontSize: '12px',
                  cursor: 'pointer',
                  fontWeight: '600',
                }}
              >
                🗑️ Hapus
              </button>
            </div>
          </div>
        ))}
      </div>

      {isModalOpen && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            backgroundColor: 'rgba(0,0,0,0.5)',
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            zIndex: 1000,
          }}
        >
          <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', width: '100%', maxWidth: '450px' }}>
            <h3 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '16px' }}>
              ➕ Tambah Lencana Baru
            </h3>
            <form onSubmit={handleAddBadge}>
              <div style={{ marginBottom: '12px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '4px' }}>
                  Nama Lencana
                </label>
                <input
                  type="text"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Contoh: Juara Sains Cilik"
                  required
                  style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                />
              </div>
              <div style={{ marginBottom: '12px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '4px' }}>
                  Deskripsi Lencana
                </label>
                <textarea
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  placeholder="Diberikan saat menyelesaikan 5 topik Sains."
                  style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                />
              </div>
              <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px', marginTop: '16px' }}>
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  style={{ padding: '8px 14px', backgroundColor: '#f1f5f9', border: 'none', borderRadius: '6px', cursor: 'pointer' }}
                >
                  Batal
                </button>
                <button
                  type="submit"
                  style={{ padding: '8px 14px', backgroundColor: '#f59e0b', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer' }}
                >
                  Simpan Lencana
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
