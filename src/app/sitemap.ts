import { MetadataRoute } from 'next';
import { fetchMovies } from '@/lib/data';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
  const now = new Date();

  // 1. Core High-Priority Static & Hub Routes
  const staticRoutes: MetadataRoute.Sitemap = [
    {
      url: baseUrl,
      lastModified: now,
      changeFrequency: 'daily',
      priority: 1.0,
    },
    {
      url: `${baseUrl}/request`,
      lastModified: now,
      changeFrequency: 'weekly',
      priority: 0.8,
    },
    {
      url: `${baseUrl}/?type=MOVIE`,
      lastModified: now,
      changeFrequency: 'daily',
      priority: 0.9,
    },
    {
      url: `${baseUrl}/?type=TV_SHOW`,
      lastModified: now,
      changeFrequency: 'daily',
      priority: 0.9,
    },
  ];

  // Common high-traffic genre hubs
  const genres = [
    'Action', 'Adventure', 'Animation', 'Comedy', 'Crime',
    'Drama', 'Fantasy', 'Horror', 'Mystery', 'Romance',
    'Sci-Fi', 'Thriller', 'Superhero'
  ];

  const genreRoutes: MetadataRoute.Sitemap = genres.map(g => ({
    url: `${baseUrl}/?genre=${encodeURIComponent(g)}`,
    lastModified: now,
    changeFrequency: 'weekly',
    priority: 0.8,
  }));

  const movieUrls: MetadataRoute.Sitemap = [];
  const episodeUrls: MetadataRoute.Sitemap = [];

  try {
    const movies = await fetchMovies({ limit: 1000 });
    if (movies && movies.length > 0) {
      for (const m of movies) {
        const lastMod = m.updatedAt ? new Date(m.updatedAt) : now;

        // Parent Movie / TV Series URL
        movieUrls.push({
          url: `${baseUrl}/movies/${m.id}`,
          lastModified: lastMod,
          changeFrequency: 'daily',
          priority: 0.9,
        });

        // If TV Series, index all child season & episode URLs
        if (m.type === 'TV_SHOW' && (m as any).seasons && Array.isArray((m as any).seasons)) {
          for (const s of (m as any).seasons) {
            const sNum = s.seasonNumber || s.season_number;
            if (s.episodes && Array.isArray(s.episodes)) {
              for (const ep of s.episodes) {
                const epNum = ep.episodeNumber || ep.episode_number;
                episodeUrls.push({
                  url: `${baseUrl}/movies/${m.id}/season/${sNum}/episode/${epNum}`,
                  lastModified: ep.airDate ? new Date(ep.airDate) : lastMod,
                  changeFrequency: 'weekly',
                  priority: 0.85,
                });
              }
            }
          }
        }
      }
    }
  } catch (err) {
    console.warn('Sitemap generation error:', err);
  }

  return [...staticRoutes, ...genreRoutes, ...movieUrls, ...episodeUrls];
}
