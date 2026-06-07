export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      employer: {
        Row: {
          company_name_ar: string
          company_name_en: string
          contact_email: string
          contact_name: string
          created_at: string
          id: string
          is_active: boolean
          sector: string
          updated_at: string
          user_id: string
        }
        Insert: {
          company_name_ar: string
          company_name_en: string
          contact_email: string
          contact_name: string
          created_at?: string
          id?: string
          is_active?: boolean
          sector: string
          updated_at?: string
          user_id: string
        }
        Update: {
          company_name_ar?: string
          company_name_en?: string
          contact_email?: string
          contact_name?: string
          created_at?: string
          id?: string
          is_active?: boolean
          sector?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      interview_unlock: {
        Row: {
          created_at: string
          employer_id: string
          id: string
          notes: string | null
          role_id: string
          student_id: string
          unlocked_at: string
        }
        Insert: {
          created_at?: string
          employer_id: string
          id?: string
          notes?: string | null
          role_id: string
          student_id: string
          unlocked_at?: string
        }
        Update: {
          created_at?: string
          employer_id?: string
          id?: string
          notes?: string | null
          role_id?: string
          student_id?: string
          unlocked_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "interview_unlock_employer_id_fkey"
            columns: ["employer_id"]
            isOneToOne: false
            referencedRelation: "employer"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "interview_unlock_role_id_fkey"
            columns: ["role_id"]
            isOneToOne: false
            referencedRelation: "role"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "interview_unlock_student_id_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "student"
            referencedColumns: ["id"]
          },
        ]
      }
      level: {
        Row: {
          created_at: string
          description_ar: string
          description_en: string
          id: string
          level_number: number
          role_id: string
          title_ar: string
          title_en: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          description_ar: string
          description_en: string
          id?: string
          level_number: number
          role_id: string
          title_ar: string
          title_en: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          description_ar?: string
          description_en?: string
          id?: string
          level_number?: number
          role_id?: string
          title_ar?: string
          title_en?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "level_role_id_fkey"
            columns: ["role_id"]
            isOneToOne: false
            referencedRelation: "role"
            referencedColumns: ["id"]
          },
        ]
      }
      onboarding_unlock: {
        Row: {
          content_ar: string
          content_en: string
          content_type: string
          created_at: string
          id: string
          role_id: string
          sort_order: number
          unlocked_at_level: number
        }
        Insert: {
          content_ar: string
          content_en: string
          content_type: string
          created_at?: string
          id?: string
          role_id: string
          sort_order?: number
          unlocked_at_level: number
        }
        Update: {
          content_ar?: string
          content_en?: string
          content_type?: string
          created_at?: string
          id?: string
          role_id?: string
          sort_order?: number
          unlocked_at_level?: number
        }
        Relationships: [
          {
            foreignKeyName: "onboarding_unlock_role_id_fkey"
            columns: ["role_id"]
            isOneToOne: false
            referencedRelation: "role"
            referencedColumns: ["id"]
          },
        ]
      }
      project: {
        Row: {
          brief_ar: string
          brief_en: string
          constraints_ar: string
          constraints_en: string
          context_ar: string
          context_en: string
          created_at: string
          deliverables_ar: Json
          deliverables_en: Json
          goal_ar: string
          goal_en: string
          id: string
          level_id: string
          rubric: Json
          sort_order: number
          status: Database["public"]["Enums"]["publish_status"]
          submission_instructions_ar: string
          submission_instructions_en: string
          success_criteria_ar: Json
          success_criteria_en: Json
          time_expectation_hours: number
          title_ar: string
          title_en: string
          updated_at: string
        }
        Insert: {
          brief_ar: string
          brief_en: string
          constraints_ar: string
          constraints_en: string
          context_ar: string
          context_en: string
          created_at?: string
          deliverables_ar?: Json
          deliverables_en?: Json
          goal_ar: string
          goal_en: string
          id?: string
          level_id: string
          rubric?: Json
          sort_order?: number
          status?: Database["public"]["Enums"]["publish_status"]
          submission_instructions_ar: string
          submission_instructions_en: string
          success_criteria_ar?: Json
          success_criteria_en?: Json
          time_expectation_hours: number
          title_ar: string
          title_en: string
          updated_at?: string
        }
        Update: {
          brief_ar?: string
          brief_en?: string
          constraints_ar?: string
          constraints_en?: string
          context_ar?: string
          context_en?: string
          created_at?: string
          deliverables_ar?: Json
          deliverables_en?: Json
          goal_ar?: string
          goal_en?: string
          id?: string
          level_id?: string
          rubric?: Json
          sort_order?: number
          status?: Database["public"]["Enums"]["publish_status"]
          submission_instructions_ar?: string
          submission_instructions_en?: string
          success_criteria_ar?: Json
          success_criteria_en?: Json
          time_expectation_hours?: number
          title_ar?: string
          title_en?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "project_level_id_fkey"
            columns: ["level_id"]
            isOneToOne: false
            referencedRelation: "level"
            referencedColumns: ["id"]
          },
        ]
      }
      review: {
        Row: {
          created_at: string
          id: string
          overall_score: number | null
          reviewed_at: string
          reviewer_id: string
          reviewer_notes: string | null
          rubric_scores: Json
          submission_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          overall_score?: number | null
          reviewed_at?: string
          reviewer_id: string
          reviewer_notes?: string | null
          rubric_scores?: Json
          submission_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          overall_score?: number | null
          reviewed_at?: string
          reviewer_id?: string
          reviewer_notes?: string | null
          rubric_scores?: Json
          submission_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "review_submission_id_fkey"
            columns: ["submission_id"]
            isOneToOne: true
            referencedRelation: "submission"
            referencedColumns: ["id"]
          },
        ]
      }
      role: {
        Row: {
          created_at: string
          description_ar: string
          description_en: string
          employer_id: string | null
          id: string
          is_active: boolean
          status: Database["public"]["Enums"]["publish_status"]
          title_ar: string
          title_en: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          description_ar: string
          description_en: string
          employer_id?: string | null
          id?: string
          is_active?: boolean
          status?: Database["public"]["Enums"]["publish_status"]
          title_ar: string
          title_en: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          description_ar?: string
          description_en?: string
          employer_id?: string | null
          id?: string
          is_active?: boolean
          status?: Database["public"]["Enums"]["publish_status"]
          title_ar?: string
          title_en?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "role_employer_id_fkey"
            columns: ["employer_id"]
            isOneToOne: false
            referencedRelation: "employer"
            referencedColumns: ["id"]
          },
        ]
      }
      student: {
        Row: {
          availability: Database["public"]["Enums"]["availability_type"]
          career_interest: string
          created_at: string
          full_name: string
          graduation_status: Database["public"]["Enums"]["graduation_status"]
          id: string
          is_active: boolean
          language_pref: Database["public"]["Enums"]["language_pref"]
          major: string
          nationality_confirmed: boolean
          skill_level: Database["public"]["Enums"]["skill_level"]
          target_role_id: string | null
          university: string
          updated_at: string
          user_id: string
        }
        Insert: {
          availability: Database["public"]["Enums"]["availability_type"]
          career_interest: string
          created_at?: string
          full_name: string
          graduation_status: Database["public"]["Enums"]["graduation_status"]
          id?: string
          is_active?: boolean
          language_pref?: Database["public"]["Enums"]["language_pref"]
          major: string
          nationality_confirmed?: boolean
          skill_level: Database["public"]["Enums"]["skill_level"]
          target_role_id?: string | null
          university: string
          updated_at?: string
          user_id: string
        }
        Update: {
          availability?: Database["public"]["Enums"]["availability_type"]
          career_interest?: string
          created_at?: string
          full_name?: string
          graduation_status?: Database["public"]["Enums"]["graduation_status"]
          id?: string
          is_active?: boolean
          language_pref?: Database["public"]["Enums"]["language_pref"]
          major?: string
          nationality_confirmed?: boolean
          skill_level?: Database["public"]["Enums"]["skill_level"]
          target_role_id?: string | null
          university?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_target_role_id_fkey"
            columns: ["target_role_id"]
            isOneToOne: false
            referencedRelation: "role"
            referencedColumns: ["id"]
          },
        ]
      }
      student_progress: {
        Row: {
          completed_at: string | null
          created_at: string
          current_level: number
          current_project_id: string | null
          id: string
          interview_eligible: boolean
          role_id: string
          started_at: string
          student_id: string
          updated_at: string
        }
        Insert: {
          completed_at?: string | null
          created_at?: string
          current_level?: number
          current_project_id?: string | null
          id?: string
          interview_eligible?: boolean
          role_id: string
          started_at?: string
          student_id: string
          updated_at?: string
        }
        Update: {
          completed_at?: string | null
          created_at?: string
          current_level?: number
          current_project_id?: string | null
          id?: string
          interview_eligible?: boolean
          role_id?: string
          started_at?: string
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_progress_current_project_id_fkey"
            columns: ["current_project_id"]
            isOneToOne: false
            referencedRelation: "project"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "student_progress_role_id_fkey"
            columns: ["role_id"]
            isOneToOne: false
            referencedRelation: "role"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "student_progress_student_id_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "student"
            referencedColumns: ["id"]
          },
        ]
      }
      submission: {
        Row: {
          content_hash: string | null
          created_at: string
          duplicate_flag: boolean
          file_date_flag: boolean
          files: Json
          id: string
          project_id: string
          status: Database["public"]["Enums"]["submission_status"]
          student_id: string
          submitted_at: string
          text_response: string | null
          time_on_page_seconds: number
          timing_flag: boolean
          updated_at: string
        }
        Insert: {
          content_hash?: string | null
          created_at?: string
          duplicate_flag?: boolean
          file_date_flag?: boolean
          files?: Json
          id?: string
          project_id: string
          status?: Database["public"]["Enums"]["submission_status"]
          student_id: string
          submitted_at?: string
          text_response?: string | null
          time_on_page_seconds?: number
          timing_flag?: boolean
          updated_at?: string
        }
        Update: {
          content_hash?: string | null
          created_at?: string
          duplicate_flag?: boolean
          file_date_flag?: boolean
          files?: Json
          id?: string
          project_id?: string
          status?: Database["public"]["Enums"]["submission_status"]
          student_id?: string
          submitted_at?: string
          text_response?: string | null
          time_on_page_seconds?: number
          timing_flag?: boolean
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "submission_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "project"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "submission_student_id_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "student"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      is_employer: { Args: never; Returns: boolean }
      is_student: { Args: never; Returns: boolean }
      my_employer_id: { Args: never; Returns: string }
      my_student_id: { Args: never; Returns: string }
    }
    Enums: {
      availability_type: "full_time" | "part_time" | "limited"
      graduation_status: "enrolled" | "graduated" | "gap_year"
      language_pref: "ar" | "en"
      publish_status: "draft" | "published" | "archived"
      skill_level: "beginner" | "some_experience" | "intermediate"
      submission_status: "pending" | "reviewing" | "passed" | "failed"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      availability_type: ["full_time", "part_time", "limited"],
      graduation_status: ["enrolled", "graduated", "gap_year"],
      language_pref: ["ar", "en"],
      publish_status: ["draft", "published", "archived"],
      skill_level: ["beginner", "some_experience", "intermediate"],
      submission_status: ["pending", "reviewing", "passed", "failed"],
    },
  },
} as const
