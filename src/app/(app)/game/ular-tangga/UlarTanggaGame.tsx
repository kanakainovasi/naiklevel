'use client'

import { useState } from 'react'
import Link from 'next/link'
import { AudioSpeaker } from '@/components/ui/AudioSpeaker'
import { Database } from '@/types/database'

type Question = Database['public']['Tables']['questions']['Row']

interface Props {
  questions: Question[]
  childName: string
  childAvatar: string
}

// Ladders & Snakes Map for 25-square board
const LADDERS: Record<number, number> = {
  3: 11,
  6: 17,
  9: 18,
  15: 22,
}

const SNAKES: Record<number, number> = {
  14: 4,
  19: 8,
  23: 12,
  24: 16,
}

export default function UlarTanggaGame({ questions, childName, childAvatar }: Props) {
  const [playerPosition, setPlayerPosition] = useState(1)
  const [currentQIndex, setCurrentQIndex] = useState(0)
  const [diceRoll, setDiceRoll] = useState<number | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [isCorrect, setIsCorrect] = useState(false)
  const [selectedOpt, setSelectedOpt] = useState<string | null>(null)
  const [gameMessage, setGameMessage] = useState('Jawab pertanyaan di bawah ini untuk mengocok dadu dan melangkah!')
  const [isWon, setIsWon] = useState(false)

  const currentQ = questions[currentQIndex % questions.length]
  const options = (currentQ?.options as any) || []

  const handleAnswer = (optId: string) => {
    if (isAnswered) return
    setSelectedOpt(optId)

    const ca = currentQ.correct_answer as any
    const correct = optId === ca?.option_id

    setIsAnswered(true)
    setIsCorrect(correct)

    if (correct) {
      // Generate random dice roll 1-6
      const roll = Math.floor(Math.random() * 6) + 1
      setDiceRoll(roll)

      let nextPos = playerPosition + roll
      if (nextPos >= 25) {
        nextPos = 25
        setIsWon(true)
        setGameMessage(`🎉 SELAMAT ${childName.toUpperCase()}! Kamu berhasil mencapai garis finish (Petak 25)!`)
      } else {
        // Check for ladder or snake
        if (LADDERS[nextPos]) {
          const ladderTo = LADDERS[nextPos]
          setGameMessage(`✨ Hebat! Dadu ${roll}. Kamu mendarat di Tangga! Naik dari petak ${nextPos} ke ${ladderTo}! 🪜`)
          nextPos = ladderTo
        } else if (SNAKES[nextPos]) {
          const snakeTo = SNAKES[nextPos]
          setGameMessage(`🐍 Oh tidak! Dadu ${roll}. Kamu tergelincir di Ular dari petak ${nextPos} ke ${snakeTo}!`)
          nextPos = snakeTo
        } else {
          setGameMessage(`✅ Jawaban Benar! Dadu ${roll}. Kamu melangkah ke petak ${nextPos}!`)
        }
      }
      setPlayerPosition(nextPos)
    } else {
      setDiceRoll(null)
      setGameMessage('❌ Jawaban belum tepat! Dadu tidak terocok. Coba lagi di soal berikutnya!')
    }
  }

  const handleNextTurn = () => {
    setIsAnswered(false)
    setSelectedOpt(null)
    setCurrentQIndex((prev) => prev + 1)
  }

  return (
    <div style={{ maxWidth: '800px', margin: '0 auto' }}>
      {/* Header Banner */}
      <div
        style={{
          background: 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
          borderRadius: '20px',
          padding: '24px',
          color: 'white',
          boxShadow: '0 8px 20px rgba(16,185,129,0.3)',
          marginBottom: '24px',
          textAlign: 'center',
        }}
      >
        <h1 style={{ fontSize: '26px', fontWeight: '900', margin: 0 }}>
          🎲 Ular Tangga Edukasi Naik Level
        </h1>
        <p style={{ margin: '4px 0 0 0', opacity: 0.9, fontSize: '14px' }}>
          Jawab kuis dengan benar untuk menggulirkan dadu & capai petak 25!
        </p>
      </div>

      {/* Board & Question Layout */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: '20px', marginBottom: '24px' }}>
        {/* 5x5 Board Display */}
        <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '16px', border: '2px solid #059669', boxShadow: '0 4px 12px rgba(0,0,0,0.05)' }}>
          <h3 style={{ fontSize: '16px', fontWeight: '800', color: '#0f172a', textAlign: 'center', marginBottom: '12px' }}>
            Papan Permainan (25 Petak)
          </h3>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: '6px' }}>
            {Array.from({ length: 25 }, (_, i) => 25 - i).map((sq) => {
              const isPlayerHere = playerPosition === sq
              const isLadder = LADDERS[sq]
              const isSnake = SNAKES[sq]

              return (
                <div
                  key={sq}
                  style={{
                    height: '52px',
                    borderRadius: '8px',
                    backgroundColor: isPlayerHere ? '#fef08a' : isLadder ? '#dcfce7' : isSnake ? '#fee2e2' : '#f8fafc',
                    border: isPlayerHere ? '3px solid #eab308' : '1px solid #cbd5e1',
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '11px',
                    fontWeight: '700',
                    color: '#334155',
                    position: 'relative',
                  }}
                >
                  <span>{sq} {isLadder ? '🪜' : isSnake ? '🐍' : ''}</span>
                  {isPlayerHere && (
                    <span style={{ fontSize: '18px', position: 'absolute', bottom: '2px' }}>
                      {childAvatar || '🧑‍🎓'}
                    </span>
                  )}
                </div>
              )
            })}
          </div>
        </div>

        {/* Game Status & Question Card */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
          {/* Status Box */}
          <div style={{ backgroundColor: '#f0fdf4', padding: '16px', borderRadius: '14px', border: '1px solid #bbf7d0', fontSize: '14px', fontWeight: '700', color: '#166534' }}>
            📢 {gameMessage}
          </div>

          {isWon ? (
            <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '32px', border: '2px solid #10b981', textAlign: 'center' }}>
              <div style={{ fontSize: '56px', marginBottom: '12px' }}>🏆</div>
              <h2 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a' }}>
                Hore! {childName} Menang!
              </h2>
              <p style={{ color: '#64748b', fontSize: '14px', marginBottom: '20px' }}>
                Kamu telah menuntaskan permainan Ular Tangga Edukasi!
              </p>
              <Link href="/beranda" className="btn btn-primary">
                Kembali ke Beranda 🚀
              </Link>
            </div>
          ) : (
            currentQ && (
              <div style={{ backgroundColor: 'white', borderRadius: '16px', padding: '20px', border: '1px solid #e2e8f0', boxShadow: '0 2px 8px rgba(0,0,0,0.04)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                  <span style={{ fontSize: '12px', fontWeight: '700', color: '#059669', textTransform: 'uppercase' }}>
                    Soal Pengocok Dadu
                  </span>
                  <AudioSpeaker textToSpeak={currentQ.question_text} />
                </div>
                <h4 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', marginBottom: '16px' }}>
                  {currentQ.question_text}
                </h4>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginBottom: '16px' }}>
                  {options.map((opt: any) => (
                    <button
                      key={opt.id}
                      onClick={() => handleAnswer(opt.id)}
                      disabled={isAnswered}
                      style={{
                        textAlign: 'left',
                        padding: '12px 16px',
                        borderRadius: '10px',
                        backgroundColor: isAnswered && opt.id === (currentQ.correct_answer as any)?.option_id ? '#dcfce7' : isAnswered && opt.id === selectedOpt && !isCorrect ? '#fee2e2' : '#f8fafc',
                        border: '1.5px solid #cbd5e1',
                        fontSize: '14px',
                        fontWeight: '600',
                        color: '#0f172a',
                        cursor: isAnswered ? 'default' : 'pointer',
                      }}
                    >
                      {opt.text}
                    </button>
                  ))}
                </div>

                {isAnswered && (
                  <button
                    onClick={handleNextTurn}
                    className="btn btn-primary"
                    style={{ width: '100%' }}
                  >
                    Lanjut Soal Berikutnya →
                  </button>
                )}
              </div>
            )
          )}
        </div>
      </div>
    </div>
  )
}
