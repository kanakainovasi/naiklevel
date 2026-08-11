import Link from 'next/link'
import React from 'react'

export const metadata = {
  title: 'CMS Admin — Naik Level',
  description: 'Panel Pengelola & Analytics Naik Level',
}

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div style={{ display: 'flex', minHeight: '100vh', backgroundColor: '#f8fafc' }}>
      {/* Sidebar */}
      <aside
        style={{
          width: '260px',
          backgroundColor: '#0f172a',
          color: '#f8fafc',
          padding: '24px 16px',
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'space-between',
          borderRight: '1px solid #1e293b',
        }}
      >
        <div>
          {/* Logo Brand */}
          <div style={{ marginBottom: '32px', padding: '0 8px' }}>
            <Link href="/admin" style={{ textDecoration: 'none' }}>
              <span style={{ fontSize: '24px', fontWeight: '800', color: '#38bdf8' }}>Naik</span>
              <span style={{ fontSize: '24px', fontWeight: '800', color: '#ff6b6b' }}>Level</span>
              <span style={{ fontSize: '11px', fontWeight: '600', backgroundColor: '#334155', color: '#cbd5e1', padding: '2px 8px', borderRadius: '12px', marginLeft: '8px' }}>
                ADMIN CMS
              </span>
            </Link>
          </div>

          {/* Navigation Links */}
          <nav style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <Link
              href="/admin"
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                padding: '10px 14px',
                borderRadius: '8px',
                color: '#e2e8f0',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: '500',
                transition: 'background 0.2s',
              }}
            >
              📊 Traffic & Analitik
            </Link>
            <Link
              href="/admin/soal"
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                padding: '10px 14px',
                borderRadius: '8px',
                color: '#e2e8f0',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: '500',
                transition: 'background 0.2s',
              }}
            >
              📝 Bank Soal & CMS
            </Link>
            <Link
              href="/admin/kurikulum"
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                padding: '10px 14px',
                borderRadius: '8px',
                color: '#e2e8f0',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: '500',
                transition: 'background 0.2s',
              }}
            >
              📚 Struktur Kurikulum
            </Link>
            <Link
              href="/admin/badges"
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                padding: '10px 14px',
                borderRadius: '8px',
                color: '#e2e8f0',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: '500',
                transition: 'background 0.2s',
              }}
            >
              🏆 Lencana & Badges
            </Link>
          </nav>
        </div>

        {/* Footer Actions */}
        <div style={{ borderTop: '1px solid #1e293b', paddingTop: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
          <Link
            href="/beranda"
            style={{
              display: 'block',
              textAlign: 'center',
              padding: '8px 12px',
              backgroundColor: '#1e293b',
              color: '#94a3b8',
              borderRadius: '6px',
              textDecoration: 'none',
              fontSize: '13px',
              fontWeight: '500',
            }}
          >
            ← Kembali ke Web App
          </Link>
        </div>
      </aside>

      {/* Main Content Area */}
      <main style={{ flex: 1, padding: '32px', overflowY: 'auto' }}>
        {children}
      </main>
    </div>
  )
}
