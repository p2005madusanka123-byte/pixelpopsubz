import Link from 'next/link';
import { Film } from 'lucide-react';

export default function NotFound() {
  return (
    <div className="min-h-[70vh] flex flex-col items-center justify-center px-4 text-center space-y-6">
      <div
        className="w-20 h-20 rounded-2xl flex items-center justify-center"
        style={{ background: 'rgba(229,9,20,0.1)', border: '1px solid rgba(229,9,20,0.2)' }}
      >
        <Film className="h-10 w-10 text-[#E50914]" />
      </div>
      <div className="space-y-2">
        <h1 className="text-7xl font-black text-[#E50914]">404</h1>
        <h2 className="text-2xl font-bold" style={{ color: 'var(--color-text)' }}>Page Not Found</h2>
        <p className="text-sm max-w-sm" style={{ color: 'var(--color-text-muted)' }}>
          The movie, subtitle, or page you&apos;re looking for doesn&apos;t exist or may have been removed.
        </p>
      </div>
      <Link
        href="/"
        className="nf-btn-primary px-6 py-2.5 text-sm"
      >
        Back to Browse
      </Link>
    </div>
  );
}
