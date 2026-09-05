import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { movieId, episodeId, language, fileUrl, fileName, version } = await request.json();

    if (!fileUrl || !fileName) {
      return NextResponse.json({ error: 'fileUrl and fileName are required.' }, { status: 400 });
    }
    if (!movieId && !episodeId) {
      return NextResponse.json({ error: 'Either movieId or episodeId is required.' }, { status: 400 });
    }

    let dbUser = await prisma.user.findUnique({ where: { id: user.id } });
    if (!dbUser) {
      dbUser = await prisma.user.create({ data: { id: user.id, email: user.email!, role: 'ADMIN' } });
    }

    const subtitle = await prisma.subtitle.create({
      data: {
        movieId: movieId || null,
        episodeId: episodeId || null,
        language: language || 'Sinhala',
        fileUrl,
        fileName,
        version: version?.trim() || null,
        uploaderId: user.id,
      },
    });

    return NextResponse.json({ success: true, subtitle });
  } catch (error: any) {
    console.error('Failed to create subtitle:', error);
    return NextResponse.json({ error: 'Failed to upload subtitle record' }, { status: 500 });
  }
}

export async function DELETE(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    if (!id) return NextResponse.json({ error: 'Subtitle ID required.' }, { status: 400 });

    await prisma.subtitle.delete({ where: { id } });
    return NextResponse.json({ success: true });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
