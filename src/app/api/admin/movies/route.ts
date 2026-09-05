import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { getTmdbDetails } from '@/lib/tmdb';
import { NextResponse } from 'next/server';

// ─────────────────────────────────────────────────────────────────────────────
// POST  – Add movie (TMDB sync OR manual)
// ─────────────────────────────────────────────────────────────────────────────
export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const body = await request.json();
    const {
      tmdbId, type, manual,
      title, originalTitle, description, releaseDate,
      posterPath, backdropPath, trailerUrl,
      genres, seoTags, imdbRating, imdbId,
      runtime, country, status: movieStatus, totalSeasons,
    } = body;

    const genresArr  = Array.isArray(genres)  ? genres  : (genres  ? String(genres).split(',').map((s: string) => s.trim()) : []);
    const seoTagsArr = Array.isArray(seoTags) ? seoTags : (seoTags ? String(seoTags).split(',').map((s: string) => s.trim()) : []);

    if (manual) {
      if (!title?.trim()) return NextResponse.json({ error: 'Title is required.' }, { status: 400 });

      const movie = await prisma.movie.create({
        data: {
          title: title.trim(),
          originalTitle: originalTitle?.trim() || null,
          type: type || 'MOVIE',
          description: description?.trim() || null,
          releaseDate: releaseDate?.trim() || null,
          year: releaseDate ? parseInt(releaseDate.split('-')[0]) : null,
          posterPath: posterPath?.trim() || null,
          backdropPath: backdropPath?.trim() || null,
          trailerUrl: trailerUrl?.trim() || null,
          genres: genresArr,
          seoTags: seoTagsArr,
          imdbRating: imdbRating ? parseFloat(String(imdbRating)) : null,
          imdbId: imdbId?.trim() || null,
          runtime: runtime ? parseInt(String(runtime)) : null,
          country: country?.trim() || null,
          status: movieStatus?.trim() || null,
          totalSeasons: totalSeasons ? parseInt(String(totalSeasons)) : null,
          tmdbId: tmdbId ? String(tmdbId).trim() : null,
        },
      });
      return NextResponse.json({ success: true, movie });
    }

    // TMDB Sync
    if (!tmdbId || !type) return NextResponse.json({ error: 'TMDB ID and Type are required.' }, { status: 400 });

    const tmdbData = await getTmdbDetails(tmdbId, type);
    if (!tmdbData) return NextResponse.json({ error: 'Failed to fetch metadata from TMDB.' }, { status: 404 });

    const existing = await prisma.movie.findUnique({ where: { tmdbId: String(tmdbId) } });
    if (existing) return NextResponse.json({ error: 'This title has already been added.' }, { status: 400 });

    const movie = await prisma.movie.create({
      data: {
        title: tmdbData.title,
        originalTitle: tmdbData.originalTitle,
        type: tmdbData.type,
        description: tmdbData.description,
        releaseDate: tmdbData.releaseDate,
        year: tmdbData.releaseDate ? parseInt(tmdbData.releaseDate.split('-')[0]) : null,
        posterPath: tmdbData.posterPath,
        backdropPath: tmdbData.backdropPath,
        tmdbId: String(tmdbId),
        genres: genresArr,
        seoTags: seoTagsArr,
      },
    });
    return NextResponse.json({ success: true, movie });
  } catch (error) {
    console.error('Failed to add movie:', error);
    return NextResponse.json({ error: 'Failed to add movie' }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PUT  – Update movie
// ─────────────────────────────────────────────────────────────────────────────
export async function PUT(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const body = await request.json();
    const {
      id, title, originalTitle, type, description,
      releaseDate, posterPath, backdropPath, trailerUrl, tmdbId, imdbId,
      genres, seoTags, imdbRating, runtime, country, status: movieStatus, totalSeasons,
    } = body;

    if (!id || !title?.trim()) return NextResponse.json({ error: 'ID and Title are required.' }, { status: 400 });

    const genresArr  = Array.isArray(genres)  ? genres  : (genres  ? String(genres).split(',').map((s: string) => s.trim()) : []);
    const seoTagsArr = Array.isArray(seoTags) ? seoTags : (seoTags ? String(seoTags).split(',').map((s: string) => s.trim()) : []);

    const updated = await prisma.movie.update({
      where: { id },
      data: {
        title: title.trim(),
        originalTitle: originalTitle?.trim() || null,
        type: type || 'MOVIE',
        description: description?.trim() || null,
        releaseDate: releaseDate?.trim() || null,
        year: releaseDate ? parseInt(String(releaseDate).split('-')[0]) : null,
        posterPath: posterPath?.trim() || null,
        backdropPath: backdropPath?.trim() || null,
        trailerUrl: trailerUrl?.trim() || null,
        tmdbId: tmdbId ? String(tmdbId).trim() : null,
        imdbId: imdbId?.trim() || null,
        genres: genresArr,
        seoTags: seoTagsArr,
        imdbRating: imdbRating ? parseFloat(String(imdbRating)) : null,
        runtime: runtime ? parseInt(String(runtime)) : null,
        country: country?.trim() || null,
        status: movieStatus?.trim() || null,
        totalSeasons: totalSeasons ? parseInt(String(totalSeasons)) : null,
      },
    });
    return NextResponse.json({ success: true, movie: updated });
  } catch (error: any) {
    console.error('Failed to update movie:', error);
    return NextResponse.json({ error: error.message || 'Failed to update movie' }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DELETE  – Delete movie (cascades to seasons/episodes/subtitles/links)
// ─────────────────────────────────────────────────────────────────────────────
export async function DELETE(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    if (!id) return NextResponse.json({ error: 'Movie ID is required.' }, { status: 400 });

    await prisma.movie.delete({ where: { id } });
    return NextResponse.json({ success: true });
  } catch (error: any) {
    console.error('Failed to delete movie:', error);
    return NextResponse.json({ error: error.message || 'Failed to delete movie' }, { status: 500 });
  }
}
