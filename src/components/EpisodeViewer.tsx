'use client';

import { useState } from 'react';
import { Download, Send, Star, Clock, Calendar, Play, ChevronRight, Film, Layers, CheckCircle2, Zap, Loader2 } from 'lucide-react';
import Link from 'next/link';
import { openSponsorAd, downloadSubtitleDirectly } from '@/lib/adManager';
import AdBanner from '@/components/AdBanner';

interface Subtitle {
  id: string;
  language: string;
  fileName: string;
  fileUrl: string;
  version?: string | null;
  downloadsCount: number;
}

interface TelegramLink {
  id: string;
  quality: string;
  size?: string | null;
  downloadUrl: string;
  label?: string | null;
  clicksCount: number;
}

interface Episode {
  id: string;
  episodeNumber: number;
  title?: string | null;
  description?: string | null;
  airDate?: string | null;
  runtime?: number | null;
  imdbRating?: number | null;
  stillPath?: string | null;
  subtitles: Subtitle[];
  telegramLinks: TelegramLink[];
}

interface Season {
  id: string;
  seasonNumber: number;
  title?: string | null;
  releaseDate?: string | null;
  episodeCount?: number | null;
  posterPath?: string | null;
  episodes: Episode[];
}

interface Props {
  seasons: Season[];
  initialSeason?: number;
  initialEpisode?: number | null;
  movieId: string;
  movieTitle: string;
}

export default function EpisodeViewer({
  seasons,
  initialSeason = 1,
  initialEpisode,
  movieId,
  movieTitle,
}: Props) {
  const [activeSeason, setActiveSeason] = useState(initialSeason);
  const [activeEpisodeId, setActiveEpisodeId] = useState<string | null>(null);

  const [unlockedSubs, setUnlockedSubs] = useState<Record<string, boolean>>({});
  const [unlockedTg, setUnlockedTg] = useState<Record<string, boolean>>({});

  const [downloadingSubs, setDownloadingSubs] = useState<Record<string, 'loading' | 'done' | undefined>>({});
  const [downloadingTg, setDownloadingTg] = useState<Record<string, boolean>>({});

  const currentSeason =
    seasons.find((s) => s.seasonNumber === activeSeason) || seasons[0];
  const episodes = currentSeason?.episodes || [];

  const activeEpisode = activeEpisodeId
    ? episodes.find((e) => e.id === activeEpisodeId)
    : initialEpisode
    ? episodes.find((e) => e.episodeNumber === initialEpisode)
    : episodes[0] || null;

  const epCode = (ep: Episode) =>
    `S${String(currentSeason?.seasonNumber || 1).padStart(2, '0')}E${String(
      ep.episodeNumber
    ).padStart(2, '0')}`;

  const handleEpisodeSelect = (epId: string) => {
    openSponsorAd();
    setActiveEpisodeId(epId);
  };

  const handleSubtitleClick = async (sub: Subtitle, ep: Episode) => {
    if (!unlockedSubs[sub.id]) {
      openSponsorAd();
      setUnlockedSubs(prev => ({ ...prev, [sub.id]: true }));
    } else {
      setDownloadingSubs(prev => ({ ...prev, [sub.id]: 'loading' }));
      try {
        await downloadSubtitleDirectly(sub.fileUrl, sub.fileName || `${movieTitle} ${epCode(ep)}.srt`, sub.id);
        setDownloadingSubs(prev => ({ ...prev, [sub.id]: 'done' }));
      } catch (err) {
        setDownloadingSubs(prev => ({ ...prev, [sub.id]: undefined }));
      } finally {
        setTimeout(() => {
          setDownloadingSubs(prev => ({ ...prev, [sub.id]: undefined }));
        }, 4000);
      }
    }
  };

  const handleTelegramClick = (link: TelegramLink) => {
    if (!unlockedTg[link.id]) {
      openSponsorAd();
      setUnlockedTg(prev => ({ ...prev, [link.id]: true }));
    } else {
      setDownloadingTg(prev => ({ ...prev, [link.id]: true }));
      if (link.id) {
        fetch(`/api/telegram-links/${link.id}/click`, { method: 'POST' }).catch(() => {});
      }
      setTimeout(() => {
        window.open(link.downloadUrl, '_blank', 'noopener,noreferrer');
        setDownloadingTg(prev => ({ ...prev, [link.id]: false }));
      }, 1000);
    }
  };

  const totalSubs = episodes.reduce((a, e) => a + (e.subtitles?.length || 0), 0);
  const totalTg = episodes.reduce((a, e) => a + (e.telegramLinks?.length || 0), 0);

  return (
    <div className="space-y-6">
      {/* ── Season Selector Tabs ── */}
      <div className="flex flex-wrap gap-2.5 p-2 rounded-2xl bg-neutral-900/40 border border-white/5">
        {seasons.map((s) => {
          const isActive = activeSeason === s.seasonNumber;
          const epCount = s.episodes?.length || s.episodeCount || 0;
          return (
            <button
              key={s.id}
              onClick={() => {
                openSponsorAd();
                setActiveSeason(s.seasonNumber);
                setActiveEpisodeId(null);
              }}
              className={`relative flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-black uppercase tracking-wider transition-all duration-300 cursor-pointer ${
                isActive
                  ? 'bg-gradient-to-r from-[#E50914] to-red-700 text-white shadow-lg shadow-red-900/30 scale-[1.02]'
                  : 'bg-white/5 hover:bg-white/10 text-neutral-300 border border-white/5'
              }`}
            >
              <span>{s.title || `Season ${s.seasonNumber}`}</span>
              <span className={`text-[10px] px-1.5 py-0.5 rounded-md font-bold ${
                isActive ? 'bg-black/30 text-white' : 'bg-black/20 text-neutral-400'
              }`}>
                {epCount} Ep{epCount !== 1 ? 's' : ''}
              </span>
            </button>
          );
        })}
      </div>

      {/* ── Season Info Banner ── */}
      <div
        className="flex flex-wrap items-center justify-between gap-3 px-5 py-3.5 rounded-2xl text-xs border"
        style={{
          background: 'var(--color-bg-card)',
          borderColor: 'var(--color-border)',
        }}
      >
        <div className="flex items-center gap-3">
          <span className="font-black text-sm" style={{ color: 'var(--color-text)' }}>
            {currentSeason?.title || `Season ${activeSeason}`}
          </span>
          <span className="w-1 h-1 rounded-full bg-neutral-600" />
          <span className="text-neutral-400 font-medium">
            {episodes.length} Episodes
          </span>
        </div>

        <div className="flex items-center gap-3 font-bold text-[11px]">
          <span className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
            <Download className="h-3 w-3" />
            {totalSubs} Subtitles
          </span>
          <span className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-sky-500/10 text-sky-400 border border-sky-500/20">
            <Send className="h-3 w-3" />
            {totalTg} Telegram Rips
          </span>
        </div>
      </div>

      {/* ── Main Layout: Episode List + Selected Episode Showcase ── */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-5">

        {/* Episode List */}
        <div
          className="lg:col-span-5 rounded-3xl overflow-hidden flex flex-col border shadow-xl"
          style={{
            borderColor: 'var(--color-border)',
            background: 'var(--color-bg-card)',
          }}
        >
          <div
            className="px-5 py-4 border-b flex items-center justify-between shrink-0 bg-neutral-900/30"
            style={{ borderColor: 'var(--color-border)' }}
          >
            <h3
              className="text-xs font-black uppercase tracking-widest flex items-center gap-2"
              style={{ color: 'var(--color-text)' }}
            >
              <Layers className="h-3.5 w-3.5 text-[#E50914]" />
              Episode List ({episodes.length})
            </h3>
            <span className="text-[10px] text-neutral-400 font-semibold">
              Select to download
            </span>
          </div>

          <div
            className="divide-y overflow-y-auto flex-1 max-h-[580px] custom-scrollbar"
            style={{ borderColor: 'var(--color-border)' }}
          >
            {episodes.length === 0 ? (
              <div className="p-12 text-center text-xs text-neutral-400 flex flex-col items-center gap-2">
                <Film className="h-8 w-8 opacity-20" />
                No episodes found for this season.
              </div>
            ) : (
              episodes.map((ep) => {
                const isSelected = activeEpisode?.id === ep.id;
                const hasSubs = ep.subtitles && ep.subtitles.length > 0;
                const hasTg = ep.telegramLinks && ep.telegramLinks.length > 0;

                return (
                  <div
                    key={ep.id}
                    onClick={() => handleEpisodeSelect(ep.id)}
                    className={`group flex items-start gap-3.5 p-3.5 cursor-pointer transition-all duration-200 text-left ${
                      isSelected
                        ? 'bg-red-500/10 border-l-4 border-l-[#E50914]'
                        : 'hover:bg-white/[0.03] border-l-4 border-l-transparent'
                    }`}
                  >
                    <div className="relative shrink-0 w-20 aspect-video rounded-xl overflow-hidden bg-neutral-800 border border-white/5 shadow">
                      {ep.stillPath ? (
                        <img
                          src={ep.stillPath}
                          alt={ep.title || ''}
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                          loading="lazy"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center bg-neutral-900 text-neutral-600">
                          <Play className="h-4 w-4 fill-current" />
                        </div>
                      )}
                      <span className="absolute bottom-1 right-1 text-[8px] font-black px-1.5 py-0.5 rounded bg-black/80 text-white font-mono">
                        {epCode(ep)}
                      </span>
                    </div>

                    <div className="flex-1 min-w-0 space-y-1">
                      <div className="flex items-center justify-between gap-1">
                        <h4
                          className={`text-xs font-bold truncate transition-colors ${
                            isSelected ? 'text-[#E50914]' : 'text-white group-hover:text-[#E50914]'
                          }`}
                        >
                          {ep.episodeNumber}. {ep.title || `Episode ${ep.episodeNumber}`}
                        </h4>
                        {ep.imdbRating && (
                          <span className="flex items-center gap-0.5 text-[10px] text-amber-400 font-bold shrink-0">
                            <Star className="h-2.5 w-2.5 fill-amber-400" />
                            {ep.imdbRating.toFixed(1)}
                          </span>
                        )}
                      </div>

                      {ep.description && (
                        <p className="text-[11px] text-neutral-400 line-clamp-1">
                          {ep.description}
                        </p>
                      )}

                      <div className="flex items-center gap-2 pt-0.5 text-[10px] text-neutral-500">
                        {ep.runtime && <span>{ep.runtime} min</span>}
                        {hasSubs && (
                          <span className="flex items-center gap-0.5 text-emerald-400 font-semibold">
                            <CheckCircle2 className="h-2.5 w-2.5" /> Sub
                          </span>
                        )}
                        {hasTg && (
                          <span className="flex items-center gap-0.5 text-sky-400 font-semibold">
                            <Send className="h-2.5 w-2.5" /> TG
                          </span>
                        )}
                      </div>
                    </div>

                    <ChevronRight className={`shrink-0 h-4 w-4 mt-2 transition-transform ${
                      isSelected ? 'text-[#E50914] translate-x-0.5' : 'text-neutral-600 group-hover:text-white'
                    }`} />
                  </div>
                );
              })
            )}
          </div>
        </div>

        {/* Episode Showcase and Downloads */}
        <div className="lg:col-span-7">
          {activeEpisode ? (
            <div
              className="rounded-3xl overflow-hidden border shadow-2xl space-y-6"
              style={{
                borderColor: 'var(--color-border)',
                background: 'var(--color-bg-card)',
              }}
            >
              {/* Hero Still */}
              <div className="relative aspect-video w-full overflow-hidden bg-neutral-900">
                {activeEpisode.stillPath ? (
                  <img
                    src={activeEpisode.stillPath}
                    alt={activeEpisode.title || ''}
                    className="w-full h-full object-cover"
                  />
                ) : (
                  <div className="w-full h-full flex flex-col items-center justify-center text-neutral-600 gap-2">
                    <Film className="h-12 w-12 opacity-30" />
                    <span className="text-xs uppercase font-bold tracking-widest">{movieTitle}</span>
                  </div>
                )}

                <div className="absolute inset-0 bg-gradient-to-t from-neutral-950 via-neutral-950/60 to-transparent" />

                <div className="absolute top-4 left-4 right-4 flex items-center justify-between">
                  <span className="px-3 py-1 rounded-xl text-xs font-black uppercase tracking-wider text-white bg-[#E50914] shadow-lg">
                    {epCode(activeEpisode)}
                  </span>

                  <Link
                    href={`/movies/${movieId}/season/${activeSeason}/episode/${activeEpisode.episodeNumber}`}
                    onClick={() => openSponsorAd()}
                    className="flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold text-white bg-black/60 hover:bg-black/80 backdrop-blur-md border border-white/10 transition-colors shadow-lg"
                  >
                    <Play className="h-3 w-3 fill-white" />
                    <span>Dedicated Page ↗</span>
                  </Link>
                </div>

                <div className="absolute bottom-4 left-5 right-5 space-y-1.5">
                  <h3 className="text-lg sm:text-2xl font-black text-white leading-tight">
                    {activeEpisode.title || `Episode ${activeEpisode.episodeNumber}`}
                  </h3>
                  <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-neutral-300 font-medium">
                    {activeEpisode.imdbRating && (
                      <span className="flex items-center gap-1 text-amber-400 font-bold">
                        <Star className="h-3.5 w-3.5 fill-amber-400" />
                        {activeEpisode.imdbRating.toFixed(1)} IMDb
                      </span>
                    )}
                    {activeEpisode.runtime && (
                      <span className="flex items-center gap-1">
                        <Clock className="h-3.5 w-3.5" />{activeEpisode.runtime} min
                      </span>
                    )}
                    {activeEpisode.airDate && (
                      <span className="flex items-center gap-1">
                        <Calendar className="h-3.5 w-3.5" />{activeEpisode.airDate}
                      </span>
                    )}
                  </div>
                </div>
              </div>

              <div className="p-6 space-y-6">
                {activeEpisode.description && (
                  <p className="text-xs sm:text-sm leading-relaxed text-neutral-300">
                    {activeEpisode.description}
                  </p>
                )}

                {/* ── Subtitles Download List ── */}
                {activeEpisode.subtitles && activeEpisode.subtitles.length > 0 && (
                  <div className="space-y-3">
                    <h4 className="text-xs font-black uppercase tracking-widest text-emerald-400 flex items-center gap-1.5">
                      <Download className="h-4 w-4" />
                      Download Sinhala Subtitles (.SRT)
                    </h4>
                    <div className="space-y-2.5">
                      {activeEpisode.subtitles.map((sub) => {
                        const isUnlocked = unlockedSubs[sub.id];
                        const downloadState = downloadingSubs[sub.id];
                        const isLoading = downloadState === 'loading';
                        const isDone = downloadState === 'done';

                        return (
                          <button
                            key={sub.id}
                            type="button"
                            onClick={() => handleSubtitleClick(sub, activeEpisode)}
                            disabled={isLoading}
                            className={`w-full group flex items-center justify-between gap-3.5 p-4 rounded-2xl transition-all hover:scale-[1.01] cursor-pointer text-left shadow-lg ${
                              isDone
                                ? 'bg-emerald-900/40 border-2 border-emerald-400'
                                : isLoading
                                ? 'bg-emerald-950/50 border-2 border-emerald-500'
                                : isUnlocked
                                ? 'bg-emerald-950/30 border-2 border-emerald-500/80 animate-pulse'
                                : 'bg-emerald-950/20 hover:bg-emerald-900/30 border border-emerald-500/20'
                            }`}
                          >
                            <div className="flex items-center gap-3.5 min-w-0">
                              <div className={`w-11 h-11 rounded-xl flex items-center justify-center shrink-0 transition-colors ${
                                isDone
                                  ? 'bg-emerald-400 text-black shadow-lg'
                                  : isUnlocked || isLoading
                                  ? 'bg-emerald-500 text-white shadow-lg'
                                  : 'bg-emerald-500/20 text-emerald-400'
                              }`}>
                                {isLoading ? (
                                  <Loader2 className="h-5 w-5 animate-spin" />
                                ) : isDone ? (
                                  <CheckCircle2 className="h-5 w-5 text-black" />
                                ) : isUnlocked ? (
                                  <Zap className="h-5 w-5 fill-current" />
                                ) : (
                                  <Download className="h-5 w-5" />
                                )}
                              </div>
                              <div className="min-w-0">
                                <p className="text-xs sm:text-sm font-bold text-white truncate group-hover:text-emerald-300">
                                  {sub.fileName}
                                </p>
                                <p className="text-[11px] text-neutral-400 flex items-center gap-2 mt-0.5">
                                  <span>{sub.language}</span>
                                  {sub.version && (
                                    <span className="px-1.5 py-0.2 rounded bg-neutral-800 text-neutral-300 text-[10px]">
                                      {sub.version}
                                    </span>
                                  )}
                                  <span>• ↓ {sub.downloadsCount?.toLocaleString() || 0} downloads</span>
                                </p>
                              </div>
                            </div>
                            <span className={`shrink-0 px-4 py-2 rounded-xl text-xs font-black text-white transition-colors shadow-lg flex items-center gap-1.5 ${
                              isDone
                                ? 'bg-emerald-500 text-black font-extrabold scale-105'
                                : isLoading
                                ? 'bg-emerald-600 scale-105'
                                : isUnlocked
                                ? 'bg-gradient-to-r from-emerald-500 to-green-600 scale-105 font-extrabold'
                                : 'bg-emerald-600 group-hover:bg-emerald-500'
                            }`}>
                              {isLoading ? (
                                <>
                                  <Loader2 className="h-3.5 w-3.5 animate-spin" />
                                  DOWNLOADING...
                                </>
                              ) : isDone ? (
                                <>
                                  <CheckCircle2 className="h-3.5 w-3.5" />
                                  SAVED!
                                </>
                              ) : isUnlocked ? (
                                <>
                                  <Download className="h-3.5 w-3.5" />
                                  DOWNLOAD NOW
                                </>
                              ) : (
                                <>
                                  <Download className="h-3.5 w-3.5" />
                                  DOWNLOAD
                                </>
                              )}
                            </span>
                          </button>
                        );
                      })}
                    </div>
                  </div>
                )}

                {/* ── High-Dwell Ad Banner Between Episode Subs and TG ── */}
                <AdBanner unit="300x250" />

                {/* ── Telegram Download Links (Matching Full-Size Layout) ── */}
                {activeEpisode.telegramLinks && activeEpisode.telegramLinks.length > 0 && (
                  <div className="space-y-3">
                    <div className="flex flex-col gap-0.5">
                      <h4 className="text-xs font-black uppercase tracking-widest text-sky-400 flex items-center gap-1.5">
                        <Send className="h-4 w-4" />
                        External Telegram Channel Directory Links
                      </h4>
                      <p className="text-[10px] text-neutral-400">
                        Indexed public links hosted on external Telegram servers. Not hosted on PixelSubzLk.
                      </p>
                    </div>
                    <div className="space-y-2.5">
                      {activeEpisode.telegramLinks.map((link) => {
                        const isUnlocked = unlockedTg[link.id];
                        const isLoading = downloadingTg[link.id];

                        return (
                          <button
                            key={link.id}
                            type="button"
                            onClick={() => handleTelegramClick(link)}
                            disabled={isLoading}
                            className={`w-full group flex items-center justify-between gap-3.5 p-4 rounded-2xl transition-all hover:scale-[1.01] cursor-pointer text-left shadow-lg ${
                              isLoading
                                ? 'bg-sky-950/50 border-2 border-sky-400'
                                : isUnlocked
                                ? 'bg-sky-950/30 border-2 border-sky-500/80 animate-pulse'
                                : 'bg-sky-950/20 hover:bg-sky-900/30 border border-sky-500/20'
                            }`}
                          >
                            <div className="flex items-center gap-3.5 min-w-0">
                              <div className={`w-11 h-11 rounded-xl flex items-center justify-center shrink-0 transition-colors ${
                                isUnlocked || isLoading
                                  ? 'bg-sky-500 text-white shadow-lg'
                                  : 'bg-sky-500/20 text-sky-400'
                              }`}>
                                {isLoading ? (
                                  <Loader2 className="h-5 w-5 animate-spin" />
                                ) : isUnlocked ? (
                                  <Zap className="h-5 w-5 fill-current" />
                                ) : (
                                  <Send className="h-5 w-5" />
                                )}
                              </div>
                              <div className="min-w-0">
                                <p className="text-xs sm:text-sm font-bold text-white truncate group-hover:text-sky-300">
                                  {movieTitle} {epCode(activeEpisode)} {link.quality ? `— ${link.quality}` : ''}
                                </p>
                                <p className="text-[11px] text-neutral-400 flex items-center gap-2 mt-0.5">
                                  {link.size && <span>{link.size}</span>}
                                  {link.label && (
                                    <span className="px-1.5 py-0.2 rounded bg-sky-500/15 text-sky-300 font-bold text-[10px]">
                                      {link.label}
                                    </span>
                                  )}
                                  <span>• ⚡ Fast Telegram CDN</span>
                                </p>
                              </div>
                            </div>
                            <span className={`shrink-0 px-4 py-2 rounded-xl text-xs font-black text-white shadow transition-all ${
                              isLoading
                                ? 'bg-sky-600 scale-105'
                                : isUnlocked
                                ? 'bg-gradient-to-r from-sky-500 to-blue-600 scale-105 font-extrabold'
                                : 'bg-sky-500 group-hover:bg-sky-400'
                            }`}>
                              {isLoading ? (
                                <>
                                  <Loader2 className="h-3.5 w-3.5 animate-spin" />
                                  OPENING...
                                </>
                              ) : isUnlocked ? (
                                <>
                                  <Send className="h-3.5 w-3.5" />
                                  OPEN TG NOW
                                </>
                              ) : (
                                <>
                                  <Send className="h-3.5 w-3.5" />
                                  TELEGRAM
                                </>
                              )}
                            </span>
                          </button>
                        );
                      })}
                    </div>
                  </div>
                )}
              </div>
            </div>
          ) : (
            <div className="h-full min-h-[350px] rounded-3xl border-2 border-dashed border-neutral-800 flex flex-col items-center justify-center p-8 text-center text-neutral-500">
              <Play className="h-10 w-10 mb-3 opacity-30 text-[#E50914]" />
              <p className="text-sm font-bold text-neutral-300">Select an Episode</p>
              <p className="text-xs text-neutral-500 mt-1 max-w-sm">
                Choose any episode from the left panel to access direct Sinhala subtitle downloads and Telegram links.
              </p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
