import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getChildDashboardData() {
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

  // Get parent and children
  const { data: parent } = await supabase
    .from('parents')
    .select('*')
    .eq('id', user.id)
    .single()

  const { data: childrenList } = await supabase
    .from('children')
    .select('*')
    .eq('parent_id', user.id)

  const activeChildId = cookieStore.get('active_child_id')?.value

  let activeChild = childrenList?.find((c) => c.id === activeChildId) || childrenList?.[0] || null

  // If no child profile exists, redirect to setup page
  if (!activeChild) {
    redirect('/profil/setup')
  }

  // Get active education level
  let levelId = activeChild.education_level_id
  if (!levelId) {
    const { data: defaultLvl } = await supabase
      .from('education_levels')
      .select('id')
      .eq('slug', 'sd-kelas-1')
      .single()
    levelId = defaultLvl?.id || null
  }

  // Fetch subjects for this education level
  const { data: subjects } = await supabase
    .from('subjects')
    .select('*')
    .eq('education_level_id', levelId || '')
    .order('order_index')

  // Fetch earned badges
  const { data: childBadgeRows } = await supabase
    .from('child_badges')
    .select('*')
    .eq('child_id', activeChild.id)

  const { data: badgesList } = await supabase.from('badges').select('id, name')

  const earnedBadges = (childBadgeRows || []).map((cb) => ({
    ...cb,
    badgeName: badgesList?.find((b) => b.id === cb.badge_id)?.name || 'Lencana',
  }))

  return {
    parent,
    childrenList: childrenList || [],
    activeChild,
    subjects: subjects || [],
    earnedBadges: earnedBadges || [],
  }
}

export default async function BerandaPage() {
  const data = await getChildDashboardData()
  const { activeChild, childrenList, subjects, earnedBadges } = data

  const currentXp = activeChild.xp_total || 0
  const currentLevel = activeChild.current_level || 1
  const xpForNextLevel = currentLevel * 100
  const progressPercent = Math.min(100, Math.floor((currentXp % 100)))

  return (
    <div className="container py-8" style={{ maxWidth: '1000px', margin: '0 auto', padding: '24px 16px' }}>
      {/* Child Profile Banner */}
      <div
        style={{
          background: 'linear-gradient(135deg, #0284c7 0%, #38bdf8 100%)',
          borderRadius: '20px',
          padding: '28px',
          color: 'white',
          boxShadow: '0 10px 25px -5px rgba(2,132,199,0.3)',
          marginBottom: '32px',
          position: 'relative',
        }}
      >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '20px' }}>
          {/* Avatar & Name */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '20px' }}>
            <div
              style={{
                width: '80px',
                height: '80px',
                borderRadius: '50%',
                backgroundColor: 'white',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '48px',
                boxShadow: '0 4px 10px rgba(0,0,0,0.15)',
              }}
            >
              {activeChild.avatar_url || '🧑‍🎓'}
            </div>
            <div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', margin: 0 }}>
                  Halo, {activeChild.name}! 🚀
                </h1>
              </div>
              <p style={{ margin: '4px 0 0 0', opacity: 0.9, fontSize: '15px' }}>
                Siap untuk naik level belajar hari ini?
              </p>
            </div>
          </div>

          {/* Level & XP Box */}
          <div
            style={{
              backgroundColor: 'rgba(255, 255, 255, 0.2)',
              backdropFilter: 'blur(10px)',
              padding: '16px 24px',
              borderRadius: '16px',
              minWidth: '220px',
            }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '14px', fontWeight: '700', marginBottom: '8px' }}>
              <span>Level {currentLevel}</span>
              <span>🔥 {activeChild.streak_days || 0} Hari Streak</span>
            </div>

            {/* XP Progress Bar */}
            <div
              style={{
                height: '10px',
                backgroundColor: 'rgba(255, 255, 255, 0.3)',
                borderRadius: '5px',
                overflow: 'hidden',
              }}
            >
              <div
                style={{
                  height: '100%',
                  width: `${progressPercent}%`,
                  backgroundColor: '#f59e0b',
                  borderRadius: '5px',
                  transition: 'width 0.5s ease',
                }}
              />
            </div>
            <div style={{ fontSize: '12px', textAlign: 'right', marginTop: '6px', opacity: 0.9 }}>
              {currentXp} XP / {xpForNextLevel} XP
            </div>
          </div>
        </div>

        {/* Multi-child switcher if > 1 child */}
        {childrenList.length > 1 && (
          <div style={{ marginTop: '20px', paddingTop: '16px', borderTop: '1px solid rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ fontSize: '13px', fontWeight: '600' }}>Ganti Profil Anak:</span>
            <div style={{ display: 'flex', gap: '8px' }}>
              {childrenList.map((child) => (
                <Link
                  key={child.id}
                  href={`/beranda?childId=${child.id}`}
                  style={{
                    padding: '4px 12px',
                    borderRadius: '12px',
                    backgroundColor: child.id === activeChild.id ? 'white' : 'rgba(255,255,255,0.2)',
                    color: child.id === activeChild.id ? '#0284c7' : 'white',
                    fontSize: '13px',
                    fontWeight: '700',
                    textDecoration: 'none',
                  }}
                >
                  {child.avatar_url || '👦'} {child.name}
                </Link>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* Main Feature Cards: Latihan Reguler vs Olimpiade */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '20px', marginBottom: '36px' }}>
        <div
          style={{
            backgroundColor: 'white',
            borderRadius: '16px',
            padding: '24px',
            border: '2px solid #e0f2fe',
            boxShadow: '0 4px 12px rgba(0,0,0,0.05)',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'space-between',
          }}
        >
          <div>
            <div style={{ fontSize: '36px', marginBottom: '12px' }}>📖</div>
            <h3 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', margin: '0 0 8px 0' }}>
              Latihan Soal Adaptif
            </h3>
            <p style={{ color: '#64748b', fontSize: '14px', lineHeight: '1.5', margin: 0 }}>
              Belajar tanpa tekanan waktu per mata pelajaran. Dapatkan nilai & breakdown per Elemen Kurikulum.
            </p>
          </div>
          <span style={{ marginTop: '20px', fontSize: '13px', fontWeight: '700', color: '#0284c7' }}>
            Pilih Mata Pelajaran di Bawah 👇
          </span>
        </div>

        <Link
          href="/olimpiade"
          style={{
            backgroundColor: 'white',
            borderRadius: '16px',
            padding: '24px',
            border: '2px solid #fef3c7',
            boxShadow: '0 4px 12px rgba(0,0,0,0.05)',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'space-between',
            textDecoration: 'none',
          }}
        >
          <div>
            <div style={{ fontSize: '36px', marginBottom: '12px' }}>🏆</div>
            <h3 style={{ fontSize: '20px', fontWeight: '800', color: '#d97706', margin: '0 0 8px 0' }}>
              Soal Olimpiade (OSN)
            </h3>
            <p style={{ color: '#64748b', fontSize: '14px', lineHeight: '1.5', margin: 0 }}>
              Tantangan berwaktu gaya olimpiade sains nasional. Dapatkan XP ganda & lencana prestisius!
            </p>
          </div>
          <span style={{ marginTop: '20px', fontSize: '14px', fontWeight: '700', color: '#d97706', display: 'flex', alignItems: 'center', gap: '6px' }}>
            Mulai Tantangan Olimpiade →
          </span>
        </Link>
      </div>

      {/* Subjects Grid */}
      <div style={{ marginBottom: '40px' }}>
        <h2 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
          📚 Mata Pelajaran Belajar
        </h2>

        {subjects.length === 0 ? (
          <div style={{ backgroundColor: 'white', padding: '32px', borderRadius: '12px', textAlign: 'center', color: '#94a3b8' }}>
            Belum ada mata pelajaran untuk kelas ini.
          </div>
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '16px' }}>
            {subjects.map((subj) => (
              <Link
                key={subj.id}
                href={`/belajar/${subj.slug}`}
                style={{
                  backgroundColor: 'white',
                  borderRadius: '14px',
                  padding: '20px',
                  border: '1px solid #e2e8f0',
                  textDecoration: 'none',
                  boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
                  transition: 'transform 0.2s, boxShadow 0.2s',
                  display: 'flex',
                  flexDirection: 'column',
                  gap: '8px',
                }}
              >
                <div style={{ fontSize: '32px' }}>{subj.icon || '📘'}</div>
                <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
                  {subj.name}
                </h3>
                <p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>
                  {subj.description || 'Latihan soal sesuai Capaian Pembelajaran'}
                </p>
              </Link>
            ))}
          </div>
        )}
      </div>

      {/* Earned Badges Showcase */}
      <div>
        <h2 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
          🏆 Lencana Pencapaian ({earnedBadges.length})
        </h2>
        <div style={{ display: 'flex', gap: '12px', overflowX: 'auto', paddingBottom: '12px' }}>
          {earnedBadges.length === 0 ? (
            <div style={{ backgroundColor: 'white', padding: '16px 24px', borderRadius: '12px', color: '#94a3b8', fontSize: '14px' }}>
              Selesaikan kuis pertamamu untuk membuka lencana pertama! 🎯
            </div>
          ) : (
            earnedBadges.map((eb: any) => (
              <div
                key={eb.badge_id}
                style={{
                  backgroundColor: 'white',
                  borderRadius: '12px',
                  padding: '12px 16px',
                  border: '1px solid #e2e8f0',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '10px',
                  minWidth: '180px',
                }}
              >
                <span style={{ fontSize: '24px' }}>🏆</span>
                <div>
                  <div style={{ fontSize: '13px', fontWeight: '700', color: '#0f172a' }}>
                    {eb.badgeName}
                  </div>
                </div>
              </div>
            ))
          )}
        </div>
      </div>
    </div>
  )
}
