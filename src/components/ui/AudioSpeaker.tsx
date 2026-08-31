'use client'

import { useState } from 'react'

interface AudioSpeakerProps {
  textToSpeak: string
  label?: string
}

export function AudioSpeaker({ textToSpeak, label }: AudioSpeakerProps) {
  const [isSpeaking, setIsSpeaking] = useState(false)

  const handleSpeak = () => {
    if (!('speechSynthesis' in window)) {
      alert('Browser Anda belum mendukung suara otomatis.')
      return
    }

    window.speechSynthesis.cancel() // Stop any ongoing speech

    const utterance = new SpeechSynthesisUtterance(textToSpeak)
    utterance.lang = 'id-ID' // Bahasa Indonesia
    utterance.rate = 0.9 // Slightly slower for children

    utterance.onstart = () => setIsSpeaking(true)
    utterance.onend = () => setIsSpeaking(false)
    utterance.onerror = () => setIsSpeaking(false)

    window.speechSynthesis.speak(utterance)
  }

  return (
    <button
      type="button"
      onClick={handleSpeak}
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        gap: '6px',
        padding: '6px 14px',
        borderRadius: '20px',
        backgroundColor: isSpeaking ? '#fef08a' : '#e0f2fe',
        color: isSpeaking ? '#854d0e' : '#0369a1',
        border: '2px solid',
        borderColor: isSpeaking ? '#facc15' : '#7dd3fc',
        fontSize: '14px',
        fontWeight: '700',
        cursor: 'pointer',
        transition: 'all 0.2s ease',
      }}
      title="Dengarkan Suara Soal"
    >
      <span style={{ fontSize: '18px' }}>{isSpeaking ? '🔊' : '🔈'}</span>
      <span>{label || (isSpeaking ? 'Membaca...' : 'Dengar Suara')}</span>
    </button>
  )
}
