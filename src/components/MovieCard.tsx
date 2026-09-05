'use client';

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Film, Tv, Download, Send } from 'lucide-react';
import { openSponsorAd } from '@/lib/adManager';

export default function MovieCard(props: any) {
  const router = useRouter();
  const m = props?.movie || props || {};
  const id = m.id || props?.id || '';
  const title = m.title || props?.title || 'Untitled';
  const type = m.type || props?.type || 'MOVIE';
  const isMovie = type === 'MOVIE';
  const posterPath = m.posterPath || props?.posterPath || null;
  const releaseDate = m.releaseDate || props?.releaseDate || null;
  const subCount = m._count?.subtitles ?? props?.subtitlesCount ?? 0;
  const linkCount = m._count?.telegramLinks ?? props?.telegramLinksCount ?? 0;

  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    // Only intercept primary left click without modifier keys (cmd/ctrl/shift)
    if (e.button === 0 && !e.metaKey && !e.ctrlKey && !e.shiftKey && !e.altKey) {
      e.preventDefault();
      // Directly trigger window.open synchronously within user gesture to prevent popup blocking
      openSponsorAd();
      // Navigate cleanly
      router.push(`/movies/${id}`);
    }
  };

  return (
    <Link
      href={`/movies/${id}`}
      onClick={handleClick}
      className="nf-movie-card group rounded-xl overflow-hidden flex flex-col transition-all duration-300 hover:-translate-y-1 cursor-pointer"
    >
      {/* Poster */}
      <div className="relative aspect-[2/3] w-full overflow-hidden nf-movie-card-poster">
        {posterPath ? (
          <img
            src={posterPath}
            alt={title}
            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            loading="lazy"
          />
        ) : (
          <div className="w-full h-full flex flex-col items-center justify-center p-4 nf-movie-card-placeholder">
            {isMovie ? <Film className="h-10 w-10 mb-2" /> : <Tv className="h-10 w-10 mb-2" />}
            <span className="text-xs text-center font-medium line-clamp-2 px-2">{title}</span>
          </div>
        )}

        {/* Type badge */}
        <div className="absolute top-2 left-2">
          <span
            className="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded shadow text-white"
            style={{ background: isMovie ? '#E50914' : '#6d28d9' }}
          >
            {isMovie ? 'Movie' : 'TV'}
          </span>
        </div>

        {/* Hover overlay */}
        <div className="absolute inset-0 bg-black/80 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col items-center justify-center gap-3 p-4 text-center">
          <p className="text-white text-sm font-bold line-clamp-2">{title}</p>
          {releaseDate && (
            <p className="text-neutral-400 text-xs">{String(releaseDate).split('-')[0]}</p>
          )}
          <div className="flex gap-2 pt-1">
            <span className="text-xs font-semibold text-white bg-[#E50914] px-2 py-1 rounded flex items-center gap-1">
              <Download className="h-3 w-3" />
              {subCount} Sub{subCount !== 1 ? 's' : ''}
            </span>
            <span className="text-xs font-semibold text-white bg-sky-600 px-2 py-1 rounded flex items-center gap-1">
              <Send className="h-3 w-3" />
              {linkCount} Link{linkCount !== 1 ? 's' : ''}
            </span>
          </div>
        </div>
      </div>

      {/* Card info */}
      <div className="p-3 flex flex-col gap-1.5 nf-movie-card-info">
        <h3 className="text-sm font-bold line-clamp-1 transition-colors group-hover:text-[#E50914] nf-movie-card-title">
          {title}
        </h3>
        <div className="flex items-center justify-between text-xs nf-movie-card-meta">
          <span>{releaseDate ? String(releaseDate).split('-')[0] : 'N/A'}</span>
          <span className="text-[#E50914] font-semibold">{subCount} {subCount === 1 ? 'Sub' : 'Subs'}</span>
        </div>
      </div>
    </Link>
  );
}
