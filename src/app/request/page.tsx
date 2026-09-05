import prisma, { isDatabaseConfigured } from '@/lib/db';
import RequestForm from '@/components/RequestForm';
import { MessageSquare, Calendar, User } from 'lucide-react';
import type { Metadata } from 'next';

export const dynamic = 'force-dynamic';

export const metadata: Metadata = {
  title: 'Request Sinhala Subtitles & Movies',
  description: 'Can’t find Sinhala subtitles or direct Telegram download links for your favorite movie or TV series? Submit a free request on PixelSubzLk.',
  alternates: {
    canonical: '/request',
  },
  openGraph: {
    title: 'Request Sinhala Subtitles & Movies | PixelSubzLk',
    description: 'Submit a free request for Sinhala subtitles and Telegram downloads.',
    url: 'https://pixelsubz.lk/request',
  },
};

export default async function RequestPage() {
  let requests: any[] = [];
  if (isDatabaseConfigured()) {
    try {
      requests = await prisma.downloadRequest.findMany({
        include: { user: { select: { email: true } } },
        orderBy: { createdAt: 'desc' },
      });
    } catch (error) {
      console.warn('Failed to load requests:', error);
    }
  }

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">

        {/* Left: Form */}
        <div className="space-y-6">
          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight" style={{ color: 'var(--color-text)' }}>
              Requests Portal
            </h1>
            <p className="text-xs sm:text-sm" style={{ color: 'var(--color-text-muted)' }}>
              Can&apos;t find what you&apos;re looking for? Request subtitles or a movie download link and our team will look into it.
            </p>
          </div>
          <RequestForm />
        </div>

        {/* Right: Active Requests */}
        <div className="md:col-span-2 space-y-6">
          <h2 className="nf-section-title">
            <MessageSquare className="h-5 w-5 text-[#E50914]" />
            <span>Active Requests</span>
            <span
              className="text-xs px-2 py-0.5 rounded-full font-medium ml-auto"
              style={{ background: 'var(--color-bg-elevated)', color: 'var(--color-text-muted)' }}
            >
              {requests.length} total
            </span>
          </h2>

          {requests.length === 0 ? (
            <div
              className="rounded-xl p-12 text-center text-sm"
              style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text-muted)' }}
            >
              No requests yet. Be the first to request subtitles!
            </div>
          ) : (
            <div className="space-y-3">
              {requests.map(req => (
                <div
                  key={req.id}
                  className="rounded-xl p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 transition-all"
                  style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
                >
                  <div className="space-y-1.5">
                    <h3 className="text-sm font-bold truncate" style={{ color: 'var(--color-text)' }}>
                      {req.title}
                    </h3>
                    <div className="flex flex-wrap items-center gap-3 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                      <span
                        className="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded text-white"
                        style={{ background: req.type === 'MOVIE' ? '#4f46e5' : '#be185d' }}
                      >
                        {req.type === 'MOVIE' ? 'Movie' : 'TV Show'}
                      </span>
                      <span className="flex items-center gap-1">
                        <User className="h-3 w-3" />
                        {req.user?.email ? req.user.email.split('@')[0] : 'Anonymous'}
                      </span>
                      <span className="flex items-center gap-1">
                        <Calendar className="h-3 w-3" />
                        {new Date(req.createdAt).toLocaleDateString()}
                      </span>
                    </div>
                  </div>

                  <span
                    className={`text-xs font-bold px-2.5 py-1 rounded-full border shrink-0 ${
                      req.status === 'PENDING'
                        ? 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20'
                        : req.status === 'FILLED'
                        ? 'bg-green-500/10 text-green-400 border-green-500/20'
                        : 'bg-red-500/10 text-red-400 border-red-500/20'
                    }`}
                  >
                    {req.status}
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
