'use client'

import { useState, useEffect } from 'react'
import { createBrowserClient } from '@supabase/ssr'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { Database } from '@/types/database'
import ChangePasswordForm from './ChangePasswordForm'

export default function PengaturanProfilPage() {
  const router = useRouter()
  const supabase = createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )

  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [fullName, setFullName] = useState('')
  const [phone, setPhone] = useState('')
  const [dailyLimit, setDailyLimit] = useState(60)
  const [message, setMessage] = useState('')

  useEffect(() => {
    async function loadProfile() {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        router.push('/masuk')
        return
      }

      const { data: parent } = await supabase
        .from('parents')
        .select('*')
        .eq('id', user.id)
        .single()

      if (parent) {
        setFullName(parent.full_name || '')
        setPhone(parent.phone || '')
        setDailyLimit(parent.daily_limit_minutes || 60)
      }
      setLoading(false)
    }
    loadProfile()
  }, [])

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    setMessage('')

    const { data: { user } } = await supabase.auth.getUser()
    if (!user) return

    const { error } = await supabase
      .from('parents')
      .update({
        full_name: fullName,
        phone: phone,
        daily_limit_minutes: dailyLimit,
      })
      .eq('id', user.id)

    if (error) {
      setMessage('❌ Gagal menyimpan. Silakan coba lagi.')
    } else {
      setMessage('✅ Profil berhasil disimpan!')
    }
    setSaving(false)
  }

  if (loading) {
    return (
      <div style={{ minHeight: '60vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <div style={{ fontSize: '18px', color: '#64748b' }}>Memuat profil...</div>
      </div>
    )
  }

  return (
    <div style={{ maxWidth: '600px', margin: '0 auto', padding: '24px 16px' }}>
      <Link
        href="/beranda"
        style={{
          display: 'inline-flex',
          alignItems: 'center',
          gap: '6px',
          color: '#64748b',
          textDecoration: 'none',
          fontSize: '14px',
          fontWeight: '600',
          marginBottom: '20px',
        }}
      >
        ← Kembali ke Beranda
      </Link>

      <div
        style={{
          backgroundColor: 'white',
          borderRadius: '20px',
          padding: '32px',
          border: '1px solid #e2e8f0',
          boxShadow: '0 4px 16px rgba(0,0,0,0.04)',
        }}
      >
        <h1 style={{ fontSize: '24px', fontWeight: '800', color: '#0f172a', margin: '0 0 4px 0' }}>
          ⚙️ Pengaturan Profil Orang Tua
        </h1>
        <p style={{ color: '#64748b', fontSize: '14px', margin: '0 0 24px 0' }}>
          Kelola informasi akun dan batasan penggunaan anak.
        </p>

        <form onSubmit={handleSave} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
          <div>
            <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#475569', marginBottom: '6px' }}>
              Nama Lengkap
            </label>
            <input
              type="text"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              placeholder="Nama orang tua"
              style={{
                width: '100%',
                padding: '12px 16px',
                borderRadius: '10px',
                border: '1px solid #e2e8f0',
                fontSize: '15px',
                outline: 'none',
                boxSizing: 'border-box',
              }}
            />
          </div>

          <div>
            <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#475569', marginBottom: '6px' }}>
              Nomor Telepon (WhatsApp)
            </label>
            <input
              type="tel"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              placeholder="08xxxxxxxxxx"
              style={{
                width: '100%',
                padding: '12px 16px',
                borderRadius: '10px',
                border: '1px solid #e2e8f0',
                fontSize: '15px',
                outline: 'none',
                boxSizing: 'border-box',
              }}
            />
          </div>

          <div>
            <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', color: '#475569', marginBottom: '6px' }}>
              Batas Waktu Harian Anak (menit)
            </label>
            <input
              type="number"
              min={10}
              max={180}
              value={dailyLimit}
              onChange={(e) => setDailyLimit(Number(e.target.value))}
              style={{
                width: '100%',
                padding: '12px 16px',
                borderRadius: '10px',
                border: '1px solid #e2e8f0',
                fontSize: '15px',
                outline: 'none',
                boxSizing: 'border-box',
              }}
            />
            <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>
              Anak akan mendapat peringatan ketika mendekati batas waktu harian.
            </div>
          </div>

          {message && (
            <div style={{ padding: '12px', borderRadius: '8px', backgroundColor: message.startsWith('✅') ? '#f0fdf4' : '#fef2f2', fontSize: '14px', fontWeight: '600' }}>
              {message}
            </div>
          )}

          <button
            type="submit"
            disabled={saving}
            style={{
              padding: '14px 24px',
              backgroundColor: saving ? '#94a3b8' : '#0284c7',
              color: 'white',
              borderRadius: '12px',
              border: 'none',
              fontSize: '15px',
              fontWeight: '700',
              cursor: saving ? 'not-allowed' : 'pointer',
            }}
          >
            {saving ? 'Menyimpan...' : '💾 Simpan Perubahan'}
          </button>
        </form>
      </div>

      {/* Privacy Section */}
      <div
        style={{
          marginTop: '24px',
          backgroundColor: '#fffbeb',
          borderRadius: '16px',
          padding: '24px',
          border: '1px solid #fde68a',
        }}
      >
        <h3 style={{ fontSize: '16px', fontWeight: '800', color: '#b45309', margin: '0 0 8px 0' }}>
          🔒 Privasi & Keamanan Data
        </h3>
        <p style={{ fontSize: '13px', color: '#92400e', lineHeight: '1.6', margin: 0 }}>
          Naik Level mematuhi UU Pelindungan Data Pribadi (UU PDP). Data anak Anda bersifat privat dan
          tidak akan dibagikan ke pihak ketiga. Anda dapat menghapus akun dan semua data kapan saja
          dengan menghubungi tim kami.
        </p>
      </div>

      {/* Change Password Form */}
      <ChangePasswordForm />
    </div>
  )
}
