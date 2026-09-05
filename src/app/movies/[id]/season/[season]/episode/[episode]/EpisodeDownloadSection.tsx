'use client';

import { useState } from 'react';
import { Download, Send, Zap, CheckCircle2, Loader2 } from 'lucide-react';
import { openSponsorAd, downloadSubtitleDirectly } from '@/lib/adManager';
import AdBanner from '@/components/AdBanner';

interface EpisodeDownloadSectionProps {
  subtitles: any[];
  telegramLinks: any[];
  movieTitle: string;
  epCode: string;
}

export default function EpisodeDownloadSection({
  subtitles,
  telegramLinks,
  movieTitle,
  epCode,
}: EpisodeDownloadSectionProps) {
  const [unlockedSubs, setUnlockedSubs] = useState<Record<string, boolean>>({});
  const [unlockedTg, setUnlockedTg] = useState<Record<string, boolean>>({});

  const [downloadingSubs, setDownloadingSubs] = useState<Record<string, 'loading' | 'done' | undefined>>({});
  const [downloadingTg, setDownloadingTg] = useState<Record<string, boolean>>({});

  const handleSubtitleClick = async (sub: any) => {
    if (!unlockedSubs[sub.id]) {
      openSponsorAd();
      setUnlockedSubs(prev => ({ ...prev, [sub.id]: true }));
    } else {
      setDownloadingSubs(prev => ({ ...prev, [sub.id]: 'loading' }));
      try {
        await downloadSubtitleDirectly(sub.fileUrl, sub.fileName || `${movieTitle} ${epCode}.srt`, sub.id);
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

  const handleTelegramClick = (link: any) => {
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

  return (
    <div className="space-y-8">
      {/* ── Subtitles Download Section ── */}
      {subtitles?.length > 0 && (
        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="text-base font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
              <Download className="h-5 w-5 text-[#E50914]" />
              Sinhala Subtitle Direct Downloads (.SRT)
            </h2>
            <span className="text-xs font-semibold px-2.5 py-1 rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
              {subtitles.length} available
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
            {subtitles.map((sub: any) => {
              const isUnlocked = unlockedSubs[sub.id];
              const downloadState = downloadingSubs[sub.id];
              const isLoading = downloadState === 'loading';
              const isDone = downloadState === 'done';

              return (
                <button
                  key={sub.id}
                  type="button"
                  onClick={() => handleSubtitleClick(sub)}
                  disabled={isLoading}
                  className={`group flex items-center justify-between gap-3.5 p-4 rounded-2xl text-left transition-all hover:scale-[1.01] cursor-pointer shadow-lg ${
                    isDone
                      ? 'bg-emerald-900/40 border-2 border-emerald-400'
                      : isLoading
                      ? 'bg-emerald-950/50 border-2 border-emerald-500'
                      : isUnlocked
                      ? 'bg-emerald-950/30 border-2 border-emerald-500/80 animate-pulse'
                      : 'bg-neutral-900/40 border border-neutral-800 hover:border-neutral-700'
                  }`}
                >
                  <div className="flex items-center gap-3.5 min-w-0">
                    <div className={`w-11 h-11 rounded-xl flex items-center justify-center shrink-0 transition-colors ${
                      isDone
                        ? 'bg-emerald-400 text-black shadow-lg'
                        : isUnlocked || isLoading
                        ? 'bg-emerald-500 text-white shadow-lg'
                        : 'bg-emerald-500/15 text-emerald-400'
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
                      <p className="text-[11px] text-neutral-400 mt-0.5 flex items-center gap-2">
                        <span>{sub.language}</span>
                        {sub.version && (
                          <span className="px-1.5 py-0.2 rounded bg-neutral-800 text-neutral-300 text-[10px]">
                            {sub.version}
                          </span>
                        )}
                        <span>• ↓ {sub.downloadsCount?.toLocaleString() || 0}</span>
                      </p>
                    </div>
                  </div>

                  <span className={`shrink-0 px-4 py-2 rounded-xl text-xs font-black text-white flex items-center gap-1.5 shadow-md transition-all ${
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
        </section>
      )}

      {/* ── High-Dwell Ad Banner: Placed Directly Between Subtitles & Telegram ── */}
      <AdBanner unit="300x250" />

      {/* ── Telegram Download Section (Matching Full-Size Layout) ── */}
      {telegramLinks?.length > 0 && (
        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-base font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                <Send className="h-5 w-5 text-sky-400" />
                External Telegram Channel Directory Links
              </h2>
              <p className="text-[11px] text-neutral-400 mt-0.5">
                Indexed public channels hosted on external Telegram servers. Not hosted on PixelSubzLk.
              </p>
            </div>
            <span className="text-xs font-semibold px-2.5 py-1 rounded-full bg-sky-500/10 text-sky-400 border border-sky-500/20 shrink-0">
              {telegramLinks.length} available
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
            {telegramLinks.map((link: any) => {
              const isUnlocked = unlockedTg[link.id];
              const isLoading = downloadingTg[link.id];

              return (
                <button
                  key={link.id}
                  type="button"
                  onClick={() => handleTelegramClick(link)}
                  disabled={isLoading}
                  className={`group flex items-center justify-between gap-3.5 p-4 rounded-2xl text-left transition-all hover:scale-[1.01] cursor-pointer shadow-lg ${
                    isLoading
                      ? 'bg-sky-950/50 border-2 border-sky-400'
                      : isUnlocked
                      ? 'bg-sky-950/30 border-2 border-sky-500/80 animate-pulse'
                      : 'bg-neutral-900/40 border border-neutral-800 hover:border-neutral-700'
                  }`}
                >
                  <div className="flex items-center gap-3.5 min-w-0">
                    <div className={`w-11 h-11 rounded-xl flex items-center justify-center shrink-0 transition-colors ${
                      isUnlocked || isLoading
                        ? 'bg-sky-500 text-white shadow-lg'
                        : 'bg-sky-500/15 text-sky-400'
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
                        {movieTitle} {epCode} {link.quality ? `— ${link.quality}` : ''}
                      </p>
                      <p className="text-[11px] text-neutral-400 mt-0.5 flex items-center gap-2">
                        {link.size && <span>{link.size}</span>}
                        {link.label && (
                          <span className="px-1.5 py-0.2 rounded bg-sky-500/10 text-sky-300 font-bold text-[10px]">
                            {link.label}
                          </span>
                        )}
                        <span>• ⚡ Fast Telegram CDN</span>
                      </p>
                    </div>
                  </div>

                  <span className={`shrink-0 px-4 py-2 rounded-xl text-xs font-black text-white flex items-center gap-1.5 shadow-md transition-all ${
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
        </section>
      )}
    </div>
  );
}
