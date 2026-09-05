'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { Film, Lock, Mail, Loader2, ArrowRight, ShieldAlert } from 'lucide-react';

export default function AdminLoginForm() {
  const router = useRouter();
  const supabase = createClient();

  const [redirect, setRedirect] = useState('/admin');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search);
      const red = params.get('redirect');
      if (red) setRedirect(red);
    }

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user) {
        router.push(redirect);
      }
    });
  }, [supabase.auth, router, redirect]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) return;
    setLoading(true);
    setError(null);

    try {
      const { data, error: signInError } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      });

      if (signInError) {
        if (signInError.message.toLowerCase().includes('invalid login credentials')) {
          throw new Error('Email හෝ Password වැරදියි. කරුණාකර ඔබගේ Supabase Dashboard හි Authentication > Users යටතේ සෑදූ නිවැරදි Admin විස්තර ඇතුළත් කරන්න.');
        }
        throw signInError;
      }

      if (data.session) {
        router.push(redirect);
        router.refresh();
      }
    } catch (err: any) {
      setError(err.message || 'Authentication failed. Authorized administrators only.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      className="w-full max-w-md rounded-3xl p-6 sm:p-8 shadow-2xl space-y-6 border transition-all"
      style={{ background: 'var(--color-bg-card)', borderColor: 'var(--color-border)' }}
    >
      <div className="flex flex-col items-center gap-3 text-center">
        <div className="w-14 h-14 bg-[#E50914] rounded-2xl flex items-center justify-center shadow-xl shadow-red-900/30">
          <Film className="h-7 w-7 text-white" />
        </div>
        <div>
          <h1 className="text-xl sm:text-2xl font-black" style={{ color: 'var(--color-text)' }}>
            PixelSubz<span className="text-[#E50914]">Lk</span> Admin Portal
          </h1>
          <p className="text-xs mt-1" style={{ color: 'var(--color-text-muted)' }}>
            Restricted area. Authorized administrators only.
          </p>
        </div>
      </div>

      <div className="p-3 rounded-xl bg-red-500/10 border border-red-500/20 text-red-300 text-xs flex gap-2.5 items-start">
        <ShieldAlert className="w-4 h-4 shrink-0 text-red-400 mt-0.5" />
        <p className="leading-relaxed text-[11px]">
          මෙම පද්ධතියට ඇතුල් විය හැක්කේ Supabase Dashboard හි Authentication යටතේ ලියාපදිංචි කළ නිල පරිපාලකවරුන්ට පමණි.
        </p>
      </div>

      {error && (
        <div className="bg-red-500/10 border border-red-500/30 text-red-400 p-3.5 rounded-xl text-xs leading-relaxed font-semibold">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-xs font-bold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
            Admin Email Address
          </label>
          <div className="relative">
            <input
              type="email"
              required
              value={email}
              onChange={e => setEmail(e.target.value)}
              placeholder="admin@pixelsubz.lk"
              className="nf-input nf-input-icon-left h-11 text-sm"
            />
            <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 pointer-events-none" style={{ color: 'var(--color-text-subtle)' }} />
          </div>
        </div>

        <div>
          <label className="block text-xs font-bold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
            Password
          </label>
          <div className="relative">
            <input
              type="password"
              required
              value={password}
              onChange={e => setPassword(e.target.value)}
              placeholder="••••••••"
              className="nf-input nf-input-icon-left h-11 text-sm"
            />
            <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 pointer-events-none" style={{ color: 'var(--color-text-subtle)' }} />
          </div>
        </div>

        <button
          type="submit"
          disabled={loading || !email || !password}
          className="nf-btn-primary w-full justify-center h-11 text-sm font-black disabled:opacity-40 disabled:cursor-not-allowed disabled:transform-none shadow-lg shadow-red-900/20 cursor-pointer"
        >
          {loading ? (
            <><Loader2 className="h-4 w-4 animate-spin" /><span>Sign in වෙමින් පවතී…</span></>
          ) : (
            <><span>Sign In / ඇතුල් වන්න</span><ArrowRight className="h-4 w-4" /></>
          )}
        </button>
      </form>
    </div>
  );
}
