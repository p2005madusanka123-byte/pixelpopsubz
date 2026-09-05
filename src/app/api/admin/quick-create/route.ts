import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { getTmdbDetails } from '@/lib/tmdb';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    let dbUser = await prisma.user.findUnique({ where: { id: user.id } });
    if (!dbUser) {
      dbUser = await prisma.user.create({ data: { id: user.id, email: user.email!, role: 'ADMIN' } });
    }

    const body = await request.json();
    const {
      type, // 'MOVIE' | 'TV_SHOW'
      useTmdb,
      tmdbId,
      title,
      description,
      releaseDate,
      posterPath,
      backdropPath,
      genres,
      imdbRating,
      // TV Series specific
      seasonNumber,
      episodeNumber,
      episodeTitle,
      episodeDescription,
      episodeStillPath,
      // Links
      subFileName,
      subFileUrl,
      telegramUrl,
      telegramLabel,
    } = body;

    let finalTitle = title?.trim() || '';
    let finalDesc = description?.trim() || null;
    let finalRelDate = releaseDate?.trim() || null;
    let finalPoster = posterPath?.trim() || null;
    let finalBackdrop = backdropPath?.trim() || null;
    let finalGenres = Array.isArray(genres) ? genres : (genres ? String(genres).split(',').map((s: string) => s.trim()).filter(Boolean) : []);
    let finalRating = imdbRating ? parseFloat(String(imdbRating)) : null;
    let finalTmdbId = tmdbId ? String(tmdbId).trim() : null;

    // 1. Auto-fetch from TMDB if requested
    if (useTmdb && finalTmdbId) {
      try {
        const tmdbData = await getTmdbDetails(finalTmdbId, type || 'MOVIE');
        if (tmdbData) {
          if (!finalTitle) finalTitle = tmdbData.title;
          if (!finalDesc) finalDesc = tmdbData.description;
          if (!finalRelDate) finalRelDate = tmdbData.releaseDate;
          if (!finalPoster) finalPoster = tmdbData.posterPath;
          if (!finalBackdrop) finalBackdrop = tmdbData.backdropPath;
        }
      } catch (tmdbErr) {
        console.warn('TMDB auto-fetch warning:', tmdbErr);
      }
    }

    if (!finalTitle) {
      return NextResponse.json({ error: 'Title is required.' }, { status: 400 });
    }

    const year = finalRelDate ? parseInt(finalRelDate.split('-')[0]) : null;
    const isTv = type === 'TV_SHOW';

    // 2. Find or Create Movie / TV Series parent record
    let movie = null;
    if (finalTmdbId) {
      movie = await prisma.movie.findUnique({ where: { tmdbId: finalTmdbId } });
    }
    if (!movie) {
      movie = await prisma.movie.findFirst({
        where: {
          title: { equals: finalTitle, mode: 'insensitive' },
          type: isTv ? 'TV_SHOW' : 'MOVIE',
        },
      });
    }

    if (!movie) {
      movie = await prisma.movie.create({
        data: {
          title: finalTitle,
          type: isTv ? 'TV_SHOW' : 'MOVIE',
          description: finalDesc,
          releaseDate: finalRelDate,
          year,
          posterPath: finalPoster,
          backdropPath: finalBackdrop,
          genres: finalGenres,
          imdbRating: finalRating,
          tmdbId: finalTmdbId,
          totalSeasons: isTv ? Math.max(1, parseInt(String(seasonNumber || 1))) : null,
        },
      });
    } else {
      // Update missing fields
      const updateData: any = {};
      if (!movie.posterPath && finalPoster) updateData.posterPath = finalPoster;
      if (!movie.backdropPath && finalBackdrop) updateData.backdropPath = finalBackdrop;
      if (!movie.description && finalDesc) updateData.description = finalDesc;
      if (isTv && seasonNumber && (!movie.totalSeasons || parseInt(String(seasonNumber)) > movie.totalSeasons)) {
        updateData.totalSeasons = parseInt(String(seasonNumber));
      }
      if (Object.keys(updateData).length > 0) {
        movie = await prisma.movie.update({ where: { id: movie.id }, data: updateData });
      }
    }

    let targetMovieId: string | null = movie.id;
    let targetEpisodeId: string | null = null;

    // 3. If TV Show, create or find Season and Episode
    if (isTv) {
      targetMovieId = null;
      const sNum = parseInt(String(seasonNumber || 1));
      const eNum = parseInt(String(episodeNumber || 1));

      const season = await prisma.season.upsert({
        where: { movieId_seasonNumber: { movieId: movie.id, seasonNumber: sNum } },
        update: {},
        create: {
          movieId: movie.id,
          seasonNumber: sNum,
          title: 'Season ' + sNum,
          description: movie.title + ' Season ' + sNum,
        },
      });

      const episode = await prisma.episode.upsert({
        where: { seasonId_episodeNumber: { seasonId: season.id, episodeNumber: eNum } },
        update: {
          title: episodeTitle?.trim() || undefined,
          description: episodeDescription?.trim() || undefined,
          stillPath: episodeStillPath?.trim() || finalPoster || undefined,
        },
        create: {
          seasonId: season.id,
          episodeNumber: eNum,
          title: episodeTitle?.trim() || ('Episode ' + eNum),
          description: episodeDescription?.trim() || null,
          stillPath: episodeStillPath?.trim() || finalPoster || null,
        },
      });

      targetEpisodeId = episode.id;
    }

    // 4. Attach Subtitle if provided
    let createdSub = null;
    if (subFileUrl?.trim()) {
      const cleanFileName = subFileName?.trim() || (isTv ? (finalTitle + '_S' + String(seasonNumber||1).padStart(2,'0') + 'E' + String(episodeNumber||1).padStart(2,'0') + '_Sinhala.srt') : (finalTitle + '_Sinhala.srt'));
      createdSub = await prisma.subtitle.create({
        data: {
          movieId: targetMovieId,
          episodeId: targetEpisodeId,
          language: 'Sinhala',
          fileName: cleanFileName,
          fileUrl: subFileUrl.trim(),
          uploaderId: user.id,
        },
      });
    }

    // 5. Attach Telegram Link if provided
    let createdTg = null;
    if (telegramUrl?.trim()) {
      createdTg = await prisma.telegramLink.create({
        data: {
          movieId: targetMovieId,
          episodeId: targetEpisodeId,
          downloadUrl: telegramUrl.trim(),
          quality: null,
          size: null,
          label: telegramLabel?.trim() || (isTv ? ('Episode ' + (episodeNumber || 1)) : 'Direct Telegram Copy'),
        },
      });
    }

    return NextResponse.json({
      success: true,
      movie,
      subtitle: createdSub,
      telegramLink: createdTg,
      message: 'Successfully published ' + finalTitle + (isTv ? (' S' + (seasonNumber || 1) + 'E' + (episodeNumber || 1)) : '') + '!',
    });
  } catch (error: any) {
    console.error('Unified create error:', error);
    return NextResponse.json({ error: error.message || 'Failed to create entry' }, { status: 500 });
  }
}
