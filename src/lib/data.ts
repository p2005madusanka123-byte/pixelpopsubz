import { createClient } from '@supabase/supabase-js';

// --- Supabase Client ----------------------------------------------------------
function getSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !key) return null;
  return createClient(url, key, { auth: { persistSession: false } });
}

export interface FetchMoviesOptions {
  search?: string;
  type?: string;
  genre?: string;
  page?: number;
  limit?: number;
}

export async function fetchMovies(opts: FetchMoviesOptions = {}) {
  const { search, type, genre, page = 1, limit = 24 } = opts;
  const cleanSearch = search ? search.trim().toLowerCase() : '';
  const from = (page - 1) * limit;
  const to = from + limit - 1;

  const supabase = getSupabase();
  if (!supabase) return [];

  try {
    let query = supabase
      .from('movies')
      .select(`
        id, title, original_title, type, description, release_date, year, runtime,
        imdb_rating, tmdb_id, genres, seo_tags, language, country, status,
        total_seasons, poster_path, backdrop_path, trailer_url, created_at, updated_at,
        subtitles(id),
        telegram_links(id),
        seasons(
          id, season_number,
          episodes(
            id, episode_number,
            subtitles(id),
            telegram_links(id)
          )
        )
      `)
      .order('created_at', { ascending: false })
      .range(from, to);

    if (type) query = query.eq('type', type);
    if (cleanSearch) {
      query = query.or(`title.ilike.%${cleanSearch}%,original_title.ilike.%${cleanSearch}%,description.ilike.%${cleanSearch}%`);
    }
    if (genre) query = query.contains('genres', [genre]);

    const { data, error } = await query;
    if (error) {
      console.error('[fetchMovies] Supabase error:', error.message);
      return [];
    }
    if (!data || data.length === 0) return [];

    return data.map((m: any) => {
      const directSubCount = m.subtitles?.length || 0;
      const directTgCount = m.telegram_links?.length || 0;
      let episodeSubCount = 0;
      let episodeTgCount = 0;
      let totalEpisodes = 0;

      if (m.seasons && Array.isArray(m.seasons)) {
        for (const s of m.seasons) {
          if (s.episodes && Array.isArray(s.episodes)) {
            totalEpisodes += s.episodes.length;
            for (const ep of s.episodes) {
              episodeSubCount += ep.subtitles?.length || 0;
              episodeTgCount += ep.telegram_links?.length || 0;
            }
          }
        }
      }

      return {
        id: m.id,
        title: m.title,
        originalTitle: m.original_title,
        type: m.type,
        description: m.description,
        releaseDate: m.release_date,
        year: m.year,
        runtime: m.runtime,
        imdbRating: m.imdb_rating ? Number(m.imdb_rating) : null,
        tmdbId: m.tmdb_id,
        genres: m.genres || [],
        seoTags: m.seo_tags || [],
        language: m.language,
        country: m.country,
        status: m.status,
        totalSeasons: m.total_seasons,
        posterPath: m.poster_path,
        backdropPath: m.backdrop_path,
        trailerUrl: m.trailer_url,
        createdAt: m.created_at,
        updatedAt: m.updated_at,
        _count: {
          subtitles: directSubCount + episodeSubCount,
          telegramLinks: directTgCount + episodeTgCount,
          episodes: totalEpisodes,
        },
      };
    });
  } catch (err: any) {
    console.error('[fetchMovies] Error:', err?.message || err);
    return [];
  }
}

export async function fetchMovieById(id: string) {
  const supabase = getSupabase();
  if (!supabase) return null;

  try {
    const { data: m, error } = await supabase
      .from('movies')
      .select(`
        *,
        subtitles(*),
        telegram_links(*),
        seasons(
          *,
          episodes(
            *,
            subtitles(*),
            telegram_links(*)
          )
        )
      `)
      .eq('id', id)
      .maybeSingle();

    if (error) {
      console.error('[fetchMovieById] Supabase error:', error.message);
      return null;
    }
    if (!m) return null;

    return {
      id: m.id,
      title: m.title,
      originalTitle: m.original_title,
      type: m.type,
      description: m.description,
      releaseDate: m.release_date,
      year: m.year,
      runtime: m.runtime,
      imdbRating: m.imdb_rating ? Number(m.imdb_rating) : null,
      tmdbId: m.tmdb_id,
      genres: m.genres || [],
      seoTags: m.seo_tags || [],
      language: m.language,
      country: m.country,
      status: m.status,
      totalSeasons: m.total_seasons,
      posterPath: m.poster_path,
      backdropPath: m.backdrop_path,
      trailerUrl: m.trailer_url,
      createdAt: m.created_at,
      updatedAt: m.updated_at,
      subtitles: (m.subtitles || []).map((s: any) => ({
        id: s.id,
        language: s.language,
        fileName: s.file_name,
        fileUrl: s.file_url,
        version: s.version,
        downloadsCount: s.downloads_count || 0,
        createdAt: s.created_at,
      })),
      telegramLinks: (m.telegram_links || []).map((t: any) => ({
        id: t.id,
        quality: t.quality,
        size: t.size,
        downloadUrl: t.download_url,
        label: t.label,
        clicksCount: t.clicks_count || 0,
        createdAt: t.created_at,
      })),
      seasons: (m.seasons || [])
        .sort((a: any, b: any) => a.season_number - b.season_number)
        .map((s: any) => ({
          id: s.id,
          seasonNumber: s.season_number,
          title: s.title,
          description: s.description,
          releaseDate: s.release_date,
          posterPath: s.poster_path,
          episodeCount: s.episode_count,
          episodes: (s.episodes || [])
            .sort((a: any, b: any) => a.episode_number - b.episode_number)
            .map((e: any) => ({
              id: e.id,
              episodeNumber: e.episode_number,
              title: e.title,
              description: e.description,
              airDate: e.air_date,
              runtime: e.runtime,
              imdbRating: e.imdb_rating ? Number(e.imdb_rating) : null,
              stillPath: e.still_path,
              subtitles: (e.subtitles || []).map((sub: any) => ({
                id: sub.id,
                language: sub.language,
                fileName: sub.file_name,
                fileUrl: sub.file_url,
                version: sub.version,
                downloadsCount: sub.downloads_count || 0,
                createdAt: sub.created_at,
              })),
              telegramLinks: (e.telegram_links || []).map((tl: any) => ({
                id: tl.id,
                quality: tl.quality,
                size: tl.size,
                downloadUrl: tl.download_url,
                label: tl.label,
                clicksCount: tl.clicks_count || 0,
                createdAt: tl.created_at,
              })),
            })),
        })),
    };
  } catch (err: any) {
    console.error('[fetchMovieById] Error:', err?.message || err);
    return null;
  }
}
