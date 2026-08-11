'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Database } from '@/types/database'

type Question = Database['public']['Tables']['questions']['Row']
type EducationLevel = Database['public']['Tables']['education_levels']['Row']
type Subject = Database['public']['Tables']['subjects']['Row']
type Topic = Database['public']['Tables']['topics']['Row']

interface Props {
  initialQuestions: Question[]
  educationLevels: EducationLevel[]
  subjects: Subject[]
  topics: Topic[]
}

export default function QuestionManager({
  initialQuestions,
  educationLevels,
  subjects,
  topics,
}: Props) {
  const supabase = createClient()

  const [questions, setQuestions] = useState<Question[]>(initialQuestions)
  const [selectedTopicId, setSelectedTopicId] = useState<string>('')
  const [questionTypeFilter, setQuestionTypeFilter] = useState<string>('all')
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingQuestion, setEditingQuestion] = useState<Question | null>(null)

  // Form State
  const [formTopicId, setFormTopicId] = useState<string>(topics[0]?.id || '')
  const [formQuestionType, setFormQuestionType] = useState<'regular' | 'olympiad'>('regular')
  const [formContentType, setFormContentType] = useState<'multiple_choice' | 'true_false' | 'fill_blank'>('multiple_choice')
  const [formQuestionText, setFormQuestionText] = useState('')
  const [formExplanation, setFormExplanation] = useState('')
  const [formDifficulty, setFormDifficulty] = useState<number>(1)
  const [formXpReward, setFormXpReward] = useState<number>(10)
  const [formNeedsValidation, setFormNeedsValidation] = useState(false)

  // Options state for Multiple Choice
  const [options, setOptions] = useState([
    { id: 'opt_a', text: '' },
    { id: 'opt_b', text: '' },
    { id: 'opt_c', text: '' },
    { id: 'opt_d', text: '' },
  ])
  const [correctOptionId, setCorrectOptionId] = useState('opt_a')

  const filteredQuestions = questions.filter((q) => {
    if (selectedTopicId && q.topic_id !== selectedTopicId) return false
    if (questionTypeFilter !== 'all' && q.question_type !== questionTypeFilter) return false
    return true
  })

  const openAddModal = () => {
    setEditingQuestion(null)
    setFormQuestionText('')
    setFormExplanation('')
    setFormDifficulty(1)
    setFormXpReward(10)
    setFormNeedsValidation(false)
    setOptions([
      { id: 'opt_a', text: '' },
      { id: 'opt_b', text: '' },
      { id: 'opt_c', text: '' },
      { id: 'opt_d', text: '' },
    ])
    setCorrectOptionId('opt_a')
    setIsModalOpen(true)
  }

  const openEditModal = (q: Question) => {
    setEditingQuestion(q)
    setFormTopicId(q.topic_id)
    setFormQuestionType(q.question_type as 'regular' | 'olympiad')
    setFormContentType((q.content_type as any) || 'multiple_choice')
    setFormQuestionText(q.question_text)
    setFormExplanation(q.explanation || '')
    setFormDifficulty(q.difficulty || 1)
    setFormXpReward(q.xp_reward || 10)
    setFormNeedsValidation(q.needs_curriculum_validation || false)

    if (q.options && Array.isArray(q.options)) {
      setOptions(q.options as any)
    }
    if (q.correct_answer && typeof q.correct_answer === 'object') {
      const ca = q.correct_answer as any
      if (ca.option_id) setCorrectOptionId(ca.option_id)
    }
    setIsModalOpen(true)
  }

  const handleSaveQuestion = async (e: React.FormEvent) => {
    e.preventDefault()

    const questionData = {
      topic_id: formTopicId,
      question_type: formQuestionType,
      content_type: formContentType,
      question_text: formQuestionText,
      explanation: formExplanation,
      difficulty: formDifficulty,
      xp_reward: formXpReward,
      needs_curriculum_validation: formNeedsValidation,
      options: formContentType === 'multiple_choice' ? options : null,
      correct_answer: formContentType === 'multiple_choice' ? { option_id: correctOptionId } : { text_value: 'true' },
    }

    if (editingQuestion) {
      const { data, error } = await supabase
        .from('questions')
        .update(questionData)
        .eq('id', editingQuestion.id)
        .select()
        .single()

      if (error) {
        alert('Gagal mengupdate soal: ' + error.message)
        return
      }
      setQuestions(questions.map((q) => (q.id === editingQuestion.id ? data : q)))
    } else {
      const { data, error } = await supabase
        .from('questions')
        .insert(questionData)
        .select()
        .single()

      if (error) {
        alert('Gagal menambah soal: ' + error.message)
        return
      }
      setQuestions([data, ...questions])
    }

    setIsModalOpen(false)
  }

  const handleDeleteQuestion = async (id: string) => {
    if (!confirm('Apakah Anda yakin ingin menghapus soal ini?')) return

    const { error } = await supabase.from('questions').delete().eq('id', id)
    if (error) {
      alert('Gagal menghapus soal: ' + error.message)
      return
    }
    setQuestions(questions.filter((q) => q.id !== id))
  }

  const handleToggleValidation = async (q: Question) => {
    const newVal = !q.needs_curriculum_validation
    const { error } = await supabase
      .from('questions')
      .update({ needs_curriculum_validation: newVal })
      .eq('id', q.id)

    if (error) {
      alert('Gagal mengubah status validasi: ' + error.message)
      return
    }

    setQuestions(
      questions.map((item) =>
        item.id === q.id ? { ...item, needs_curriculum_validation: newVal } : item
      )
    )
  }

  return (
    <div>
      {/* Header & Actions */}
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          marginBottom: '24px',
        }}
      >
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            📝 Bank Soal & CMS Content
          </h1>
          <p style={{ color: '#64748b', marginTop: '4px', fontSize: '14px' }}>
            Kelola, edit, dan tambah latihan soal serta olimpiade secara manual.
          </p>
        </div>

        <button
          onClick={openAddModal}
          style={{
            backgroundColor: '#0284c7',
            color: 'white',
            border: 'none',
            padding: '12px 20px',
            borderRadius: '8px',
            fontWeight: '600',
            cursor: 'pointer',
            fontSize: '14px',
            boxShadow: '0 2px 4px rgba(2,132,199,0.2)',
          }}
        >
          ➕ Tambah Soal Baru
        </button>
      </div>

      {/* Filters Bar */}
      <div
        style={{
          backgroundColor: 'white',
          padding: '16px 20px',
          borderRadius: '12px',
          border: '1px solid #e2e8f0',
          marginBottom: '24px',
          display: 'flex',
          gap: '16px',
          flexWrap: 'wrap',
          alignItems: 'center',
        }}
      >
        <div style={{ flex: 1, minWidth: '200px' }}>
          <label style={{ display: 'block', fontSize: '12px', fontWeight: '600', color: '#64748b', marginBottom: '4px' }}>
            Filter Topik/Bab
          </label>
          <select
            value={selectedTopicId}
            onChange={(e) => setSelectedTopicId(e.target.value)}
            style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
          >
            <option value="">-- Semua Topik --</option>
            {topics.map((t) => (
              <option key={t.id} value={t.id}>
                {t.name}
              </option>
            ))}
          </select>
        </div>

        <div style={{ width: '180px' }}>
          <label style={{ display: 'block', fontSize: '12px', fontWeight: '600', color: '#64748b', marginBottom: '4px' }}>
            Tipe Soal
          </label>
          <select
            value={questionTypeFilter}
            onChange={(e) => setQuestionTypeFilter(e.target.value)}
            style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
          >
            <option value="all">Semua Tipe</option>
            <option value="regular">Kuis Reguler</option>
            <option value="olympiad">Soal Olimpiade</option>
          </select>
        </div>

        <div style={{ alignSelf: 'flex-end' }}>
          <span style={{ fontSize: '13px', color: '#64748b', fontWeight: '500' }}>
            Menampilkan: <strong>{filteredQuestions.length}</strong> soal
          </span>
        </div>
      </div>

      {/* Question Table */}
      <div style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid #e2e8f0', overflow: 'hidden' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '14px' }}>
          <thead>
            <tr style={{ backgroundColor: '#f8fafc', borderBottom: '2px solid #e2e8f0', textAlign: 'left' }}>
              <th style={{ padding: '12px 16px', color: '#475569' }}>No</th>
              <th style={{ padding: '12px 16px', color: '#475569' }}>Pertanyaan</th>
              <th style={{ padding: '12px 16px', color: '#475569' }}>Topik</th>
              <th style={{ padding: '12px 16px', color: '#475569' }}>Tipe</th>
              <th style={{ padding: '12px 16px', color: '#475569' }}>XP Reward</th>
              <th style={{ padding: '12px 16px', color: '#475569' }}>Status Validasi</th>
              <th style={{ padding: '12px 16px', color: '#475569', textAlign: 'center' }}>Aksi</th>
            </tr>
          </thead>
          <tbody>
            {filteredQuestions.length === 0 ? (
              <tr>
                <td colSpan={7} style={{ textAlign: 'center', padding: '32px', color: '#94a3b8' }}>
                  Tidak ada soal yang ditemukan. Klik tombol "Tambah Soal Baru" untuk membuat soal.
                </td>
              </tr>
            ) : (
              filteredQuestions.map((q, idx) => {
                const topic = topics.find((t) => t.id === q.topic_id)
                return (
                  <tr key={q.id} style={{ borderBottom: '1px solid #f1f5f9' }}>
                    <td style={{ padding: '12px 16px', color: '#94a3b8', fontWeight: '500' }}>{idx + 1}</td>
                    <td style={{ padding: '12px 16px', fontWeight: '600', color: '#0f172a', maxWidth: '350px' }}>
                      {q.question_text}
                    </td>
                    <td style={{ padding: '12px 16px', color: '#475569', fontSize: '13px' }}>
                      {topic?.name || 'Topik Umum'}
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <span
                        style={{
                          padding: '4px 8px',
                          borderRadius: '12px',
                          fontSize: '11px',
                          fontWeight: '700',
                          backgroundColor: q.question_type === 'olympiad' ? '#fef3c7' : '#e0f2fe',
                          color: q.question_type === 'olympiad' ? '#d97706' : '#0369a1',
                        }}
                      >
                        {q.question_type === 'olympiad' ? '🏆 Olimpiade' : '📖 Reguler'}
                      </span>
                    </td>
                    <td style={{ padding: '12px 16px', fontWeight: '600', color: '#16a34a' }}>
                      +{q.xp_reward || 10} XP
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <button
                        onClick={() => handleToggleValidation(q)}
                        style={{
                          padding: '4px 10px',
                          borderRadius: '6px',
                          border: 'none',
                          fontSize: '12px',
                          fontWeight: '600',
                          cursor: 'pointer',
                          backgroundColor: q.needs_curriculum_validation ? '#fee2e2' : '#dcfce7',
                          color: q.needs_curriculum_validation ? '#dc2626' : '#15803d',
                        }}
                      >
                        {q.needs_curriculum_validation ? '⚠️ Perlu Review' : '✅ Tervalidasi'}
                      </button>
                    </td>
                    <td style={{ padding: '12px 16px', textAlign: 'center' }}>
                      <button
                        onClick={() => openEditModal(q)}
                        style={{
                          marginRight: '8px',
                          padding: '6px 12px',
                          backgroundColor: '#f1f5f9',
                          color: '#0f172a',
                          border: '1px solid #cbd5e1',
                          borderRadius: '6px',
                          cursor: 'pointer',
                          fontSize: '12px',
                          fontWeight: '600',
                        }}
                      >
                        ✏️ Edit
                      </button>
                      <button
                        onClick={() => handleDeleteQuestion(q.id)}
                        style={{
                          padding: '6px 12px',
                          backgroundColor: '#fee2e2',
                          color: '#b91c1c',
                          border: 'none',
                          borderRadius: '6px',
                          cursor: 'pointer',
                          fontSize: '12px',
                          fontWeight: '600',
                        }}
                      >
                        🗑️ Hapus
                      </button>
                    </td>
                  </tr>
                )
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Modal Add / Edit Question */}
      {isModalOpen && (
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
            padding: '20px',
          }}
        >
          <div
            style={{
              backgroundColor: 'white',
              borderRadius: '12px',
              padding: '28px',
              maxWidth: '650px',
              width: '100%',
              maxHeight: '90vh',
              overflowY: 'auto',
              boxShadow: '0 20px 25px -5px rgba(0,0,0,0.1)',
            }}
          >
            <h2 style={{ fontSize: '20px', fontWeight: '800', marginBottom: '20px', color: '#0f172a' }}>
              {editingQuestion ? '✏️ Edit Soal' : '➕ Tambah Soal Baru'}
            </h2>

            <form onSubmit={handleSaveQuestion}>
              <div style={{ marginBottom: '16px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                  Topik/Bab Kurikulum
                </label>
                <select
                  value={formTopicId}
                  onChange={(e) => setFormTopicId(e.target.value)}
                  required
                  style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                >
                  {topics.map((t) => (
                    <option key={t.id} value={t.id}>
                      {t.name}
                    </option>
                  ))}
                </select>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '16px' }}>
                <div>
                  <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                    Tipe Soal
                  </label>
                  <select
                    value={formQuestionType}
                    onChange={(e) => setFormQuestionType(e.target.value as any)}
                    style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                  >
                    <option value="regular">Reguler (Latihan)</option>
                    <option value="olympiad">Olimpiade (Timer)</option>
                  </select>
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                    Jenis Jawaban
                  </label>
                  <select
                    value={formContentType}
                    onChange={(e) => setFormContentType(e.target.value as any)}
                    style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                  >
                    <option value="multiple_choice">Pilihan Ganda</option>
                    <option value="true_false">Benar / Salah</option>
                  </select>
                </div>
              </div>

              <div style={{ marginBottom: '16px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                  Teks Pertanyaan
                </label>
                <textarea
                  value={formQuestionText}
                  onChange={(e) => setFormQuestionText(e.target.value)}
                  rows={3}
                  required
                  placeholder="Contoh: Berapakah hasil dari 5 + 3?"
                  style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1', fontSize: '14px' }}
                />
              </div>

              {/* Options Editor for Multiple Choice */}
              {formContentType === 'multiple_choice' && (
                <div style={{ marginBottom: '20px', backgroundColor: '#f8fafc', padding: '16px', borderRadius: '8px' }}>
                  <label style={{ display: 'block', fontSize: '13px', fontWeight: '700', marginBottom: '10px', color: '#334155' }}>
                    Pilihan Jawaban & Kunci Jawaban
                  </label>
                  {options.map((opt, idx) => (
                    <div key={opt.id} style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '8px' }}>
                      <input
                        type="radio"
                        name="correct_option"
                        checked={correctOptionId === opt.id}
                        onChange={() => setCorrectOptionId(opt.id)}
                        title="Tandai sebagai kunci jawaban benar"
                      />
                      <span style={{ fontWeight: '600', fontSize: '13px', width: '20px' }}>
                        {String.fromCharCode(65 + idx)}.
                      </span>
                      <input
                        type="text"
                        value={opt.text}
                        onChange={(e) => {
                          const newOpts = [...options]
                          newOpts[idx].text = e.target.value
                          setOptions(newOpts)
                        }}
                        placeholder={`Pilihan ${String.fromCharCode(65 + idx)}`}
                        required
                        style={{ flex: 1, padding: '8px 10px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                      />
                    </div>
                  ))}
                  <span style={{ fontSize: '11px', color: '#64748b' }}>
                    * Radio button yang terpilih adalah KUNCI JAWABAN BENAR.
                  </span>
                </div>
              )}

              <div style={{ marginBottom: '16px' }}>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                  Penjelasan Jawaban (Pembahasan)
                </label>
                <textarea
                  value={formExplanation}
                  onChange={(e) => setFormExplanation(e.target.value)}
                  rows={2}
                  placeholder="Penjelasan ringkas agar anak mengerti mengapa jawaban ini benar."
                  style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1', fontSize: '14px' }}
                />
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '20px' }}>
                <div>
                  <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '6px' }}>
                    Reward XP
                  </label>
                  <input
                    type="number"
                    value={formXpReward}
                    onChange={(e) => setFormXpReward(Number(e.target.value))}
                    min={5}
                    max={100}
                    style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #cbd5e1' }}
                  />
                </div>
                <div style={{ display: 'flex', alignItems: 'center', marginTop: '20px' }}>
                  <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer', fontSize: '13px', fontWeight: '600' }}>
                    <input
                      type="checkbox"
                      checked={formNeedsValidation}
                      onChange={(e) => setFormNeedsValidation(e.target.checked)}
                    />
                    Butuh Review Kurikulum
                  </label>
                </div>
              </div>

              <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '12px', borderTop: '1px solid #e2e8f0', paddingTop: '16px' }}>
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  style={{ padding: '10px 18px', backgroundColor: '#f1f5f9', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer' }}
                >
                  Batal
                </button>
                <button
                  type="submit"
                  style={{ padding: '10px 18px', backgroundColor: '#0284c7', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer' }}
                >
                  Simpan Soal
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
