import MovieCard from '@/components/MovieCard';
import AdBanner from '@/components/AdBanner';
import { Sparkles, Download, Send, Globe, X, Filter, Film, Tv, ShieldCheck, Zap, Heart, ChevronLeft, ChevronRight } from 'lucide-react';
import Link from 'next/link';
import { fetchMovies } from '@/lib/data';

export const dynamic = 'force-dynamic';

interface PageProps {
  searchParams: Promise<{ search?: string; type?: string; genre?: string; page?: string }>;
}

export default async function Home({ searchParams }: PageProps) {
  const resolvedParams = await searchParams;
  const search = resolvedParams.search || '';
  const typeFilter = resolvedParams.type || '';
  const genreFilter = resolvedParams.genre || '';
  const currentPage = Math.max(1, parseInt(resolvedParams.page || '1', 10) || 1);
  const pageSize = 24;

  const movies = await fetchMovies({
    search,
    type: typeFilter,
    genre: genreFilter,
    page: currentPage,
    limit: pageSize,
  });

  // Check if there is likely a next page (if current page returned full page)
  const hasNextPage = movies.length === pageSize;

  const isFiltering = Boolean(search || typeFilter || genreFilter);
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';

  // ── Enterprise ItemList Schema for Google Carousels ────────────────────────
  const itemListSchema = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    'name': 'Latest Sinhala Subtitles and Telegram Downloads',
    'description': 'Verified high quality Sinhala subtitles for movies and TV shows.',
    'itemListElement': movies.slice(0, 30).map((m: any, idx: number) => ({
      '@type': 'ListItem',
      'position': idx + 1,
      'name': m.title,
      'url': `${siteUrl}/movies/${m.id}`,
      'image': m.posterPath || undefined,
    })),
  };

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(itemListSchema) }}
      />

      <div className="max-w-[1700px] mx-auto px-3 sm:px-6 lg:px-8 xl:px-12 py-6 sm:py-8 space-y-8 sm:space-y-12">

        {/* Top Monetization Leaderboard Ad */}
        <AdBanner unit="300x250" />

        {/* Hero Section — only shown when no active search or filter */}
        {!isFiltering && (
          <section
            aria-label="Welcome Hero"
            className="relative rounded-2xl sm:rounded-3xl overflow-hidden px-5 py-10 sm:px-10 sm:py-16 lg:py-20 flex flex-col lg:flex-row items-center justify-between gap-8"
            style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
          >
            {/* Radial Red Lighting */}
            <div
              className="absolute -left-20 -top-20 w-80 h-80 rounded-full pointer-events-none"
              style={{ background: 'radial-gradient(circle, rgba(229,9,20,0.18) 0%, transparent 70%)' }}
            />
            <div
              className="absolute -right-20 -bottom-20 w-80 h-80 rounded-full pointer-events-none"
              style={{ background: 'radial-gradient(circle, rgba(229,9,20,0.10) 0%, transparent 70%)' }}
            />

            <div className="relative z-10 max-w-2xl space-y-4 text-center lg:text-left">
              <div className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-[#E50914] bg-red-500/10 px-3 py-1 rounded-full border border-red-500/20">
                <Sparkles className="w-3.5 h-3.5" />
                <span>Sri Lanka&apos;s #1 Fast Subtitles Platform</span>
              </div>

              <h1
                className="text-2xl sm:text-4xl md:text-5xl lg:text-6xl font-black tracking-tight leading-tight"
                style={{ color: 'var(--color-text)' }}
              >
                Download Sinhala Subtitles
                <br />
                <span className="text-[#E50914]">&amp; Telegram Movies Direct</span>
              </h1>

              <p className="text-sm sm:text-base leading-relaxed" style={{ color: 'var(--color-text-muted)' }}>
                Discover Sinhala subtitle files (.srt) for the newest Hollywood, Bollywood, Korean and TV Series. Get direct, fast Telegram download links with verified 480p, 720p, and 1080p video qualities.
              </p>

              {/* Quick feature pills */}
              <div className="pt-2 flex flex-wrap items-center justify-center lg:justify-start gap-3 text-xs font-semibold" style={{ color: 'var(--color-text-muted)' }}>
                <span className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg" style={{ background: 'var(--color-bg-elevated)' }}>
                  <Download className="w-3.5 h-3.5 text-[#E50914]" />
                  100% Free SRT Downloads
                </span>
                <span className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg" style={{ background: 'var(--color-bg-elevated)' }}>
                  <Send className="w-3.5 h-3.5 text-sky-400" />
                  Telegram High-Speed Channels
                </span>
                <span className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg" style={{ background: 'var(--color-bg-elevated)' }}>
                  <Globe className="w-3.5 h-3.5 text-emerald-400" />
                  Movies &amp; TV Series
                </span>
              </div>
            </div>

            <div
              className="relative z-10 shrink-0 hidden lg:flex flex-col items-center justify-center w-56 h-56 xl:w-64 xl:h-64 rounded-3xl"
              style={{ background: 'rgba(229,9,20,0.05)', border: '1px solid rgba(229,9,20,0.15)' }}
            >
              <div className="w-20 h-20 rounded-2xl bg-[#E50914] flex items-center justify-center shadow-2xl shadow-red-900/50 mb-3">
                <Download className="w-10 h-10 text-white" />
              </div>
              <div className="text-center">
                <p className="text-xl font-black" style={{ color: 'var(--color-text)' }}>
                  PixelSubz<span className="text-[#E50914]">Lk</span>
                </p>
                <p className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Direct &amp; Fast Sinhala Subs</p>
              </div>
            </div>
          </section>
        )}

        {/* Active Filter Chips */}
        {isFiltering && (
          <div className="flex flex-wrap items-center gap-2 pt-2">
            <span className="text-xs font-semibold" style={{ color: 'var(--color-text-muted)' }}>Active Filters:</span>
            {search && (
              <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium bg-[#E50914]/15 text-[#E50914] border border-[#E50914]/30">
                Search: &ldquo;{search}&rdquo;
                <Link href={`/?type=${typeFilter}&genre=${genreFilter}`} className="hover:opacity-75 ml-0.5">
                  <X className="w-3 h-3" />
                </Link>
              </span>
            )}
            {typeFilter && (
              <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium bg-blue-500/15 text-blue-400 border border-blue-500/30">
                Type: {typeFilter === 'MOVIE' ? 'Movies' : 'TV Series'}
                <Link href={`/?search=${encodeURIComponent(search)}&genre=${genreFilter}`} className="hover:opacity-75 ml-0.5">
                  <X className="w-3 h-3" />
                </Link>
              </span>
            )}
            {genreFilter && (
              <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium bg-purple-500/15 text-purple-400 border border-purple-500/30">
                Genre: {genreFilter}
                <Link href={`/?search=${encodeURIComponent(search)}&type=${typeFilter}`} className="hover:opacity-75 ml-0.5">
                  <X className="w-3 h-3" />
                </Link>
              </span>
            )}
            <Link
              href="/"
              className="text-xs font-semibold text-neutral-400 hover:text-white transition-colors underline ml-2"
            >
              Clear all
            </Link>
          </div>
        )}

        {/* Main Catalog Section */}
        <section aria-labelledby="catalog-heading" className="space-y-6">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b pb-4" style={{ borderColor: 'var(--color-border)' }}>
            <div>
              <h2 id="catalog-heading" className="text-xl sm:text-2xl font-black" style={{ color: 'var(--color-text)' }}>
                {search ? `Search Results for "${search}"` : genreFilter ? `${genreFilter} Subtitles` : typeFilter === 'MOVIE' ? 'Latest Movies' : typeFilter === 'TV_SHOW' ? 'Latest TV Series' : 'Latest Releases'}
              </h2>
              <p className="text-xs sm:text-sm mt-0.5" style={{ color: 'var(--color-text-muted)' }}>
                {movies.length > 0 ? `Showing ${movies.length} verified titles` : 'No matching titles found'}
              </p>
            </div>

            {/* Quick Type Filter Tabs */}
            <div className="flex items-center p-1 rounded-xl shrink-0" style={{ background: 'var(--color-bg-elevated)' }}>
              <Link
                href={`/?${search ? `search=${encodeURIComponent(search)}&` : ''}${genreFilter ? `genre=${genreFilter}` : ''}`}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-bold transition-all ${
                  !typeFilter ? 'bg-[#E50914] text-white shadow-md' : 'text-neutral-400 hover:text-white'
                }`}
              >
                All
              </Link>
              <Link
                href={`/?type=MOVIE${search ? `&search=${encodeURIComponent(search)}` : ''}${genreFilter ? `&genre=${genreFilter}` : ''}`}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-bold transition-all ${
                  typeFilter === 'MOVIE' ? 'bg-[#E50914] text-white shadow-md' : 'text-neutral-400 hover:text-white'
                }`}
              >
                Movies
              </Link>
              <Link
                href={`/?type=TV_SHOW${search ? `&search=${encodeURIComponent(search)}` : ''}${genreFilter ? `&genre=${genreFilter}` : ''}`}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-bold transition-all ${
                  typeFilter === 'TV_SHOW' ? 'bg-[#E50914] text-white shadow-md' : 'text-neutral-400 hover:text-white'
                }`}
              >
                TV Series
              </Link>
            </div>
          </div>

          {/* Content Cards Grid */}
          {movies.length > 0 ? (
            <>
              <div className="grid grid-cols-2 xs:grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 2xl:grid-cols-7 gap-3 sm:gap-4 md:gap-5">
                {movies.map((movie) => (
                  <MovieCard
                    key={movie.id}
                    movie={movie}
                  />
                ))}
              </div>

              {/* ── High-Performance Pagination Bar ── */}
              <div className="pt-6 pb-2 flex items-center justify-center gap-3">
                {currentPage > 1 && (
                  <Link
                    href={`/?${search ? `search=${encodeURIComponent(search)}&` : ''}${typeFilter ? `type=${typeFilter}&` : ''}${genreFilter ? `genre=${genreFilter}&` : ''}page=${currentPage - 1}`}
                    className="flex items-center gap-1.5 px-4 py-2 rounded-xl text-xs font-bold transition-all bg-neutral-900 border border-neutral-800 text-neutral-200 hover:text-white hover:border-neutral-600 shadow-md active:scale-95"
                  >
                    <ChevronLeft className="h-4 w-4" />
                    <span>Previous Page</span>
                  </Link>
                )}

                <span
                  className="px-4 py-2 rounded-xl text-xs font-black tracking-wider shadow-md"
                  style={{
                    background: 'var(--color-bg-card)',
                    border: '1px solid var(--color-border)',
                    color: 'var(--color-text)',
                  }}
                >
                  Page {currentPage}
                </span>

                {hasNextPage && (
                  <Link
                    href={`/?${search ? `search=${encodeURIComponent(search)}&` : ''}${typeFilter ? `type=${typeFilter}&` : ''}${genreFilter ? `genre=${genreFilter}&` : ''}page=${currentPage + 1}`}
                    className="flex items-center gap-1.5 px-5 py-2 rounded-xl text-xs font-black transition-all bg-[#E50914] text-white hover:bg-red-700 shadow-lg shadow-red-900/30 active:scale-95"
                  >
                    <span>Next Page</span>
                    <ChevronRight className="h-4 w-4" />
                  </Link>
                )}
              </div>
            </>
          ) : (
            /* Clean Empty State when no results found */
            <div
              className="rounded-3xl p-12 sm:p-16 text-center space-y-4 flex flex-col items-center justify-center max-w-xl mx-auto"
              style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
            >
              <div className="w-16 h-16 rounded-2xl bg-neutral-900 flex items-center justify-center text-neutral-500 mb-2">
                <Film className="w-8 h-8 text-neutral-600" />
              </div>
              <h3 className="text-lg sm:text-xl font-bold" style={{ color: 'var(--color-text)' }}>
                No titles found matching your search
              </h3>
              <p className="text-xs sm:text-sm text-neutral-400 max-w-sm">
                Try searching with different keywords, check the spelling, or reset your active filters.
              </p>
              <Link
                href="/"
                className="mt-2 inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[#E50914] hover:bg-red-700 text-white font-bold text-xs transition-all shadow-lg"
              >
                Reset All Filters
              </Link>
            </div>
          )}
        </section>

        {/* High-CPM In-Content Ad Slot (Unit 2: 160x300) */}
        <AdBanner unit="160x300" />

        {/* ── High-Authority Bilingual Semantic SEO Content Section ──── */}
        <section
          aria-label="About Sinhala Subtitles"
          className="rounded-3xl p-6 sm:p-10 space-y-6"
          style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
        >
          <div className="space-y-1">
            <h3 className="text-base sm:text-xl font-black" style={{ color: 'var(--color-text)' }}>
              Download Latest Sinhala Subtitles &amp; Direct Telegram Movies — PixelSubz<span className="text-[#E50914]">Lk</span>
            </h3>
            <p className="text-xs text-neutral-400">
              ශ්‍රී ලංකාවේ ප්‍රමුඛතම සහ වේගවත්ම සිංහල උපසිරැසි සහ Direct Telegram ඩවුන්ලෝඩ් වේදිකාව.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 text-xs sm:text-sm leading-relaxed" style={{ color: 'var(--color-text-muted)' }}>
            <div className="p-4 rounded-2xl bg-neutral-900/40 border border-neutral-800 space-y-2">
              <h4 className="font-bold flex items-center gap-2 text-white">
                <ShieldCheck className="w-4 h-4 text-emerald-400" />
                🇱🇰 100% Synced Sinhala Subtitles
              </h4>
              <p>
                Download synchronized, clean UTF-8 Sinhala subtitles (.srt) for Hollywood, Bollywood, Tamil, Malayalam, Telugu, and Korean cinema. Fully compatible with VLC, MX Player, KMPlayer, PotPlayer, Smart TVs, and iOS/Android.
              </p>
            </div>

            <div className="p-4 rounded-2xl bg-neutral-900/40 border border-neutral-800 space-y-2">
              <h4 className="font-bold flex items-center gap-2 text-white">
                <Zap className="w-4 h-4 text-sky-400" />
                ⚡ High-Speed Direct Telegram Links
              </h4>
              <p>
                Access verified high-speed Telegram channel links to download full HD 1080p, 720p, and lightweight 480p rips encoded in modern x265 HEVC with multi-audio support.
              </p>
            </div>

            <div className="p-4 rounded-2xl bg-neutral-900/40 border border-neutral-800 space-y-2">
              <h4 className="font-bold flex items-center gap-2 text-white">
                <Tv className="w-4 h-4 text-purple-400" />
                📺 Complete TV Series &amp; Episode Archive
              </h4>
              <p>
                Stay updated with the newest season and episode releases for top trending TV series. Complete season subtitle archives with episode-by-episode tracking.
              </p>
            </div>
          </div>
        </section>

        {/* Footer Sponsor Ad */}
        

      </div>
    </>
  );
}
