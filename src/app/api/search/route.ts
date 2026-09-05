import { NextResponse } from 'next/server';
import { fetchMovies } from '@/lib/data';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get('q')?.trim() || '';

  if (!q) {
    return NextResponse.json({ results: [] });
  }

  try {
    const movies = await fetchMovies({ search: q, limit: 8 });

    if (movies && movies.length > 0) {
      const results = movies.map(m => ({
        id: m.id,
        title: m.title,
        originalTitle: m.originalTitle,
        type: m.type,
        releaseDate: m.releaseDate,
        posterPath: m.posterPath,
        subtitlesCount: m._count?.subtitles || 0,
      }));
      return NextResponse.json({ results });
    }
  } catch (err) {
    console.error('Search API error:', err);
  }

  return NextResponse.json({ results: [] });
}
