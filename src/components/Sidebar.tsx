'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import {
  Film,
  Tv,
  X,
  Send,
  Sparkles,
  Layers,
  Flame,
  Clapperboard,
  Heart,
  Ghost,
  Compass,
  Smile,
  Shield,
  Search,
  MessageSquarePlus,
} from 'lucide-react';

interface SidebarProps {
  isOpen: boolean;
  onClose: () => void;
}

const GENRES = [
  { name: 'Action', icon: Flame, color: '#f97316' },
  { name: 'Thriller', icon: Shield, color: '#ef4444' },
  { name: 'Sci-Fi', icon: Sparkles, color: '#8b5cf6' },
  { name: 'Horror', icon: Ghost, color: '#a855f7' },
  { name: 'Adventure', icon: Compass, color: '#eab308' },
  { name: 'Drama', icon: Clapperboard, color: '#3b82f6' },
  { name: 'Comedy', icon: Smile, color: '#10b981' },
  { name: 'Romance', icon: Heart, color: '#ec4899' },
  { name: 'Animation', icon: Layers, color: '#06b6d4' },
  { name: 'Crime', icon: Shield, color: '#64748b' },
  { name: 'Mystery', icon: Search, color: '#6366f1' },
  { name: 'Fantasy', icon: Sparkles, color: '#14b8a6' },
];

export default function Sidebar({ isOpen, onClose }: SidebarProps) {
  const [currentType, setCurrentType] = useState('');
  const [currentGenre, setCurrentGenre] = useState('');

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const sp = new URLSearchParams(window.location.search);
      setCurrentType(sp.get('type') || '');
      setCurrentGenre(sp.get('genre') || '');
    }
  }, [isOpen]);

  return (
    <>
      {/* Backdrop overlay */}
      {isOpen && (
        <div
          onClick={onClose}
          className="fixed inset-0 z-50 bg-black/70 backdrop-blur-sm transition-opacity duration-300"
          aria-hidden="true"
        />
      )}

      {/* Slide-out Sidebar Drawer */}
      <aside
        className={`fixed top-0 left-0 bottom-0 z-50 w-80 max-w-[85vw] flex flex-col transition-transform duration-300 ease-out shadow-2xl ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
        style={{
          background: 'var(--color-bg)',
          borderRight: '1px solid var(--color-border)',
          boxShadow: '10px 0 30px rgba(0,0,0,0.6)',
        }}
        aria-label="Sidebar Navigation"
      >
        {/* Top Header */}
        <div
          className="h-16 px-5 flex items-center justify-between border-b"
          style={{ borderColor: 'var(--color-border)' }}
        >
          <Link href="/" onClick={onClose} className="flex items-center space-x-2.5">
            <div className="w-9 h-9 rounded-xl overflow-hidden flex items-center justify-center shadow-md bg-black/40 border border-white/10">
              <img src="/logo.png" alt="PixelSubzLk Logo" className="w-full h-full object-cover" />
            </div>
            <span className="font-black text-lg tracking-tight" style={{ color: 'var(--color-text)' }}>
              PixelSubz<span className="text-[#E50914]">Lk</span>
            </span>
          </Link>

          <button
            onClick={onClose}
            className="p-2 rounded-full hover:bg-neutral-800 transition-colors"
            style={{ color: 'var(--color-text-muted)' }}
            aria-label="Close sidebar"
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        {/* Scrollable Content */}
        <div className="flex-1 overflow-y-auto p-4 space-y-6">

          {/* Section 1: Main Type Switcher (Movies vs TV Series) */}
          <div className="space-y-2">
            <h3 className="text-[11px] font-bold uppercase tracking-widest px-2" style={{ color: 'var(--color-text-muted)' }}>
              Browse By Format
            </h3>

            <div className="grid grid-cols-1 gap-1.5">
              <Link
                href="/"
                onClick={onClose}
                className={`flex items-center gap-3 px-3 py-2.5 rounded-xl font-bold text-sm transition-all ${
                  !currentType && !currentGenre ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
                }`}
                style={{
                  color: (!currentType && !currentGenre) ? '#ffffff' : 'var(--color-text)',
                  border: (!currentType && !currentGenre) ? 'none' : '1px solid var(--color-border)',
                }}
              >
                <Layers className="h-4 w-4" />
                <span>All Releases</span>
              </Link>

              <Link
                href="/?type=MOVIE"
                onClick={onClose}
                className={`flex items-center gap-3 px-3 py-2.5 rounded-xl font-bold text-sm transition-all ${
                  currentType === 'MOVIE' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
                }`}
                style={{
                  color: currentType === 'MOVIE' ? '#ffffff' : 'var(--color-text)',
                  border: currentType === 'MOVIE' ? 'none' : '1px solid var(--color-border)',
                }}
              >
                <Film className="h-4 w-4 text-[#E50914]" />
                <span>Movies</span>
              </Link>

              <Link
                href="/?type=TV_SHOW"
                onClick={onClose}
                className={`flex items-center gap-3 px-3 py-2.5 rounded-xl font-bold text-sm transition-all ${
                  currentType === 'TV_SHOW' ? 'bg-[#6d28d9] text-white shadow-lg shadow-purple-900/30' : 'hover:bg-neutral-800/40'
                }`}
                style={{
                  color: currentType === 'TV_SHOW' ? '#ffffff' : 'var(--color-text)',
                  border: currentType === 'TV_SHOW' ? 'none' : '1px solid var(--color-border)',
                }}
              >
                <Tv className="h-4 w-4 text-purple-400" />
                <span>TV Series</span>
              </Link>

              <Link
                href="/request"
                onClick={onClose}
                className="flex items-center gap-3 px-3 py-2.5 rounded-xl font-semibold text-sm hover:bg-neutral-800/40 transition-all"
                style={{ color: 'var(--color-text)', border: '1px solid var(--color-border)' }}
              >
                <MessageSquarePlus className="h-4 w-4 text-amber-400" />
                <span>Request Subtitles</span>
              </Link>
            </div>
          </div>

          {/* Section 2: Categories / Genres */}
          <div className="space-y-2">
            <h3 className="text-[11px] font-bold uppercase tracking-widest px-2" style={{ color: 'var(--color-text-muted)' }}>
              Categories &amp; Genres
            </h3>

            <div className="grid grid-cols-2 gap-2">
              {GENRES.map((g) => {
                const IconComponent = g.icon;
                const isSelected = currentGenre.toLowerCase() === g.name.toLowerCase();

                return (
                  <Link
                    key={g.name}
                    href={`/?genre=${encodeURIComponent(g.name)}${currentType ? `&type=${currentType}` : ''}`}
                    onClick={onClose}
                    className={`flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-semibold transition-all ${
                      isSelected
                        ? 'bg-[#E50914] text-white shadow-md shadow-red-900/30'
                        : 'hover:bg-neutral-800/40'
                    }`}
                    style={{
                      background: isSelected ? '#E50914' : 'var(--color-bg-card)',
                      border: isSelected ? 'none' : '1px solid var(--color-border)',
                      color: isSelected ? '#ffffff' : 'var(--color-text)',
                    }}
                  >
                    <IconComponent className="h-3.5 w-3.5 shrink-0" style={{ color: isSelected ? '#ffffff' : g.color }} />
                    <span className="truncate">{g.name}</span>
                  </Link>
                );
              })}
            </div>
          </div>

        </div>

        {/* Section 3: Bottom Social Buttons (Telegram & Facebook) */}
        <div
          className="p-4 border-t space-y-2.5"
          style={{ borderColor: 'var(--color-border)', background: 'var(--color-bg-card)' }}
        >
          <div className="text-[11px] font-bold uppercase tracking-wider text-center" style={{ color: 'var(--color-text-muted)' }}>
            Join Our Community
          </div>

          {/* Telegram Channel Button */}
          <a
            href="https://t.me/pixelpoplk"
            target="_blank"
            rel="noopener noreferrer"
            className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-xl text-xs font-bold text-white transition-all hover:scale-102 active:scale-98 shadow-md"
            style={{
              background: '#0088cc',
              boxShadow: '0 4px 14px rgba(0, 136, 204, 0.3)',
            }}
          >
            <Send className="h-4 w-4" />
            <span>Join Telegram Channel</span>
          </a>

          {/* Facebook Page Button */}
          <a
            href="https://www.facebook.com/share/19PMibMoPL/"
            target="_blank"
            rel="noopener noreferrer"
            className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-xl text-xs font-bold text-white transition-all hover:scale-102 active:scale-98 shadow-md"
            style={{
              background: '#1877F2',
              boxShadow: '0 4px 14px rgba(24, 119, 242, 0.3)',
            }}
          >
            <svg className="h-4 w-4 fill-current" viewBox="0 0 24 24">
              <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
            </svg>
            <span>Follow on Facebook</span>
          </a>
        </div>
      </aside>
    </>
  );
}
