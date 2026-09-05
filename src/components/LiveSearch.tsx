'use client';

import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { Search, Film, Tv, Download, Loader2, X, ChevronRight } from 'lucide-react';
import Link from 'next/link';

interface SearchResult {
  id: string;
  title: string;
  originalTitle?: string;
  type: string;
  releaseDate?: string;
  posterPath?: string;
  subtitlesCount?: number;
}

interface LiveSearchProps {
  placeholder?: string;
  className?: string;
  isMobile?: boolean;
}

export default function LiveSearch({ placeholder = 'Search movies, TV shows…', className = '', isMobile = false }: LiveSearchProps) {
  const router = useRouter();
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  // Debounced search
  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      setIsOpen(false);
      setLoading(false);
      return;
    }

    setLoading(true);
    const timer = setTimeout(async () => {
      try {
        const res = await fetch(`/api/search?q=${encodeURIComponent(query.trim())}`);
        if (res.ok) {
          const data = await res.json();
          setResults(data.results || []);
          setIsOpen(true);
        }
      } catch (err) {
        console.error('Search error:', err);
      } finally {
        setLoading(false);
      }
    }, 150);

    return () => clearTimeout(timer);
  }, [query]);

  // Click outside to dismiss
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleFormSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      setIsOpen(false);
      router.push(`/?search=${encodeURIComponent(query.trim())}`);
    }
  };

  const handleSelect = (id: string) => {
    setIsOpen(false);
    setQuery('');
    router.push(`/movies/${id}`);
  };

  return (
    <div ref={containerRef} className={`relative ${className}`}>
      <form onSubmit={handleFormSubmit} className="relative w-full">
        <input
          type="text"
          placeholder={placeholder}
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onFocus={() => {
            if (results.length > 0) setIsOpen(true);
          }}
          className={`nf-input nf-input-icon-left nf-input-icon-right text-sm h-10 ${isMobile ? 'h-10.5 text-base sm:text-sm' : ''}`}
        />
        <Search
          className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 pointer-events-none"
          style={{ color: 'var(--color-text-subtle)' }}
        />

        {loading ? (
          <Loader2
            className="absolute right-3 top-1/2 -translate-y-1/2 h-4 w-4 animate-spin text-[#E50914]"
          />
        ) : query ? (
          <button
            type="button"
            onClick={() => {
              setQuery('');
              setResults([]);
              setIsOpen(false);
            }}
            className="absolute right-3 top-1/2 -translate-y-1/2 p-0.5 rounded-full hover:bg-neutral-800 transition-colors"
            style={{ color: 'var(--color-text-subtle)' }}
          >
            <X className="h-3.5 w-3.5" />
          </button>
        ) : null}
      </form>

      {/* Live Dropdown Results */}
      {isOpen && (
        <div
          className="absolute top-full left-0 right-0 mt-1.5 rounded-2xl shadow-2xl z-50 overflow-hidden backdrop-blur-xl transition-all max-h-[420px] overflow-y-auto"
          style={{
            background: 'var(--color-bg-card)',
            border: '1px solid var(--color-border)',
            boxShadow: '0 20px 40px rgba(0,0,0,0.5)',
          }}
        >
          {results.length > 0 ? (
            <div className="p-2 space-y-1">
              <div className="px-3 py-1.5 text-[11px] font-bold uppercase tracking-wider flex items-center justify-between" style={{ color: 'var(--color-text-muted)' }}>
                <span>Quick Matches</span>
                <span className="text-[#E50914]">{results.length} found</span>
              </div>

              {results.map((item) => {
                const isTv = item.type === 'TV_SHOW';
                const year = item.releaseDate ? item.releaseDate.split('-')[0] : '';

                return (
                  <button
                    key={item.id}
                    onClick={() => handleSelect(item.id)}
                    type="button"
                    className="w-full p-2 rounded-xl flex items-center gap-3 text-left transition-all hover:bg-red-600/10 group"
                  >
                    {/* Thumbnail */}
                    <div
                      className="w-10 h-14 rounded-lg overflow-hidden shrink-0 shadow flex items-center justify-center"
                      style={{ background: 'var(--color-bg-elevated)' }}
                    >
                      {item.posterPath ? (
                        <img
                          src={item.posterPath}
                          alt={item.title}
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform"
                        />
                      ) : (
                        isTv ? <Tv className="w-5 h-5 text-neutral-500" /> : <Film className="w-5 h-5 text-neutral-500" />
                      )}
                    </div>

                    {/* Meta info */}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-1.5 flex-wrap">
                        <span
                          className="text-[9px] uppercase font-black px-1.5 py-0.5 rounded text-white"
                          style={{ background: isTv ? '#6d28d9' : '#E50914' }}
                        >
                          {isTv ? 'TV' : 'Movie'}
                        </span>
                        {year && (
                          <span className="text-[11px]" style={{ color: 'var(--color-text-subtle)' }}>
                            {year}
                          </span>
                        )}
                      </div>

                      <h4
                        className="text-xs sm:text-sm font-bold truncate group-hover:text-[#E50914] transition-colors mt-0.5"
                        style={{ color: 'var(--color-text)' }}
                      >
                        {item.title}
                      </h4>

                      <div className="flex items-center gap-2 text-[11px] text-[#E50914] font-semibold mt-0.5">
                        <Download className="w-3 h-3" />
                        <span>{item.subtitlesCount || 0} Sinhala Sub{(item.subtitlesCount || 0) !== 1 ? 's' : ''}</span>
                      </div>
                    </div>

                    <ChevronRight className="w-4 h-4 shrink-0 opacity-0 group-hover:opacity-100 transition-opacity text-[#E50914]" />
                  </button>
                );
              })}

              {/* View all results button */}
              <div className="pt-1.5 border-t" style={{ borderColor: 'var(--color-border)' }}>
                <button
                  type="button"
                  onClick={handleFormSubmit}
                  className="w-full py-2 px-3 text-xs font-bold text-center text-[#E50914] hover:underline flex items-center justify-center gap-1"
                >
                  <span>View all results for &ldquo;{query}&rdquo;</span>
                  <ChevronRight className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>
          ) : (
            <div className="p-6 text-center text-xs" style={{ color: 'var(--color-text-muted)' }}>
              No matches found for &ldquo;<span className="text-[#E50914] font-semibold">{query}</span>&rdquo;.
              <div className="mt-2">
                <button
                  type="button"
                  onClick={handleFormSubmit}
                  className="text-xs font-bold text-[#E50914] hover:underline"
                >
                  Press Enter to search entire catalog ↵
                </button>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
