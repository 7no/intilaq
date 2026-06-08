// lib/auth/constants.ts

export const ROLE_COOKIE_NAME = 'x-intilaq-role' as const

export type UserRole = 'student' | 'employer' | 'admin'

export const ROLE_REDIRECT: Record<UserRole, string> = {
  student: '/student/dashboard',
  employer: '/employer/dashboard',
  admin: '/admin/dashboard',
} as const

export const GRADUATION_STATUS_LABELS_AR: Record<string, string> = {
  enrolled: 'طالب (لا يزال في الجامعة)',
  graduated: 'خريج',
  gap_year: 'في فترة انتقالية',
}

export const SKILL_LEVEL_LABELS_AR: Record<string, string> = {
  beginner: 'مبتدئ (لا خبرة عملية سابقة)',
  some_experience: 'لدي بعض الخبرة',
  intermediate: 'متوسط (خبرة عملية محدودة)',
}

export const AVAILABILITY_LABELS_AR: Record<string, string> = {
  full_time: 'متفرغ تمامًا (أكثر من 30 ساعة أسبوعيًا)',
  part_time: 'متفرغ جزئيًا (15–30 ساعة أسبوعيًا)',
  limited: 'وقت محدود (أقل من 15 ساعة أسبوعيًا)',
}

export const SECTOR_OPTIONS_AR: Array<{ value: string; label: string }> = [
  { value: 'tech', label: 'تقنية المعلومات' },
  { value: 'finance', label: 'الخدمات المالية والمصرفية' },
  { value: 'retail', label: 'التجزئة والتجارة الإلكترونية' },
  { value: 'healthcare', label: 'الرعاية الصحية' },
  { value: 'education', label: 'التعليم والتدريب' },
  { value: 'logistics', label: 'اللوجستيات والتوصيل' },
  { value: 'hospitality', label: 'الضيافة والسياحة' },
  { value: 'government', label: 'القطاع الحكومي والشبه الحكومي' },
  { value: 'media', label: 'الإعلام والتسويق الرقمي' },
  { value: 'construction', label: 'المقاولات والعقارات' },
  { value: 'other', label: 'قطاع آخر' },
]