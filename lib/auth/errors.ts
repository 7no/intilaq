// lib/auth/errors.ts

export const AUTH_ERRORS_AR: Record<string, string> = {
  'Invalid login credentials':
    'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
  'Email not confirmed':
    'البريد الإلكتروني لم يُفعَّل بعد. يرجى مراجعة بريدك الوارد.',
  'User already registered':
    'هذا البريد الإلكتروني مسجّل مسبقًا. يمكنك تسجيل الدخول مباشرة.',
  'Password should be at least 6 characters':
    'كلمة المرور يجب أن تكون 8 أحرف على الأقل.',
  'Signup requires a valid password':
    'يرجى إدخال كلمة مرور صالحة.',
  'Email rate limit exceeded':
    'لقد تجاوزت الحد المسموح به للمحاولات. يرجى الانتظار قليلاً والمحاولة مجددًا.',
  'over_email_send_rate_limit':
    'تم إرسال عدد كبير من رسائل التحقق. يرجى الانتظار دقيقة والمحاولة مجددًا.',
  'DEFAULT':
    'حدث خطأ غير متوقع. يرجى المحاولة مجددًا.',
}

export function toArabicError(supabaseMessage: string): string {
  return AUTH_ERRORS_AR[supabaseMessage] ?? AUTH_ERRORS_AR['DEFAULT']
}