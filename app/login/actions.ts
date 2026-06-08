// app/login/actions.ts
'use server'

import { signIn } from '@/lib/auth'
import { ROLE_REDIRECT } from '@/lib/auth/constants'
import { redirect } from 'next/navigation'

export interface LoginState {
  error?: string
}

export async function loginAction(
  _prevState: LoginState,
  formData: FormData
): Promise<LoginState> {

  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const redirectTo = formData.get('redirectTo') as string | null

  if (!email || !password) {
    return { error: 'يرجى إدخال البريد الإلكتروني وكلمة المرور.' }
  }

  const result = await signIn(email, password)

  if (!result.success || !result.role) {
    return { error: result.error }
  }

  const defaultRedirect = ROLE_REDIRECT[result.role]

  if (
    redirectTo &&
    redirectTo.startsWith('/') &&
    redirectTo.startsWith(defaultRedirect.split('/').slice(0, 2).join('/'))
  ) {
    redirect(redirectTo)
  }

  redirect(defaultRedirect)
}