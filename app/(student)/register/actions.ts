// app/(student)/register/actions.ts
'use server'

import { signUpStudent, type StudentSignUpData } from '@/lib/auth'
import { ROLE_REDIRECT } from '@/lib/auth/constants'
import { redirect } from 'next/navigation'

export interface StudentRegisterState {
  error?: string
  fieldErrors?: Partial<Record<string, string>>
}

export async function studentRegisterAction(
  _prevState: StudentRegisterState,
  formData: FormData
): Promise<StudentRegisterState> {

  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const full_name = formData.get('full_name') as string
  const university = formData.get('university') as string
  const major = formData.get('major') as string
  const graduation_status = formData.get('graduation_status') as string
  const nationality_confirmed = formData.get('nationality_confirmed') === 'on'
  const career_interest = formData.get('career_interest') as string
  const target_role_id = formData.get('target_role_id') as string | null
  const skill_level = formData.get('skill_level') as string
  const availability = formData.get('availability') as string
  const language_pref = (formData.get('language_pref') as string) || 'ar'

  const fieldErrors: StudentRegisterState['fieldErrors'] = {}

  if (!email || !email.includes('@'))
    fieldErrors.email = 'يرجى إدخال بريد إلكتروني صحيح.'
  if (!password || password.length < 8)
    fieldErrors.password = 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.'
  if (!full_name || full_name.trim().length < 3)
    fieldErrors.full_name = 'يرجى إدخال الاسم الكامل (3 أحرف على الأقل).'
  if (!university || university.trim().length < 2)
    fieldErrors.university = 'يرجى إدخال اسم الجامعة أو المؤسسة.'
  if (!major || major.trim().length < 2)
    fieldErrors.major = 'يرجى إدخال التخصص.'
  if (!graduation_status)
    fieldErrors.graduation_status = 'يرجى تحديد الحالة الدراسية.'
  if (!nationality_confirmed)
    fieldErrors.nationality_confirmed = 'يجب تأكيد الجنسية السعودية للمتابعة.'
  if (!career_interest || career_interest.trim().length < 2)
    fieldErrors.career_interest = 'يرجى ذكر مجال الاهتمام المهني.'
  if (!skill_level)
    fieldErrors.skill_level = 'يرجى تحديد مستوى الخبرة.'
  if (!availability)
    fieldErrors.availability = 'يرجى تحديد التفرغ المتاح.'

  if (Object.keys(fieldErrors).length > 0) {
    return { fieldErrors }
  }

  const result = await signUpStudent({
    email,
    password,
    full_name,
    university,
    major,
    graduation_status: graduation_status as StudentSignUpData['graduation_status'],
    nationality_confirmed: true,
    career_interest,
    target_role_id: target_role_id || null,
    skill_level: skill_level as StudentSignUpData['skill_level'],
    availability: availability as StudentSignUpData['availability'],
    language_pref: language_pref as StudentSignUpData['language_pref'],
  })

  if (!result.success) {
    return { error: result.error }
  }

  redirect(ROLE_REDIRECT['student'])
}