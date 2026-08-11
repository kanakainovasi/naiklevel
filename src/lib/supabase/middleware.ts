import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'
import { Database } from '@/types/database'

export async function updateSession(request: NextRequest) {
  let supabaseResponse = NextResponse.next({
    request,
  })

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!supabaseUrl || !supabaseAnonKey) {
    return supabaseResponse
  }

  const supabase = createServerClient<Database>(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value))
          supabaseResponse = NextResponse.next({
            request,
          })
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  // Verify session with Supabase Auth
  const {
    data: { user },
  } = await supabase.auth.getUser()

  const path = request.nextUrl.pathname
  const isAuthPath = path.startsWith('/masuk') || path.startsWith('/daftar')
  const isAdminPath = path.startsWith('/admin')
  const isProtectedPath =
    path.startsWith('/beranda') ||
    path.startsWith('/belajar') ||
    path.startsWith('/olimpiade') ||
    path.startsWith('/profil') ||
    path.startsWith('/dashboard') ||
    path.startsWith('/anak') ||
    path.startsWith('/raport')

  // Check admin access
  if (isAdminPath) {
    if (!user) {
      const url = request.nextUrl.clone()
      url.pathname = '/masuk'
      return NextResponse.redirect(url)
    }

    // Verify parent role
    const { data: parent } = await supabase
      .from('parents')
      .select('role')
      .eq('id', user.id)
      .single()

    if (!parent || parent.role !== 'admin') {
      const url = request.nextUrl.clone()
      url.pathname = '/beranda'
      return NextResponse.redirect(url)
    }
  }

  if (!user && isProtectedPath) {
    const url = request.nextUrl.clone()
    url.pathname = '/masuk'
    return NextResponse.redirect(url)
  }

  if (user && isAuthPath) {
    const url = request.nextUrl.clone()
    url.pathname = '/beranda'
    return NextResponse.redirect(url)
  }

  // Record pageview asynchronously (non-blocking for analytics)
  if (!path.startsWith('/api')) {
    const userAgent = request.headers.get('user-agent') || ''
    const referrer = request.headers.get('referer') || ''
    try {
      await supabase.from('page_views').insert({
        path,
        user_agent: userAgent,
        referrer,
        parent_id: user?.id || null,
      })
    } catch {
      // Ignore background analytics logging errors
    }
  }

  return supabaseResponse
}
