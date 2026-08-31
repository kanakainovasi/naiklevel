'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export interface PhotoSubmissionState {
  error?: string
  success?: boolean
}

export async function uploadPhotoSubmission(
  prevState: PhotoSubmissionState,
  formData: FormData
): Promise<PhotoSubmissionState> {
  const childId = formData.get('childId') as string
  const topicId = formData.get('topicId') as string
  const photoUrl = formData.get('photoUrl') as string
  const parentNote = formData.get('parentNote') as string

  if (!childId || !topicId || !photoUrl) {
    return { error: 'Foto dan data pendukung wajib diisi.' }
  }

  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return { error: 'Sesi Anda telah habis. Silakan masuk kembali.' }
  }

  // Insert record into photo_submissions
  const { error } = await supabase.from('photo_submissions').insert({
    child_id: childId,
    topic_id: topicId,
    photo_url: photoUrl,
    parent_note: parentNote || null,
  })

  if (error) {
    return { error: error.message }
  }

  revalidatePath('/karya')
  return { success: true }
}
