import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getDashboardData() {
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

  const { data: parent } = await supabase
    .from('parents')
    .select('*')
    .eq('id', user.id)
    .single()

  const { data: childrenList } = await supabase
    .from('children')
    .select('*')
    .eq('parent_id', user.id)

  // Fetch education level names
  const { data: educationLevels } = await supabase
    .from('education_levels')
    .select('id, name')

  // Enrich children with level names
  const enrichedChildren = (childrenList || []).map((child) => ({
    ...child,
    levelName: educationLevels?.find((l) => l.id === child.education_level_id)?.name || 'Belum dipilih',
  }))

  // Get recent quiz sessions across all children
  const childIds = enrichedChildren.map((c) => c.id)
  let recentSessions: any[] = []
  if (childIds.length > 0) {
    const { data: sessions } = await supabase
      .from('quiz_sessions')
      .select('*')
      .in('child_id', childIds)
      .order('started_at', { ascending: false })
      .limit(10)

    // Enrich sessions with child and topic names
    const { data: topics } = await supabase.from('topics').select('id, name')

    recentSessions = (sessions || []).map((s) => ({
      ...s,
      childName: enrichedChildren.find((c) => c.id === s.child_id)?.name || '-',
      childAvatar: enrichedChildren.find((c) => c.id === s.child_id)?.avatar_url || '👦',
      topicName: topics?.find((t) => t.id === s.topic_id)?.name || '-',
    }))
  }

  // Get badges earned
  let allBadges: any[] = []
  if (childIds.length > 0) {
    const { data: childBadgeRows } = await supabase
      .from('child_badges')
      .select('*')
      .in('child_id', childIds)
      .order('earned_at', { ascending: false })

    const { data: badgesList } = await supabase.from('badges').select('id, name, description')

    allBadges = (childBadgeRows || []).map((cb) => ({
      ...cb,
      badgeName: badgesList?.find((b) => b.id === cb.badge_id)?.name || 'Lencana',
      childName: enrichedChildren.find((c) => c.id === cb.child_id)?.name || '-',
    }))
  }

  return {
    parent,
    enrichedChildren,
    recentSessions,
    allBadges,
  }
}

export default async function DashboardOrangTuaPage() {
  const { parent, enrichedChildren, recentSessions, allBadges } = await getDashboardData()

  return (
    <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '24px 16px' }}>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '28px', flexWrap: 'wrap', gap: '12px' }}>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            Dashboard Orang Tua
          </h1>
          <p style={{ color: '#64748b', marginTop: '4px', fontSize: '14px' }}>
            Selamat datang, <strong>{parent?.full_name || 'Bunda/Ayah'}</strong>. Pantau progres belajar anak-anak Anda.
          </p>
        </div>
        <div style={{ display: 'flex', gap: '10px' }}>
          <Link
            href="/raport"
            style={{
              padding: '10px 20px',
              backgroundColor: '#0f172a',
              color: 'white',
              borderRadius: '10px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: '700',
            }}
          >
            📄 Raport Bayangan
          </Link>
          <Link
            href="/profil/setup"
            style={{
              padding: '10px 20px',
              backgroundColor: '#16a34a',
              color: 'white',
              borderRadius: '10px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: '700',
            }}
          >
            ➕ Tambah Anak
          </Link>
        </div>
      </div>

      {/* Children Profiles */}
      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '14px' }}>
        👧 Profil Anak ({enrichedChildren.length})
      </h2>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px', marginBottom: '32px' }}>
        {enrichedChildren.length === 0 ? (
          <div style={{ backgroundColor: 'white', padding: '32px', borderRadius: '16px', textAlign: 'center', color: '#94a3b8' }}>
            Belum ada profil anak. Klik &quot;Tambah Anak&quot; untuk membuat profil baru.
          </div>
        ) : (
          enrichedChildren.map((child) => (
            <div
              key={child.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '16px',
                padding: '24px',
                border: '1px solid #e2e8f0',
                boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
              }}
            >
              <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '16px' }}>
                <div
                  style={{
                    width: '56px',
                    height: '56px',
                    borderRadius: '50%',
                    backgroundColor: '#e0f2fe',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '32px',
                  }}
                >
                  {child.avatar_url || '🧑‍🎓'}
                </div>
                <div>
                  <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
                    {child.name}
                  </h3>
                  <div style={{ fontSize: '13px', color: '#64748b' }}>
                    {child.levelName}
                  </div>
                </div>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '8px', backgroundColor: '#f8fafc', padding: '12px', borderRadius: '10px' }}>
                <div style={{ textAlign: 'center' }}>
                  <div style={{ fontSize: '11px', fontWeight: '600', color: '#64748b' }}>LEVEL</div>
                  <div style={{ fontSize: '18px', fontWeight: '800', color: '#0284c7' }}>{child.current_level || 1}</div>
                </div>
                <div style={{ textAlign: 'center' }}>
                  <div style={{ fontSize: '11px', fontWeight: '600', color: '#64748b' }}>XP</div>
                  <div style={{ fontSize: '18px', fontWeight: '800', color: '#16a34a' }}>{child.xp_total || 0}</div>
                </div>
                <div style={{ textAlign: 'center' }}>
                  <div style={{ fontSize: '11px', fontWeight: '600', color: '#64748b' }}>STREAK</div>
                  <div style={{ fontSize: '18px', fontWeight: '800', color: '#d97706' }}>🔥 {child.streak_days || 0}</div>
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      {/* Recent Quiz Sessions */}
      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '14px' }}>
        📝 Riwayat Kuis Terbaru
      </h2>
      <div style={{ backgroundColor: 'white', borderRadius: '16px', border: '1px solid #e2e8f0', overflow: 'hidden', marginBottom: '32px' }}>
        {recentSessions.length === 0 ? (
          <div style={{ padding: '32px', textAlign: 'center', color: '#94a3b8', fontSize: '14px' }}>
            Belum ada riwayat kuis. Ajak anak mengerjakan latihan soal pertama! 🎯
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '14px' }}>
            <thead>
              <tr style={{ backgroundColor: '#f8fafc', borderBottom: '2px solid #e2e8f0', textAlign: 'left' }}>
                <th style={{ padding: '12px 16px', color: '#475569' }}>Anak</th>
                <th style={{ padding: '12px 16px', color: '#475569' }}>Topik</th>
                <th style={{ padding: '12px 16px', color: '#475569' }}>Tipe</th>
                <th style={{ padding: '12px 16px', color: '#475569' }}>Nilai</th>
                <th style={{ padding: '12px 16px', color: '#475569' }}>XP</th>
                <th style={{ padding: '12px 16px', color: '#475569' }}>Waktu</th>
              </tr>
            </thead>
            <tbody>
              {recentSessions.map((s: any) => (
                <tr key={s.id} style={{ borderBottom: '1px solid #f1f5f9' }}>
                  <td style={{ padding: '12px 16px', fontWeight: '600' }}>
                    {s.childAvatar} {s.childName}
                  </td>
                  <td style={{ padding: '12px 16px', color: '#475569' }}>{s.topicName}</td>
                  <td style={{ padding: '12px 16px' }}>
                    <span style={{
                      padding: '2px 8px',
                      borderRadius: '8px',
                      fontSize: '11px',
                      fontWeight: '700',
                      backgroundColor: s.session_type === 'olympiad' ? '#fef3c7' : '#e0f2fe',
                      color: s.session_type === 'olympiad' ? '#d97706' : '#0369a1',
                    }}>
                      {s.session_type === 'olympiad' ? '🏆 Olimpiade' : '📖 Reguler'}
                    </span>
                  </td>
                  <td style={{ padding: '12px 16px', fontWeight: '700', color: (s.score || 0) >= 80 ? '#16a34a' : '#0284c7' }}>
                    {s.score || 0}%
                  </td>
                  <td style={{ padding: '12px 16px', fontWeight: '600', color: '#16a34a' }}>
                    +{s.xp_earned || 0}
                  </td>
                  <td style={{ padding: '12px 16px', fontSize: '12px', color: '#94a3b8' }}>
                    {s.started_at ? new Date(s.started_at).toLocaleDateString('id-ID') : '-'}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {/* Badges Earned */}
      <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '14px' }}>
        🏆 Lencana yang Diraih
      </h2>
      <div style={{ display: 'flex', gap: '12px', overflowX: 'auto', paddingBottom: '12px' }}>
        {allBadges.length === 0 ? (
          <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '12px', color: '#94a3b8', fontSize: '14px' }}>
            Belum ada lencana yang diraih. Terus semangat belajar!
          </div>
        ) : (
          allBadges.map((b: any) => (
            <div
              key={b.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '12px',
                padding: '16px',
                border: '1px solid #fef3c7',
                minWidth: '200px',
                textAlign: 'center',
              }}
            >
              <div style={{ fontSize: '32px', marginBottom: '8px' }}>🏆</div>
              <div style={{ fontSize: '14px', fontWeight: '700', color: '#0f172a' }}>{b.badgeName}</div>
              <div style={{ fontSize: '11px', color: '#64748b', marginTop: '4px' }}>Diraih oleh {b.childName}</div>
            </div>
          ))
        )}
      </div>

      {/* Parental Controls */}
      <div style={{ marginTop: '32px', backgroundColor: 'white', borderRadius: '16px', padding: '24px', border: '1px solid #e2e8f0' }}>
        <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', marginBottom: '12px' }}>
          ⚙️ Kontrol Orang Tua
        </h2>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '16px' }}>
          <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '10px' }}>
            <div style={{ fontSize: '13px', fontWeight: '700', color: '#475569', marginBottom: '4px' }}>Batas Waktu Harian</div>
            <div style={{ fontSize: '20px', fontWeight: '800', color: '#0284c7' }}>
              {parent?.daily_limit_minutes || 60} menit/hari
            </div>
            <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>
              Batasan penggunaan layar untuk anak
            </div>
          </div>
          <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '10px' }}>
            <div style={{ fontSize: '13px', fontWeight: '700', color: '#475569', marginBottom: '4px' }}>Langganan</div>
            <div style={{ fontSize: '20px', fontWeight: '800', color: parent?.subscription_tier === 'premium' ? '#d97706' : '#64748b' }}>
              {parent?.subscription_tier === 'premium' ? '⭐ Premium' : 'Gratis'}
            </div>
            <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px' }}>
              {parent?.subscription_tier === 'premium' ? 'Akses semua fitur olimpiade & raport detail' : 'Upgrade untuk fitur olimpiade & laporan lanjutan'}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
