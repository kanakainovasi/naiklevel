import Link from 'next/link'
import React from 'react'

export default function AppLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', backgroundColor: '#f8fafc', fontFamily: "'Nunito', system-ui, -apple-system, sans-serif" }}>
      {/* Top Navigation Bar */}
      <header style={{
        backgroundColor: 'white',
        borderBottom: '1px solid #e2e8f0',
        position: 'sticky',
        top: 0,
        zIndex: 50,
        boxShadow: '0 1px 3px rgba(0,0,0,0.02)'
      }}>
        <div style={{
          maxWidth: '1200px',
          margin: '0 auto',
          padding: '0 16px',
          height: '64px',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          {/* Logo */}
          <Link href="/beranda" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '6px' }}>
            <span style={{ fontSize: '22px', fontWeight: '900', color: '#0284c7' }}>Naik</span>
            <span style={{ fontSize: '22px', fontWeight: '900', color: '#e11d48', backgroundColor: '#ffe4e6', padding: '2px 8px', borderRadius: '8px' }}>Level</span>
          </Link>

          {/* Navigation Items */}
          <nav style={{ display: 'flex', alignItems: 'center', gap: '20px' }}>
            <Link href="/beranda" style={{ fontSize: '15px', fontWeight: '700', color: '#475569', textDecoration: 'none' }}>
              🎯 Belajar
            </Link>
            <Link href="/olimpiade" style={{ fontSize: '15px', fontWeight: '700', color: '#d97706', textDecoration: 'none' }}>
              🏆 Olimpiade
            </Link>
            <Link href="/karya" style={{ fontSize: '15px', fontWeight: '700', color: '#be185d', textDecoration: 'none' }}>
              🎨 Karya
            </Link>
            <Link href="/raport" style={{ fontSize: '15px', fontWeight: '700', color: '#475569', textDecoration: 'none' }}>
              📊 Raport
            </Link>
            <Link href="/dashboard" style={{ fontSize: '15px', fontWeight: '700', color: '#0f172a', textDecoration: 'none', borderLeft: '2px solid #e2e8f0', paddingLeft: '20px' }}>
              👨‍👩‍👧‍👦 Dashboard Wali
            </Link>
            <Link href="/profil/pengaturan" style={{ fontSize: '15px', fontWeight: '700', color: '#64748b', textDecoration: 'none' }}>
              ⚙️ Pengaturan
            </Link>
          </nav>
        </div>
      </header>

      {/* Main Content Area */}
      <main style={{ flex: 1, paddingBottom: '40px' }}>
        {children}
      </main>

      {/* Footer */}
      <footer style={{
        backgroundColor: '#0f172a',
        color: '#94a3b8',
        padding: '24px 16px',
        textAlign: 'center',
        fontSize: '13px',
        borderTop: '1px solid #1e293b'
      }}>
        <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
          <div>© {new Date().getFullYear()} Naik Level. Hak Cipta Dilindungi Undang-Undang.</div>
          <div style={{ marginTop: '6px', fontSize: '11px', color: '#64748b' }}>
            Kepatuhan UU PDP Terjamin. Belajar Interaktif Kurikulum Merdeka untuk Anak Cerdas Indonesia.
          </div>
        </div>
      </footer>
    </div>
  )
}
