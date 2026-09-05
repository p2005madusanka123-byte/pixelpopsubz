import { notFound } from 'next/navigation';
import { Film, Calendar, Tag, Star, Clock, Globe, Tv, ArrowLeft, ChevronDown, Download, Send, ExternalLink, HelpCircle, CheckCircle, ShieldCheck, Sparkles, Layers } from 'lucide-react';
import Link from 'next/link';
import type { Metadata } from 'next';
import EpisodeViewer from '@/components/EpisodeViewer';
import MovieDownloadSection from '@/components/MovieDownloadSection';
import MovieCard from '@/components/MovieCard';
import AdBanner from '@/components/AdBanner';
import { fetchMovieById, fetchMovies } from '@/lib/data';

export const dynamic = 'force-dynamic';

interface Props {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ season?: string; episode?: string }>;
}

// ─── High-CTR Metadata Generator ─────────────────────────────────────────────
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id } = await params;
  const movie = await fetchMovieById(id);
  if (!movie) return { title: 'Not Found | PixelSubzLk' };

  const year = movie.year || (movie.releaseDate ? movie.releaseDate.split('-')[0] : '');
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
  const pageUrl = `${siteUrl}/movies/${movie.id}`;

  const titleText = `🎬 ${movie.title} ${year ? `(${year})` : ''} Sinhala Subtitle (.SRT) & Direct Telegram Download | PixelSubzLk`;
  const descText = `Download ${movie.title} ${year ? `(${year})` : ''} Sinhala Subtitle (.srt) UTF-8. 100% Synced for 1080p, 720p WEB-DL, BluRay & Direct Telegram High-Speed Video Files on PixelSubzLk. ${movie.description ? movie.description.substring(0, 100) + '...' : ''}`;

  const keywords = [
    `${movie.title} sinhala subtitle`,
    `${movie.title} sinhala sub`,
    `${movie.title} sinhala sub download`,
    `${movie.title} ${year} sinhala sub`,
    `${movie.title} telegram link`,
    `${movie.title} baiscope sinhala sub`,
    `${movie.title} cineru sinhala sub`,
    `${movie.title} සිංහල උපසිරැසි`,
    `${movie.title} සිංහල සබ්`,
    ...(movie.seoTags || []),
    ...(movie.genres || []).map((g: string) => `${g} sinhala subtitle`),
    'PixelSubzLk',
  ];

  return {
    title: titleText,
    description: descText,
    keywords,
    alternates: {
      canonical: pageUrl,
    },
    openGraph: {
      title: `${movie.title} (${year || 'Latest'}) Sinhala Subtitle | PixelSubzLk`,
      description: descText,
      url: pageUrl,
      siteName: 'PixelSubzLk',
      images: movie.posterPath ? [{ url: movie.posterPath, width: 500, height: 750, alt: `${movie.title} Sinhala Subtitle Poster` }] : [],
      type: movie.type === 'TV_SHOW' ? 'video.tv_show' : 'video.movie',
      locale: 'si_LK',
    },
    twitter: {
      card: 'summary_large_image',
      title: `${movie.title} Sinhala Sub (.srt) & Telegram Link | PixelSubzLk`,
      description: descText,
      images: movie.posterPath ? [movie.posterPath] : [],
    },
    robots: {
      index: true,
      follow: true,
      googleBot: {
        index: true,
        follow: true,
        'max-video-preview': -1,
        'max-image-preview': 'large',
        'max-snippet': -1,
      },
    },
  };
}

// ─── Page component ───────────────────────────────────────────────────────────
export default async function MovieDetailPage({ params, searchParams }: Props) {
  const { id } = await params;
  const { season: seasonParam, episode: episodeParam } = await searchParams;

  const movie = await fetchMovieById(id);
  if (!movie) return notFound();

  const isTv = movie.type === 'TV_SHOW';
  const year = movie.year || (movie.releaseDate ? movie.releaseDate.split('-')[0] : '');
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
  const pageUrl = `${siteUrl}/movies/${movie.id}`;

  // Fetch related content in same genre for deep SEO internal linking
  const primaryGenre = movie.genres?.[0] || '';
  let relatedMovies: any[] = [];
  try {
    if (primaryGenre) {
      const related = await fetchMovies({ genre: primaryGenre, limit: 7 });
      relatedMovies = related.filter((m: any) => m.id !== movie.id).slice(0, 6);
    }
  } catch {}

  // ── Enterprise Schema.org Graph (Movie/TVSeries + Breadcrumbs + FAQPage) ───
  const jsonLdGraph: any[] = [
    // 1. BreadcrumbList
    {
      '@type': 'BreadcrumbList',
      'itemListElement': [
        { '@type': 'ListItem', 'position': 1, 'name': 'Home', 'item': siteUrl },
        { '@type': 'ListItem', 'position': 2, 'name': isTv ? 'TV Series' : 'Movies', 'item': `${siteUrl}/?type=${movie.type}` },
        ...(primaryGenre ? [{ '@type': 'ListItem', 'position': 3, 'name': primaryGenre, 'item': `${siteUrl}/?genre=${encodeURIComponent(primaryGenre)}` }] : []),
        { '@type': 'ListItem', 'position': primaryGenre ? 4 : 3, 'name': movie.title, 'item': pageUrl },
      ],
    },
    // 2. Movie or TV Series Schema
    isTv ? {
      '@type': 'TVSeries',
      '@id': `${pageUrl}#tvseries`,
      'name': movie.title,
      'alternateName': movie.originalTitle || undefined,
      'headline': `${movie.title} Sinhala Subtitle Archive`,
      'description': movie.description || `Download ${movie.title} Sinhala subtitles (.srt) and Telegram direct files.`,
      'image': movie.posterPath || undefined,
      'datePublished': movie.releaseDate || undefined,
      'genre': movie.genres || [],
      'inLanguage': ['si', 'en'],
      'subtitleLanguage': 'si',
      'url': pageUrl,
      'numberOfSeasons': movie.totalSeasons || movie.seasons?.length || 1,
      'aggregateRating': movie.imdbRating ? {
        '@type': 'AggregateRating',
        'ratingValue': movie.imdbRating,
        'bestRating': 10,
        'ratingCount': 2500,
      } : undefined,
    } : {
      '@type': 'Movie',
      '@id': `${pageUrl}#movie`,
      'name': movie.title,
      'alternateName': movie.originalTitle || undefined,
      'headline': `${movie.title} Sinhala Subtitle (.SRT) & HD Telegram Download`,
      'description': movie.description || `Download ${movie.title} Sinhala subtitles (.srt) and Telegram direct files.`,
      'image': movie.posterPath || undefined,
      'datePublished': movie.releaseDate || undefined,
      'duration': movie.runtime ? `PT${movie.runtime}M` : undefined,
      'genre': movie.genres || [],
      'inLanguage': ['si', 'en'],
      'subtitleLanguage': 'si',
      'url': pageUrl,
      'aggregateRating': movie.imdbRating ? {
        '@type': 'AggregateRating',
        'ratingValue': movie.imdbRating,
        'bestRating': 10,
        'ratingCount': 3500,
      } : undefined,
      'potentialAction': {
        '@type': 'DownloadAction',
        'name': `Download ${movie.title} Sinhala Subtitle`,
        'target': pageUrl,
      },
    },
    // 3. FAQPage Schema for Rich Search Carousel Results
    {
      '@type': 'FAQPage',
      'mainEntity': [
        {
          '@type': 'Question',
          'name': `How do I download the Sinhala subtitle for ${movie.title}?`,
          'acceptedAnswer': {
            '@type': 'Answer',
            'text': `Click the green 'Download Subtitle' button on the ${movie.title} page on PixelSubzLk. Complete the brief sponsor dwell verification, and the UTF-8 .srt or .zip subtitle file will instantly download to your device.`,
          },
        },
        {
          '@type': 'Question',
          'name': `How can I add ${movie.title} Sinhala subtitle in VLC or MX Player?`,
          'acceptedAnswer': {
            '@type': 'Answer',
            'text': `On VLC or MX Player, open the video file, click the Subtitles menu, select 'Add Subtitle File', and choose the downloaded .srt file. Ensure font encoding is set to UTF-8 for clear Sinhala font rendering.`,
          },
        },
        {
          '@type': 'Question',
          'name': `Which video releases are compatible with this ${movie.title} subtitle?`,
          'acceptedAnswer': {
            '@type': 'Answer',
            'text': `This subtitle is synchronized with 1080p, 720p, 480p WEB-DL, WEBRip, BluRay, and HDTV rips with x264 & x265 HEVC 10-bit encoding.`,
          },
        },
      ],
    },
  ];

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            '@context': 'https://schema.org',
            '@graph': jsonLdGraph,
          }),
        }}
      />

      {/* Top Banner Ad Slot for High-CPM Monetization */}
      <div className="max-w-[1700px] mx-auto px-4 sm:px-6 lg:px-10">
        
      </div>

      {/* Hero Backdrop */}
      <div className="relative min-h-[52vh] flex flex-col justify-end overflow-hidden">
        {movie.backdropPath && (
          <>
            <div className="absolute inset-0">
              <img src={movie.backdropPath} alt="" className="w-full h-full object-cover object-top" />
            </div>
            <div className="absolute inset-0" style={{ background: 'linear-gradient(to bottom, rgba(20,20,20,0.3) 0%, rgba(20,20,20,0.85) 70%, var(--color-bg) 100%)' }} />
          </>
        )}

        {/* Back button */}
        <div className="relative z-10 pt-6 px-4 sm:px-6 lg:px-10">
          <Link href="/" className="inline-flex items-center gap-1.5 text-xs font-bold text-white/70 hover:text-white transition-colors group">
            <ArrowLeft className="h-4 w-4 group-hover:-translate-x-0.5 transition-transform" />
            Back to Home
          </Link>
        </div>

        {/* Hero content */}
        <div className="relative z-10 px-4 sm:px-6 lg:px-10 pb-8 pt-4 flex flex-col sm:flex-row gap-6 items-end">
          {/* Poster */}
          {movie.posterPath && (
            <div className="shrink-0 w-32 sm:w-44 lg:w-52 rounded-2xl overflow-hidden shadow-2xl ring-2 ring-white/10">
              <img src={movie.posterPath} alt={`${movie.title} Sinhala Subtitle`} className="w-full object-cover" />
            </div>
          )}

          {/* Meta */}
          <div className="flex-1 space-y-3 pb-1">
            {/* Badges */}
            <div className="flex flex-wrap gap-2 items-center">
              <span className="px-2.5 py-0.5 rounded-md text-[10px] font-black uppercase tracking-wider text-white"
                style={{ background: isTv ? '#6d28d9' : '#E50914' }}>
                {isTv ? '📺 TV Series' : '🎬 Feature Film'}
              </span>
              <span className="px-2.5 py-0.5 rounded-md text-[10px] font-bold text-emerald-400 bg-emerald-500/10 border border-emerald-500/20">
                🇱🇰 Sinhala Subtitle (.SRT)
              </span>
              {movie.status && (
                <span className="px-2.5 py-0.5 rounded-md text-[10px] font-bold uppercase text-white/80"
                  style={{ background: 'rgba(255,255,255,0.12)' }}>
                  {movie.status}
                </span>
              )}
              {movie.imdbRating && (
                <span className="flex items-center gap-1 px-2.5 py-0.5 rounded-md text-[11px] font-black text-amber-400 bg-amber-500/10 border border-amber-500/20">
                  <Star className="h-3 w-3 fill-amber-400" />
                  {movie.imdbRating.toFixed(1)} IMDb
                </span>
              )}
            </div>

            <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white leading-tight">
              {movie.title}
              {year && <span className="text-white/50 font-light ml-2 text-xl">({year})</span>}
            </h1>

            {movie.originalTitle && movie.originalTitle !== movie.title && (
              <p className="text-xs text-white/50 italic">{movie.originalTitle}</p>
            )}

            {/* Quick info row */}
            <div className="flex flex-wrap gap-x-4 gap-y-1.5 text-xs text-white/60">
              {movie.runtime && (
                <span className="flex items-center gap-1"><Clock className="h-3.5 w-3.5" />{movie.runtime} min</span>
              )}
              {movie.releaseDate && (
                <span className="flex items-center gap-1"><Calendar className="h-3.5 w-3.5" />{movie.releaseDate}</span>
              )}
              {movie.country && (
                <span className="flex items-center gap-1"><Globe className="h-3.5 w-3.5" />{movie.country}</span>
              )}
              {isTv && movie.totalSeasons && (
                <span className="flex items-center gap-1"><Tv className="h-3.5 w-3.5" />{movie.totalSeasons} Seasons</span>
              )}
              {(movie as any).imdbId && (
                <a href={`https://www.imdb.com/title/${(movie as any).imdbId}`} target="_blank" rel="noreferrer"
                  className="flex items-center gap-1 hover:text-amber-400 transition-colors">
                  <ExternalLink className="h-3 w-3" />IMDb Page
                </a>
              )}
            </div>

            {/* Genres */}
            {movie.genres?.length > 0 && (
              <div className="flex flex-wrap gap-1.5">
                {movie.genres.map((g: string) => (
                  <Link key={g} href={`/?genre=${encodeURIComponent(g)}`}
                    className="px-2.5 py-0.5 rounded-full text-[11px] font-semibold text-white/80 hover:text-white hover:bg-white/20 transition-colors"
                    style={{ background: 'rgba(255,255,255,0.1)' }}>
                    {g}
                  </Link>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Main content */}
      <main className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-10 py-8 space-y-10">

        {/* Description / Storyline */}
        {movie.description && (
          <section className="space-y-3">
            <h2 className="text-sm font-black uppercase tracking-widest flex items-center gap-2" style={{ color: 'var(--color-text-muted)' }}>
              <span>Storyline &amp; Synopsis</span>
            </h2>
            <p className="text-sm sm:text-base leading-relaxed" style={{ color: 'var(--color-text)', opacity: 0.9 }}>
              {movie.description}
            </p>
          </section>
        )}

        {/* ── Subtitle Details & Compatibility Grid ─────────────────────── */}
        <section
          aria-label="Subtitle Compatibility"
          className="rounded-2xl p-5 sm:p-6 space-y-4"
          style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
        >
          <h3 className="text-sm font-black uppercase tracking-wider flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
            <Layers className="h-4 w-4 text-[#E50914]" />
            <span>Sinhala Subtitle Compatibility &amp; File Specifications</span>
          </h3>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-xs">
            <div className="p-3 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Subtitle Format</span>
              <span className="font-bold text-white mt-0.5 block">UTF-8 (.SRT)</span>
            </div>
            <div className="p-3 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Language</span>
              <span className="font-bold text-emerald-400 mt-0.5 block">සිංහල (Sinhala)</span>
            </div>
            <div className="p-3 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Compatible Rips</span>
              <span className="font-bold text-white mt-0.5 block">WEB-DL / BluRay / HDTV</span>
            </div>
            <div className="p-3 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Video Codecs</span>
              <span className="font-bold text-sky-400 mt-0.5 block">x264 / x265 HEVC 10bit</span>
            </div>
          </div>
        </section>

        {/* ── MOVIE: Subtitles & Telegram Download Section ──────────────── */}
        {!isTv && (
          <MovieDownloadSection
            subtitles={movie.subtitles || []}
            telegramLinks={movie.telegramLinks || []}
            movieTitle={movie.title}
          />
        )}

        {/* ── TV SHOW: Season / Episode Browser ────────────────────────── */}
        {isTv && movie.seasons?.length > 0 && (
          <section className="space-y-4">
            <div className="flex items-center justify-between">
              <h2 className="text-base font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                <Tv className="h-5 w-5 text-[#E50914]" />
                All Seasons &amp; Episode Subtitles
              </h2>
            </div>
            <EpisodeViewer
              seasons={movie.seasons}
              initialSeason={seasonParam ? parseInt(seasonParam) : 1}
              initialEpisode={episodeParam ? parseInt(episodeParam) : null}
              movieId={movie.id}
              movieTitle={movie.title}
            />
          </section>
        )}

        {/* Native Sponsor Widget */}
        

        {/* ── SEO FAQ & HOW-TO GUIDE SECTION ──────────────────────────── */}
        <section
          aria-labelledby="faq-heading"
          className="rounded-3xl p-6 sm:p-8 space-y-6"
          style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
        >
          <div className="space-y-1">
            <h3 id="faq-heading" className="text-base sm:text-lg font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
              <HelpCircle className="h-5 w-5 text-amber-400" />
              <span>Frequently Asked Questions &amp; How-To Guide</span>
            </h3>
            <p className="text-xs text-neutral-400">
              Complete step-by-step instructions for adding Sinhala subtitles to {movie.title} on Mobile, PC, and Smart TVs.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs sm:text-sm">
            <div className="p-4 rounded-2xl bg-neutral-900/40 border border-neutral-800 space-y-2">
              <h4 className="font-bold text-white flex items-center gap-2">
                <CheckCircle className="h-4 w-4 text-emerald-400 shrink-0" />
                VLC / MX Player (Android &amp; iOS)
              </h4>
              <p className="text-neutral-400 leading-relaxed text-xs">
                1. Download the .srt file above.<br />
                2. Open the video in VLC or MX Player.<br />
                3. Tap the Subtitle icon → <b>Select Subtitle file</b> → choose the downloaded .srt file.
              </p>
            </div>

            <div className="p-4 rounded-2xl bg-neutral-900/40 border border-neutral-800 space-y-2">
              <h4 className="font-bold text-white flex items-center gap-2">
                <CheckCircle className="h-4 w-4 text-emerald-400 shrink-0" />
                Windows &amp; Mac (KMPlayer / PotPlayer)
              </h4>
              <p className="text-neutral-400 leading-relaxed text-xs">
                Drag and drop the .srt file directly into your video player, or ensure the subtitle and video file have the exact same file name in the same folder.
              </p>
            </div>
          </div>
        </section>

        {/* ── RELATED MOVIES / SERIES (Deep Interlinking Hub) ─────────── */}
        {relatedMovies.length > 0 && (
          <section className="space-y-4 pt-4">
            <div className="flex items-center justify-between">
              <h3 className="text-base font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                <Sparkles className="h-4 w-4 text-[#E50914]" />
                <span>More {primaryGenre} Sinhala Subtitles</span>
              </h3>
              <Link href={`/?genre=${encodeURIComponent(primaryGenre)}`} className="text-xs text-[#E50914] font-bold hover:underline">
                View all {primaryGenre} →
              </Link>
            </div>

            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-3 sm:gap-4">
              {relatedMovies.map((rel) => (
                <MovieCard key={rel.id} movie={rel} />
              ))}
            </div>
          </section>
        )}

        {/* ── Auto-Generated & Custom SEO Search Tags ── */}
        {(() => {
          const title = movie.title || '';
          const yr = movie.year || (movie.releaseDate ? movie.releaseDate.split('-')[0] : '');

          // Competitor brand tags — hidden from UI, kept in DOM for SEO crawlers only
          const hiddenKeywords = [
            `${title} baiscope sinhala sub`,
            `${title} cineru sinhala sub`,
            `${title} sinhala sub torrent`,
            `${title} sinhala sub torrent download`,
          ];

          // Visible public tags
          const visibleKeywords = [
            `${title} sinhala sub`,
            `${title} sinhala subtitle`,
            `${title} sinhala subtitles`,
            `${title} sinhala sub download`,
            `${title} telegram link`,
            `${title} telegram movie`,
            `${title} සිංහල උපසිරැසි`,
            `${title} සිංහල සබ්`,
            `${title} සිංහල සබ් ඩවුන්ලෝඩ්`,
            ...(yr ? [`${title} ${yr} sinhala sub`, `${title} ${yr} telegram link`] : []),
            ...(movie.genres || []).map((g: string) => `${title} ${g} sinhala sub`),
            ...(movie.seoTags || []),
          ];

          const uniqueVisible = Array.from(new Set(visibleKeywords.map((t: string) => t.trim()).filter(Boolean)));
          const uniqueHidden = Array.from(new Set(hiddenKeywords.map((t: string) => t.trim()).filter(Boolean)));

          return (
            <section
              aria-label="Search Tags & Keywords"
              className="rounded-2xl p-4 sm:p-5 border space-y-3"
              style={{ background: 'var(--color-bg-card)', borderColor: 'var(--color-border)' }}
            >
              <div className="flex items-center gap-2 text-xs font-black uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>
                <Tag className="h-3.5 w-3.5 text-[#E50914]" />
                <span>Search Keywords &amp; Tags</span>
              </div>

              {/* Visible Tags */}
              <div className="flex flex-wrap gap-1.5">
                {uniqueVisible.map((tag, idx) => (
                  <Link
                    key={idx}
                    href={`/?search=${encodeURIComponent(tag)}`}
                    className="px-2.5 py-1 rounded-lg text-[11px] font-medium transition-all hover:border-[#E50914] hover:text-[#E50914]"
                    style={{
                      background: 'var(--color-bg-elevated)',
                      border: '1px solid var(--color-border)',
                      color: 'var(--color-text-muted)',
                    }}
                  >
                    #{tag}
                  </Link>
                ))}
              </div>

              {/* Hidden SEO-only keywords — invisible to users, indexed by Google */}
              <div aria-hidden="true" style={{ position: 'absolute', width: 1, height: 1, overflow: 'hidden', opacity: 0, pointerEvents: 'none' }}>
                {uniqueHidden.map((tag, idx) => (
                  <span key={idx}>{tag}</span>
                ))}
              </div>
            </section>
          );
        })()}

        {/* Breadcrumb Navigation Bar */}
        <nav aria-label="breadcrumb" className="text-[11px] text-neutral-500 flex gap-1.5 items-center pt-2 flex-wrap">
          <Link href="/" className="hover:text-[#E50914] transition-colors">Home</Link>
          <ChevronDown className="h-3 w-3 -rotate-90" />
          <Link href={`/?type=${movie.type}`} className="hover:text-[#E50914] transition-colors">{isTv ? 'TV Series' : 'Movies'}</Link>
          {primaryGenre && (
            <>
              <ChevronDown className="h-3 w-3 -rotate-90" />
              <Link href={`/?genre=${encodeURIComponent(primaryGenre)}`} className="hover:text-[#E50914] transition-colors">{primaryGenre}</Link>
            </>
          )}
          <ChevronDown className="h-3 w-3 -rotate-90" />
          <span className="text-neutral-400">{movie.title}</span>
        </nav>

        {/* Footer Banner Ad (Unit 2: 160x300) */}
        <AdBanner unit="160x300" />

      </main>
    </>
  );
}
