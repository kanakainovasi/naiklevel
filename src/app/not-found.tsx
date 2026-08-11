import Link from 'next/link'

export default function NotFound() {
  return (
    <div
      style={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#f8fafc',
        fontFamily: "'Nunito', system-ui, -apple-system, sans-serif",
        textAlign: 'center',
        padding: '24px',
      }}
    >
      <div>
        <div style={{ fontSize: '120px', marginBottom: '8px', lineHeight: '1' }}>🤔</div>
        <h1 style={{ fontSize: '64px', fontWeight: '900', color: '#0f172a', margin: '0 0 8px 0' }}>404</h1>
        <h2 style={{ fontSize: '24px', fontWeight: '700', color: '#475569', margin: '0 0 16px 0' }}>
          Halaman Tidak Ditemukan
        </h2>
        <p style={{ fontSize: '16px', color: '#94a3b8', maxWidth: '400px', margin: '0 auto 32px auto', lineHeight: '1.6' }}>
          Sepertinya halaman yang kamu cari sudah dipindahkan atau tidak ada. Yuk kembali belajar!
        </p>
        <div style={{ display: 'flex', gap: '12px', justifyContent: 'center', flexWrap: 'wrap' }}>
          <Link
            href="/"
            style={{
              padding: '14px 28px',
              backgroundColor: '#0284c7',
              color: 'white',
              borderRadius: '12px',
              textDecoration: 'none',
              fontSize: '15px',
              fontWeight: '700',
              boxShadow: '0 4px 12px rgba(2,132,199,0.3)',
            }}
          >
            🏠 Ke Beranda
          </Link>
          <Link
            href="/beranda"
            style={{
              padding: '14px 28px',
              backgroundColor: '#0f172a',
              color: 'white',
              borderRadius: '12px',
              textDecoration: 'none',
              fontSize: '15px',
              fontWeight: '700',
            }}
          >
            📚 Mulai Belajar
          </Link>
        </div>
      </div>
    </div>
  )
}
