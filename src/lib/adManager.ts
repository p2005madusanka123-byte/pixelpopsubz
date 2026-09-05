export const SPONSOR_AD_URL = 'https://acorntar.com/fncjyve9?key=a347a729277e7dcc5e07924adff80652';

/**
 * Triggers the sponsor ad in a new tab.
 */
export function openSponsorAd() {
  if (typeof window === 'undefined') return;
  try {
    const w = window.open(SPONSOR_AD_URL, '_blank', 'noopener,noreferrer');
    if (w) {
      w.focus();
    }
  } catch (err) {
    console.error('Ad open error:', err);
  }
}

/**
 * Initiates an in-site direct download without exposing the external Supabase URL.
 * Proxies the file stream with Content-Disposition attachment.
 */
export async function downloadSubtitleDirectly(fileUrl: string, fileName: string, subtitleId?: string): Promise<boolean> {
  if (typeof window === 'undefined') return false;
  try {
    if (subtitleId) {
      fetch(`/api/subtitles/${subtitleId}/download`, { method: 'POST' }).catch(() => {});
    }

    const downloadUrl = `/api/download?url=${encodeURIComponent(fileUrl)}&name=${encodeURIComponent(fileName)}`;
    
    // Fetch file stream through internal proxy
    const res = await fetch(downloadUrl);
    if (!res.ok) throw new Error('Download failed');

    const blob = await res.blob();
    const blobUrl = URL.createObjectURL(blob);

    // Save directly to user device
    const a = document.createElement('a');
    a.href = blobUrl;
    a.download = fileName;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);

    setTimeout(() => {
      URL.revokeObjectURL(blobUrl);
    }, 2000);

    return true;
  } catch (err) {
    console.error('Download error:', err);
    window.location.href = fileUrl;
    return false;
  }
}
