// app/(student)/register/page.tsx
'use client'

import { useActionState } from 'react'
import { studentRegisterAction } from './actions'
import styles from './page.module.css'
import {
  GRADUATION_STATUS_LABELS_AR,
  SKILL_LEVEL_LABELS_AR,
  AVAILABILITY_LABELS_AR,
} from '@/lib/auth/constants'

const initialState = {}

export default function StudentRegisterPage() {
  const [state, formAction, isPending] = useActionState(
    studentRegisterAction,
    initialState
  )

  return (
    <main className={styles.container}>
      <div className={styles.card}>
        <div className={styles.header}>
          <h1 className={styles.title}>انطلاق</h1>
          <p className={styles.subtitle}>إنشاء حساب طالب</p>
        </div>

        {state.error && (
          <div className={styles.errorBanner} role="alert">
            {state.error}
          </div>
        )}

        <form action={formAction} className={styles.form} noValidate>

          <div className={styles.field}>
            <label htmlFor="full_name" className={styles.label}>
              الاسم الكامل <span className={styles.required}>*</span>
            </label>
            <input
              id="full_name"
              name="full_name"
              type="text"
              autoComplete="name"
              className={styles.input}
            />
            {state.fieldErrors?.full_name && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.full_name}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="email" className={styles.label}>
              البريد الإلكتروني <span className={styles.required}>*</span>
            </label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="email"
              dir="ltr"
              className={styles.input}
            />
            {state.fieldErrors?.email && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.email}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="password" className={styles.label}>
              كلمة المرور <span className={styles.required}>*</span>
            </label>
            <input
              id="password"
              name="password"
              type="password"
              autoComplete="new-password"
              dir="ltr"
              className={styles.input}
            />
            <span className={styles.hint}>8 أحرف على الأقل</span>
            {state.fieldErrors?.password && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.password}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="university" className={styles.label}>
              الجامعة أو المؤسسة التعليمية <span className={styles.required}>*</span>
            </label>
            <input
              id="university"
              name="university"
              type="text"
              className={styles.input}
            />
            {state.fieldErrors?.university && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.university}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="major" className={styles.label}>
              التخصص <span className={styles.required}>*</span>
            </label>
            <input
              id="major"
              name="major"
              type="text"
              className={styles.input}
            />
            {state.fieldErrors?.major && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.major}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="graduation_status" className={styles.label}>
              الحالة الدراسية <span className={styles.required}>*</span>
            </label>
            <select
              id="graduation_status"
              name="graduation_status"
              className={styles.select}
            >
              <option value="">— اختر —</option>
              {Object.entries(GRADUATION_STATUS_LABELS_AR).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
            {state.fieldErrors?.graduation_status && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.graduation_status}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="career_interest" className={styles.label}>
              مجال الاهتمام المهني <span className={styles.required}>*</span>
            </label>
            <input
              id="career_interest"
              name="career_interest"
              type="text"
              placeholder="مثال: التسويق الرقمي، تحليل البيانات، الموارد البشرية"
              className={styles.input}
            />
            {state.fieldErrors?.career_interest && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.career_interest}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="skill_level" className={styles.label}>
              مستوى الخبرة الحالي <span className={styles.required}>*</span>
            </label>
            <select
              id="skill_level"
              name="skill_level"
              className={styles.select}
            >
              <option value="">— اختر —</option>
              {Object.entries(SKILL_LEVEL_LABELS_AR).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
            {state.fieldErrors?.skill_level && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.skill_level}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <label htmlFor="availability" className={styles.label}>
              التفرغ المتاح أسبوعيًا <span className={styles.required}>*</span>
            </label>
            <select
              id="availability"
              name="availability"
              className={styles.select}
            >
              <option value="">— اختر —</option>
              {Object.entries(AVAILABILITY_LABELS_AR).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
            {state.fieldErrors?.availability && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.availability}
              </span>
            )}
          </div>

          <div className={styles.field}>
            <span className={styles.label}>لغة الواجهة المفضلة</span>
            <div className={styles.radioGroup}>
              <label className={styles.radioLabel}>
                <input
                  type="radio"
                  name="language_pref"
                  value="ar"
                  defaultChecked
                  className={styles.radio}
                />
                العربية
              </label>
              <label className={styles.radioLabel}>
                <input
                  type="radio"
                  name="language_pref"
                  value="en"
                  className={styles.radio}
                />
                English
              </label>
            </div>
          </div>

          <div className={styles.nationalityField}>
            <label className={styles.checkboxLabel}>
              <input
                type="checkbox"
                name="nationality_confirmed"
                className={styles.checkbox}
                required
              />
              <span>
                أؤكد أنني مواطن سعودي. المنصة مخصصة للكوادر الوطنية السعودية فقط.{' '}
                <span className={styles.required}>*</span>
              </span>
            </label>
            {state.fieldErrors?.nationality_confirmed && (
              <span className={styles.fieldError} role="alert">
                {state.fieldErrors.nationality_confirmed}
              </span>
            )}
          </div>

          <button
            type="submit"
            disabled={isPending}
            className={styles.submitButton}
          >
            {isPending ? 'جارٍ إنشاء الحساب...' : 'إنشاء الحساب والبدء'}
          </button>

          <p className={styles.loginLink}>
            لديك حساب؟{' '}
            <a href="/login" className={styles.link}>
              سجّل الدخول
            </a>
          </p>
        </form>
      </div>
    </main>
  )
}