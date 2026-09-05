import Link from 'next/link';
import { Film } from 'lucide-react';

export default function Footer() {
  return (
    <footer
      className="py-8 mt-auto text-sm"
      style={{ borderTop: '1px solid var(--color-border)', background: 'var(--color-bg)', color: 'var(--color-text-muted)' }}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row items-center justify-between gap-6">

          {/* Brand */}
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl overflow-hidden flex items-center justify-center shadow-lg shadow-red-900/20 bg-black/40 border border-white/10">
              <img src="/logo.png" alt="PixelSubzLk Logo" className="w-full h-full object-cover" />
            </div>
            <div>
              <span className="font-black text-base" style={{ color: 'var(--color-text)' }}>
                PixelSubz<span className="text-[#E50914]">Lk</span>
              </span>
              <p className="text-[10px] text-neutral-500 font-medium">Community Subtitle Archive</p>
            </div>
          </div>

          {/* Links */}
          <div className="flex flex-col items-center md:items-end gap-3">
            <div className="flex flex-wrap justify-center md:justify-end gap-5 text-sm font-semibold">
              <Link href="/" className="transition-colors hover:text-[#E50914]">Home</Link>
              <Link href="/?type=MOVIE" className="transition-colors hover:text-[#E50914]">Movies</Link>
              <Link href="/?type=TV_SHOW" className="transition-colors hover:text-[#E50914]">TV Series</Link>
              <Link href="/request" className="transition-colors hover:text-[#E50914]">Request Subtitles</Link>
              <a
                href="https://t.me/pixelpoplk"
                target="_blank"
                rel="noopener noreferrer"
                className="text-sky-400 hover:text-sky-300 flex items-center gap-1 transition-colors"
                title="Official Telegram Channel"
              >
                <svg className="h-3.5 w-3.5 fill-current" viewBox="0 0 24 24">
                  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm4.64 6.8c-.15 1.58-.8 5.42-1.13 7.19-.14.75-.42 1-.68 1.03-.58.05-1.02-.38-1.58-.75-.88-.58-1.38-.94-2.23-1.5-.99-.65-.35-1.01.22-1.59.15-.15 2.71-2.48 2.76-2.69a.2.2 0 00-.05-.18c-.06-.05-.14-.03-.21-.02-.09.02-1.49.95-4.22 2.79-.4.27-.76.41-1.08.4-.36-.01-1.04-.2-1.55-.37-.63-.2-1.12-.31-1.08-.66.02-.18.27-.36.75-.55 2.92-1.27 4.86-2.11 5.83-2.51 2.78-1.16 3.35-1.36 3.73-1.36.08 0 .27.02.39.12.1.08.13.19.14.27-.01.06.01.24 0 .38z"/>
                </svg>
                <span>Telegram</span>
              </a>
              <a
                href="https://www.facebook.com/share/19PMibMoPL/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-500 hover:text-blue-400 flex items-center gap-1 transition-colors"
                title="Official Facebook Page"
              >
                <svg className="h-3.5 w-3.5 fill-current" viewBox="0 0 24 24">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                </svg>
                <span>Facebook</span>
              </a>
              <a href="mailto:dmca@pixelsubz.lk" className="text-[#E50914] hover:underline flex items-center gap-1">
                DMCA &amp; Copyright Notice
              </a>
            </div>
            <div className="max-w-xl p-3.5 rounded-xl bg-neutral-900/50 border border-neutral-800/80 text-[11px] leading-relaxed text-neutral-400 text-center md:text-right space-y-1">
              <p>
                <strong>Legal Disclaimer:</strong> PixelSubzLk does not host, stream, rip, copy, or upload any copyrighted media or video files on its servers. We only provide text-based subtitles (.srt) created by the community for educational &amp; accessibility purposes under Fair Use.
              </p>
              <p>
                All external links point strictly to third-party public platforms. For DMCA takedown requests or copyright concerns, contact: <a href="mailto:dmca@pixelsubz.lk" className="text-[#E50914] font-mono font-bold hover:underline">dmca@pixelsubz.lk</a>.
              </p>
            </div>
          </div>
        </div>

        <div className="mt-6 pt-4 text-center text-xs flex flex-col sm:flex-row items-center justify-between gap-2" style={{ borderTop: '1px solid var(--color-border)', color: 'var(--color-text-subtle)' }}>
          <span>&copy; {new Date().getFullYear()} PixelSubzLk. All rights reserved.</span>
          <span>Educational Sinhala Subtitle Indexing Platform.</span>
        </div>
      </div>
    </footer>
  );
}
