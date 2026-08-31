import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Naik Level — Aplikasi Belajar Anak Kurikulum Merdeka (TK A s/d SD Kelas 6)',
  description:
    'Platform belajar interaktif anak usia 4-12 tahun (TK A s/d SD Kelas 6) berbasis Kurikulum Merdeka. Latihan soal adaptif, olimpiade OSN berwaktu, raport bayangan triwulanan, dan galeri karya fisik.',
  keywords: [
    'aplikasi belajar anak',
    'kurikulum merdeka',
    'latihan soal SD',
    'soal kuis TK A TK B',
    'olimpiade OSN SD',
    'raport bayangan',
    'naik level',
    'soal matematika SD',
    'IPAS SD',
  ],
  openGraph: {
    title: 'Naik Level — Aplikasi Belajar Anak Kurikulum Merdeka (TK A s/d SD Kelas 6)',
    description:
      'Tingkatkan level prestasi anak usia 4-12 tahun dengan latihan soal & olimpiade berbasis Kurikulum Merdeka.',
    url: 'https://naiklevel.id',
    siteName: 'Naik Level',
    locale: 'id_ID',
    type: 'website',
  },
  alternates: {
    canonical: 'https://naiklevel.id',
  },
}

export default function Home() {
  // Rich Schema.org Graph for SEO & GEO (AI Search Engines)
  const schemaGraph = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'EducationalOrganization',
        'name': 'Naik Level',
        'url': 'https://naiklevel.id',
        'logo': 'https://naiklevel.id/favicon.ico',
        'sameAs': ['https://github.com/kanakainovasi/naiklevel'],
        'description':
          'Platform edukasi interaktif Kurikulum Merdeka untuk anak usia 4–12 tahun (TK A sampai SD Kelas 6).',
      },
      {
        '@type': 'SoftwareApplication',
        'name': 'Naik Level App',
        'operatingSystem': 'Web, Android, iOS',
        'applicationCategory': 'EducationalApplication',
        'offers': {
          '@type': 'Offer',
          'price': '0',
          'priceCurrency': 'IDR',
        },
        'aggregateRating': {
          '@type': 'AggregateRating',
          'ratingValue': '4.9',
          'ratingCount': '320',
        },
      },
      {
        '@type': 'FAQPage',
        'mainEntity': [
          {
            '@type': 'Question',
            'name': 'Apa itu aplikasi Naik Level?',
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': 'Naik Level adalah web aplikasi belajar interaktif untuk anak usia 4–12 tahun (TK A, TK B, dan SD Kelas 1–6) yang mengikuti Capaian Pembelajaran resmi Kurikulum Merdeka BSKAP Kemdikbudristek.',
            },
          },
          {
            '@type': 'Question',
            'name': 'Mata pelajaran apa saja yang tersedia di Naik Level?',
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': 'Tersedia Matematika, Bahasa Indonesia, IPAS (Sains & Sosial), Pendidikan Pancasila, PJOK, Seni Budaya, Bahasa Inggris, Pendidikan Agama (6 agama resmi), serta Soal Olimpiade Sains Nasional (OSN).',
            },
          },
          {
            '@type': 'Question',
            'name': 'Bagaimana Naik Level membantu pemantauan belajar anak oleh orang tua?',
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': 'Naik Level menyediakan Dashboard Orang Tua, pengingat batas waktu layar harian, galeri karya fisik (Take a Picture), serta Raport Bayangan Triwulanan otomatis per Elemen Kurikulum.',
            },
          },
        ],
      },
    ],
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(schemaGraph) }}
      />

      {/* Header Navigation */}
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
      <section
        className="py-16"
        style={{
          background:
            'linear-gradient(135deg, var(--color-primary-blue-soft) 0%, var(--color-primary-red-soft) 100%)',
        }}
      >
        <div className="container text-center">
          <span
            className="btn btn-outline text-xs font-bold mb-4 animate-bounce"
            style={{
              pointerEvents: 'none',
              backgroundColor: 'white',
              borderColor: 'var(--color-primary-blue)',
            }}
          >
            ✨ Belajar Seru Kurikulum Merdeka (TK A s/d SD Kelas 6)
          </span>
          <h1
            className="text-3xl font-extrabold mb-4"
            style={{
              fontSize: 'clamp(2.5rem, 5vw, 4rem)',
              color: 'var(--color-text-main)',
              lineHeight: 1.15,
            }}
          >
            Ubah <span style={{ color: 'var(--color-primary-red)' }}>Screen Time</span> Anak <br />
            Menjadi <span style={{ color: 'var(--color-primary-blue)' }}>Naik Level</span>!
          </h1>
          <p
            className="text-lg mb-8"
            style={{
              maxWidth: '700px',
              margin: '16px auto 32px',
              color: 'var(--color-text-muted)',
              fontFamily: 'var(--font-body)',
            }}
          >
            Platform belajar interaktif gratis untuk usia 4–12 tahun (TK A, TK B, hingga SD Kelas 6). 
            Dilengkapi latihan soal adaptif, tantangan olimpiade OSN berwaktu, dan laporan Raport Bayangan triwulanan.
          </p>
          <div className="flex justify-center gap-4 flex-wrap">
            <Link href="/daftar" className="btn btn-primary text-lg">
              Mulai Belajar Gratis 🚀
            </Link>
            <Link href="/materi/matematika-sd-1/bilangan-cacah-sampai-20" className="btn btn-outline text-lg">
              Coba Contoh Soal 📝
            </Link>
          </div>
        </div>
      </section>

      {/* Grade Selector Grid for SEO Internal Linking */}
      <section className="py-12" style={{ backgroundColor: 'white', borderBottom: '1px solid var(--color-border)' }}>
        <div className="container">
          <div className="text-center mb-8">
            <h2 className="text-2xl font-extrabold mb-2">Pilih Jenjang Sekolah Anak Anda</h2>
            <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
              Materi terstruktur lengkap mengacu pada Capaian Pembelajaran BSKAP Kemdikbudristek.
            </p>
          </div>

          <div className="grid grid-cols-4 gap-4">
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🎨</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>TK A (Usia 4-5)</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase Fondasi STPPA</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>✏️</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>TK B (Usia 5-6)</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Persiapan SD</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🎒</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 1</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase A (Flagship)</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>📖</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 2</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase A Lanjutan</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🔬</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 3</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase B & IPAS</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🌱</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 4</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase B Lanjutan</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🚀</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 5</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase C & OSN</p>
            </div>
            <div className="card text-center" style={{ padding: '16px' }}>
              <div style={{ fontSize: '32px' }}>🎓</div>
              <h3 style={{ fontSize: '16px', marginTop: '8px' }}>SD Kelas 6</h3>
              <p style={{ fontSize: '12px', color: 'var(--color-text-muted)', marginTop: '4px' }}>Fase C & Kelulusan</p>
            </div>
          </div>
        </div>
      </section>

      {/* Flagship Features */}
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
                Ribuan soal kuis interaktif dari Matematika, IPAS, Bahasa Indonesia, hingga Agama. Dilengkapi skor instan dan pembahasan.
              </p>
            </div>

            <div className="card card-red">
              <div style={{ fontSize: '40px', marginBottom: '16px' }}>🏆</div>
              <h3 className="mb-2">Tantangan Olimpiade OSN</h3>
              <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
                Soal HOTS berwaktu gaya Olimpiade Sains Nasional (OSN) untuk mengasah berpikir analitis dengan bonus 2.5x XP.
              </p>
            </div>

            <div className="card card-pink">
              <div style={{ fontSize: '40px', marginBottom: '16px' }}>📊</div>
              <h3 className="mb-2">Raport Bayangan Triwulanan</h3>
              <p style={{ color: 'var(--color-text-muted)', fontSize: '15px' }}>
                Laporan evaluasi otomatis untuk orang tua yang memetakan Kekuatan Utama dan Area Pendampingan anak per Elemen Kurikulum.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* GEO Structured FAQ Section for AI Search Citation */}
      <section className="py-16" style={{ backgroundColor: 'white', borderTop: '1px solid var(--color-border)' }}>
        <div className="container" style={{ maxWidth: '800px' }}>
          <div className="text-center mb-10">
            <h2 className="text-2xl font-extrabold mb-2">Pertanyaan Sering Diajukan (FAQ)</h2>
            <p style={{ color: 'var(--color-text-muted)' }}>Seputar penggunaan platform belajar Naik Level.</p>
          </div>

          <div className="flex flex-col gap-6">
            <div style={{ backgroundColor: 'var(--color-bg-main)', padding: '20px', borderRadius: '12px' }}>
              <h3 style={{ fontSize: '17px', fontWeight: '700', color: 'var(--color-primary-blue)', marginBottom: '6px' }}>
                Apakah Naik Level sesuai dengan Kurikulum Merdeka?
              </h3>
              <p style={{ fontSize: '14px', color: 'var(--color-text-muted)', margin: 0 }}>
                Ya, seluruh materi dan bank soal di Naik Level disusun mengikuti Capaian Pembelajaran (CP) Kurikulum Merdeka resmi dari Kemdikbudristek untuk jenjang TK A, TK B, hingga SD Kelas 1–6.
              </p>
            </div>

            <div style={{ backgroundColor: 'var(--color-bg-main)', padding: '20px', borderRadius: '12px' }}>
              <h3 style={{ fontSize: '17px', fontWeight: '700', color: 'var(--color-primary-blue)', marginBottom: '6px' }}>
                Apakah ada suara narasi audio untuk anak TK / pembaca pemula?
              </h3>
              <p style={{ fontSize: '14px', color: 'var(--color-text-muted)', margin: 0 }}>
                Ya! Setiap soal kuis dilengkapi tombol suara 🔈 (Audio TTS Narration) sehingga anak TK yang belum lancar membaca dapat mendengar pertanyaan dibacakan secara otomatis.
              </p>
            </div>

            <div style={{ backgroundColor: 'var(--color-bg-main)', padding: '20px', borderRadius: '12px' }}>
              <h3 style={{ fontSize: '17px', fontWeight: '700', color: 'var(--color-primary-blue)', marginBottom: '6px' }}>
                Bagaimana cara melihat hasil karya fisik anak (Take a Picture)?
              </h3>
              <p style={{ fontSize: '14px', color: 'var(--color-text-muted)', margin: 0 }}>
                Anak atau orang tua dapat mengunggah foto hasil lukisan/kolase pada menu 🎨 Karya Fisik. Foto tersimpan aman dan privat di akun orang tua.
              </p>
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
            <Link href="/soal/dki-jakarta/jakarta-selatan/sd-kelas-1" style={{ color: 'white' }}>
              Soal Jakarta
            </Link>
            <Link href="/soal/jawa-barat/bandung/sd-kelas-1" style={{ color: 'white' }}>
              Soal Bandung
            </Link>
            <Link href="/soal/jawa-timur/surabaya/sd-kelas-1" style={{ color: 'white' }}>
              Soal Surabaya
            </Link>
          </div>
        </div>
      </footer>
    </>
  )
}
