import { createClient } from '@/lib/supabase/server'
import { ChildSetupForm } from '@/features/children/ChildSetupForm'
import { redirect } from 'next/navigation'

export default async function ProfilSetupPage() {
  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/masuk')
  }

  // Fetch education levels from database
  let educationLevels: any[] = []
  try {
    const { data } = await supabase
      .from('education_levels')
      .select('id, name, level_type')
      .order('order_index', { ascending: true })
    educationLevels = data || []
  } catch (err) {
    console.error('Failed to load education levels:', err)
  }

  return (
    <main
      className="flex items-center justify-center"
      style={{
        minHeight: '100vh',
        background: 'linear-gradient(135deg, var(--color-primary-blue-soft) 0%, var(--color-primary-red-soft) 100%)',
        padding: '24px',
      }}
    >
      <div className="card" style={{ maxWidth: '500px', width: '100%', padding: '32px' }}>
        <div className="text-center mb-6">
          <span style={{ fontSize: '32px' }}>👋</span>
          <h2 style={{ fontSize: '22px', color: 'var(--color-text-main)', marginTop: '8px' }}>
            Buat Profil Anak Anda
          </h2>
          <p style={{ fontSize: '13px', color: 'var(--color-text-muted)', marginTop: '4px' }}>
            Naik Level mendukung multi-profil. Anda bisa menambah profil anak lain nanti.
          </p>
        </div>
        <ChildSetupForm educationLevels={educationLevels} />
      </div>
    </main>
  )
}
