-- ============================================================
-- INTILAQ Migration 003: Row Level Security Policies
-- ============================================================

-- ── Helper functions ──────────────────────────────────────────
CREATE OR REPLACE FUNCTION is_student()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (SELECT 1 FROM student WHERE user_id = auth.uid())
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION is_employer()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (SELECT 1 FROM employer WHERE user_id = auth.uid())
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION my_student_id()
RETURNS UUID AS $$
  SELECT id FROM student WHERE user_id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION my_employer_id()
RETURNS UUID AS $$
  SELECT id FROM employer WHERE user_id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ── Enable RLS on all tables ──────────────────────────────────
ALTER TABLE student           ENABLE ROW LEVEL SECURITY;
ALTER TABLE employer          ENABLE ROW LEVEL SECURITY;
ALTER TABLE role              ENABLE ROW LEVEL SECURITY;
ALTER TABLE level             ENABLE ROW LEVEL SECURITY;
ALTER TABLE project           ENABLE ROW LEVEL SECURITY;
ALTER TABLE onboarding_unlock ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_progress  ENABLE ROW LEVEL SECURITY;
ALTER TABLE submission        ENABLE ROW LEVEL SECURITY;
ALTER TABLE review            ENABLE ROW LEVEL SECURITY;
ALTER TABLE interview_unlock  ENABLE ROW LEVEL SECURITY;

-- ── Policies: student table ───────────────────────────────────
CREATE POLICY "student: select own row"
  ON student FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "student: update own row"
  ON student FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "employer: read candidate student rows"
  ON student FOR SELECT
  USING (
    is_employer() AND
    EXISTS (
      SELECT 1
      FROM submission s
      JOIN project p   ON s.project_id = p.id
      JOIN level l     ON p.level_id   = l.id
      JOIN role r      ON l.role_id    = r.id
      WHERE s.student_id   = student.id
        AND r.employer_id  = my_employer_id()
    )
  );

-- ── Policies: employer table ──────────────────────────────────
CREATE POLICY "employer: select own row"
  ON employer FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "employer: update own row"
  ON employer FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- ── Policies: role table ──────────────────────────────────────
CREATE POLICY "all authenticated: read published roles"
  ON role FOR SELECT
  USING (
    auth.uid() IS NOT NULL AND
    status = 'published' AND
    is_active = true
  );

CREATE POLICY "employer: read own roles any status"
  ON role FOR SELECT
  USING (employer_id = my_employer_id());

-- ── Policies: level table ─────────────────────────────────────
CREATE POLICY "all authenticated: read levels of published roles"
  ON level FOR SELECT
  USING (
    auth.uid() IS NOT NULL AND
    EXISTS (
      SELECT 1 FROM role r
      WHERE r.id        = level.role_id
        AND r.status    = 'published'
        AND r.is_active = true
    )
  );

-- ── Policies: project table ───────────────────────────────────
CREATE POLICY "student: read projects in own pathway"
  ON project FOR SELECT
  USING (
    is_student() AND
    status = 'published' AND
    EXISTS (
      SELECT 1
      FROM student_progress sp
      JOIN level l ON l.id = project.level_id
      WHERE sp.student_id = my_student_id()
        AND sp.role_id    = l.role_id
        AND l.level_number <= sp.current_level
    )
  );

CREATE POLICY "employer: read own role projects"
  ON project FOR SELECT
  USING (
    is_employer() AND
    EXISTS (
      SELECT 1
      FROM level l
      JOIN role r ON r.id = l.role_id
      WHERE l.id          = project.level_id
        AND r.employer_id = my_employer_id()
    )
  );

-- ── Policies: onboarding_unlock table ────────────────────────
CREATE POLICY "student: read own pathway onboarding"
  ON onboarding_unlock FOR SELECT
  USING (
    is_student() AND
    EXISTS (
      SELECT 1 FROM student_progress sp
      WHERE sp.student_id       = my_student_id()
        AND sp.role_id          = onboarding_unlock.role_id
        AND sp.current_level   >= onboarding_unlock.unlocked_at_level
    )
  );

-- ── Policies: student_progress table ─────────────────────────
CREATE POLICY "student: select own progress"
  ON student_progress FOR SELECT
  USING (student_id = my_student_id());

CREATE POLICY "student: insert own progress"
  ON student_progress FOR INSERT
  WITH CHECK (student_id = my_student_id());

CREATE POLICY "student: update own progress"
  ON student_progress FOR UPDATE
  USING (student_id = my_student_id());

CREATE POLICY "employer: read candidate progress"
  ON student_progress FOR SELECT
  USING (
    is_employer() AND
    EXISTS (
      SELECT 1 FROM role r
      WHERE r.id          = student_progress.role_id
        AND r.employer_id = my_employer_id()
    )
  );

-- ── Policies: submission table ─────────────────────