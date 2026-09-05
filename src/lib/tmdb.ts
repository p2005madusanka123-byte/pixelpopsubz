const TMDB_API_URL = 'https://api.themoviedb.org/3';

export interface TmdbSearchResult {
  id: number;
  title?: string;
  name?: string; // TV show name
  original_title?: string;
  original_name?: string;
  media_type: 'movie' | 'tv';
  overview: string;
  release_date?: string;
  first_air_date?: string;
  poster_path: string | null;
  backdrop_path: string | null;
}

export interface TmdbDetails {
  id: number;
  title: string;
  originalTitle: string;
  type: 'MOVIE' | 'TV_SHOW';
  description: string;
  releaseDate: string;
  posterPath: string | null;
  backdropPath: string | null;
}

export async function searchTmdb(query: string): Promise<TmdbSearchResult[]> {
  const apiKey = process.env.TMDB_API_KEY;
  const accessToken = process.env.TMDB_ACCESS_TOKEN;

  let headers: HeadersInit = {};
  let url = `${TMDB_API_URL}/search/multi?query=${encodeURIComponent(query)}&include_adult=false`;

  if (accessToken) {
    headers = {
      Authorization: `Bearer ${accessToken}`,
      accept: 'application/json',
    };
  } else if (apiKey) {
    url += `&api_key=${apiKey}`;
  } else {
    console.warn("TMDB API credentials not set. Returning empty array.");
    return [];
  }

  try {
    const res = await fetch(url, { headers, next: { revalidate: 3600 } });
    if (!res.ok) throw new Error('Failed to fetch from TMDB');
    const data = await res.json();
    return data.results || [];
  } catch (error) {
    console.error('TMDB Search Error:', error);
    return [];
  }
}

export async function getTmdbDetails(id: string, type: 'MOVIE' | 'TV_SHOW'): Promise<TmdbDetails | null> {
  const apiKey = process.env.TMDB_API_KEY;
  const accessToken = process.env.TMDB_ACCESS_TOKEN;

  let headers: HeadersInit = {};
  const mediaType = type === 'MOVIE' ? 'movie' : 'tv';
  let url = `${TMDB_API_URL}/${mediaType}/${id}`;

  if (accessToken) {
    headers = {
      Authorization: `Bearer ${accessToken}`,
      accept: 'application/json',
    };
  } else if (apiKey) {
    url += `?api_key=${apiKey}`;
  } else {
    console.warn("TMDB API credentials not set. Returning null.");
    return null;
  }

  try {
    const res = await fetch(url, { headers, next: { revalidate: 86400 } });
    if (!res.ok) return null;
    const data = await res.json();
    
    return {
      id: data.id,
      title: data.title || data.name,
      originalTitle: data.original_title || data.original_name,
      type,
      description: data.overview || '',
      releaseDate: data.release_date || data.first_air_date || '',
      posterPath: data.poster_path ? `https://image.tmdb.org/t/p/w500${data.poster_path}` : null,
      backdropPath: data.backdrop_path ? `https://image.tmdb.org/t/p/original${data.backdrop_path}` : null,
    };
  } catch (error) {
    console.error('TMDB Details Error:', error);
    return null;
  }
}
