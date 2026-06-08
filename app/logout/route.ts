// app/logout/route.ts
import { signOut } from '@/lib/auth'
import { redirect } from 'next/navigation'
import { type NextRequest } from 'next/server'

export async function GET(_request: NextRequest) {
  await signOut()
  redirect('/login')
}