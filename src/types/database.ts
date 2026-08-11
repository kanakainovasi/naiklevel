export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      parents: {
        Row: {
          id: string
          email: string
          full_name: string
          phone: string | null
          privacy_consent_at: string
          daily_limit_minutes: number | null
          subscription_tier: 'free' | 'premium' | null
          role: 'parent' | 'admin' | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id: string
          email: string
          full_name: string
          phone?: string | null
          privacy_consent_at?: string
          daily_limit_minutes?: number | null
          subscription_tier?: 'free' | 'premium' | null
          role?: 'parent' | 'admin' | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: {
          id?: string
          email?: string
          full_name?: string
          phone?: string | null
          privacy_consent_at?: string
          daily_limit_minutes?: number | null
          subscription_tier?: 'free' | 'premium' | null
          role?: 'parent' | 'admin' | null
          created_at?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      page_views: {
        Row: {
          id: string
          path: string
          user_agent: string | null
          referrer: string | null
          parent_id: string | null
          child_id: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          path: string
          user_agent?: string | null
          referrer?: string | null
          parent_id?: string | null
          child_id?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          path?: string
          user_agent?: string | null
          referrer?: string | null
          parent_id?: string | null
          child_id?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
      education_levels: {
        Row: {
          id: string
          name: string
          slug: string
          phase: string
          order_index: number
          level_type: 'tk' | 'sd'
        }
        Insert: {
          id?: string
          name: string
          slug: string
          phase: string
          order_index: number
          level_type: 'tk' | 'sd'
        }
        Update: {
          id?: string
          name?: string
          slug?: string
          phase?: string
          order_index?: number
          level_type?: 'tk' | 'sd'
        }
        Relationships: []
      }
      children: {
        Row: {
          id: string
          parent_id: string
          name: string
          birth_date: string | null
          avatar_url: string | null
          education_level_id: string | null
          xp_total: number | null
          current_level: number | null
          streak_days: number | null
          last_active_at: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          parent_id: string
          name: string
          birth_date?: string | null
          avatar_url?: string | null
          education_level_id?: string | null
          xp_total?: number | null
          current_level?: number | null
          streak_days?: number | null
          last_active_at?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          parent_id?: string
          name?: string
          birth_date?: string | null
          avatar_url?: string | null
          education_level_id?: string | null
          xp_total?: number | null
          current_level?: number | null
          streak_days?: number | null
          last_active_at?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
      subjects: {
        Row: {
          id: string
          education_level_id: string
          name: string
          official_name: string | null
          slug: string
          icon: string | null
          description: string | null
          order_index: number
        }
        Insert: {
          id?: string
          education_level_id: string
          name: string
          official_name?: string | null
          slug: string
          icon?: string | null
          description?: string | null
          order_index: number
        }
        Update: {
          id?: string
          education_level_id?: string
          name?: string
          official_name?: string | null
          slug?: string
          icon?: string | null
          description?: string | null
          order_index?: number
        }
        Relationships: []
      }
      elements: {
        Row: {
          id: string
          subject_id: string
          name: string
          description: string | null
          order_index: number
        }
        Insert: {
          id?: string
          subject_id: string
          name: string
          description?: string | null
          order_index: number
        }
        Update: {
          id?: string
          subject_id?: string
          name?: string
          description?: string | null
          order_index?: number
        }
        Relationships: []
      }
      topics: {
        Row: {
          id: string
          element_id: string
          name: string
          slug: string
          description: string | null
          order_index: number
          is_published: boolean | null
        }
        Insert: {
          id?: string
          element_id: string
          name: string
          slug: string
          description?: string | null
          order_index: number
          is_published?: boolean | null
        }
        Update: {
          id?: string
          element_id?: string
          name?: string
          slug?: string
          description?: string | null
          order_index?: number
          is_published?: boolean | null
        }
        Relationships: []
      }
      questions: {
        Row: {
          id: string
          topic_id: string
          question_type: 'regular' | 'olympiad'
          content_type: 'multiple_choice' | 'true_false' | 'fill_blank' | 'matching'
          question_text: string
          question_image_url: string | null
          options: Json | null
          correct_answer: Json
          explanation: string | null
          difficulty: number | null
          xp_reward: number | null
          time_limit_seconds: number | null
          needs_curriculum_validation: boolean | null
          order_index: number
          created_at: string | null
        }
        Insert: {
          id?: string
          topic_id: string
          question_type: 'regular' | 'olympiad'
          content_type: 'multiple_choice' | 'true_false' | 'fill_blank' | 'matching'
          question_text: string
          question_image_url?: string | null
          options?: Json | null
          correct_answer: Json
          explanation?: string | null
          difficulty?: number | null
          xp_reward?: number | null
          time_limit_seconds?: number | null
          needs_curriculum_validation?: boolean | null
          order_index?: number
          created_at?: string | null
        }
        Update: {
          id?: string
          topic_id?: string
          question_type?: 'regular' | 'olympiad'
          content_type?: 'multiple_choice' | 'true_false' | 'fill_blank' | 'matching'
          question_text?: string
          question_image_url?: string | null
          options?: Json | null
          correct_answer?: Json
          explanation?: string | null
          difficulty?: number | null
          xp_reward?: number | null
          time_limit_seconds?: number | null
          needs_curriculum_validation?: boolean | null
          order_index?: number
          created_at?: string | null
        }
        Relationships: []
      }
      quiz_sessions: {
        Row: {
          id: string
          child_id: string
          topic_id: string
          session_type: 'regular' | 'olympiad' | null
          score: number | null
          total_questions: number | null
          correct_answers: number | null
          xp_earned: number | null
          time_spent_seconds: number | null
          started_at: string | null
          completed_at: string | null
        }
        Insert: {
          id?: string
          child_id: string
          topic_id: string
          session_type?: 'regular' | 'olympiad' | null
          score?: number | null
          total_questions?: number | null
          correct_answers?: number | null
          xp_earned?: number | null
          time_spent_seconds?: number | null
          started_at?: string | null
          completed_at?: string | null
        }
        Update: {
          id?: string
          child_id?: string
          topic_id?: string
          session_type?: 'regular' | 'olympiad' | null
          score?: number | null
          total_questions?: number | null
          correct_answers?: number | null
          xp_earned?: number | null
          time_spent_seconds?: number | null
          started_at?: string | null
          completed_at?: string | null
        }
        Relationships: []
      }
      quiz_answers: {
        Row: {
          id: string
          session_id: string
          question_id: string
          selected_answer: Json | null
          is_correct: boolean | null
          time_spent_seconds: number | null
        }
        Insert: {
          id?: string
          session_id: string
          question_id: string
          selected_answer?: Json | null
          is_correct?: boolean | null
          time_spent_seconds?: number | null
        }
        Update: {
          id?: string
          session_id?: string
          question_id?: string
          selected_answer?: Json | null
          is_correct?: boolean | null
          time_spent_seconds?: number | null
        }
        Relationships: []
      }
      badges: {
        Row: {
          id: string
          name: string
          description: string | null
          icon_url: string | null
          criteria: Json | null
          created_at: string | null
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          icon_url?: string | null
          criteria?: Json | null
          created_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          icon_url?: string | null
          criteria?: Json | null
          created_at?: string | null
        }
        Relationships: []
      }
      child_badges: {
        Row: {
          id: string
          child_id: string
          badge_id: string
          earned_at: string | null
        }
        Insert: {
          id?: string
          child_id: string
          badge_id: string
          earned_at?: string | null
        }
        Update: {
          id?: string
          child_id?: string
          badge_id?: string
          earned_at?: string | null
        }
        Relationships: []
      }
      child_xp_log: {
        Row: {
          id: string
          child_id: string
          xp_amount: number
          source_type: 'quiz_regular' | 'quiz_olympiad' | 'streak_bonus' | 'badge_bonus'
          source_id: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          child_id: string
          xp_amount: number
          source_type: 'quiz_regular' | 'quiz_olympiad' | 'streak_bonus' | 'badge_bonus'
          source_id?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          child_id?: string
          xp_amount?: number
          source_type?: 'quiz_regular' | 'quiz_olympiad' | 'streak_bonus' | 'badge_bonus'
          source_id?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
      photo_submissions: {
        Row: {
          id: string
          child_id: string
          topic_id: string
          photo_url: string
          parent_note: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          child_id: string
          topic_id: string
          photo_url: string
          parent_note?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          child_id?: string
          topic_id?: string
          photo_url?: string
          parent_note?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

export type QuestionOption = {
  id: string
  text: string
  image_url?: string
}

export type CorrectAnswer = {
  option_id?: string
  text_value?: string
  boolean_value?: boolean
}

export type BadgeCriteria = {
  type: 'first_quiz' | 'complete_subject' | 'first_olympiad' | 'streak' | 'perfect_score'
  subject?: string
  days?: number
}
