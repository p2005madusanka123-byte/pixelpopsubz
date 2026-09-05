'use client';

import { useState } from 'react';
import { Sparkles, ExternalLink } from 'lucide-react';

interface AdSlotProps {
  slot: 'top-banner' | 'in-content' | 'sidebar' | 'footer-banner' | 'sponsor-native';
  className?: string;
}

export default function AdSlot({ slot, className = '' }: AdSlotProps) {
  // Configurable ad slots for High-CPM Ad Networks (Google AdSense, Adsterra, PropellerAds, Monetag, etc.)
  const [adLoaded] = useState(true);

  if (slot === 'top-banner') {
    return (
      <aside aria-label="Advertisement Banner" className={`w-full flex flex-col items-center justify-center my-4 overflow-hidden ${className}`}>
        <div className="w-full max-w-[728px] min-h-[90px] rounded-xl border border-dashed border-neutral-800 bg-neutral-900/40 p-2 flex flex-col items-center justify-center text-center relative">
          <span className="text-[9px] uppercase tracking-widest text-neutral-600 font-bold mb-1">Sponsored Advertisement</span>
          <div className="flex items-center gap-3 text-neutral-400 text-xs">
            <Sparkles className="w-4 h-4 text-amber-500 animate-pulse" />
            <span className="font-semibold text-neutral-300">High-Speed Cloud Storage &amp; Streaming Fast Premium VPN</span>
            <a
              href="https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652"
              target="_blank"
              rel="noopener noreferrer"
              className="px-2.5 py-1 rounded bg-[#E50914] text-white text-[11px] font-bold hover:bg-red-700 transition-colors flex items-center gap-1"
            >
              <span>Explore</span>
              <ExternalLink className="w-3 h-3" />
            </a>
          </div>
        </div>
      </aside>
    );
  }

  if (slot === 'in-content') {
    return (
      <aside aria-label="Sponsored Content" className={`w-full my-6 flex flex-col items-center justify-center ${className}`}>
        <div className="w-full max-w-[650px] min-h-[140px] rounded-2xl border border-neutral-800 bg-gradient-to-r from-neutral-900/90 to-neutral-950 p-4 sm:p-5 flex flex-col sm:flex-row items-center justify-between gap-4 shadow-xl">
          <div className="space-y-1 text-center sm:text-left">
            <span className="text-[9px] uppercase tracking-widest text-neutral-500 font-bold">Premium Sponsor</span>
            <h4 className="text-sm font-bold text-white flex items-center gap-1.5 justify-center sm:justify-start">
              ⚡ Ultra-Fast 4K Movie &amp; Subtitle Streaming
            </h4>
            <p className="text-xs text-neutral-400 max-w-md leading-relaxed">
              Watch latest movies and TV series with zero buffering &amp; 100% ad-free experience.
            </p>
          </div>
          <a
            href="https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652"
            target="_blank"
            rel="noopener noreferrer"
            className="shrink-0 px-4 py-2.5 rounded-xl bg-gradient-to-r from-amber-500 to-amber-600 hover:from-amber-600 hover:to-amber-700 text-black font-black text-xs shadow-lg transition-all"
          >
            Claim Access ↗
          </a>
        </div>
      </aside>
    );
  }

  if (slot === 'sponsor-native') {
    return (
      <aside aria-label="Recommended Sponsor" className={`w-full rounded-2xl border border-neutral-800 bg-neutral-900/50 p-4 space-y-2 ${className}`}>
        <div className="flex items-center justify-between text-[10px] text-neutral-500 font-bold uppercase tracking-wider">
          <span>Official Network Sponsor</span>
          <span className="text-amber-500 font-semibold">Verified Safe</span>
        </div>
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-[#E50914]/20 text-[#E50914] flex items-center justify-center shrink-0 font-black text-sm">
            SRT
          </div>
          <div className="min-w-0 flex-1">
            <p className="text-xs font-bold text-white truncate">Unlimited High-Speed Media Downloader</p>
            <p className="text-[11px] text-neutral-400 truncate">Download movies, subs, and Telegram files up to 1Gbps</p>
          </div>
          <a
            href="https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652"
            target="_blank"
            rel="noopener noreferrer"
            className="px-3 py-1.5 rounded-lg bg-neutral-800 hover:bg-neutral-700 text-white font-bold text-xs shrink-0 transition-colors"
          >
            Start
          </a>
        </div>
      </aside>
    );
  }

  if (slot === 'footer-banner') {
    return (
      <aside aria-label="Bottom Sponsor" className={`w-full my-6 flex justify-center ${className}`}>
        <div className="w-full max-w-[728px] min-h-[60px] rounded-xl border border-neutral-800/80 bg-neutral-900/30 p-2.5 flex items-center justify-between text-xs text-neutral-400">
          <div className="flex items-center gap-2">
            <span className="text-[9px] uppercase tracking-wider font-bold px-1.5 py-0.5 rounded bg-neutral-800 text-neutral-400">Ad</span>
            <span>Looking for High-Speed Direct Subtitle &amp; Video Streams?</span>
          </div>
          <a
            href="https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652"
            target="_blank"
            rel="noopener noreferrer"
            className="text-[#E50914] font-bold hover:underline"
          >
            Learn More →
          </a>
        </div>
      </aside>
    );
  }

  return null;
}
