'use client';

import { useEffect, useRef, useState } from 'react';

/**
 * ==============================================================================
 * 🎯 ACORNTAR / BANNER AD CONFIGURATION
 * ==============================================================================
 * ඔබට අවශ්‍ය විටෙක මෙහි ඇති 'key', 'width', 'height' පහසුවෙන් වෙනස් කරගත හැක.
 */
export const AD_CONFIGS = {
  // 300x250 Medium Rectangle (High-CPM for In-Content & Below Downloads)
  '300x250': {
    key: '8f20aa10628b81f1599f8608f3a83374',
    format: 'iframe',
    height: 250,
    width: 300,
  },
  // 160x300 Skyscraper / Vertical Banner (Sidebar or Mobile)
  '160x300': {
    key: '399fab0da57ef47c78efa4bbf8625b8b',
    format: 'iframe',
    height: 300,
    width: 160,
  },
};

interface AdBannerProps {
  unit?: '300x250' | '160x300';
  customKey?: string;
  className?: string;
}

export default function AdBanner({ unit = '300x250', customKey, className = '' }: AdBannerProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [mounted, setMounted] = useState(false);

  const config = AD_CONFIGS[unit] || AD_CONFIGS['300x250'];
  const adKey = customKey || config.key;
  const width = config.width;
  const height = config.height;

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!mounted || !containerRef.current) return;

    // Clear previous content
    containerRef.current.innerHTML = '';

    // Create an isolated iframe to guarantee zero document.write conflicts, fast loading & zero CLS
    const iframe = document.createElement('iframe');
    iframe.width = width.toString();
    iframe.height = height.toString();
    iframe.style.border = 'none';
    iframe.style.overflow = 'hidden';
    iframe.style.display = 'block';
    iframe.style.margin = '0 auto';
    iframe.setAttribute('scrolling', 'no');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('allowtransparency', 'true');
    iframe.setAttribute('loading', 'lazy');

    const adHtml = `<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body {
      margin: 0;
      padding: 0;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
      background: transparent;
    }
  </style>
</head>
<body>
  <script type="text/javascript">
    atOptions = {
      'key' : '${adKey}',
      'format' : 'iframe',
      'height' : ${height},
      'width' : ${width},
      'params' : {}
    };
  </script>
  <script type="text/javascript" src="https://acorntar.com/${adKey}/invoke.js"></script>
</body>
</html>`;

    containerRef.current.appendChild(iframe);

    try {
      const doc = iframe.contentWindow?.document || iframe.contentDocument;
      if (doc) {
        doc.open();
        doc.write(adHtml);
        doc.close();
      }
    } catch (e) {
      iframe.srcdoc = adHtml;
    }
  }, [mounted, adKey, width, height]);

  return (
    <div className={`w-full flex flex-col items-center justify-center my-6 overflow-hidden ${className}`}>
      <div
        className="relative flex flex-col items-center justify-center p-2 rounded-2xl transition-all"
        style={{
          minHeight: `${height + 26}px`,
          minWidth: `${Math.min(width, 320)}px`,
          background: 'rgba(255,255,255,0.02)',
          border: '1px dashed rgba(255,255,255,0.1)',
        }}
      >
        <span className="text-[9px] uppercase tracking-widest text-neutral-500 font-bold mb-1.5 select-none">
          Sponsored Advertisement
        </span>

        {/* Ad Container */}
        <div
          ref={containerRef}
          style={{ width: `${width}px`, height: `${height}px` }}
          className="flex items-center justify-center overflow-hidden rounded-xl"
        >
          {!mounted && (
            <div
              className="w-full h-full bg-neutral-900/40 rounded-xl animate-pulse flex items-center justify-center text-[10px] text-neutral-600"
            >
              Loading Ad…
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
