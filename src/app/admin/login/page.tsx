import { Suspense } from 'react';
import { Loader2 } from 'lucide-react';
import AdminLoginForm from './AdminLoginForm';

export const dynamic = 'force-dynamic';

export default function AdminLoginPage() {
  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-12" style={{ background: 'var(--color-bg)' }}>
      <Suspense fallback={
        <div className="flex flex-col items-center gap-3">
          <Loader2 className="h-8 w-8 animate-spin text-[#E50914]" />
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Loading admin portal…</p>
        </div>
      }>
        <AdminLoginForm />
      </Suspense>
    </div>
  );
}
