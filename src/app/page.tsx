import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Naik Level — Aplikasi Belajar Anak Terintegrasi Kurikulum Merdeka',
  description: 'Tingkatkan level prestasi anak usia 4-12 tahun dengan latihan soal & olimpiade berbasis Kurikulum Merdeka. Interaktif, terarah, dan ramah anak.',
}

export default function Home() {
  // Schema markup for software application
  const schemaMarkup = {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    'name': 'Naik Level',
    'operatingSystem': 'Web, Mobile',
    'applicationCategory': 'EducationalApplication',
    'offers': {
      '@type': 'Offer',
      'price': '0',
      'priceCurrency': 'IDR',
    },
    'aggregateRating': {
      '@type': 'AggregateRating',
      'ratingValue': '4.8',
      'ratingCount': '245',
    },
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(schemaMarkup) }}
      />
      
      {/* Header */}
      <header className="header">
        <div className="container flex justify-between items-center">
          <div className="logo-text">
            <span className="logo-naik">Naik</span>
            <span className="logo-level">Level</span>
          </div>
          <nav className="flex items-center gap-4">
            <Link href="/masuk" className="btn btn-outline text-sm">
              Masuk
            </Link>
            <Link href="/daftar" className="btn btn-primary text-sm">
              Daftar Gratis
            </Link>
          </nav>
        </div>
      </header>

      {/* Hero Section */}
      <section className="py-16" style={{ background: 'linear-gradient(135deg, var(--color-primary-blue-soft) 0%, var(--color-primary-red-soft) 100%)' }}>
        <div className="container text-center">
          <span className="btn btn-outline text-xs font-bold mb-4 animate-bounce" style={{ pointerEvents: 'none', backgroundColor: 'white', borderColor: 'var(--color-primary-blue)' }}>
            ✨ Belajar Seru Sesuai Kurikulum Merdeka
          </span>
          <h1 className="text-3xl font-extrabold mb-4" style={{ fontSize: 'clamp(2.5rem, 5vw, 4rem)', color: 'var(--color-text-main)' }}>
            Ubah <span style={{ color: 'var(--color-primary-red)' }}>Screen Time</span> Anak <br />
            Menjadi <span style={{ color: 'var(--color-primary-blue)' }}>Naik Level</span>!
          </h1>
          <p className="text-lg mb-8" style={{ maxWidth: '650px', margin: '16px auto 32px', color: 'var(--color-text-muted)', fontFamily: 'var(--font-body)' }}>
            Aplikasi belajar interaktif untuk usia 4-12 tahun (TK A s/d SD Kelas 6). 
            Mengikuti Capaian Pembelajaran Kurikulum Merdeka untuk membimbing tumbuh kembang akademik anak dengan cara yang menyenangkan.
          </p>
          <div className="flex justify-center gap-4 flex-wrap">
            <Link href="/daftar" className="btn btn-primary text-lg">
              Mulai Petualangan 🚀
            </Link>
            <Link href="/tentang" className="btn btn-outline text-lg">
              Pelajari Lebih Lanjut
            </Link>
          </div>
        </div>
      </section>

      {/* Flagship Feature Section */}
      <section className="py-16">
        <div className="container">
          <div className="text-center mb-12">
            <h2 className="text-2xl mb-2">Mengapa Memilih Naik Level?</h2>
            <p style={{ color: 'var(--color-text-muted)' }}>Dirancang khusus untuk melatih kemandirian dan rasa ingin tahu anak.</p>
          </div>
          
          <div className="grid grid-cols-3 gap-8">
            <div className="card card-blue">
              <div style={{ fontSize: '40px', marginBottom: '16px' }}>🔢</div>
              <h3 className="mb-2">Latihan Soal Adaptif</h3>
              <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
                Ribuan latihan soal interaktif dari semua mata pelajaran resmi. Penilaian instan dengan breakdown lengkap per Elemen/Domain Kurikulum.
              </p>
            </div>
            
            <div className="card card-red">
              <div style={{ fontSize: '40px', marginBottom: '16px' }}>🏆</div>
              <h3 className="mb-2">Soal Olimpiade</h3>
              <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
                Tantangan olimpiade berwaktu untuk melatih kecepatan berpikir analitis gaya Olimpiade Sains Nasional (OSN).
              </p>
            </div>
            
            <div className="card card-pink">
              <div style={{ fontSize: '40px', marginBottom: '16px' }}>🎁</div>
              <h3 className="mb-2">Gamifikasi Asyik</h3>
              <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
                Kumpulkan XP, naikkan level profil anak, dan dapatkan lencana (badges) prestisius atas setiap pencapaian belajar mereka.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Subjects Highlights (SD Kelas 1 Showcase) */}
      <section className="py-16" style={{ backgroundColor: 'var(--color-bg-card)', borderTop: '3px solid var(--color-border)', borderBottom: '3px solid var(--color-border)' }}>
        <div className="container">
          <div className="text-center mb-12">
            <h2 className="text-2xl mb-2">Flagship Kurikulum: SD Kelas 1</h2>
            <p style={{ color: 'var(--color-text-muted)' }}>Mata pelajaran lengkap sesuai Capaian Pembelajaran Fase A.</p>
          </div>

          <div className="grid grid-cols-4 gap-6">
            <div className="card text-center" style={{ padding: '20px' }}>
              <div style={{ fontSize: '32px', marginBottom: '12px' }}>🔢</div>
              <h4>Matematika</h4>
              <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '8px' }}>Bilangan, Aljabar, Geometri, Pengukuran</p>
            </div>
            <div className="card text-center" style={{ padding: '20px' }}>
              <div style={{ fontSize: '32px', marginBottom: '12px' }}>📖</div>
              <h4>Bahasa Indonesia</h4>
              <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '8px' }}>Membaca, Menulis, Menyimak, Memirsa</p>
            </div>
            <div className="card text-center" style={{ padding: '20px' }}>
              <div style={{ fontSize: '32px', marginBottom: '12px' }}>🦅</div>
              <h4>Pancasila</h4>
              <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '8px' }}>Simbol Garuda, Aturan Rumah & Sekolah</p>
            </div>
            <div className="card text-center" style={{ padding: '20px' }}>
              <div style={{ fontSize: '32px', marginBottom: '12px' }}>🎨</div>
              <h4>Seni Rupa</h4>
              <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '8px' }}>Garis & Warna, Karya Kolase Kreatif</p>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer style={{ backgroundColor: 'var(--color-text-main)', color: 'white', padding: '40px 0' }}>
        <div className="container flex justify-between items-center flex-wrap gap-4">
          <div>
            <div className="logo-text mb-2">
              <span className="logo-naik" style={{ color: 'white' }}>Naik</span>
              <span className="logo-level" style={{ color: 'var(--color-primary-blue-soft)' }}>Level</span>
            </div>
            <p style={{ fontSize: '14px', color: 'rgba(255, 255, 255, 0.6)' }}>
              © {new Date().getFullYear()} Naik Level. Hak Cipta Dilindungi Undang-Undang.
            </p>
          </div>
          <div className="flex gap-6" style={{ fontSize: '14px', color: 'rgba(255, 255, 255, 0.8)' }}>
            <Link href="/kebijakan-privasi" style={{ color: 'white' }}>
              Kebijakan Privasi (PDP)
            </Link>
            <Link href="/syarat-ketentuan" style={{ color: 'white' }}>
              Syarat & Ketentuan
            </Link>
          </div>
        </div>
      </footer>
    </>
  )
}
