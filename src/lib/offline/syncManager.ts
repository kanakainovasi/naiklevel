/**
 * Offline Sync Manager for Naik Level App & Mobile App
 * Caches quiz sessions and XP logs when offline and syncs them automatically upon reconnection.
 */

export interface PendingQuizSession {
  id: string
  childId: string
  topicId: string
  sessionType: 'regular' | 'olympiad'
  score: number
  totalQuestions: number
  correctAnswers: number
  xpEarned: number
  timestamp: string
}

const OFFLINE_QUEUE_KEY = 'naiklevel_offline_quiz_queue'

/**
 * Queue a completed quiz session when device is offline
 */
export function queueOfflineQuizSession(session: PendingQuizSession): void {
  if (typeof window === 'undefined') return

  try {
    const existingQueue: PendingQuizSession[] = JSON.parse(
      localStorage.getItem(OFFLINE_QUEUE_KEY) || '[]'
    )
    existingQueue.push(session)
    localStorage.setItem(OFFLINE_QUEUE_KEY, JSON.stringify(existingQueue))
    console.log('[OfflineSync] Session queued offline:', session.id)
  } catch (err) {
    console.error('[OfflineSync] Failed to queue offline session:', err)
  }
}

/**
 * Retrieve pending offline quiz sessions
 */
export function getPendingOfflineSessions(): PendingQuizSession[] {
  if (typeof window === 'undefined') return []

  try {
    return JSON.parse(localStorage.getItem(OFFLINE_QUEUE_KEY) || '[]')
  } catch {
    return []
  }
}

/**
 * Clear pending offline queue after successful sync
 */
export function clearOfflineQueue(): void {
  if (typeof window === 'undefined') return
  localStorage.removeItem(OFFLINE_QUEUE_KEY)
}
