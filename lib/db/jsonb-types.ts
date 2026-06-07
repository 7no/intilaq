// lib/db/jsonb-types.ts
// JSONB column shapes — not enforced by DB, enforced at application layer.

export interface RubricCriterion {
  id: string
  label_ar: string
  label_en: string
  description_ar: string
  description_en: string
  weight: 1 | 2 | 3
  passing_score: 1 | 2
}

export type Rubric = RubricCriterion[]

export type Deliverables = string[]

export type SuccessCriteria = string[]

export interface SubmissionFile {
  path: string
  name: string
  size_bytes: number
  mime_type: string
  uploaded_at: string
}

export type SubmissionFiles = SubmissionFile[]

export interface RubricScore {
  criterion_id: string
  score: 0 | 1 | 2
  comment: string
}

export type RubricScores = RubricScore[]