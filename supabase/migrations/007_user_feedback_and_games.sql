-- ==============================================================================
-- Migration 007: User Feedback Inbox (Saran & Komplain) & Manual Subscriptions
-- ==============================================================================

BEGIN;

CREATE TABLE IF NOT EXISTS public.user_feedback (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id UUID REFERENCES public.parents(id) ON DELETE SET NULL,
    category TEXT NOT NULL CHECK (category IN ('saran', 'komplain', 'pertanyaan', 'lainnya')),
    subject TEXT NOT NULL,
    message TEXT NOT NULL,
    contact_email TEXT,
    status TEXT DEFAULT 'unread' CHECK (status IN ('unread', 'read', 'resolved')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast inbox queries
CREATE INDEX IF NOT EXISTS idx_user_feedback_status ON public.user_feedback(status);
CREATE INDEX IF NOT EXISTS idx_user_feedback_created ON public.user_feedback(created_at DESC);

-- Enable RLS
ALTER TABLE public.user_feedback ENABLE ROW LEVEL SECURITY;

-- Allow parents to insert feedback
CREATE POLICY "Parents can insert feedback" ON public.user_feedback
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Admin can read/update all feedback
CREATE POLICY "Admin can CRUD feedback" ON public.user_feedback
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.parents p
            WHERE p.id = auth.uid() AND p.role = 'admin'
        )
    );

COMMIT;
