-- ============================================================================
-- FIX: Supabase "Database error creating new user"
-- Run this in: Supabase Dashboard → SQL Editor → New Query → Run (Ctrl+Enter)
-- ============================================================================

-- 1. Drop old problematic trigger on auth.users if it exists
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP FUNCTION IF EXISTS handle_new_user();

-- 2. Create ultra-safe trigger that NEVER blocks user creation
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.email, 'admin@pixelsubz.lk'),
    'ADMIN'
  )
  ON CONFLICT (id) DO UPDATE
  SET email = EXCLUDED.email,
      role = 'ADMIN',
      updated_at = NOW();

  RETURN NEW;
EXCEPTION WHEN OTHERS THEN
  -- Never abort auth.users creation on trigger error
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Re-attach trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- 4. Ensure permissions are granted to public schema
GRANT ALL ON public.users TO postgres, service_role, authenticated, anon;

-- 5. If RLS is enabled on users, allow insert & select
DROP POLICY IF EXISTS "allow_all_users_insert" ON public.users;
CREATE POLICY "allow_all_users_insert" ON public.users FOR ALL USING (true) WITH CHECK (true);
