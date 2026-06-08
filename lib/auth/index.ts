// lib/auth/index.ts
'use server'

import { createClient } from '@/lib/supabase/server'
import { toArabicError } from '@/lib/auth/errors'
import { cookies } from 'next/headers'
import { ROLE_COOKIE_NAME, type UserRole } from '@/lib/auth/constants'

export type { UserRole }
export { ROLE_COOKIE_NAME }

export interface AuthResult {
  success: boolean
  error?: string
  role?: UserRole
}

// ── Role detection ─────────────────────────────────────────────
export async function detectUserRole(userId: string): Promise<UserRole | null> {
  const supabase = await createClient()

  const { data: employerRow } = await supabase
    .from('employer')
    .select('id, is_admin')
    .eq('user_id', userId)
    .single()

  if (employerRow) {
    return employerRow.is_admin ? 'admin' : 'employer'
  }

  const { data: studentRow } = await supabase
    .from('student')
    .select('id')
    .eq('user_id', userId)
    .single()

  if (studentRow) {
    return 'student'
  }

  return null
}

// ── Cookie management ──────────────────────────────────────────
export async function setRoleCookie(role: UserRole): Promise<void> {
  const cookieStore = await cookies()
  cookieStore.set(ROLE_COOKIE_NAME, role, {
    httpOnly: true,
    sameSite: 'lax',
    secure: process.env.NODE_ENV === 'production',
    maxAge: 60 * 60 * 24 * 7,
    path: '/',
  })
}

export async function clearRoleCookie(): Promise<void> {
  const cookieStore = await cookies()
  cookieStore.delete(ROLE_COOKIE_NAME)
}

// ── Sign in ────────────────────────────────────────────────────
export async function signIn(
  email: string,
  password: string
): Promise<AuthResult> {
  const supabase = await createClient()

  const { data, error } = await supabase.auth.signInWithPassword({
    email: email.trim().toLowerCase(),
    password,
  })

  if (error || !data.user) {
    return {
      success: false,
      error: toArabicError(error?.message ?? 'DEFAULT'),
    }
  }

  const role = await detectUserRole(data.user.id)

  if (!role) {
    await supabase.auth.signOut()
    return {
      success: false,
      error: 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني. يرجى التسجيل أولاً.',
    }
  }

  await setRoleCookie(role)
  return { success: true, role }
}

// ── Sign out ───────────────────────────────────────────────────
export async function signOut(): Promise<void> {
  const supabase = await createClient()
  await supabase.auth.signOut()
  await clearRoleCookie()
}

// ── Student sign-up ────────────────────────────────────────────
export interface StudentSignUpData {
  email: string
  password: string
  full_name: string
  university: string
  major: string
  graduation_status: 'enrolled' | 'graduated' | 'gap_year'
  nationality_confirmed: boolean
  career_interest: string
  target_role_id: string | null
  skill_level: 'beginner' | 'some_experience' | 'intermediate'
  availability: 'full_time' | 'part_time' | 'limited'
  language_pref: 'ar' | 'en'
}

export async function signUpStudent(
  data: StudentSignUpData
): Promise<AuthResult> {
  if (!data.nationality_confirmed) {
    return {
      success: false,
      error: 'يجب تأكيد الجنسية السعودية للتسجيل في المنصة.',
    }
  }

  if (data.password.length < 8) {
    return {
      success: false,
      error: 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.',
    }
  }

  const supabase = await createClient()

  const { data: authData, error: authError } = await supabase.auth.signUp({
    email: data.email.trim().toLowerCase(),
    password: data.password,
  })

  if (authError || !authData.user) {
    return {
      success: false,
      error: toArabicError(authError?.message ?? 'DEFAULT'),
    }
  }

  const { error: profileError } = await supabase.from('student').insert({
    user_id: authData.user.id,
    full_name: data.full_name.trim(),
    university: data.university.trim(),
    major: data.major.trim(),
    graduation_status: data.graduation_status,
    nationality_confirmed: true,
    career_interest: data.career_interest.trim(),
    target_role_id: data.target_role_id ?? null,
    skill_level: data.skill_level,
    availability: data.availability,
    language_pref: data.language_pref,
    is_active: true,
  })

  if (profileError) {
    return {
      success: false,
      error: 'تم إنشاء الحساب لكن حدث خطأ في حفظ البيانات. يرجى التواصل مع الدعم.',
    }
  }

  await setRoleCookie('student')
  return { success: true, role: 'student' }
}

// ── Employer sign-up ───────────────────────────────────────────
export interface EmployerSignUpData {
  email: string
  password: string
  company_name_ar: string
  company_name_en: string
  sector: string
  contact_name: string
  contact_email: string
}

export async function signUpEmployer(
  data: EmployerSignUpData
): Promise<AuthResult> {
  if (data.password.length < 8) {
    return {
      success: false,
      error: 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.',
    }
  }

  const supabase = await createClient()

  const { data: authData, error: authError } = await supabase.auth.signUp({
    email: data.email.trim().toLowerCase(),
    password: data.password,
  })

  if (authError || !authData.user) {
    return {
      success: false,
      error: toArabicError(authError?.message ?? 'DEFAULT'),
    }
  }

  const { error: profileError } = await supabase.from('employer').insert({
    user_id: authData.user.id,
    company_name_ar: data.company_name_ar.trim(),
    company_name_en: data.company_name_en.trim(),
    sector: data.sector.trim(),
    contact_name: data.contact_name.trim(),
    contact_email: data.contact_email.trim().toLowerCase(),
    is_active: true,
    is_admin: false,
  })

  if (profileError) {
    return {
      success: false,
      error: 'تم إنشاء الحساب لكن حدث خطأ في حفظ بيانات الشركة. يرجى التواصل مع الدعم.',
    }
  }

  await setRoleCookie('employer')
  return { success: true, role: 'employer' }
}