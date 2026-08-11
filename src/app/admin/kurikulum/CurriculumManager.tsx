'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Database } from '@/types/database'

type EducationLevel = Database['public']['Tables']['education_levels']['Row']
type Subject = Database['public']['Tables']['subjects']['Row']
type ElementItem = Database['public']['Tables']['elements']['Row']
type Topic = Database['public']['Tables']['topics']['Row']

interface Props {
  educationLevels: EducationLevel[]
  subjects: Subject[]
  elements: ElementItem[]
  topics: Topic[]
}

export default function CurriculumManager({
  educationLevels,
  subjects: initialSubjects,
  elements: initialElements,
  topics: initialTopics,
}: Props) {
  const supabase = createClient()

  const [selectedLevelId, setSelectedLevelId] = useState<string>(educationLevels[0]?.id || '')
  const [subjects, setSubjects] = useState<Subject[]>(initialSubjects)
  const [elements, setElements] = useState<ElementItem[]>(initialElements)
  const [topics, setTopics] = useState<Topic[]>(initialTopics)

  const [selectedSubjectId, setSelectedSubjectId] = useState<string>('')
  const [selectedElementId, setSelectedElementId] = useState<string>('')

  // Modals state
  const [isTopicModalOpen, setIsTopicModalOpen] = useState(false)
  const [newTopicName, setNewTopicName] = useState('')
  const [newTopicSlug, setNewTopicSlug] = useState('')

  const levelSubjects = subjects.filter((s) => s.education_level_id === selectedLevelId)
  const activeSubjectId = selectedSubjectId || levelSubjects[0]?.id || ''
  const subjectElements = elements.filter((e) => e.subject_id === activeSubjectId)
  const activeElementId = selectedElementId || subjectElements[0]?.id || ''
  const elementTopics = topics.filter((t) => t.element_id === activeElementId)

  const handleAddTopic = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!activeElementId || !newTopicName) return

    const slug = newTopicSlug || newTopicName.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')

    const { data, error } = await supabase
      .from('topics')
      .insert({
        element_id: activeElementId,
        name: newTopicName,
        slug: slug,
        order_index: elementTopics.length + 1,
        is_published: true,
      })
      .select()
      .single()

    if (error) {
      alert('Gagal menambah topik: ' + error.message)
      return
    }

    setTopics([...topics, data])
    setNewTopicName('')
    setNewTopicSlug('')
    setIsTopicModalOpen(false)
  }

  const handleDeleteTopic = async (id: string) => {
    if (!confirm('Apakah Anda yakin ingin menghapus topik ini beserta seluruh soalnya?')) return
    const { error } = await supabase.from('topics').delete().eq('id', id)
    if (error) {
      alert('Gagal menghapus topik: ' + error.message)
      return
    }
    setTopics(topics.filter((t) => t.id !== id))
  }

  return (
    <div>
      {/* Header */}
      <div style={{ marginBottom: '24px' }}>
        <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
          📚 Struktur Kurikulum Merdeka
        </h1>
        <p style={{ color: '#64748b', marginTop: '4px', fontSize: '14px' }}>
          Kelola hierarki Jenjang → Mata Pelajaran → Elemen/Domain → Topik/Bab secara manual.
        </p>
      </div>

      {/* Level Selector Tabs */}
      <div style={{ display: 'flex', gap: '8px', marginBottom: '24px', overflowX: 'auto', paddingBottom: '8px' }}>
        {educationLevels.map((lvl) => (
          <button
            key={lvl.id}
            onClick={() => {
              setSelectedLevelId(lvl.id)
              setSelectedSubjectId('')
              setSelectedElementId('')
            }}
            style={{
              padding: '10px 18px',
              borderRadius: '8px',
              fontWeight: '700',
              fontSize: '14px',
              border: 'none',
              cursor: 'pointer',
              backgroundColor: selectedLevelId === lvl.id ? '#0f172a' : 'white',
              color: selectedLevelId === lvl.id ? 'white' : '#64748b',
              boxShadow: '0 1px 3px rgba(0,0,0,0.05)',
              borderWidth: '1px',
              borderStyle: 'solid',
              borderColor: selectedLevelId === lvl.id ? '#0f172a' : '#cbd5e1',
            }}
          >
            {lvl.level_type.toUpperCase()} {lvl.name} ({lvl.phase})
          </button>
        ))}
      </div>

      {/* Main Grid: Subjects -> Elements -> Topics */}
      <div style={{ display: 'grid', gridTemplateColumns: '260px 300px 1fr', gap: '20px' }}>
        {/* Panel 1: Subjects */}
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '16px', border: '1px solid #e2e8f0' }}>
          <h3 style={{ fontSize: '14px', fontWeight: '700', color: '#475569', textTransform: 'uppercase', marginBottom: '12px' }}>
            📖 Mata Pelajaran
          </h3>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
            {levelSubjects.length === 0 ? (
              <div style={{ color: '#94a3b8', fontSize: '13px' }}>Belum ada mapel di jenjang ini.</div>
            ) : (
              levelSubjects.map((s) => (
                <button
                  key={s.id}
                  onClick={() => {
                    setSelectedSubjectId(s.id)
                    setSelectedElementId('')
                  }}
                  style={{
                    textAlign: 'left',
                    padding: '10px 12px',
                    borderRadius: '6px',
                    border: 'none',
                    cursor: 'pointer',
                    fontSize: '13px',
                    fontWeight: '600',
                    backgroundColor: activeSubjectId === s.id ? '#e0f2fe' : 'transparent',
                    color: activeSubjectId === s.id ? '#0369a1' : '#334155',
                  }}
                >
                  {s.icon || '📘'} {s.name}
                </button>
              ))
            )}
          </div>
        </div>

        {/* Panel 2: Elements */}
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '16px', border: '1px solid #e2e8f0' }}>
          <h3 style={{ fontSize: '14px', fontWeight: '700', color: '#475569', textTransform: 'uppercase', marginBottom: '12px' }}>
            🧩 Elemen / Domain CP
          </h3>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
            {subjectElements.length === 0 ? (
              <div style={{ color: '#94a3b8', fontSize: '13px' }}>Pilih mata pelajaran untuk melihat elemen.</div>
            ) : (
              subjectElements.map((e) => (
                <button
                  key={e.id}
                  onClick={() => setSelectedElementId(e.id)}
                  style={{
                    textAlign: 'left',
                    padding: '10px 12px',
                    borderRadius: '6px',
                    border: 'none',
                    cursor: 'pointer',
                    fontSize: '13px',
                    fontWeight: '600',
                    backgroundColor: activeElementId === e.id ? '#fef3c7' : 'transparent',
                    color: activeElementId === e.id ? '#b45309' : '#334155',
                  }}
                >
                  • {e.name}
                </button>
              ))
            )}
          </div>
        </div>

        {/* Panel 3: Topics List */}
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #e2e8f0' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
            <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
              📌 Daftar Topik / Bab Belajar
            </h3>
            {activeElementId && (
              <button
                onClick={() => setIsTopicModalOpen(true)}
                style={{
                  backgroundColor: '#16a34a',
                  color: 'white',
                  border: 'none',
                  padding: '6px 12px',
                  borderRadius: '6px',
                  fontSize: '13px',
                  fontWeight: '600',
                  cursor: 'pointer',
                }}
              >
                ➕ Tambah Topik
              </button>
            )}
          </div>

          {!activeElementId ? (
            <div style={{ color: '#94a3b8', textAlign: 'center', padding: '40px 0', fontSize: '14px' }}>
              Pilih elemen untuk melihat dan mengedit daftar topik.
            </div>
          ) : elementTopics.length === 0 ? (
            <div style={{ color: '#94a3b8', textAlign: 'center', padding: '40px 0', fontSize: '14px' }}>
              Belum ada topik pada elemen ini. Klik "Tambah Topik" untuk menambahkan topik baru.
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
              {elementTopics.map((t, idx) => (
                <div
                  key={t.id}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    padding: '12px 16px',
                    borderRadius: '8px',
                    border: '1px solid #f1f5f9',
                    backgroundColor: '#fafafa',
                  }}
                >
                  <div>
                    <div style={{ fontWeight: '600', color: '#0f172a', fontSize: '14px' }}>
                      {idx + 1}. {t.name}
                    </div>
                    <div style={{ fontSize: '12px', color: '#94a3b8', marginTop: '2px' }}>
                      Slug: <code>{t.slug}</code>
                    </div>
                  </div>
                  <button
                    onClick={() => handleDeleteTopic(t.id)}
                    style={{
                      padding: '4px 8px',
                      backgroundColor: '#fee2e2',
                      color: '#b91c1c',
                      border: 'none',
                      borderRadius: '4px',
                      fontSize: '12px',
                      cursor: 'pointer',
                    }}
                  >
                    Hapus
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Add Topic Modal */}
      {isTopicModalOpen && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            backgroundColor: 'rgba(0,0,0,0.5)',
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            zIndex: 1000,
          }}
        >
          <div
            style={{
              backgroundColor: 'white',
              borderRadius: '12px',
              padding: '24px',
              width: '100%',
              maxWidth: '450px',
            }}
          >
            <h3 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '16px' }}>
              ➕ Tambah Topik / Bab Baru
            </h3>
            <form onSubmit={handleAddTopic}>
              <div style={{ marginBottom: '14px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '4px' }}>
                  Nama Topik
                </label>
                <input
                  type="text"
                  value={newTopicName}
                  onChange={(e) => setNewTopicName(e.target.value)}
                  placeholder="Contoh: Bilangan Cacah sampai 20"
                  required
                  style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                />
              </div>
              <div style={{ marginBottom: '20px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '4px' }}>
                  URL Slug (Opsional)
                </label>
                <input
                  type="text"
                  value={newTopicSlug}
                  onChange={(e) => setNewTopicSlug(e.target.value)}
                  placeholder="bilangan-cacah-sampai-20"
                  style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                />
              </div>
              <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px' }}>
                <button
                  type="button"
                  onClick={() => setIsTopicModalOpen(false)}
                  style={{ padding: '8px 14px', backgroundColor: '#f1f5f9', border: 'none', borderRadius: '6px', cursor: 'pointer' }}
                >
                  Batal
                </button>
                <button
                  type="submit"
                  style={{ padding: '8px 14px', backgroundColor: '#16a34a', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer' }}
                >
                  Simpan Topik
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
