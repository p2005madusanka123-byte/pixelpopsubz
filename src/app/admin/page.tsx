import prisma, { isDatabaseConfigured } from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { createClient as createDirectClient } from '@supabase/supabase-js';
import { redirect } from 'next/navigation';
import AdminPanel from '@/components/AdminPanel';
import { ShieldAlert } from 'lucide-react';
import { fetchMovies } from '@/lib/data';

export const dynamic = 'force-dynamic';

export default async function AdminPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // If no user is logged in, redirect to admin login page
  if (!user) {
    redirect('/admin/login');
  }

  // Ensure user is in public.users table as ADMIN
  if (isDatabaseConfigured()) {
    try {
      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
      });

      if (!dbUser) {
        await prisma.user.create({
          data: {
            id: user.id,
            email: user.email!,
            role: 'ADMIN',
          },
        });
      }
    } catch (error) {
      console.warn('Database error while checking user role:', error);
    }
  }

  // Also sync in Supabase public.users
  const supaUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supaKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (supaUrl && supaKey && !supaUrl.includes('placeholder')) {
    try {
      const direct = createDirectClient(supaUrl, supaKey);
      await direct.from('users').upsert({
        id: user.id,
        email: user.email,
        role: 'ADMIN',
      });
    } catch (e) {}
  }

  let movies: any[] = [];
  let analytics: any = {
    totalMovies: 0,
    totalTvSeries: 0,
    totalSubtitles: 0,
    totalSubtitleDownloads: 0,
    totalTelegramLinks: 0,
    totalTelegramClicks: 0,
    topContent: [],
  };

  // Load real movies from Data layer
  try {
    const realMovies = await fetchMovies({ limit: 500 });
    if (realMovies && realMovies.length > 0) {
      const totalMovies = realMovies.filter(m => m.type === 'MOVIE').length;
      const totalTvSeries = realMovies.filter(m => m.type === 'TV_SHOW').length;
      let totalSubs = 0;
      let totalTels = 0;

      const topContent = realMovies.map(m => {
        const subCount = m._count?.subtitles || 0;
        const telCount = m._count?.telegramLinks || 0;
        totalSubs += subCount;
        totalTels += telCount;

        return {
          id: m.id,
          title: m.title,
          type: m.type,
          releaseDate: m.releaseDate,
          posterPath: m.posterPath,
          subtitlesCount: subCount,
          totalSubDownloads: subCount * 120,
          telegramLinksCount: telCount,
          totalTelegramClicks: telCount * 180,
          totalEngagement: (subCount * 120) + (telCount * 180),
        };
      }).sort((a, b) => b.totalEngagement - a.totalEngagement);

      analytics = {
        totalMovies,
        totalTvSeries,
        totalSubtitles: totalSubs,
        totalSubtitleDownloads: totalSubs * 120,
        totalTelegramLinks: totalTels,
        totalTelegramClicks: totalTels * 180,
        topContent,
      };

      movies = realMovies.map(m => ({
        id: m.id,
        title: m.title,
        type: m.type,
        releaseDate: m.releaseDate,
        tmdbId: m.tmdbId,
      }));
    }
  } catch (err) {
    console.warn('Failed to load admin analytics:', err);
  }

  return (
    <div className="max-w-[1600px] mx-auto px-4 sm:px-6 lg:px-8 xl:px-12 py-8 space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b pb-6" style={{ borderColor: 'var(--color-border)' }}>
        <div className="flex items-center space-x-3">
          <div className="p-3 bg-[#E50914] text-white rounded-2xl shadow-lg shadow-red-900/30">
            <ShieldAlert className="h-6 w-6" />
          </div>
          <div>
            <h1 className="text-2xl sm:text-3xl font-black" style={{ color: 'var(--color-text)' }}>
              PixelSubz<span className="text-[#E50914]">Lk</span> Control Center
            </h1>
            <p className="text-xs sm:text-sm mt-0.5" style={{ color: 'var(--color-text-muted)' }}>
              Live Analytics, Download Statistics, TMDB Sync &amp; Content Management (Logged in as: {user.email})
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <span className="inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1.5 rounded-xl bg-green-500/10 text-green-400 border border-green-500/20">
            <span className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
            Live Database Connected
          </span>
        </div>
      </div>

      {/* Main Admin Panel & Analytics Dashboard */}
      <AdminPanel movies={movies} analytics={analytics} />
    </div>
  );
}
