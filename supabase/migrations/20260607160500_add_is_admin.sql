-- ============================================================
-- INTILAQ Migration 004: Add is_admin to employer + Fix RLS INSERT policies
-- ============================================================

ALTER TABLE employer ADD COLUMN is_admin BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX idx_employer_is_admin ON employer(is_admin) WHERE is_admin = true;

-- ── RLS INSERT policy fix for signup ─────────────────────────
-- During signup, my_student_id() / my_employer_id() return NULL
-- because the profile row doesn't exist yet.
-- We need direct user_id checks for INSERT policies.

CREATE POLICY "student: insert own profile"
  ON student FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "employer: insert own profile"
  ON employer FOR INSERT
  WITH CHECK (user_id = auth.uid());

-- Re-add student_progress INSERT with correct check
DROP POLICY IF EXISTS "student: insert own progress" ON student_progress;

CREATE POLICY "student: insert own progress"
  ON student_progress FOR INSERT
  WITH CHECK (
    student_id = my_student_id()
  );