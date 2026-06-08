// app/login/page.tsx
'use client'

import { useActionState } from 'react'
import { useSearchParams } from 'next/navigation'
import { Suspense } from 'react'
import { loginAction } from './actions'
import styles from './page.module.css'

function LoginForm() {
  const [state, formAction, isPending] = useActionState(loginAction, {})
  const searchParams = useSearchParams()
  const redirectTo = searchParams.get('redirect') ?? ''
  const isUnauthorized = searchParams.get('error') === 'unauthorized'

  return (
    <main className={styles.container}>
      <div className={styles.card}>
        <div className={styles.header}>
          <h1 className={styles.title}>انطلاق</h1>
          <p className={styles.subtitle}>تسجيل الدخول</p>
        </div>

        {isUnauthorized && (
          <div className={styles.warningBanner} role="alert">
            ليس لديك صلاحية الوصول إلى هذه الصفحة.
          </div>
        )}

        {state.error && (
          <div className={styles.errorBanner} role="alert">
            {state.error}
          </div>
        )}

        <form action={formAction} className={styles.form} noValidate>
          <input type="hidden" name="redirectTo" value={redirectTo} />

          <div className={styles.field}>
            <label htmlFor="email" className={styles.label}>
              البريد الإلكتروني
            </label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="email"
              dir="ltr"
              className={styles.input}
            />
          </div>

          <div className={styles.field}>
            <label htmlFor="password" className={styles.label}>
              كلمة المرور
            </label>
            <input
              id="password"
              name="password"
              type="password"
              autoComplete="current-password"
              dir="ltr"
              className={styles.input}
            />
          </div>

          <button
            type="submit"
            disabled={isPending}
            className={styles.submitButton}
          >
            {isPending ? 'جارٍ تسجيل الدخول...' : 'تسجيل الدخول'}
          </button>
        </form>

        <div className={styles.links}>
          <p className={styles.registerText}>
            طالب جديد؟{' '}
            <a href="/student/register" className={styles.link}>
              أنشئ حسابك
            </a>
          </p>
          <p className={styles.registerText}>
            جهة توظيف؟{' '}
            <a href="/employer/register" className={styles.link}>
              سجّل شركتك
            </a>
          </p>
        </div>
      </div>
    </main>
  )
}

export default function LoginPage() {
  return (
    <Suspense>
      <LoginForm />
    </Suspense>
  )
}