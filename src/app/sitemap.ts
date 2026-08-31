import type { MetadataRoute } from 'next'
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { Database } from '@/types/database'

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://naiklevel.id'
  const cookieStore = await cookies()
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

  const supabase = createServerClient<Database>(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll()
      },
      setAll() {},
    },
  })

  // Static routes
  const staticRoutes: MetadataRoute.Sitemap = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 1.0,
    },
    {
      url: `${baseUrl}/masuk`,
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.8,
    },
    {
      url: `${baseUrl}/daftar`,
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.9,
    },
  ]

  // Dynamic topic routes for SEO indexing
  let topicRoutes: MetadataRoute.Sitemap = []
  try {
    const { data: topics } = await supabase
      .from('topics')
      .select('slug, elements(subjects(slug))')
      .eq('is_published', true)

    if (topics) {
      topicRoutes = topics.map((t: any) => {
        const subjectSlug = t.elements?.subjects?.slug || 'matematika-sd-1'
        return {
          url: `${baseUrl}/materi/${subjectSlug}/${t.slug}`,
          lastModified: new Date(),
          changeFrequency: 'weekly' as const,
          priority: 0.8,
        }
      })
    }
  } catch (err) {
    console.error('Error generating dynamic sitemap topics:', err)
  }

  return [...staticRoutes, ...topicRoutes]
}
