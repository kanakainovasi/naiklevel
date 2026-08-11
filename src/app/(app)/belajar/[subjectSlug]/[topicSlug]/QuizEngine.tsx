'use client'

import { useState } from 'react'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { Database } from '@/types/database'

type Question = Database['public']['Tables']['questions']['Row']
type Topic = Database['public']['Tables']['topics']['Row']
type Child = Database['public']['Tables']['children']['Row']

interface Props {
  questions: Question[]
  topic: Topic
  activeChild: Child
  subjectSlug: string
}

export default function QuizEngine({
  questions,
  topic,
  activeChild,
  subjectSlug,
}: Props) {
  const supabase = createClient()

  const [currentIndex, setCurrentIndex] = useState(0)
  const [selectedOptionId, setSelectedOptionId] = useState<string | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [isCorrect, setIsCorrect] = useState(false)
  const [correctCount, setCorrectCount] = useState(0)
  const [totalXpEarned, setTotalXpEarned] = useState(0)
  const [isCompleted, setIsCompleted] = useState(false)

  const currentQuestion = questions[currentIndex]

  if (!currentQuestion && !isCompleted) {
    return (
      <div style={{ textAlign: 'center', padding: '60px 20px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
        <h2>Belum Ada Soal di Topik Ini</h2>
        <p style={{ color: '#64748b' }}>Admin akan segera menambahkan soal latihan untuk topik ini.</p>
        <Link href={`/belajar/${subjectSlug}`} style={{ padding: '10px 20px', backgroundColor: '#0284c7', color: 'white', borderRadius: '8px', textDecoration: 'none', fontWeight: '700' }}>
          ← Kembali ke Daftar Topik
        </Link>
      </div>
    )
  }

  const handleSelectOption = (optId: string) => {
    if (isAnswered) return
    setSelectedOptionId(optId)

    const ca = currentQuestion.correct_answer as any
    const correctOptId = ca?.option_id || 'a'
    const correct = optId === correctOptId

    setIsAnswered(true)
    setIsCorrect(correct)

    if (correct) {
      setCorrectCount((prev) => prev + 1)
      setTotalXpEarned((prev) => prev + (currentQuestion.xp_reward || 10))
    }
  }

  const handleNextQuestion = () => {
    if (currentIndex + 1 < questions.length) {
      setCurrentIndex((prev) => prev + 1)
      setSelectedOptionId(null)
      setIsAnswered(false)
    } else {
      finishQuiz()
    }
  }

  const finishQuiz = async () => {
    setIsCompleted(true)

    // Save Quiz Session to Supabase
    const finalScore = Math.round((correctCount / questions.length) * 100)
    const { data: session } = await supabase
      .from('quiz_sessions')
      .insert({
        child_id: activeChild.id,
        topic_id: topic.id,
        session_type: 'regular',
        score: finalScore,
        total_questions: questions.length,
        correct_answers: correctCount,
        xp_earned: totalXpEarned,
      })
      .select()
      .single()

    // Log XP and update child's XP total
    if (totalXpEarned > 0) {
      await supabase.from('child_xp_log').insert({
        child_id: activeChild.id,
        xp_amount: totalXpEarned,
        source_type: 'quiz_regular',
        source_id: session?.id || null,
      })

      const newXp = (activeChild.xp_total || 0) + totalXpEarned
      const newLevel = Math.floor(newXp / 100) + 1

      await supabase
        .from('children')
        .update({
          xp_total: newXp,
          current_level: newLevel,
          last_active_at: new Date().toISOString(),
        })
        .eq('id', activeChild.id)
    }
  }

  // Quiz Results View
  if (isCompleted) {
    const finalScore = Math.round((correctCount / questions.length) * 100)
    return (
      <div
        style={{
          backgroundColor: 'white',
          borderRadius: '20px',
          padding: '36px',
          maxWidth: '600px',
          margin: '0 auto',
          textAlign: 'center',
          boxShadow: '0 10px 25px rgba(0,0,0,0.08)',
          border: '2px solid #e0f2fe',
        }}
      >
        <div style={{ fontSize: '64px', marginBottom: '16px' }}>
          {finalScore >= 80 ? '🎉' : finalScore >= 50 ? '👍' : '💪'}
        </div>

        <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', margin: '0 0 8px 0' }}>
          {finalScore >= 80 ? 'Luar Biasa, Naik Level!' : 'Bagus Sekali! Terus Berlatih!'}
        </h1>
        <p style={{ color: '#64748b', fontSize: '15px', marginBottom: '28px' }}>
          Kamu telah menyelesaikan topik <strong>{topic.name}</strong>.
        </p>

        {/* Score & XP Summary Card */}
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: '1fr 1fr',
            gap: '16px',
            backgroundColor: '#f8fafc',
            padding: '20px',
            borderRadius: '16px',
            marginBottom: '28px',
          }}
        >
          <div>
            <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b', textTransform: 'uppercase' }}>
              Nilai Kamu
            </div>
            <div style={{ fontSize: '36px', fontWeight: '800', color: '#0284c7', marginTop: '4px' }}>
              {finalScore}%
            </div>
            <div style={{ fontSize: '12px', color: '#94a3b8' }}>
              {correctCount} dari {questions.length} benar
            </div>
          </div>

          <div>
            <div style={{ fontSize: '12px', fontWeight: '700', color: '#64748b', textTransform: 'uppercase' }}>
              XP Diperoleh
            </div>
            <div style={{ fontSize: '36px', fontWeight: '800', color: '#16a34a', marginTop: '4px' }}>
              +{totalXpEarned}
            </div>
            <div style={{ fontSize: '12px', color: '#94a3b8' }}>Point Pengalaman</div>
          </div>
        </div>

        <div style={{ display: 'flex', gap: '12px', justifyContent: 'center' }}>
          <Link
            href={`/belajar/${subjectSlug}`}
            style={{
              padding: '12px 24px',
              backgroundColor: '#0284c7',
              color: 'white',
              borderRadius: '10px',
              fontWeight: '700',
              textDecoration: 'none',
              fontSize: '15px',
            }}
          >
            Lanjut Topik Lain 🚀
          </Link>
        </div>
      </div>
    )
  }

  // Active Question View
  const progressPercent = Math.round(((currentIndex + 1) / questions.length) * 100)
  const options = (currentQuestion.options as any) || []

  return (
    <div style={{ maxWidth: '700px', margin: '0 auto' }}>
      {/* Header & Progress Bar */}
      <div style={{ marginBottom: '24px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
          <span style={{ fontSize: '14px', fontWeight: '700', color: '#0284c7' }}>
            Soal {currentIndex + 1} dari {questions.length}
          </span>
          <span style={{ fontSize: '14px', fontWeight: '700', color: '#16a34a' }}>
            +{currentQuestion.xp_reward || 10} XP
          </span>
        </div>

        <div style={{ height: '8px', backgroundColor: '#e2e8f0', borderRadius: '4px', overflow: 'hidden' }}>
          <div
            style={{
              height: '100%',
              width: `${progressPercent}%`,
              backgroundColor: '#0284c7',
              transition: 'width 0.3s ease',
            }}
          />
        </div>
      </div>

      {/* Question Card */}
      <div
        style={{
          backgroundColor: 'white',
          borderRadius: '20px',
          padding: '28px',
          border: '1px solid #e2e8f0',
          boxShadow: '0 4px 12px rgba(0,0,0,0.04)',
          marginBottom: '24px',
        }}
      >
        <h2 style={{ fontSize: '20px', fontWeight: '800', color: '#0f172a', lineHeight: '1.5', margin: '0 0 24px 0' }}>
          {currentQuestion.question_text}
        </h2>

        {/* Options List */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
          {options.map((opt: any) => {
            let bg = 'white'
            let border = '2px solid #e2e8f0'
            let textColor = '#0f172a'

            if (isAnswered) {
              const ca = currentQuestion.correct_answer as any
              if (opt.id === ca?.option_id) {
                bg = '#dcfce7'
                border = '2px solid #16a34a'
                textColor = '#15803d'
              } else if (opt.id === selectedOptionId && !isCorrect) {
                bg = '#fee2e2'
                border = '2px solid #dc2626'
                textColor = '#b91c1c'
              }
            }

            return (
              <button
                key={opt.id}
                onClick={() => handleSelectOption(opt.id)}
                disabled={isAnswered}
                style={{
                  textAlign: 'left',
                  padding: '16px 20px',
                  borderRadius: '12px',
                  backgroundColor: bg,
                  border: border,
                  color: textColor,
                  fontSize: '16px',
                  fontWeight: '600',
                  cursor: isAnswered ? 'default' : 'pointer',
                  transition: 'all 0.2s ease',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '12px',
                }}
              >
                <span
                  style={{
                    width: '28px',
                    height: '28px',
                    borderRadius: '50%',
                    backgroundColor: isAnswered && opt.id === (currentQuestion.correct_answer as any)?.option_id ? '#16a34a' : '#f1f5f9',
                    color: isAnswered && opt.id === (currentQuestion.correct_answer as any)?.option_id ? 'white' : '#475569',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '13px',
                    fontWeight: '700',
                  }}
                >
                  {opt.id.toUpperCase().replace('OPT_', '')}
                </span>
                <span>{opt.text}</span>
              </button>
            )
          })}
        </div>
      </div>

      {/* Explanation Banner & Next Button */}
      {isAnswered && (
        <div
          style={{
            backgroundColor: isCorrect ? '#f0fdf4' : '#fef2f2',
            borderRadius: '16px',
            padding: '20px',
            border: isCorrect ? '1px solid #bbf7d0' : '1px solid #fecaca',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            flexWrap: 'wrap',
            gap: '16px',
          }}
        >
          <div>
            <div style={{ fontSize: '16px', fontWeight: '800', color: isCorrect ? '#15803d' : '#b91c1c' }}>
              {isCorrect ? '✅ Jawaban Kamu Benar!' : '❌ Belum Tepat'}
            </div>
            {currentQuestion.explanation && (
              <p style={{ margin: '4px 0 0 0', fontSize: '14px', color: '#475569' }}>
                💡 Pembahasan: {currentQuestion.explanation}
              </p>
            )}
          </div>

          <button
            onClick={handleNextQuestion}
            style={{
              padding: '12px 24px',
              backgroundColor: '#0284c7',
              color: 'white',
              border: 'none',
              borderRadius: '10px',
              fontWeight: '700',
              fontSize: '15px',
              cursor: 'pointer',
            }}
          >
            {currentIndex + 1 === questions.length ? 'Lihat Hasil 🏆' : 'Soal Berikutnya →'}
          </button>
        </div>
      )}
    </div>
  )
}
