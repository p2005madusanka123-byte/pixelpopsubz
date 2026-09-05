'use client';

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useTheme } from '@/components/ThemeProvider';
import Sidebar from '@/components/Sidebar';
import LiveSearch from '@/components/LiveSearch';
import { Film, MessageSquarePlus, Sun, Moon, Menu } from 'lucide-react';

export default function Navbar() {
  const router = useRouter();
  const supabase = createClient();
  const { theme, toggleTheme } = useTheme();
  const [scrolled, setScrolled] = useState(false);
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 10);
    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const navBg = theme === 'dark'
    ? scrolled ? 'bg-[#141414]/95 backdrop-blur-md' : 'bg-[#141414]'
    : scrolled ? 'bg-white/95 backdrop-blur-md shadow-sm' : 'bg-white';

  return (
    <>
      <nav
        className={`sticky top-0 z-40 transition-all duration-200 ${navBg}`}
        style={{ borderBottom: '1px solid var(--color-border)' }}
      >
        <div className="max-w-[1700px] mx-auto px-3 sm:px-6 lg:px-8 xl:px-12">
          <div className="flex items-center justify-between h-16 gap-3 sm:gap-6">

            {/* Left: Sidebar Toggle Button + Logo */}
            <div className="flex items-center gap-2 sm:gap-3 shrink-0">
              <button
                onClick={() => setIsSidebarOpen(true)}
                className="p-2 rounded-xl hover:bg-neutral-800/50 transition-all active:scale-95 cursor-pointer"
                style={{
                  background: 'var(--color-bg-card)',
                  border: '1px solid var(--color-border)',
                  color: 'var(--color-text)',
                }}
                aria-label="Open Sidebar Menu"
                title="Categories & Menu"
              >
                <Menu className="h-5 w-5 text-[#E50914]" />
              </button>

              <Link href="/" className="flex items-center space-x-2.5 shrink-0 group">
                <div className="w-9 h-9 rounded-xl overflow-hidden flex items-center justify-center shadow-lg shadow-red-900/30 group-hover:scale-105 transition-transform bg-black/40 border border-white/10">
                  <img src="/logo.png" alt="PixelSubzLk Logo" className="w-full h-full object-cover" />
                </div>
                <span className="font-black text-lg tracking-tight" style={{ color: 'var(--color-text)' }}>
                  PixelSubz<span className="text-[#E50914]">Lk</span>
                </span>
              </Link>
            </div>

            {/* Middle: Desktop Live Instant Search */}
            <div className="hidden md:block flex-1 max-w-xl mx-auto">
              <LiveSearch placeholder="Search movies, TV series, actors…" />
            </div>

            {/* Right: Browse, Request, Theme Toggle */}
            <div className="flex items-center gap-2 shrink-0">
              <Link href="/" className="nf-nav-link hidden lg:block">Browse</Link>
              <Link href="/?type=MOVIE" className="nf-nav-link hidden lg:block">Movies</Link>
              <Link href="/?type=TV_SHOW" className="nf-nav-link hidden lg:block">TV Series</Link>
              <Link href="/request" className="nf-nav-link hidden sm:flex items-center gap-1">
                <MessageSquarePlus className="h-4 w-4" />
                <span className="hidden sm:inline">Request</span>
              </Link>
              <a
                href="https://t.me/pixelpoplk"
                target="_blank"
                rel="noopener noreferrer"
                className="hidden sm:flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-bold text-white bg-[#0088cc] hover:bg-[#0077b5] transition-all shadow-md active:scale-95"
                title="Join our official Telegram Channel"
              >
                <svg className="h-3.5 w-3.5 fill-current" viewBox="0 0 24 24">
                  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm4.64 6.8c-.15 1.58-.8 5.42-1.13 7.19-.14.75-.42 1-.68 1.03-.58.05-1.02-.38-1.58-.75-.88-.58-1.38-.94-2.23-1.5-.99-.65-.35-1.01.22-1.59.15-.15 2.71-2.48 2.76-2.69a.2.2 0 00-.05-.18c-.06-.05-.14-.03-.21-.02-.09.02-1.49.95-4.22 2.79-.4.27-.76.41-1.08.4-.36-.01-1.04-.2-1.55-.37-.63-.2-1.12-.31-1.08-.66.02-.18.27-.36.75-.55 2.92-1.27 4.86-2.11 5.83-2.51 2.78-1.16 3.35-1.36 3.73-1.36.08 0 .27.02.39.12.1.08.13.19.14.27-.01.06.01.24 0 .38z"/>
                </svg>
                <span>Telegram</span>
              </a>

              {/* Theme toggle */}
              <button
                onClick={toggleTheme}
                title={theme === 'dark' ? 'Switch to Light Mode' : 'Switch to Dark Mode'}
                className="p-2 rounded-xl transition-all hover:scale-105 active:scale-95 cursor-pointer"
                style={{
                  background: 'var(--color-bg-card)',
                  border: '1px solid var(--color-border)',
                  color: 'var(--color-text-muted)',
                }}
                aria-label="Toggle theme"
              >
                {theme === 'dark' ? <Sun className="h-4 w-4 text-amber-400" /> : <Moon className="h-4 w-4 text-blue-500" />}
              </button>
            </div>

          </div>

          {/* Mobile Live Instant Search */}
          <div className="md:hidden pb-3 pt-1">
            <LiveSearch placeholder="Search movies, TV shows…" isMobile={true} />
          </div>
        </div>
      </nav>

      {/* Sidebar Drawer */}
      <Sidebar isOpen={isSidebarOpen} onClose={() => setIsSidebarOpen(false)} />
    </>
  );
}
