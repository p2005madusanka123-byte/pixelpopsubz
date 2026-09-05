import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

// ─────────────────────────────────────────────────────────────────────────────
// GET  – fetch all seasons (+ episodes) for a movie
// ─────────────────────────────────────────────────────────────────────────────
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const movieId = searchParams.get('movieId');
    if (!movieId) return NextResponse.json({ error: 'movieId required' }, { status: 400 });

    const seasons = await prisma.season.findMany({
      where: { movieId },
      orderBy: { seasonNumber: 'asc' },
      include: {
        episodes: {
          orderBy: { episodeNumber: 'asc' },
          include: {
            subtitles: { select: { id: true, fileName: true, fileUrl: true, language: true, downloadsCount: true } },
            telegramLinks: { select: { id: true, quality: true, size: true, downloadUrl: true, label: true, clicksCount: true } },
          },
        },
      },
    });

    return NextResponse.json({ seasons });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// POST  – create or upsert a season
// ─────────────────────────────────────────────────────────────────────────────
export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { movieId, seasonNumber, title, description, releaseDate, posterPath, episodeCount } = await request.json();
    if (!movieId || !seasonNumber) return NextResponse.json({ error: 'movieId and seasonNumber are required.' }, { status: 400 });

    const season = await prisma.season.upsert({
      where: { movieId_seasonNumber: { movieId, seasonNumber: parseInt(String(seasonNumber)) } },
      update: {
        title: title?.trim() || null,
        description: description?.trim() || null,
        releaseDate: releaseDate?.trim() || null,
        posterPath: posterPath?.trim() || null,
        episodeCount: episodeCount ? parseInt(String(episodeCount)) : null,
      },
      create: {
        movieId,
        seasonNumber: parseInt(String(seasonNumber)),
        title: title?.trim() || `Season ${seasonNumber}`,
        description: description?.trim() || null,
        releaseDate: releaseDate?.trim() || null,
        posterPath: posterPath?.trim() || null,
        episodeCount: episodeCount ? parseInt(String(episodeCount)) : null,
      },
    });

    return NextResponse.json({ success: true, season });
  } catch (error: any) {
    console.error('Season error:', error);
    return NextResponse.json({ error: error.message || 'Failed to save season' }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DELETE  – delete a season (cascades to all its episodes + links)
// ─────────────────────────────────────────────────────────────────────────────
export async function DELETE(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    if (!id) return NextResponse.json({ error: 'Season ID required.' }, { status: 400 });

    await prisma.season.delete({ where: { id } });
    return NextResponse.json({ success: true });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
