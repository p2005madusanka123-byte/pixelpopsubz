'use client';

import { useState, useEffect, useRef } from 'react';
import { Download, Send, ExternalLink, X, Clock, CheckCircle2, AlertTriangle, Sparkles, RefreshCw, ShieldAlert } from 'lucide-react';

const AD_URL = 'https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652';
const REQUIRED_SECONDS = 5;
const REQUIRED_MS = REQUIRED_SECONDS * 1000;

export interface DownloadItem {
  type: 'SUBTITLE' | 'TELEGRAM';
  title?: string;
  fileName?: string;
  version?: string;
  quality?: string;
  size?: string;
  url: string;
}

interface DownloadAdModalProps {
  item: DownloadItem | null;
  isOpen: boolean;
  onClose: () => void;
}

type ModalStep = 'INSTRUCTIONS' | 'ACTIVE_ON_AD' | 'INCOMPLETE_WARNING' | 'READY';

export default function DownloadAdModal({ item, isOpen, onClose }: DownloadAdModalProps) {
  const [step, setStep] = useState<ModalStep>('INSTRUCTIONS');
  const [accumulatedMs, setAccumulatedMs] = useState(0);
  const [isTabHidden, setIsTabHidden] = useState(false);

  const leftTabTimeRef = useRef<number | null>(null);
  const accumulatedMsRef = useRef<number>(0);
  const stepRef = useRef<ModalStep>('INSTRUCTIONS');

  // Keep refs in sync
  useEffect(() => {
    accumulatedMsRef.current = accumulatedMs;
  }, [accumulatedMs]);

  useEffect(() => {
    stepRef.current = step;
  }, [step]);

  // Reset state when opened
  useEffect(() => {
    if (isOpen) {
      setStep('INSTRUCTIONS');
      setAccumulatedMs(0);
      accumulatedMsRef.current = 0;
      leftTabTimeRef.current = null;
    }
  }, [isOpen, item]);

  // Handle Tab Visibility & Focus changes to strictly track time away on the ad
  useEffect(() => {
    if (!isOpen) return;

    const handleVisibilityChange = () => {
      const isHidden = document.visibilityState === 'hidden';
      setIsTabHidden(isHidden);

      if (stepRef.current === 'ACTIVE_ON_AD') {
        if (isHidden) {
          // User switched away to the ad tab
          leftTabTimeRef.current = Date.now();
        } else {
          // User came back to our tab
          if (leftTabTimeRef.current) {
            const elapsed = Date.now() - leftTabTimeRef.current;
            leftTabTimeRef.current = null;
            const newTotal = accumulatedMsRef.current + elapsed;

            if (newTotal >= REQUIRED_MS) {
              setAccumulatedMs(REQUIRED_MS);
              accumulatedMsRef.current = REQUIRED_MS;
              setStep('READY');
            } else {
              setAccumulatedMs(newTotal);
              accumulatedMsRef.current = newTotal;
              setStep('INCOMPLETE_WARNING');
            }
          }
        }
      }
    };

    const handleWindowBlur = () => {
      if (stepRef.current === 'ACTIVE_ON_AD' && !leftTabTimeRef.current) {
        leftTabTimeRef.current = Date.now();
      }
    };

    const handleWindowFocus = () => {
      if (stepRef.current === 'ACTIVE_ON_AD' && leftTabTimeRef.current) {
        const elapsed = Date.now() - leftTabTimeRef.current;
        leftTabTimeRef.current = null;
        const newTotal = accumulatedMsRef.current + elapsed;

        if (newTotal >= REQUIRED_MS) {
          setAccumulatedMs(REQUIRED_MS);
          accumulatedMsRef.current = REQUIRED_MS;
          setStep('READY');
        } else {
          setAccumulatedMs(newTotal);
          accumulatedMsRef.current = newTotal;
          setStep('INCOMPLETE_WARNING');
        }
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    window.addEventListener('blur', handleWindowBlur);
    window.addEventListener('focus', handleWindowFocus);

    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange);
      window.removeEventListener('blur', handleWindowBlur);
      window.removeEventListener('focus', handleWindowFocus);
    };
  }, [isOpen]);

  if (!isOpen || !item) return null;

  const isTg = item.type === 'TELEGRAM';
  const remainingMs = Math.max(0, REQUIRED_MS - accumulatedMs);
  const remainingSec = Math.ceil(remainingMs / 1000);
  const completedSec = Math.floor(accumulatedMs / 1000);
  const progressPercent = Math.min(100, Math.round((accumulatedMs / REQUIRED_MS) * 100));

  const handleStartOrResumeAd = () => {
    leftTabTimeRef.current = Date.now();
    setStep('ACTIVE_ON_AD');

    if (typeof window !== 'undefined') {
      window.open(AD_URL, '_blank', 'noopener,noreferrer');
    }
  };

  const handleFinalDownload = () => {
    if (typeof window !== 'undefined' && item.url) {
      if (isTg) {
        window.open(item.url, '_blank', 'noopener,noreferrer');
      } else {
        const link = document.createElement('a');
        link.href = item.url;
        link.download = item.fileName || 'subtitle.zip';
        link.target = '_blank';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }
    }
    onClose();
  };

  return (
    <div className="fixed inset-0 z-[999] flex items-center justify-center p-4 bg-black/85 backdrop-blur-md animate-in fade-in duration-200">
      <div
        className="relative w-full max-w-lg rounded-2xl shadow-2xl overflow-hidden text-left border transition-all"
        style={{
          background: 'var(--color-bg-card, #141414)',
          borderColor: 'var(--color-border, #262626)',
          color: 'var(--color-text, #ffffff)',
        }}
      >
        {/* Header with Close */}
        <div className="flex items-center justify-between p-4 sm:p-5 border-b" style={{ borderColor: 'var(--color-border, #262626)' }}>
          <div className="flex items-center gap-2.5">
            <div
              className="w-9 h-9 rounded-xl flex items-center justify-center font-bold text-white shadow-lg"
              style={{ background: isTg ? '#0284c7' : '#E50914' }}
            >
              {isTg ? <Send className="w-4 h-4" /> : <Download className="w-4 h-4" />}
            </div>
            <div>
              <h3 className="text-base font-bold line-clamp-1">
                {isTg ? 'Telegram Copy' : 'Direct Subtitle'}
              </h3>
              <p className="text-[11px] text-neutral-400 line-clamp-1">
                {item.fileName || item.quality || item.title || 'PixelSubzLk Download'}
              </p>
            </div>
          </div>

          <button
            onClick={onClose}
            className="p-1.5 rounded-lg text-neutral-400 hover:text-white hover:bg-neutral-800 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Modal Body */}
        <div className="p-5 sm:p-6 space-y-5">
          {/* STEP 1: INITIAL INSTRUCTIONS */}
          {step === 'INSTRUCTIONS' && (
            <div className="space-y-4">
              <div className="p-3.5 rounded-xl bg-amber-500/10 border border-amber-500/20 text-amber-300 text-xs flex gap-2.5 items-start">
                <ShieldAlert className="w-5 h-5 shrink-0 text-amber-400 mt-0.5" />
                <div className="space-y-1">
                  <p className="font-bold text-sm">බාගත කරන්නේ කෙසේද? / How to Download:</p>
                  <p className="text-[12px] text-neutral-300 leading-relaxed">
                    🇱🇰 <strong>සිංහල:</strong> මෙම ගොනුව ලබා ගැනීමට ඔබ අපගේ අනුග්‍රාහක වෙබ් පිටුවේ (Sponsor Tab) <strong>අනිවාර්යයෙන්ම තත්පර 5ක්</strong> රැඳී සිටිය යුතුය. <strong>&quot;Continue / ඉදිරියට යන්න&quot;</strong> ක්ලික් කළ පසු එය අලුත් Tab එකක විවෘත වේ.
                  </p>
                  <p className="text-[11px] text-neutral-400 leading-relaxed pt-1">
                    🇬🇧 <strong>English:</strong> You must stay on the sponsor page for <strong>5 full seconds</strong>. Click &quot;Continue&quot; to open the sponsor tab.
                  </p>
                </div>
              </div>

              {/* Item Preview */}
              <div className="p-3 rounded-xl bg-neutral-900/60 border border-neutral-800 space-y-1.5 text-xs">
                <div className="flex justify-between text-neutral-400">
                  <span>ගොනුව / File:</span>
                  <span className="font-semibold text-white truncate max-w-[240px]">
                    {item.fileName || item.quality || item.title}
                  </span>
                </div>
                {item.version && (
                  <div className="flex justify-between text-neutral-400">
                    <span>Quality / Version:</span>
                    <span className="font-semibold text-neutral-200">{item.version}</span>
                  </div>
                )}
                {item.size && (
                  <div className="flex justify-between text-neutral-400">
                    <span>Size:</span>
                    <span className="font-semibold text-neutral-200">{item.size}</span>
                  </div>
                )}
              </div>

              {/* Buttons */}
              <div className="flex flex-col sm:flex-row gap-2.5 pt-1">
                <button
                  type="button"
                  onClick={handleStartOrResumeAd}
                  className="flex-1 py-3.5 px-4 rounded-xl font-black text-sm text-white flex items-center justify-center gap-2 shadow-lg hover:scale-[1.02] active:scale-95 transition-all"
                  style={{ background: '#E50914' }}
                >
                  <Sparkles className="w-4 h-4" />
                  Continue / ඉදිරියට යන්න (5s Ad)
                </button>
                <button
                  type="button"
                  onClick={onClose}
                  className="py-3.5 px-4 rounded-xl font-bold text-xs text-neutral-400 hover:text-white bg-neutral-800/80 hover:bg-neutral-800 transition-colors"
                >
                  Cancel / අවලංගු කරන්න
                </button>
              </div>
            </div>
          )}

          {/* STEP 2: ACTIVE ON AD (User is on the sponsor tab) */}
          {step === 'ACTIVE_ON_AD' && (
            <div className="py-4 text-center space-y-5">
              <div className="relative inline-flex items-center justify-center">
                <div className="w-20 h-20 rounded-full border-4 border-red-500/20 border-t-[#E50914] animate-spin" />
                <span className="absolute font-black text-2xl text-white">
                  {remainingSec}s
                </span>
              </div>

              <div className="space-y-1.5">
                <h4 className="font-black text-base text-white">
                  දැන්වීම් පිටුවේ තත්පර {remainingSec}ක් රැඳී සිටින්න...
                </h4>
                <p className="text-xs text-neutral-400 max-w-sm mx-auto">
                  Please keep the sponsor tab open for {remainingSec} more seconds. The download will unlock when you return!
                </p>
              </div>

              {/* Progress Bar */}
              <div className="w-full bg-neutral-800 h-2.5 rounded-full overflow-hidden">
                <div
                  className="bg-[#E50914] h-full transition-all duration-300 rounded-full"
                  style={{ width: `${progressPercent}%` }}
                />
              </div>

              <div className="p-3 rounded-xl bg-neutral-900/90 border border-neutral-800 text-[12px] text-neutral-300">
                💡 අනුග්‍රාහක වෙබ් පිටුව (Sponsor Tab) විවෘතව තබාගෙන තත්පර {remainingSec} අවසන් වූ පසු මෙම Tab එකට පැමිණෙන්න.
              </div>
            </div>
          )}

          {/* STEP 3: INCOMPLETE WARNING (User came back too early!) */}
          {step === 'INCOMPLETE_WARNING' && (
            <div className="space-y-4">
              <div className="p-4 rounded-2xl bg-red-500/10 border border-red-500/30 text-red-300 space-y-2">
                <div className="flex items-center gap-2 text-red-400 font-black text-sm">
                  <AlertTriangle className="w-5 h-5 shrink-0" />
                  <span>තත්පර 5 සම්පූර්ණ වී නැත! / Time Incomplete!</span>
                </div>
                <p className="text-xs text-neutral-200 leading-relaxed">
                  🇱🇰 ඔබ දැන්වීම් පිටුවේ රැඳී සිටියේ <strong>තත්පර {completedSec}ක්</strong> පමණි. Download එක Unlock වීමට තව <strong>තත්පර {remainingSec}ක්</strong> අනිවාර්යයෙන්ම දැන්වීම් පිටුවේ රැඳී සිටිය යුතුය.
                </p>
                <p className="text-[11px] text-neutral-400 leading-relaxed">
                  🇬🇧 You stayed on the sponsor page for only <strong>{completedSec}s</strong>. Please complete the remaining <strong>{remainingSec}s</strong> to unlock.
                </p>
              </div>

              {/* Progress Bar */}
              <div className="space-y-1">
                <div className="flex justify-between text-[11px] text-neutral-400 font-bold">
                  <span>ප්‍රගතිය / Progress: {completedSec}s / 5s</span>
                  <span className="text-[#E50914]">{progressPercent}%</span>
                </div>
                <div className="w-full bg-neutral-800 h-2.5 rounded-full overflow-hidden">
                  <div
                    className="bg-[#E50914] h-full transition-all duration-300 rounded-full"
                    style={{ width: `${progressPercent}%` }}
                  />
                </div>
              </div>

              {/* Action Buttons */}
              <div className="flex flex-col sm:flex-row gap-2.5 pt-2">
                <button
                  type="button"
                  onClick={handleStartOrResumeAd}
                  className="flex-1 py-3.5 px-4 rounded-xl font-black text-sm text-white flex items-center justify-center gap-2 shadow-xl hover:scale-[1.02] active:scale-95 transition-all"
                  style={{ background: '#E50914' }}
                >
                  <RefreshCw className="w-4 h-4 animate-spin" />
                  දැන්වීම වෙත යන්න (ඉතිරි {remainingSec}s සම්පූර්ණ කරන්න)
                </button>
                <button
                  type="button"
                  onClick={onClose}
                  className="py-3.5 px-4 rounded-xl font-bold text-xs text-neutral-400 hover:text-white bg-neutral-800/80 hover:bg-neutral-800 transition-colors"
                >
                  Cancel / අවලංගු කරන්න
                </button>
              </div>
            </div>
          )}

          {/* STEP 4: 5 SECONDS COMPLETED -> READY TO DOWNLOAD */}
          {step === 'READY' && (
            <div className="py-3 space-y-4 text-center">
              <div className="w-16 h-16 mx-auto rounded-full bg-emerald-500/10 border-2 border-emerald-500/30 flex items-center justify-center text-emerald-400 shadow-lg shadow-emerald-950/40">
                <CheckCircle2 className="w-9 h-9" />
              </div>

              <div className="space-y-1">
                <h4 className="font-black text-lg text-emerald-400">
                  ✅ තත්පර 5 සම්පූර්ණයි! / Download Ready!
                </h4>
                <p className="text-xs text-neutral-300 max-w-sm mx-auto">
                  ස්තූතියි! පහත <strong>&quot;Download Now / දැන් බාගත කරන්න&quot;</strong> බොත්තම ක්ලික් කර ඔබගේ ගොනුව ලබා ගන්න.
                </p>
              </div>

              <div className="flex flex-col sm:flex-row gap-2.5 pt-3">
                <button
                  type="button"
                  onClick={handleFinalDownload}
                  className="flex-1 py-3.5 px-4 rounded-xl font-black text-sm text-white flex items-center justify-center gap-2 shadow-xl bg-emerald-600 hover:bg-emerald-500 hover:scale-[1.02] active:scale-95 transition-all"
                >
                  <Download className="w-4 h-4" />
                  Download Now / දැන් බාගත කරන්න
                </button>
                <button
                  type="button"
                  onClick={onClose}
                  className="py-3.5 px-4 rounded-xl font-bold text-xs text-neutral-400 hover:text-white bg-neutral-800/80 hover:bg-neutral-800 transition-colors"
                >
                  Close / වසන්න
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
