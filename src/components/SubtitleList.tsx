'use client';

import { useState } from 'react';
import { Download, FileText, Calendar, User } from 'lucide-react';

interface Subtitle {
  id: string;
  language: string;
  fileUrl: string;
  fileName: string;
  downloadsCount: number;
  createdAt: Date;
  uploader: { email: string };
}

interface SubtitleListProps {
  subtitles: Subtitle[];
}

export default function SubtitleList({ subtitles }: SubtitleListProps) {
  const [items, setItems] = useState<Subtitle[]>(subtitles);

  const handleDownload = async (id: string, url: string) => {
    try {
      const res = await fetch(`/api/subtitles/${id}/download`, { method: 'POST' });
      if (res.ok) {
        const data = await res.json();
        setItems(prev => prev.map(item => item.id === id ? { ...item, downloadsCount: data.downloadsCount } : item));
      }
    } catch {}
    const a = document.createElement('a');
    a.href = url;
    a.setAttribute('download', '');
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  };

  if (items.length === 0) {
    return (
      <div className="rounded-xl p-6 text-center text-sm" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text-muted)' }}>
        No Sinhala subtitles uploaded yet.
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {items.map(sub => (
        <div
          key={sub.id}
          className="nf-list-card rounded-xl p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4"
        >
          <div className="flex items-start gap-3">
            <div className="p-2 rounded-lg" style={{ background: 'rgba(229,9,20,0.1)', color: '#E50914' }}>
              <FileText className="h-5 w-5" />
            </div>
            <div className="space-y-1">
              <h4 className="text-sm font-bold truncate max-w-xs sm:max-w-sm" style={{ color: 'var(--color-text)' }} title={sub.fileName}>
                {sub.fileName}
              </h4>
              <div className="flex flex-wrap items-center gap-3 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                <span className="px-2 py-0.5 rounded text-[10px] font-bold uppercase" style={{ background: 'var(--color-bg-elevated)', color: 'var(--color-text)' }}>
                  {sub.language}
                </span>
                <span className="flex items-center gap-1">
                  <User className="h-3 w-3" />
                  {sub.uploader.email.split('@')[0]}
                </span>
                <span className="flex items-center gap-1">
                  <Calendar className="h-3 w-3" />
                  {new Date(sub.createdAt).toLocaleDateString()}
                </span>
                <span>{sub.downloadsCount} download{sub.downloadsCount !== 1 ? 's' : ''}</span>
              </div>
            </div>
          </div>

          <button
            onClick={() => handleDownload(sub.id, sub.fileUrl)}
            className="nf-btn-primary text-sm shrink-0"
          >
            <Download className="h-4 w-4" />
            Download
          </button>
        </div>
      ))}
    </div>
  );
}
