import { notFound } from 'next/navigation';
import type { Metadata } from 'next';
import Link from 'next/link';
import { ArrowLeft, Star, Clock, Calendar, Tv, ChevronRight, ChevronLeft, Hash, Layers, HelpCircle, CheckCircle, Tag } from 'lucide-react';
import EpisodeDownloadSection from './EpisodeDownloadSection';
import AdBanner from '@/components/AdBanner';
import { fetchMovieById } from '@/lib/data';

export const dynamic = 'force-dynamic';

interface Props {
  params: Promise<{ id: string; season: string; episode: string }>;
}

// ── High-CTR Episode Metadata Generator ─────────────────────────────────────
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id, season, episode } = await params;
  const sNum = parseInt(season) || 1;
  const eNum = parseInt(episode) || 1;

  const movie = await fetchMovieById(id);
  if (!movie) return { title: 'Episode Not Found | PixelSubzLk' };

  const seasonData = movie.seasons?.find((s: any) => s.seasonNumber === sNum);
  const epData = seasonData?.episodes?.find((e: any) => e.episodeNumber === eNum);
  const epCode = `S${String(sNum).padStart(2, '0')}E${String(eNum).padStart(2, '0')}`;
  const epName = epData?.title ? `${epCode}: ${epData.title}` : epCode;

  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
  const pageUrl = `${siteUrl}/movies/${id}/season/${sNum}/episode/${eNum}`;

  const titleText = `🎬 ${movie.title} ${epCode} Sinhala Subtitle (.SRT) & HD Telegram Download | PixelSubzLk`;
  const descText = `Download ${movie.title} Season ${sNum} Episode ${eNum} (${epData?.title || epCode}) Sinhala Subtitles (.srt) UTF-8. 100% Synced for 1080p, 720p HDTV & WEB-DL & Direct Telegram Video on PixelSubzLk. ${epData?.description ? epData.description.substring(0, 100) + '...' : ''}`;

  const keywords = [
    `${movie.title} ${epCode} sinhala subtitle`,
    `${movie.title} ${epCode} sinhala sub`,
    `${movie.title} season ${sNum} episode ${eNum} sinhala subtitle`,
    `${movie.title} ${epCode} telegram link`,
    `${movie.title} ${epCode} baiscope sinhala sub`,
    `${movie.title} ${epCode} cineru sinhala sub`,
    `${movie.title} ${epCode} සිංහල උපසිරැසි`,
    `${movie.title} ${epCode} සිංහල සබ්`,
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
      title: `${movie.title} ${epCode} Sinhala Subtitle | PixelSubzLk`,
      description: descText,
      url: pageUrl,
      siteName: 'PixelSubzLk',
      images: (epData?.stillPath || movie.posterPath) ? [{ url: epData?.stillPath || movie.posterPath, width: 500, height: 750, alt: `${movie.title} ${epCode} Subtitle` }] : [],
      type: 'video.episode',
      locale: 'si_LK',
    },
    twitter: {
      card: 'summary_large_image',
      title: `${movie.title} ${epCode} Sinhala Sub (.srt) | PixelSubzLk`,
      description: descText,
      images: (epData?.stillPath || movie.posterPath) ? [epData?.stillPath || movie.posterPath] : [],
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

// ── Episode Page Component ───────────────────────────────────────────────────
export default async function EpisodePage({ params }: Props) {
  const { id, season, episode } = await params;
  const sNum = parseInt(season) || 1;
  const eNum = parseInt(episode) || 1;

  const dbMovie = await fetchMovieById(id);
  if (!dbMovie) return notFound();

  const seasonData = dbMovie.seasons?.find((s: any) => s.seasonNumber === sNum);
  if (!seasonData) return notFound();

  const allEpisodes = seasonData.episodes || [];
  const epData = allEpisodes.find((e: any) => e.episodeNumber === eNum);
  if (!epData) return notFound();

  const epCode = `S${String(sNum).padStart(2, '0')}E${String(eNum).padStart(2, '0')}`;
  const prevEp = allEpisodes.find((e: any) => e.episodeNumber === eNum - 1);
  const nextEp = allEpisodes.find((e: any) => e.episodeNumber === eNum + 1);
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
  const pageUrl = `${siteUrl}/movies/${id}/season/${sNum}/episode/${eNum}`;

  // ── Enterprise Schema Graph for Episode ───────────────────────────────────
  const jsonLdGraph: any[] = [
    {
      '@type': 'BreadcrumbList',
      'itemListElement': [
        { '@type': 'ListItem', 'position': 1, 'name': 'Home', 'item': siteUrl },
        { '@type': 'ListItem', 'position': 2, 'name': 'TV Series', 'item': `${siteUrl}/?type=TV_SHOW` },
        { '@type': 'ListItem', 'position': 3, 'name': dbMovie.title, 'item': `${siteUrl}/movies/${id}` },
        { '@type': 'ListItem', 'position': 4, 'name': seasonData?.title || `Season ${sNum}`, 'item': `${siteUrl}/movies/${id}?season=${sNum}` },
        { '@type': 'ListItem', 'position': 5, 'name': epCode, 'item': pageUrl },
      ],
    },
    {
      '@type': 'TVEpisode',
      '@id': `${pageUrl}#episode`,
      'name': epData.title ? `${epCode}: ${epData.title}` : epCode,
      'episodeNumber': eNum,
      'partOfSeason': {
        '@type': 'TVSeason',
        'seasonNumber': sNum,
        'name': seasonData?.title || `Season ${sNum}`,
      },
      'partOfTVSeries': {
        '@type': 'TVSeries',
        'name': dbMovie.title,
        'url': `${siteUrl}/movies/${id}`,
      },
      'description': epData.description || `Download ${dbMovie.title} ${epCode} Sinhala Subtitles.`,
      'datePublished': epData.airDate || undefined,
      'url': pageUrl,
      'image': epData.stillPath || dbMovie.posterPath || undefined,
      'inLanguage': ['si', 'en'],
      'subtitleLanguage': 'si',
      'aggregateRating': epData.imdbRating
        ? { '@type': 'AggregateRating', 'ratingValue': epData.imdbRating, 'bestRating': 10, 'ratingCount': 1000 }
        : undefined,
    },
    {
      '@type': 'FAQPage',
      'mainEntity': [
        {
          '@type': 'Question',
          'name': `How to download ${dbMovie.title} ${epCode} Sinhala Subtitle?`,
          'acceptedAnswer': {
            '@type': 'Answer',
            'text': `Click the 'Download Subtitle' button on this page. Complete the brief 5-second sponsor verification, and the UTF-8 .srt file for ${epCode} will download instantly.`,
          },
        },
        {
          '@type': 'Question',
          'name': `Is this subtitle synced with 1080p and 720p HDTV/WEB-DL releases?`,
          'acceptedAnswer': {
            '@type': 'Answer',
            'text': `Yes, all Sinhala subtitles on PixelSubzLk are fully synchronized with standard 1080p and 720p WEB-DL, HDTV, and x265 HEVC releases.`,
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

      {/* Top Banner Ad */}
      <div className="max-w-[1700px] mx-auto px-4 sm:px-6 lg:px-10">
        <AdBanner unit="300x250" />
      </div>

      {/* Backdrop */}
      <div className="relative min-h-[38vh] flex flex-col justify-end overflow-hidden">
        {(epData.stillPath || dbMovie.backdropPath) && (
          <>
            <div className="absolute inset-0">
              <img src={epData.stillPath || dbMovie.backdropPath} alt="" className="w-full h-full object-cover object-center" />
            </div>
            <div className="absolute inset-0" style={{ background: 'linear-gradient(to bottom, rgba(20,20,20,0.2) 0%, rgba(20,20,20,0.9) 75%, var(--color-bg) 100%)' }} />
          </>
        )}

        <div className="relative z-10 px-4 sm:px-6 lg:px-10 pb-6 pt-4 space-y-3">
          {/* Breadcrumb nav */}
          <nav className="flex items-center gap-1.5 text-xs text-white/60 flex-wrap">
            <Link href="/" className="hover:text-white transition-colors">Home</Link>
            <ChevronRight className="h-3 w-3" />
            <Link href={`/movies/${id}`} className="hover:text-white transition-colors">{dbMovie.title}</Link>
            <ChevronRight className="h-3 w-3" />
            <Link href={`/movies/${id}?season=${sNum}`} className="hover:text-white transition-colors">{seasonData?.title || `Season ${sNum}`}</Link>
            <ChevronRight className="h-3 w-3" />
            <span className="text-white font-bold">{epCode}</span>
          </nav>

          {/* Episode badge + title */}
          <div className="space-y-2">
            <div className="flex flex-wrap items-center gap-2">
              <span className="px-2.5 py-0.5 rounded-md text-[10px] font-black uppercase tracking-wider text-white bg-[#E50914]">
                {epCode}
              </span>
              <span className="px-2.5 py-0.5 rounded-md text-[10px] font-bold text-emerald-400 bg-emerald-500/10 border border-emerald-500/20">
                🇱🇰 Sinhala Subtitle (.SRT)
              </span>
              {epData.imdbRating && (
                <span className="flex items-center gap-1 px-2.5 py-0.5 rounded-md text-[11px] font-black text-amber-400 bg-amber-500/10 border border-amber-500/20">
                  <Star className="h-3 w-3 fill-amber-400" />{epData.imdbRating} IMDb
                </span>
              )}
            </div>

            <h1 className="text-xl sm:text-2xl lg:text-3xl font-black text-white leading-tight">
              {epData.title ? `${epCode} – ${epData.title}` : `${dbMovie.title} ${epCode}`}
            </h1>

            <div className="flex flex-wrap gap-x-4 gap-y-1 text-xs text-white/60">
              <span className="flex items-center gap-1"><Tv className="h-3.5 w-3.5" />{dbMovie.title}</span>
              {epData.runtime && <span className="flex items-center gap-1"><Clock className="h-3.5 w-3.5" />{epData.runtime} min</span>}
              {epData.airDate && <span className="flex items-center gap-1"><Calendar className="h-3.5 w-3.5" />{epData.airDate}</span>}
            </div>
          </div>
        </div>
      </div>

      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-10 py-8 space-y-10">

        {/* Description */}
        {epData.description && (
          <section className="space-y-2">
            <h2 className="text-xs font-black uppercase tracking-widest" style={{ color: 'var(--color-text-muted)' }}>Episode Synopsis</h2>
            <p className="text-sm sm:text-base leading-relaxed" style={{ color: 'var(--color-text)', opacity: 0.85 }}>{epData.description}</p>
          </section>
        )}

        {/* In-Content High-CPM Ad */}
        

        {/* ── Subtitle Details & Compatibility Grid ── */}
        <section
          aria-label="Subtitle Specs"
          className="rounded-2xl p-5 space-y-3"
          style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
        >
          <h3 className="text-xs font-black uppercase tracking-wider flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
            <Layers className="h-3.5 w-3.5 text-[#E50914]" />
            <span>Episode Subtitle Format &amp; Quality Synchronization</span>
          </h3>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5 text-xs">
            <div className="p-2.5 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Format</span>
              <span className="font-bold text-white mt-0.5 block">UTF-8 (.SRT)</span>
            </div>
            <div className="p-2.5 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Language</span>
              <span className="font-bold text-emerald-400 mt-0.5 block">සිංහල (Sinhala)</span>
            </div>
            <div className="p-2.5 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Quality</span>
              <span className="font-bold text-white mt-0.5 block">1080p / 720p / 480p</span>
            </div>
            <div className="p-2.5 rounded-xl bg-neutral-900/60 border border-neutral-800">
              <span className="text-[10px] text-neutral-500 font-bold uppercase block">Source</span>
              <span className="font-bold text-sky-400 mt-0.5 block">WEB-DL / HDTV / HEVC</span>
            </div>
          </div>
        </section>

        {/* ── Subtitle & Telegram Direct Downloads ── */}
        <EpisodeDownloadSection
          subtitles={epData.subtitles || []}
          telegramLinks={epData.telegramLinks || []}
          movieTitle={dbMovie.title}
          epCode={epCode}
        />

        {/* Prev / Next Episode Navigation */}
        <section>
          <div className="grid grid-cols-2 gap-3">
            {prevEp ? (
              <Link
                href={`/movies/${id}/season/${sNum}/episode/${prevEp.episodeNumber}`}
                className="group flex items-center gap-3 p-4 rounded-2xl transition-all hover:scale-[1.01]"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
              >
                <ChevronLeft className="h-5 w-5 shrink-0 text-neutral-400 group-hover:text-white transition-colors" />
                <div className="min-w-0">
                  <p className="text-[10px] font-bold text-neutral-500 uppercase tracking-wider">Previous</p>
                  <p className="text-xs font-bold truncate mt-0.5" style={{ color: 'var(--color-text)' }}>
                    E{prevEp.episodeNumber}: {prevEp.title || `Episode ${prevEp.episodeNumber}`}
                  </p>
                </div>
              </Link>
            ) : <div />}

            {nextEp ? (
              <Link
                href={`/movies/${id}/season/${sNum}/episode/${nextEp.episodeNumber}`}
                className="group flex items-center justify-end gap-3 p-4 rounded-2xl transition-all hover:scale-[1.01] text-right"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
              >
                <div className="min-w-0">
                  <p className="text-[10px] font-bold text-neutral-500 uppercase tracking-wider">Next Episode</p>
                  <p className="text-xs font-bold truncate mt-0.5" style={{ color: 'var(--color-text)' }}>
                    E{nextEp.episodeNumber}: {nextEp.title || `Episode ${nextEp.episodeNumber}`}
                  </p>
                </div>
                <ChevronRight className="h-5 w-5 shrink-0 text-neutral-400 group-hover:text-[#E50914] transition-colors" />
              </Link>
            ) : <div />}
          </div>
        </section>

        {/* All episodes mini list */}
        <section className="space-y-3">
          <h2 className="text-xs font-black uppercase tracking-widest flex items-center gap-2" style={{ color: 'var(--color-text-muted)' }}>
            <Hash className="h-3.5 w-3.5" />
            All Episodes — {seasonData?.title || `Season ${sNum}`}
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-2">
            {allEpisodes.map((ep: any) => {
              const isActive = ep.episodeNumber === eNum;
              const hasSub = ep.subtitles?.length > 0;
              return (
                <Link
                  key={ep.episodeNumber}
                  href={`/movies/${id}/season/${sNum}/episode/${ep.episodeNumber}`}
                  className="flex items-center gap-2 p-2.5 rounded-xl text-xs font-bold transition-all hover:scale-[1.02]"
                  style={{
                    background: isActive ? '#E50914' : 'var(--color-bg-card)',
                    border: isActive ? 'none' : '1px solid var(--color-border)',
                    color: isActive ? '#ffffff' : 'var(--color-text)',
                  }}
                >
                  <span className={`shrink-0 w-7 h-7 rounded-lg flex items-center justify-center text-[10px] font-black ${isActive ? 'bg-white/20' : 'bg-neutral-800'}`}>
                    {ep.episodeNumber}
                  </span>
                  <span className="truncate">{ep.title ? ep.title.split(':').pop()?.trim() || ep.title : `Ep ${ep.episodeNumber}`}</span>
                  {hasSub && !isActive && (
                    <span className="ml-auto shrink-0 w-2 h-2 rounded-full bg-[#E50914]" title="Subtitle available" />
                  )}
                </Link>
              );
            })}
          </div>
        </section>

        {/* ── Auto-Generated & Custom SEO Search Tags ── */}
        {(() => {
          const title = dbMovie.title || '';

          // Competitor brand tags — hidden from UI, kept in DOM for SEO crawlers only
          const hiddenKeywords = [
            `${title} ${epCode} baiscope sinhala sub`,
            `${title} ${epCode} cineru sinhala sub`,
            `${title} ${epCode} sinhala sub torrent`,
            `${title} Season ${sNum} Episode ${eNum} baiscope sinhala sub`,
            `${title} Season ${sNum} Episode ${eNum} cineru sinhala sub`,
          ];

          // Visible public tags
          const visibleKeywords = [
            `${title} ${epCode} sinhala sub`,
            `${title} ${epCode} sinhala subtitle`,
            `${title} ${epCode} sinhala subtitles`,
            `${title} ${epCode} sinhala sub download`,
            `${title} Season ${sNum} Episode ${eNum} sinhala sub`,
            `${title} ${epCode} telegram link`,
            `${title} ${epCode} සිංහල උපසිරැසි`,
            `${title} ${epCode} සිංහල සබ්`,
            ...(dbMovie.genres || []).map((g: string) => `${title} ${g} sinhala sub`),
            ...(dbMovie.seoTags || []),
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

        {/* Back link */}
        <Link
          href={`/movies/${id}?season=${sNum}`}
          className="inline-flex items-center gap-2 text-xs font-bold text-neutral-400 hover:text-white transition-colors group"
        >
          <ArrowLeft className="h-4 w-4 group-hover:-translate-x-0.5 transition-transform" />
          Back to {dbMovie.title} – {seasonData?.title || `Season ${sNum}`}
        </Link>

        {/* Footer Banner Ad (Unit 2: 160x300) */}
        <AdBanner unit="160x300" />

      </main>
    </>
  );
}
