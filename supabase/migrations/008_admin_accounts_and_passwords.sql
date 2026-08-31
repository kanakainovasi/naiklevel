-- ==============================================================================
-- Migration 008: Admin Role Promotion & Password Reset Helper
-- ==============================================================================

BEGIN;

-- Promote sulistianingdian@gmail.com & kanaka.inovasi@gmail.com to admin role in parents table
UPDATE public.parents
SET role = 'admin'
WHERE email IN ('sulistianingdian@gmail.com', 'kanaka.inovasi@gmail.com');

-- Add trigger function so if either email signs up in future, their role is automatically 'admin'
CREATE OR REPLACE FUNCTION public.auto_promote_admin_role()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.email IN ('sulistianingdian@gmail.com', 'kanaka.inovasi@gmail.com') THEN
        NEW.role := 'admin';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trigger_auto_promote_admin ON public.parents;
CREATE TRIGGER trigger_auto_promote_admin
    BEFORE INSERT OR UPDATE ON public.parents
    FOR EACH ROW
    EXECUTE FUNCTION public.auto_promote_admin_role();

COMMIT;
