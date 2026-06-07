-- ============================================================
-- INTILAQ Migration 002: Progress and Submission Tables
-- ============================================================

-- ── Table: student_progress ───────────────────────────────────
CREATE TABLE student_progress (
  id                    UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id            UUID        NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  role_id               UUID        NOT NULL REFERENCES role(id) ON DELETE CASCADE,
  current_level         SMALLINT    NOT NULL DEFAULT 1 CHECK (current_level BETWEEN 1 AND 3),
  current_project_id    UUID        REFERENCES project(id) ON DELETE SET NULL,
  started_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at          TIMESTAMPTZ,
  interview_eligible    BOOLEAN     NOT NULL DEFAULT false,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, role_id)
);

CREATE TRIGGER student_progress_updated_at
  BEFORE UPDATE ON student_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: submission ─────────────────────────────────────────
CREATE TABLE submission (
  id                    UUID              DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id            UUID              NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  project_id            UUID              NOT NULL REFERENCES project(id) ON DELETE CASCADE,
  status                submission_status NOT NULL DEFAULT 'pending',
  text_response         TEXT,
  files                 JSONB             NOT NULL DEFAULT '[]',
  time_on_page_seconds  INTEGER           NOT NULL DEFAULT 0,
  content_hash          TEXT,
  duplicate_flag        BOOLEAN           NOT NULL DEFAULT false,
  timing_flag           BOOLEAN           NOT NULL DEFAULT false,
  file_date_flag        BOOLEAN           NOT NULL DEFAULT false,
  submitted_at          TIMESTAMPTZ       NOT NULL DEFAULT now(),
  created_at            TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ       NOT NULL DEFAULT now(),
  CONSTRAINT text_or_files_required CHECK (
    text_response IS NOT NULL OR jsonb_array_length(files) > 0
  )
);

CREATE TRIGGER submission_updated_at
  BEFORE UPDATE ON submission
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: review ─────────────────────────────────────────────
CREATE TABLE review (
  id              UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  submission_id   UUID        NOT NULL REFERENCES submission(id) ON DELETE CASCADE,
  reviewer_id     UUID        NOT NULL REFERENCES auth.users(id) ON DELETE RESTRICT,
  rubric_scores   JSONB       NOT NULL DEFAULT '[]',
  overall_score   SMALLINT    CHECK (overall_score BETWEEN 0 AND 100),
  reviewer_notes  TEXT,
  reviewed_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(submission_id)
);

CREATE TRIGGER review_updated_at
  BEFORE UPDATE ON review
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ── Table: interview_unlock ───────────────────────────────────
CREATE TABLE interview_unlock (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id  UUID        NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  employer_id UUID        NOT NULL REFERENCES employer(id) ON DELETE CASCADE,
  role_id     UUID        NOT NULL REFERENCES role(id) ON DELETE CASCADE,
  notes       TEXT,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, employer_id, role_id)
);

-- ── Indexes ───────────────────────────────────────────────────
CREATE INDEX idx_student_progress_student  ON student_progress(student_id);
CREATE INDEX idx_student_progress_role     ON student_progress(role_id);
CREATE INDEX idx_submission_student        ON submission(student_id);
CREATE INDEX idx_submission_project        ON submission(project_id);
CREATE INDEX idx_submission_status         ON submission(status);
CREATE INDEX idx_submission_content_hash   ON submission(content_hash) WHERE content_hash IS NOT NULL;
CREATE INDEX idx_review_submission         ON review(submission_id);
CREATE INDEX idx_interview_unlock_employer ON interview_unlock(employer_id);
CREATE INDEX idx_interview_unlock_student  ON interview_unlock(student_id);