import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import Link from 'next/link'
import { redirect } from 'next/navigation'
import { Database } from '@/types/database'

export const revalidate = 0

async function getRaportData() {
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

  // Fetch education level name
  let levelName = 'SD Kelas 1'
  if (activeChild.education_level_id) {
    const { data: lvl } = await supabase
      .from('education_levels')
      .select('name')
      .eq('id', activeChild.education_level_id)
      .single()
    if (lvl) levelName = lvl.name
  }

  // Fetch all completed quiz sessions for this child (no joins)
  const { data: sessions } = await supabase
    .from('quiz_sessions')
    .select('*')
    .eq('child_id', activeChild.id)

  // Fetch reference data separately
  const { data: topics } = await supabase.from('topics').select('id, name, element_id')
  const { data: elements } = await supabase.from('elements').select('id, name, subject_id')
  const { data: subjects } = await supabase.from('subjects').select('id, name')

  // Build lookup maps
  const topicMap = new Map((topics || []).map((t) => [t.id, t]))
  const elementMap = new Map((elements || []).map((e) => [e.id, e]))
  const subjectMap = new Map((subjects || []).map((s) => [s.id, s]))

  // Aggregate results per Element
  const elementStats: Record<string, { elementName: string; subjectName: string; totalScore: number; count: number }> = {}

  sessions?.forEach((s) => {
    const topic = topicMap.get(s.topic_id || '')
    const element = topic ? elementMap.get(topic.element_id || '') : null
    const subject = element ? subjectMap.get(element.subject_id || '') : null

    const elemName = element?.name || 'Umum'
    const subjName = subject?.name || 'Mata Pelajaran'

    if (!elementStats[elemName]) {
      elementStats[elemName] = { elementName: elemName, subjectName: subjName, totalScore: 0, count: 0 }
    }
    elementStats[elemName].totalScore += s.score || 0
    elementStats[elemName].count += 1
  })

  const elementReport = Object.values(elementStats).map((stat) => ({
    elementName: stat.elementName,
    subjectName: stat.subjectName,
    averageScore: Math.round(stat.totalScore / stat.count),
    totalSessions: stat.count,
  }))

  const strengths = elementReport.filter((e) => e.averageScore >= 80)
  const growthAreas = elementReport.filter((e) => e.averageScore < 70)

  return {
    activeChild,
    levelName,
    elementReport,
    strengths,
    growthAreas,
    totalSessions: sessions?.length || 0,
  }
}

export default async function RaportBayanganPage() {
  const data = await getRaportData()
  const { activeChild, levelName, elementReport, strengths, growthAreas, totalSessions } = data

  return (
    <div style={{ maxWidth: '850px', margin: '0 auto', padding: '24px 16px' }}>
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

      {/* Header Raport */}
      <div
        style={{
          backgroundColor: 'white',
          borderRadius: '20px',
          padding: '32px',
          border: '2px solid #0f172a',
          boxShadow: '0 8px 24px rgba(0,0,0,0.06)',
          marginBottom: '28px',
        }}
      >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px', borderBottom: '2px solid #f1f5f9', paddingBottom: '20px', marginBottom: '20px' }}>
          <div>
            <span style={{ backgroundColor: '#0f172a', color: 'white', padding: '4px 12px', borderRadius: '12px', fontSize: '11px', fontWeight: '700', textTransform: 'uppercase' }}>
              Raport Bayangan Triwulanan
            </span>
            <h1 style={{ fontSize: '26px', fontWeight: '800', color: '#0f172a', margin: '8px 0 4px 0' }}>
              Laporan Capaian Pembelajaran Anak
            </h1>
            <p style={{ color: '#64748b', margin: 0, fontSize: '14px' }}>
              Evaluasi perkembangan akademik berdasarkan Kurikulum Merdeka
            </p>
          </div>

          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '18px', fontWeight: '800', color: '#0284c7' }}>
              {activeChild.avatar_url || '🧑‍🎓'} {activeChild.name}
            </div>
            <div style={{ fontSize: '13px', color: '#64748b' }}>
              {levelName}
            </div>
          </div>
        </div>

        {/* Quick Stats Grid */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '16px' }}>
          <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px', textAlign: 'center' }}>
            <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>TOTAL SESI LATIHAN</div>
            <div style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', marginTop: '4px' }}>{totalSessions}</div>
          </div>

          <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px', textAlign: 'center' }}>
            <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>TOTAL XP PRESTASI</div>
            <div style={{ fontSize: '28px', fontWeight: '800', color: '#16a34a', marginTop: '4px' }}>{activeChild.xp_total || 0} XP</div>
          </div>

          <div style={{ backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px', textAlign: 'center' }}>
            <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b' }}>LEVEL BELAJAR</div>
            <div style={{ fontSize: '28px', fontWeight: '800', color: '#d97706', marginTop: '4px' }}>Level {activeChild.current_level || 1}</div>
          </div>
        </div>
      </div>

      {/* Analysis: Strengths & Growth Areas */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: '20px', marginBottom: '28px' }}>
        {/* Strengths */}
        <div style={{ backgroundColor: '#f0fdf4', borderRadius: '16px', padding: '24px', border: '1px solid #bbf7d0' }}>
          <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#15803d', margin: '0 0 12px 0' }}>
            🌟 Kekuatan Utama Anak
          </h3>
          {strengths.length === 0 ? (
            <p style={{ color: '#475569', fontSize: '14px' }}>
              Selesaikan lebih banyak topik kuis untuk memetakan kekuatan utama anak.
            </p>
          ) : (
            <ul style={{ margin: 0, paddingLeft: '20px', color: '#166534', fontSize: '14px', lineHeight: '1.6' }}>
              {strengths.map((s, idx) => (
                <li key={idx}>
                  <strong>{s.elementName}</strong> ({s.subjectName}): Rata-rata nilai {s.averageScore}%
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* Growth Areas */}
        <div style={{ backgroundColor: '#fffbeb', borderRadius: '16px', padding: '24px', border: '1px solid #fde68a' }}>
          <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#b45309', margin: '0 0 12px 0' }}>
            🎯 Perlu Pendampingan Tambahan
          </h3>
          {growthAreas.length === 0 ? (
            <p style={{ color: '#475569', fontSize: '14px' }}>
              Hebat! Tidak ada materi yang tertinggal sejauh ini.
            </p>
          ) : (
            <ul style={{ margin: 0, paddingLeft: '20px', color: '#92400e', fontSize: '14px', lineHeight: '1.6' }}>
              {growthAreas.map((g, idx) => (
                <li key={idx}>
                  <strong>{g.elementName}</strong> ({g.subjectName}): Perlu latihan ulang (Nilai: {g.averageScore}%)
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>

      {/* Detail Breakdown per Elemen */}
      <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '24px', border: '1px solid #e2e8f0' }}>
        <h3 style={{ fontSize: '18px', fontWeight: '800', color: '#0f172a', marginBottom: '16px' }}>
          📊 Breakdown Penguasaan Per Elemen / Domain
        </h3>

        {elementReport.length === 0 ? (
          <div style={{ color: '#94a3b8', textAlign: 'center', padding: '32px', fontSize: '14px' }}>
            Belum ada data pengerjaan kuis. Ajak anak mengerjakan latihan soal pertama!
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            {elementReport.map((item, idx) => (
              <div key={idx} style={{ borderBottom: '1px solid #f1f5f9', paddingBottom: '12px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '14px', fontWeight: '700', marginBottom: '6px' }}>
                  <span style={{ color: '#0f172a' }}>{item.elementName} <span style={{ fontSize: '12px', fontWeight: '500', color: '#64748b' }}>({item.subjectName})</span></span>
                  <span style={{ color: item.averageScore >= 80 ? '#16a34a' : '#0284c7' }}>{item.averageScore}%</span>
                </div>
                <div style={{ height: '8px', backgroundColor: '#f1f5f9', borderRadius: '4px', overflow: 'hidden' }}>
                  <div
                    style={{
                      height: '100%',
                      width: `${item.averageScore}%`,
                      backgroundColor: item.averageScore >= 80 ? '#16a34a' : item.averageScore >= 60 ? '#0284c7' : '#d97706',
                      borderRadius: '4px',
                    }}
                  />
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
