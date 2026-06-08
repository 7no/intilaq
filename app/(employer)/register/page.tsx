// app/(employer)/register/page.tsx
'use client'

import { useActionState } from 'react'
import { employerRegisterAction } from './actions'
import styles from './page.module.css'
import { SECTOR_OPTIONS_AR } from '@/lib/auth/constants'

const initialState = {}

export default function EmployerRegisterPage() {
  const [state, formAction, isPending] = useActionState(
    employerRegisterAction,
    initialState
  )

  return (
    <main className={styles.container}>
      <div className={styles.card}>
        <div className={styles.header}>
          <h1 className={styles.title}>انطلاق</h1>
          <p className={styles.subtitle}>تسجيل حساب جهة التوظيف</p>
        </div>

        {state.error && (
          <div className={styles.errorBanner} role="alert">
            {state.error}
          </div>
        )}

        <form action={formAction} className={styles.form} noValidate>

          <div className={styles.field}>
            <label htmlFor="company_name_ar" className={styles.label}>
              اسم الشركة بالعربية <span className={styles.required}>*</span>
            </label>
            <input id="company_name_ar" name="company_name_ar" type="text" className={styles.input} />
            {state.fieldErrors?.company_name_ar && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.company_name_ar}</span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="company_name_en" className={styles.label}>
              Company Name (English) <span className={styles.required}>*</span>
            </label>
            <input id="company_name_en" name="company_name_en" type="text" dir="ltr" className={styles.input} />
            {state.fieldErrors?.company_name_en && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.company_name_en}</span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="sector" className={styles.label}>
              قطاع الشركة <span className={styles.required}>*</span>
            </label>
            <select id="sector" name="sector" className={styles.select}>
              <option value="">— اختر القطاع —</option>
              {SECTOR_OPTIONS_AR.map(({ value, label }) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
            {state.fieldErrors?.sector && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.sector}</span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="contact_name" className={styles.label}>
              اسم مسؤول التواصل <span className={styles.required}>*</span>
            </label>
            <input id="contact_name" name="contact_name" type="text" className={styles.input} />
            {state.fieldErrors?.contact_name && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.contact_name}</span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="contact_email" className={styles.label}>
              البريد الإلكتروني للتواصل <span className={styles.required}>*</span>
            </label>
            <input id="contact_email" name="contact_email" type="email" dir="ltr" className={styles.input} />
            {state.fieldErrors?.contact_email && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.contact_email}</span>
            )}
          </div>

          <div className={styles.divider} />

          <div className={styles.field}>
            <label htmlFor="email" className={styles.label}>
              البريد الإلكتروني لتسجيل الدخول <span className={styles.required}>*</span>
            </label>
            <input id="email" name="email" type="email" autoComplete="email" dir="ltr" className={styles.input} />
            {state.fieldErrors?.email && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.email}</span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="password" className={styles.label}>
              كلمة المرور <span className={styles.required}>*</span>
            </label>
            <input id="password" name="password" type="password" autoComplete="new-password" dir="ltr" className={styles.input} />
            <span className={styles.hint}>8 أحرف على الأقل</span>
            {state.fieldErrors?.password && (
              <span className={styles.fieldError} role="alert">{state.fieldErrors.password}</span>
            )}
          </div>

          <button type="submit" disabled={isPending} className={styles.submitButton}>
            {isPending ? 'جارٍ إنشاء الحساب...' : 'إنشاء حساب جهة التوظيف'}
          </button>

          <p className={styles.loginLink}>
            لديك حساب؟{' '}
            <a href="/login" className={styles.link}>سجّل الدخول</a>
          </p>
        </form>
      </div>
    </main>
  )
}