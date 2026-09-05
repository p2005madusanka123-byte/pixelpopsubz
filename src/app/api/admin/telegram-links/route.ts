import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { movieId, episodeId, quality, size, downloadUrl, label } = await request.json();

    if (!downloadUrl) return NextResponse.json({ error: 'downloadUrl is required.' }, { status: 400 });
    if (!movieId && !episodeId) return NextResponse.json({ error: 'Either movieId or episodeId is required.' }, { status: 400 });

    const link = await prisma.telegramLink.create({
      data: {
        movieId: movieId || null,
        episodeId: episodeId || null,
        quality: quality || '720p',
        size: size || null,
        downloadUrl,
        label: label?.trim() || null,
      },
    });

    return NextResponse.json({ success: true, link });
  } catch (error: any) {
    console.error('Failed to create Telegram link:', error);
    return NextResponse.json({ error: 'Failed to add Telegram link record' }, { status: 500 });
  }
}

export async function DELETE(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    if (!id) return NextResponse.json({ error: 'Link ID required.' }, { status: 400 });

    await prisma.telegramLink.delete({ where: { id } });
    return NextResponse.json({ success: true });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
