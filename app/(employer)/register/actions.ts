// app/(employer)/register/actions.ts
'use server'

import { signUpEmployer } from '@/lib/auth'
import { ROLE_REDIRECT } from '@/lib/auth/constants'
import { redirect } from 'next/navigation'

export interface EmployerRegisterState {
  error?: string
  fieldErrors?: Partial<Record<string, string>>
}

export async function employerRegisterAction(
  _prevState: EmployerRegisterState,
  formData: FormData
): Promise<EmployerRegisterState> {

  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const company_name_ar = formData.get('company_name_ar') as string
  const company_name_en = formData.get('company_name_en') as string
  const sector = formData.get('sector') as string
  const contact_name = formData.get('contact_name') as string
  const contact_email = formData.get('contact_email') as string

  const fieldErrors: EmployerRegisterState['fieldErrors'] = {}

  if (!email || !email.includes('@'))
    fieldErrors.email = 'يرجى إدخال بريد إلكتروني صحيح.'
  if (!password || password.length < 8)
    fieldErrors.password = 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.'
  if (!company_name_ar || company_name_ar.trim().length < 2)
    fieldErrors.company_name_ar = 'يرجى إدخال اسم الشركة بالعربية.'
  if (!company_name_en || company_name_en.trim().length < 2)
    fieldErrors.company_name_en = 'يرجى إدخال اسم الشركة بالإنجليزية.'
  if (!sector)
    fieldErrors.sector = 'يرجى تحديد قطاع الشركة.'
  if (!contact_name || contact_name.trim().length < 2)
    fieldErrors.contact_name = 'يرجى إدخال اسم مسؤول التواصل.'
  if (!contact_email || !contact_email.includes('@'))
    fieldErrors.contact_email = 'يرجى إدخال بريد إلكتروني صحيح للتواصل.'

  if (Object.keys(fieldErrors).length > 0) {
    return { fieldErrors }
  }

  const result = await signUpEmployer({
    email,
    password,
    company_name_ar,
    company_name_en,
    sector,
    contact_name,
    contact_email,
  })

  if (!result.success) {
    return { error: result.error }
  }

  redirect(ROLE_REDIRECT['employer'])
}