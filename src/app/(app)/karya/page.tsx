import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getKaryaData() {
  const cookieStore = await cookies()
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

  const supabase = createServerClient<Database>(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll() {},
      },
    }
  )

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/masuk')
  }

  // Get active child
  const { data: childrenList } = await supabase
    .from('children')
    .select('*')
    .eq('parent_id', user.id)

  const activeChildId = cookieStore.get('active_child_id')?.value
  const activeChild = childrenList?.find((c) => c.id === activeChildId) || childrenList?.[0] || null

  if (!activeChild) {
    redirect('/profil/setup')
  }

  // Fetch photo submissions for active child
  const { data: photos } = await supabase
    .from('photo_submissions')
    .select('*')
    .eq('child_id', activeChild.id)
    .order('created_at', { ascending: false })

  const { data: topics } = await supabase.from('topics').select('id, name')

  const enrichedPhotos = (photos || []).map((p) => ({
    ...p,
    topicName: topics?.find((t) => t.id === p.topic_id)?.name || 'Karya Fisik',
  }))

  return {
    activeChild,
    enrichedPhotos,
  }
}

export default async function KaryaPage() {
  const { activeChild, enrichedPhotos } = await getKaryaData()

  return (
    <div className="container py-8" style={{ maxWidth: '900px', margin: '0 auto', padding: '24px 16px' }}>
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

      {/* Header Banner */}
      <div
        style={{
          background: 'linear-gradient(135deg, #ec4899 0%, #f43f5e 100%)',
          borderRadius: '20px',
          padding: '28px',
          color: 'white',
          boxShadow: '0 10px 25px -5px rgba(236,72,153,0.3)',
          marginBottom: '32px',
        }}
      >
        <div style={{ fontSize: '48px', marginBottom: '12px' }}>🎨</div>
        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0 0 8px 0' }}>
          Galeri Karya Fisik {activeChild.name}
        </h1>
        <p style={{ margin: 0, opacity: 0.95, fontSize: '15px', lineHeight: '1.5' }}>
          Koleksi foto hasil karya kreativitas tangan (Seni Budaya, kerajinan, & tugas fisik) tersimpan privat.
        </p>
      </div>

      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
        📸 Hasil Karya Terunggah ({enrichedPhotos.length})
      </h2>

      {enrichedPhotos.length === 0 ? (
        <div style={{ backgroundColor: 'white', padding: '40px', borderRadius: '16px', textAlign: 'center', color: '#94a3b8' }}>
          Belum ada foto karya fisik yang diunggah. Kirim foto karya pertama dari topik pelajaran Seni Budaya! 🎨
        </div>
      ) : (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '20px' }}>
          {enrichedPhotos.map((photo) => (
            <div
              key={photo.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '16px',
                overflow: 'hidden',
                border: '1px solid #e2e8f0',
                boxShadow: '0 4px 12px rgba(0,0,0,0.04)',
              }}
            >
              <img
                src={photo.photo_url}
                alt={photo.topicName}
                style={{ width: '100%', height: '200px', objectFit: 'cover' }}
              />
              <div style={{ padding: '16px' }}>
                <span
                  style={{
                    padding: '2px 8px',
                    backgroundColor: '#fce7f3',
                    color: '#be185d',
                    borderRadius: '6px',
                    fontSize: '11px',
                    fontWeight: '700',
                    textTransform: 'uppercase',
                  }}
                >
                  {photo.topicName}
                </span>
                {photo.parent_note && (
                  <p style={{ margin: '8px 0 0 0', fontSize: '14px', color: '#0f172a', fontWeight: '600' }}>
                    &quot;{photo.parent_note}&quot;
                  </p>
                )}
                <div style={{ fontSize: '11px', color: '#94a3b8', marginTop: '8px' }}>
                  {new Date(photo.created_at || '').toLocaleDateString('id-ID')}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
