-- ============================================================
-- INTILAQ Migration 001: Core Tables
-- ============================================================

-- ── Utility: updated_at auto-trigger ─────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ── Enum types ────────────────────────────────────────────────
CREATE TYPE submission_status   AS ENUM ('pending', 'reviewing', 'passed', 'failed');
CREATE TYPE graduation_status   AS ENUM ('enrolled', 'graduated', 'gap_year');
CREATE TYPE skill_level         AS ENUM ('beginner', 'some_experience', 'intermediate');
CREATE TYPE availability_type   AS ENUM ('full_time', 'part_time', 'limited');
CREATE TYPE language_pref       AS ENUM ('ar', 'en');
CREATE TYPE publish_status      AS ENUM ('draft', 'published', 'archived');

-- ── Table: employer ───────────────────────────────────────────
CREATE TABLE employer (
  id                UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id           UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  company_name_ar   TEXT        NOT NULL,
  company_name_en   TEXT        NOT NULL,
  sector            TEXT        NOT NULL,
  contact_name      TEXT        NOT NULL,
  contact_email     TEXT        NOT NULL,
  is_active         BOOLEAN     NOT NULL DEFAULT true,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id)
);

CREATE TRIGGER employer_updated_at
  BEFORE UPDATE ON employer
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: role ───────────────────────────────────────────────
CREATE TABLE role (
  id                UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
  employer_id       UUID          REFERENCES employer(id) ON DELETE SET NULL,
  title_ar          TEXT          NOT NULL,
  title_en          TEXT          NOT NULL,
  description_ar    TEXT          NOT NULL,
  description_en    TEXT          NOT NULL,
  status            publish_status NOT NULL DEFAULT 'draft',
  is_active         BOOLEAN       NOT NULL DEFAULT true,
  created_at        TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ   NOT NULL DEFAULT now()
);

CREATE TRIGGER role_updated_at
  BEFORE UPDATE ON role
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: level ──────────────────────────────────────────────
CREATE TABLE level (
  id              UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
  role_id         UUID          NOT NULL REFERENCES role(id) ON DELETE CASCADE,
  level_number    SMALLINT      NOT NULL CHECK (level_number BETWEEN 1 AND 3),
  title_ar        TEXT          NOT NULL,
  title_en        TEXT          NOT NULL,
  description_ar  TEXT          NOT NULL,
  description_en  TEXT          NOT NULL,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT now(),
  UNIQUE (role_id, level_number)
);

CREATE TRIGGER level_updated_at
  BEFORE UPDATE ON level
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: project ────────────────────────────────────────────
CREATE TABLE project (
  id                        UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
  level_id                  UUID          NOT NULL REFERENCES level(id) ON DELETE CASCADE,
  sort_order                SMALLINT      NOT NULL DEFAULT 1 CHECK (sort_order BETWEEN 1 AND 5),
  title_ar                  TEXT          NOT NULL,
  title_en                  TEXT          NOT NULL,
  brief_ar                  TEXT          NOT NULL,
  brief_en                  TEXT          NOT NULL,
  goal_ar                   TEXT          NOT NULL,
  goal_en                   TEXT          NOT NULL,
  context_ar                TEXT          NOT NULL,
  context_en                TEXT          NOT NULL,
  deliverables_ar           JSONB         NOT NULL DEFAULT '[]',
  deliverables_en           JSONB         NOT NULL DEFAULT '[]',
  constraints_ar            TEXT          NOT NULL,
  constraints_en            TEXT          NOT NULL,
  success_criteria_ar       JSONB         NOT NULL DEFAULT '[]',
  success_criteria_en       JSONB         NOT NULL DEFAULT '[]',
  submission_instructions_ar TEXT         NOT NULL,
  submission_instructions_en TEXT         NOT NULL,
  time_expectation_hours    NUMERIC(4,1)  NOT NULL CHECK (time_expectation_hours > 0),
  rubric                    JSONB         NOT NULL DEFAULT '[]',
  status                    publish_status NOT NULL DEFAULT 'draft',
  created_at                TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at                TIMESTAMPTZ   NOT NULL DEFAULT now(),
  UNIQUE (level_id, sort_order)
);

CREATE TRIGGER project_updated_at
  BEFORE UPDATE ON project
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: student ────────────────────────────────────────────
CREATE TABLE student (
  id                      UUID              DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id                 UUID              NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name               TEXT              NOT NULL,
  university              TEXT              NOT NULL,
  major                   TEXT              NOT NULL,
  graduation_status       graduation_status NOT NULL,
  nationality_confirmed   BOOLEAN           NOT NULL DEFAULT false,
  career_interest         TEXT              NOT NULL,
  target_role_id          UUID              REFERENCES role(id) ON DELETE SET NULL,
  skill_level             skill_level       NOT NULL,
  availability            availability_type NOT NULL,
  language_pref           language_pref     NOT NULL DEFAULT 'ar',
  is_active               BOOLEAN           NOT NULL DEFAULT true,
  created_at              TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at              TIMESTAMPTZ       NOT NULL DEFAULT now(),
  UNIQUE(user_id),
  CONSTRAINT nationality_required CHECK (
    is_active = false OR nationality_confirmed = true
  )
);

CREATE TRIGGER student_updated_at
  BEFORE UPDATE ON student
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: onboarding_unlock ──────────────────────────────────
CREATE TABLE onboarding_unlock (
  id                UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  role_id           UUID        NOT NULL REFERENCES role(id) ON DELETE CASCADE,
  unlocked_at_level SMALLINT    NOT NULL CHECK (unlocked_at_level BETWEEN 1 AND 3),
  content_type      TEXT        NOT NULL,
  content_ar        TEXT        NOT NULL,
  content_en        TEXT        NOT NULL,
  sort_order        SMALLINT    NOT NULL DEFAULT 1,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ── Indexes ───────────────────────────────────────────────────
CREATE INDEX idx_role_employer         ON role(employer_id);
CREATE INDEX idx_level_role            ON level(role_id);
CREATE INDEX idx_project_level         ON project(level_id);
CREATE INDEX idx_project_status        ON project(status);
CREATE INDEX idx_student_user          ON student(user_id);
CREATE INDEX idx_employer_user         ON employer(user_id);
CREATE INDEX idx_onboarding_role_level ON onboarding_unlock(role_id, unlocked_at_level);