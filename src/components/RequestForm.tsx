'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { PlusCircle, Loader2, LogIn } from 'lucide-react';

export default function RequestForm() {
  const router = useRouter();
  const supabase = createClient();
  const [user, setUser] = useState<any>(null);
  const [title, setTitle] = useState('');
  const [type, setType] = useState('MOVIE');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
    });
  }, [supabase.auth]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim()) return;
    setLoading(true);
    setError(null);
    setSuccess(false);
    try {
      const res = await fetch('/api/requests', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: title.trim(), type }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to submit request');
      setSuccess(true);
      setTitle('');
      router.refresh();
    } catch (err: any) {
      setError(err.message || 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  if (!user) {
    return (
      <div
        className="rounded-2xl p-6 text-center space-y-4"
        style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
      >
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          You must be signed in to submit a subtitle request.
        </p>
        <a
          href="/admin/login?redirect=/request"
          className="nf-btn-primary inline-flex"
        >
          <LogIn className="h-4 w-4" />
          Sign In to Request
        </a>
      </div>
    );
  }

  return (
    <div
      className="rounded-2xl p-6 space-y-5"
      style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}
    >
      <h3 className="font-bold text-lg flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
        <PlusCircle className="h-5 w-5 text-[#E50914]" />
        Request Subtitles
      </h3>

      {success && (
        <div className="bg-green-500/10 border border-green-500/30 text-green-400 p-3 rounded-lg text-xs font-semibold">
          ✓ Request submitted successfully!
        </div>
      )}
      {error && (
        <div className="bg-red-500/10 border border-red-500/30 text-red-400 p-3 rounded-lg text-xs font-semibold">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
            Title
          </label>
          <input
            type="text"
            required
            value={title}
            onChange={e => setTitle(e.target.value)}
            placeholder="e.g. Deadpool & Wolverine"
            className="nf-input"
          />
        </div>

        <div>
          <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
            Type
          </label>
          <select
            value={type}
            onChange={e => setType(e.target.value)}
            className="nf-input"
          >
            <option value="MOVIE">Movie</option>
            <option value="TV_SHOW">TV Show / Series</option>
          </select>
        </div>

        <button
          type="submit"
          disabled={loading || !title.trim()}
          className="nf-btn-primary w-full justify-center disabled:opacity-40 disabled:cursor-not-allowed disabled:transform-none"
        >
          {loading ? (
            <><Loader2 className="h-4 w-4 animate-spin" /><span>Submitting…</span></>
          ) : (
            <span>Submit Request</span>
          )}
        </button>
      </form>
    </div>
  );
}
