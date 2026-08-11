-- ==============================================================================
-- Migration: 002_admin_and_analytics.sql
-- Description: Adds role column to parents table and creates page_views table for traffic analytics.
-- ==============================================================================

-- 1. Add role column to parents table
ALTER TABLE public.parents
ADD COLUMN IF NOT EXISTS role TEXT DEFAULT 'parent' CHECK (role IN ('parent', 'admin'));

-- 2. Create page_views table for traffic analytics
CREATE TABLE IF NOT EXISTS public.page_views (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    path TEXT NOT NULL,
    user_agent TEXT,
    referrer TEXT,
    parent_id UUID REFERENCES public.parents(id) ON DELETE SET NULL,
    child_id UUID REFERENCES public.children(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for page_views queries
CREATE INDEX IF NOT EXISTS idx_page_views_created_at ON public.page_views(created_at);
CREATE INDEX IF NOT EXISTS idx_page_views_path ON public.page_views(path);

-- Enable RLS on page_views
ALTER TABLE public.page_views ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public insert into page_views (for visitor tracking)
CREATE POLICY "Allow public insert page_views"
    ON public.page_views FOR INSERT
    WITH CHECK (true);

-- Policy: Allow admins full access to page_views
CREATE POLICY "Admins can view page_views"
    ON public.page_views FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.parents
            WHERE parents.id = auth.uid() AND parents.role = 'admin'
        )
    );

-- Policy: Admin full access on curriculum and questions tables for CMS
CREATE POLICY "Admins full manage education_levels"
    ON public.education_levels FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins full manage subjects"
    ON public.subjects FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins full manage elements"
    ON public.elements FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins full manage topics"
    ON public.topics FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins full manage questions"
    ON public.questions FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins full manage badges"
    ON public.badges FOR ALL
    USING (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'))
    WITH CHECK (EXISTS (SELECT 1 FROM public.parents WHERE id = auth.uid() AND role = 'admin'));
