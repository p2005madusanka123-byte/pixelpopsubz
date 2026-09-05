'use client';

export const dynamic = 'force-dynamic';

import { useState, useEffect, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { Film, Lock, Mail, Loader2, ArrowRight } from 'lucide-react';
import Link from 'next/link';

function LoginFormContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirect = searchParams.get('redirect') || '/';
  
  const supabase = createClient();
  const [isSignUp, setIsSignUp] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  useEffect(() => {
    // Check if user is already logged in
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
    setSuccess(null);

    try {
      if (isSignUp) {
        const { data, error: signUpError } = await supabase.auth.signUp({
          email,
          password,
          options: {
            emailRedirectTo: `${window.location.origin}/auth/callback`,
          },
        });

        if (signUpError) throw signUpError;
        
        setSuccess('Registration successful! Please check your email inbox to confirm your account.');
        setEmail('');
        setPassword('');
      } else {
        const { data, error: signInError } = await supabase.auth.signInWithPassword({
          email,
          password,
        });

        if (signInError) throw signInError;
        
        router.push(redirect);
        router.refresh();
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred during authentication.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-full max-w-md bg-slate-900 border border-slate-800 rounded-2xl p-8 shadow-2xl space-y-6">
      
      {/* Brand logo & Header */}
      <div className="flex flex-col items-center text-center space-y-2">
        <div className="flex items-center space-x-2 text-primary font-bold text-2xl">
          <Film className="h-7 w-7 text-primary animate-pulse" />
          <span>SinhalaSub <span className="text-white font-light text-base bg-slate-800 px-2 py-0.5 rounded">Tele</span></span>
        </div>
        <h2 className="text-xl font-bold text-white tracking-tight">
          {isSignUp ? 'Create an account' : 'Sign in to your account'}
        </h2>
        <p className="text-xs text-slate-400">
          {isSignUp ? 'Join to request and upload subtitles' : 'Access your requests, dashboard and features'}
        </p>
      </div>

      {/* Message alerts */}
      {success && (
        <div className="bg-green-500/10 border border-green-500/30 text-green-400 p-3 rounded-lg text-xs font-semibold">
          {success}
        </div>
      )}
      {error && (
        <div className="bg-red-500/10 border border-red-500/30 text-red-400 p-3 rounded-lg text-xs font-semibold">
          {error}
        </div>
      )}

      {/* Credentials form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-xs font-semibold text-slate-400 mb-1.5 uppercase tracking-wider">
            Email Address
          </label>
          <div className="relative">
            <input
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
              className="w-full bg-slate-950 border border-slate-850 text-white rounded-lg px-4 py-2 pl-10 text-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all"
            />
            <Mail className="absolute left-3 top-2.5 h-4 w-4 text-slate-500" />
          </div>
        </div>

        <div>
          <label className="block text-xs font-semibold text-slate-400 mb-1.5 uppercase tracking-wider">
            Password
          </label>
          <div className="relative">
            <input
              type="password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
              className="w-full bg-slate-950 border border-slate-855 text-white rounded-lg px-4 py-2 pl-10 text-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all"
            />
            <Lock className="absolute left-3 top-2.5 h-4 w-4 text-slate-500" />
          </div>
        </div>

        <button
          type="submit"
          disabled={loading || !email || !password}
          className="w-full bg-primary hover:bg-amber-600 disabled:bg-slate-800 disabled:text-slate-500 disabled:scale-100 text-slate-950 font-bold py-2.5 px-4 rounded-lg text-sm transition-all hover:scale-102 flex items-center justify-center space-x-1.5 shadow-lg shadow-primary/10"
        >
          {loading ? (
            <>
              <Loader2 className="h-4 w-4 animate-spin" />
              <span>Please wait...</span>
            </>
          ) : (
            <>
              <span>{isSignUp ? 'Sign Up' : 'Sign In'}</span>
              <ArrowRight className="h-4 w-4" />
            </>
          )}
        </button>
      </form>

      {/* Switch auth mode link */}
      <div className="text-center pt-2">
        <button
          onClick={() => {
            setIsSignUp(!isSignUp);
            setError(null);
            setSuccess(null);
          }}
          className="text-xs text-amber-400 hover:underline font-semibold"
        >
          {isSignUp ? 'Already have an account? Sign In' : "Don't have an account? Sign Up"}
        </button>
      </div>

    </div>
  );
}

export default function LoginPage() {
  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-12 bg-[#0b0f19]">
      <Suspense fallback={
        <div className="flex flex-col items-center space-y-3">
          <Loader2 className="h-8 w-8 text-primary animate-spin" />
          <p className="text-slate-400 text-sm">Loading login portal...</p>
        </div>
      }>
        <LoginFormContent />
      </Suspense>
    </div>
  );
}
