-- ==============================================================================
-- Initial Schema for Naik Level App
-- Description: Creates all base tables, RLS policies, triggers, and indexes.
-- ==============================================================================

-- Ensure uuid extension is available
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==============================================================================
-- 1. Tables Creation
-- ==============================================================================

-- parents (Linked to Supabase Auth)
CREATE TABLE public.parents (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT NOT NULL,
    phone TEXT,
    privacy_consent_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    daily_limit_minutes INT DEFAULT 60,
    subscription_tier TEXT DEFAULT 'free' CHECK (subscription_tier IN ('free', 'premium')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- education_levels
CREATE TABLE public.education_levels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    phase TEXT NOT NULL,
    order_index INT NOT NULL,
    level_type TEXT NOT NULL CHECK (level_type IN ('tk', 'sd'))
);

-- children
CREATE TABLE public.children (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id UUID NOT NULL REFERENCES public.parents(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    birth_date DATE,
    avatar_url TEXT,
    education_level_id UUID REFERENCES public.education_levels(id) ON DELETE SET NULL,
    xp_total INT DEFAULT 0,
    current_level INT DEFAULT 1,
    streak_days INT DEFAULT 0,
    last_active_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- subjects
CREATE TABLE public.subjects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    education_level_id UUID NOT NULL REFERENCES public.education_levels(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    official_name TEXT,
    slug TEXT NOT NULL,
    icon TEXT,
    description TEXT,
    order_index INT NOT NULL,
    UNIQUE (education_level_id, slug)
);

-- elements
CREATE TABLE public.elements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id UUID NOT NULL REFERENCES public.subjects(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    order_index INT NOT NULL
);

-- topics
CREATE TABLE public.topics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    element_id UUID NOT NULL REFERENCES public.elements(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    description TEXT,
    order_index INT NOT NULL,
    is_published BOOLEAN DEFAULT false,
    UNIQUE (element_id, slug)
);

-- questions
CREATE TABLE public.questions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    topic_id UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
    question_type TEXT NOT NULL CHECK (question_type IN ('regular', 'olympiad')),
    content_type TEXT NOT NULL CHECK (content_type IN ('multiple_choice', 'true_false', 'fill_blank', 'matching')),
    question_text TEXT NOT NULL,
    question_image_url TEXT,
    options JSONB,
    correct_answer JSONB NOT NULL,
    explanation TEXT,
    difficulty INT DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 3),
    xp_reward INT DEFAULT 10,
    time_limit_seconds INT,
    needs_curriculum_validation BOOLEAN DEFAULT false,
    order_index INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- quiz_sessions
CREATE TABLE public.quiz_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES public.children(id) ON DELETE CASCADE,
    topic_id UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
    session_type TEXT CHECK (session_type IN ('regular', 'olympiad')),
    score INT,
    total_questions INT,
    correct_answers INT,
    xp_earned INT DEFAULT 0,
    time_spent_seconds INT,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- quiz_answers
CREATE TABLE public.quiz_answers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES public.quiz_sessions(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
    selected_answer JSONB,
    is_correct BOOLEAN,
    time_spent_seconds INT
);

-- badges
CREATE TABLE public.badges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    description TEXT,
    icon_url TEXT,
    criteria JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- child_badges
CREATE TABLE public.child_badges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES public.children(id) ON DELETE CASCADE,
    badge_id UUID NOT NULL REFERENCES public.badges(id) ON DELETE CASCADE,
    earned_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (child_id, badge_id)
);

-- child_xp_log
CREATE TABLE public.child_xp_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES public.children(id) ON DELETE CASCADE,
    xp_amount INT NOT NULL,
    source_type TEXT NOT NULL CHECK (source_type IN ('quiz_regular', 'quiz_olympiad', 'streak_bonus', 'badge_bonus')),
    source_id UUID,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- photo_submissions
CREATE TABLE public.photo_submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES public.children(id) ON DELETE CASCADE,
    topic_id UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
    photo_url TEXT NOT NULL,
    parent_note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- ==============================================================================
-- 2. Triggers for Updated At and Auth Synchronization
-- ==============================================================================

-- Auto-update updated_at for parents
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_parents_updated_at
BEFORE UPDATE ON public.parents
FOR EACH ROW EXECUTE PROCEDURE public.set_updated_at();

-- Auto-create parent on auth.users sign up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.parents (id, email, full_name, privacy_consent_at)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'Orang Tua'),
    NOW()
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();


-- ==============================================================================
-- 3. Row Level Security (RLS)
-- ==============================================================================

-- Enable RLS on all tables
ALTER TABLE public.parents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.children ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.education_levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.elements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.child_badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.child_xp_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.photo_submissions ENABLE ROW LEVEL SECURITY;

-- parents: CRUD own row
CREATE POLICY "Parents can manage their own profile"
    ON public.parents FOR ALL
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- children: Parent owner can CRUD
CREATE POLICY "Parents can manage their children"
    ON public.children FOR ALL
    USING (parent_id = auth.uid())
    WITH CHECK (parent_id = auth.uid());

-- quiz_sessions: Via child
CREATE POLICY "Parents can view and manage their children's quiz sessions"
    ON public.quiz_sessions FOR ALL
    USING (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()))
    WITH CHECK (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()));

-- quiz_answers: Via session -> child
CREATE POLICY "Parents can view and manage their children's quiz answers"
    ON public.quiz_answers FOR ALL
    USING (session_id IN (SELECT qs.id FROM public.quiz_sessions qs JOIN public.children c ON qs.child_id = c.id WHERE c.parent_id = auth.uid()))
    WITH CHECK (session_id IN (SELECT qs.id FROM public.quiz_sessions qs JOIN public.children c ON qs.child_id = c.id WHERE c.parent_id = auth.uid()));

-- child_badges: Via child
CREATE POLICY "Parents can view their children's badges"
    ON public.child_badges FOR ALL
    USING (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()))
    WITH CHECK (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()));

-- child_xp_log: Via child
CREATE POLICY "Parents can view their children's xp log"
    ON public.child_xp_log FOR ALL
    USING (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()))
    WITH CHECK (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()));

-- photo_submissions: Via child
CREATE POLICY "Parents can manage their children's photo submissions"
    ON public.photo_submissions FOR ALL
    USING (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()))
    WITH CHECK (child_id IN (SELECT id FROM public.children WHERE parent_id = auth.uid()));

-- Public Read-Only for Curriculum Data
CREATE POLICY "Public read access for education_levels" ON public.education_levels FOR SELECT USING (true);
CREATE POLICY "Public read access for subjects" ON public.subjects FOR SELECT USING (true);
CREATE POLICY "Public read access for elements" ON public.elements FOR SELECT USING (true);
CREATE POLICY "Public read access for topics" ON public.topics FOR SELECT USING (true);
CREATE POLICY "Public read access for questions" ON public.questions FOR SELECT USING (true);
CREATE POLICY "Public read access for badges" ON public.badges FOR SELECT USING (true);


-- ==============================================================================
-- 4. Indexes for Performance
-- ==============================================================================

CREATE INDEX idx_children_parent_id ON public.children(parent_id);
CREATE INDEX idx_subjects_education_level_id ON public.subjects(education_level_id);
CREATE INDEX idx_elements_subject_id ON public.elements(subject_id);
CREATE INDEX idx_topics_element_id ON public.topics(element_id);
CREATE INDEX idx_questions_topic_id ON public.questions(topic_id);
CREATE INDEX idx_quiz_sessions_child_id ON public.quiz_sessions(child_id);
CREATE INDEX idx_quiz_sessions_topic_id ON public.quiz_sessions(topic_id);
CREATE INDEX idx_quiz_answers_session_id ON public.quiz_answers(session_id);
CREATE INDEX idx_child_badges_child_id ON public.child_badges(child_id);
CREATE INDEX idx_child_xp_log_child_id ON public.child_xp_log(child_id);
CREATE INDEX idx_photo_submissions_child_id ON public.photo_submissions(child_id);
