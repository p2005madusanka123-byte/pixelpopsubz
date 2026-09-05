'use client';

import { useState } from 'react';
import { Send, FileVideo, ShieldCheck } from 'lucide-react';

interface TelegramLink {
  id: string;
  quality: string;
  size: string | null;
  downloadUrl: string;
  clicksCount: number;
}

interface TelegramLinkListProps {
  links: TelegramLink[];
}

export default function TelegramLinkList({ links }: TelegramLinkListProps) {
  const [items, setItems] = useState<TelegramLink[]>(links);

  const handleClick = async (id: string, url: string) => {
    try {
      const res = await fetch(`/api/telegram-links/${id}/click`, { method: 'POST' });
      if (res.ok) {
        const data = await res.json();
        setItems(prev => prev.map(item => item.id === id ? { ...item, clicksCount: data.clicksCount } : item));
      }
    } catch {}
    window.open(url, '_blank', 'noopener,noreferrer');
  };

  if (items.length === 0) {
    return (
      <div className="rounded-xl p-6 text-center text-sm" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text-muted)' }}>
        No Telegram download links available yet.
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {items.map(link => (
        <div
          key={link.id}
          className="nf-list-card nf-list-card-telegram rounded-xl p-4 flex items-center justify-between gap-4"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 rounded-lg bg-sky-500/10 text-sky-400 shrink-0">
              <FileVideo className="h-5 w-5" />
            </div>
            <div>
              <div className="flex items-center gap-2 flex-wrap">
                <span className="font-bold text-sm" style={{ color: 'var(--color-text)' }}>{link.quality}</span>
                {link.size && (
                  <span className="text-xs px-2 py-0.5 rounded-full font-medium" style={{ background: 'var(--color-bg-elevated)', color: 'var(--color-text-muted)' }}>
                    {link.size}
                  </span>
                )}
              </div>
              <p className="text-xs mt-0.5 flex items-center gap-1" style={{ color: 'var(--color-text-muted)' }}>
                <ShieldCheck className="h-3.5 w-3.5 text-green-500" />
                Verified • {link.clicksCount} click{link.clicksCount !== 1 ? 's' : ''}
              </p>
            </div>
          </div>

          <button
            onClick={() => handleClick(link.id, link.downloadUrl)}
            className="nf-btn-telegram flex items-center gap-1.5 text-sm font-bold text-white px-4 py-2 rounded-lg shrink-0"
          >
            <Send className="h-4 w-4" />
            Open Telegram
          </button>
        </div>
      ))}
    </div>
  );
}
