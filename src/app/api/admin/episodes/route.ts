import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

// ─────────────────────────────────────────────────────────────────────────────
// POST  – Create or upsert episode (with optional subtitle + telegram links)
// ─────────────────────────────────────────────────────────────────────────────
export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const {
      seasonId,
      episodeNumber,
      title,
      description,
      airDate,
      runtime,
      imdbRating,
      stillPath,
      // Optional inline subtitle
      subFileName,
      subFileUrl,
      subLanguage,
      // Optional inline telegram links array: [{quality, size, downloadUrl, label}]
      telegramLinks,
    } = await request.json();

    if (!seasonId || !episodeNumber) {
      return NextResponse.json({ error: 'seasonId and episodeNumber are required.' }, { status: 400 });
    }

    const episodeNum = parseInt(String(episodeNumber));

    // Upsert episode
    const episode = await prisma.episode.upsert({
      where: { seasonId_episodeNumber: { seasonId, episodeNumber: episodeNum } },
      update: {
        title: title?.trim() || null,
        description: description?.trim() || null,
        airDate: airDate?.trim() || null,
        runtime: runtime ? parseInt(String(runtime)) : null,
        imdbRating: imdbRating ? parseFloat(String(imdbRating)) : null,
        stillPath: stillPath?.trim() || null,
      },
      create: {
        seasonId,
        episodeNumber: episodeNum,
        title: title?.trim() || `Episode ${episodeNumber}`,
        description: description?.trim() || null,
        airDate: airDate?.trim() || null,
        runtime: runtime ? parseInt(String(runtime)) : null,
        imdbRating: imdbRating ? parseFloat(String(imdbRating)) : null,
        stillPath: stillPath?.trim() || null,
      },
    });

    // Optionally add subtitle for this episode
    if (subFileName?.trim() && subFileUrl?.trim()) {
      let dbUser = await prisma.user.findUnique({ where: { id: user.id } });
      if (!dbUser) {
        dbUser = await prisma.user.create({ data: { id: user.id, email: user.email!, role: 'ADMIN' } });
      }
      await prisma.subtitle.create({
        data: {
          episodeId: episode.id,
          language: subLanguage || 'Sinhala',
          fileName: subFileName.trim(),
          fileUrl: subFileUrl.trim(),
          uploaderId: user.id,
        },
      });
    }

    // Optionally add Telegram links for this episode
    if (Array.isArray(telegramLinks) && telegramLinks.length > 0) {
      for (const link of telegramLinks) {
        if (link.downloadUrl?.trim()) {
          await prisma.telegramLink.create({
            data: {
              episodeId: episode.id,
              quality: link.quality?.trim() || '720p',
              size: link.size?.trim() || null,
              downloadUrl: link.downloadUrl.trim(),
              label: link.label?.trim() || null,
            },
          });
        }
      }
    }

    const fullEpisode = await prisma.episode.findUnique({
      where: { id: episode.id },
      include: {
        subtitles: true,
        telegramLinks: true,
      },
    });

    return NextResponse.json({ success: true, episode: fullEpisode });
  } catch (error: any) {
    console.error('Episode error:', error);
    return NextResponse.json({ error: error.message || 'Failed to save episode' }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PUT  – Add a subtitle OR telegram link to an existing episode
// ─────────────────────────────────────────────────────────────────────────────
export async function PUT(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { episodeId, action, payload } = await request.json();
    if (!episodeId || !action) return NextResponse.json({ error: 'episodeId and action required.' }, { status: 400 });

    if (action === 'addSubtitle') {
      let dbUser = await prisma.user.findUnique({ where: { id: user.id } });
      if (!dbUser) {
        dbUser = await prisma.user.create({ data: { id: user.id, email: user.email!, role: 'ADMIN' } });
      }
      const subtitle = await prisma.subtitle.create({
        data: {
          episodeId,
          language: payload.language || 'Sinhala',
          fileName: payload.fileName,
          fileUrl: payload.fileUrl,
          version: payload.version || null,
          uploaderId: user.id,
        },
      });
      return NextResponse.json({ success: true, subtitle });
    }

    if (action === 'addTelegramLink') {
      const link = await prisma.telegramLink.create({
        data: {
          episodeId,
          quality: payload.quality || '720p',
          size: payload.size || null,
          downloadUrl: payload.downloadUrl,
          label: payload.label || null,
        },
      });
      return NextResponse.json({ success: true, link });
    }

    return NextResponse.json({ error: 'Unknown action.' }, { status: 400 });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DELETE  – Delete episode
// ─────────────────────────────────────────────────────────────────────────────
export async function DELETE(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    if (!id) return NextResponse.json({ error: 'Episode ID required.' }, { status: 400 });

    await prisma.episode.delete({ where: { id } });
    return NextResponse.json({ success: true });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
