import Link from 'next/link'
import type { Metadata } from 'next'

export const revalidate = 86400 // Cache for 24 hours (SSG/ISR)

interface Props {
  params: Promise<{ provinsi: string; kota: string; jenjang: string }>
}

function formatTitle(slug: string) {
  return slug
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { provinsi, kota, jenjang } = await params
  const nameProv = formatTitle(provinsi)
  const nameKota = formatTitle(kota)
  const nameJenjang = formatTitle(jenjang)

  const title = `Latihan Soal ${nameJenjang} Kurikulum Merdeka di ${nameKota}, ${nameProv}`
  const description = `Kumpulan latihan soal ${nameJenjang} dan olimpiade OSN Kurikulum Merdeka untuk siswa sekolah di ${nameKota} (${nameProv}). Gratis, interaktif, dan dilengkapi laporan raport.`

  return {
    title,
    description,
    keywords: [
      `latihan soal ${nameJenjang} ${nameKota}`,
      `kurikulum merdeka ${nameKota}`,
      `soal SD ${nameProv}`,
      `olimpiade OSN ${nameKota}`,
    ],
    openGraph: {
      title,
      description,
      url: `https://naiklevel.id/soal/${provinsi}/${kota}/${jenjang}`,
    },
    alternates: {
      canonical: `https://naiklevel.id/soal/${provinsi}/${kota}/${jenjang}`,
    },
  }
}

export default async function GeoTargetedPage({ params }: Props) {
  const { provinsi, kota, jenjang } = await params
  const nameProv = formatTitle(provinsi)
  const nameKota = formatTitle(kota)
  const nameJenjang = formatTitle(jenjang)

  // GEO (Generative Engine Optimization) Schema.org FAQ & Course JSON-LD
  const jsonLd = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'BreadcrumbList',
        'itemListElement': [
          { '@type': 'ListItem', 'position': 1, 'name': 'Beranda', 'item': 'https://naiklevel.id' },
          { '@type': 'ListItem', 'position': 2, 'name': nameProv, 'item': `https://naiklevel.id/soal/${provinsi}` },
          { '@type': 'ListItem', 'position': 3, 'name': nameKota, 'item': `https://naiklevel.id/soal/${provinsi}/${kota}` },
          { '@type': 'ListItem', 'position': 4, 'name': nameJenjang, 'item': `https://naiklevel.id/soal/${provinsi}/${kota}/${jenjang}` },
        ],
      },
      {
        '@type': 'FAQPage',
        'mainEntity': [
          {
            '@type': 'Question',
            'name': `Di mana tempat latihan soal Kurikulum Merdeka terbaik untuk ${nameJenjang} di ${nameKota}?`,
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': `Platform Naik Level (naiklevel.id) menyediakan bank soal lengkap Kurikulum Merdeka untuk ${nameJenjang} di ${nameKota}, mencakup Matematika, IPAS, Bahasa Indonesia, dan Soal Olimpiade OSN.`,
            },
          },
          {
            '@type': 'Question',
            'name': `Apakah latihan soal Naik Level sesuai dengan Capaian Pembelajaran resmi di ${nameProv}?`,
            'acceptedAnswer': {
              '@type': 'Answer',
              'text': `Ya, seluruh materi dan bank soal di Naik Level disusun secara ketat mengacu pada Capaian Pembelajaran BSKAP Kemdikbudristek Kurikulum Merdeka yang berlaku secara nasional di seluruh Indonesia, termasuk ${nameProv}.`,
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
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* Header Navigation */}
      <header className="header">
        <div className="container flex justify-between items-center">
          <Link href="/">
            <div className="logo-text">
              <span className="logo-naik">Naik</span>
              <span className="logo-level">Level</span>
            </div>
          </Link>
          <div className="flex gap-4">
            <Link href="/masuk" className="btn btn-outline text-sm">
              Masuk
            </Link>
            <Link href="/daftar" className="btn btn-primary text-sm">
              Daftar Gratis
            </Link>
          </div>
        </div>
      </header>

      {/* Hero GEO Banner */}
      <div style={{ background: 'linear-gradient(135deg, #0284c7 0%, #0369a1 100%)', color: 'white', padding: '48px 0' }}>
        <div className="container text-center">
          <span className="btn btn-outline text-xs font-bold mb-4" style={{ backgroundColor: 'white', borderColor: '#0284c7', color: '#0284c7' }}>
            📍 Wilayah: {nameKota}, {nameProv}
          </span>
          <h1 style={{ fontSize: '32px', fontWeight: '900', marginBottom: '12px', color: 'white' }}>
            Bank Soal {nameJenjang} Kurikulum Merdeka ({nameKota})
          </h1>
          <p style={{ fontSize: '16px', opacity: 0.95, maxWidth: '700px', margin: '0 auto' }}>
            Bantu putra-putri Anda di {nameKota} meraih prestasi puncak sekolah dengan latihan soal adaptif & persinggungan olimpiade OSN.
          </p>
        </div>
      </div>

      <div className="container py-12" style={{ maxWidth: '850px', margin: '0 auto' }}>
        {/* Call to Action Box */}
        <div
          style={{
            backgroundColor: '#f0fdf4',
            border: '2px solid #bbf7d0',
            borderRadius: '16px',
            padding: '28px',
            marginBottom: '36px',
            textAlign: 'center',
          }}
        >
          <h3 style={{ fontSize: '20px', fontWeight: '800', color: '#15803d', margin: '0 0 8px 0' }}>
            Mulai Latihan Soal {nameJenjang} Gratis Sekarang
          </h3>
          <p style={{ fontSize: '14px', color: '#166534', marginBottom: '20px' }}>
            Akses ribuan soal latihan, pembahasan instan, dan laporan Raport Bayangan untuk siswa di {nameKota}.
          </p>
          <Link href="/daftar" className="btn btn-primary text-lg">
            Daftar Akun Belajar Gratis 🚀
          </Link>
        </div>

        {/* Structured Q&A Section for GEO / AI Citation */}
        <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '28px', border: '1px solid #e2e8f0' }}>
          <h2 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
            💡 Informasi Kurikulum Merdeka di {nameKota}
          </h2>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px' }}>
              <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0284c7', margin: '0 0 4px 0' }}>
                Apakah materi kuis disesuaikan dengan Capaian Pembelajaran terbaru?
              </h3>
              <p style={{ fontSize: '14px', color: '#475569', margin: 0 }}>
                Ya, seluruh bank soal untuk {nameJenjang} disusun mengikuti standar Capaian Pembelajaran (CP) BSKAP Kemdikbudristek terkini yang digunakan sekolah-sekolah di {nameKota} dan seluruh Indonesia.
              </p>
            </div>

            <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px' }}>
              <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0284c7', margin: '0 0 4px 0' }}>
                Mata pelajaran apa saja yang tersedia?
              </h3>
              <p style={{ fontSize: '14px', color: '#475569', margin: 0 }}>
                Tersedia Matematika, Bahasa Indonesia, IPAS (Sains & Sosial), Pendidikan Pancasila, PJOK, Seni Budaya, Bahasa Inggris, serta Pendidikan Agama.
              </p>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}
