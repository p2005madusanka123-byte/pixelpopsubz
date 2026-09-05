import prisma from '@/lib/db';
import { NextResponse } from 'next/server';

interface RouteParams {
  params: Promise<{ id: string }>;
}

export async function POST(request: Request, { params }: RouteParams) {
  try {
    const resolvedParams = await params;
    const subtitle = await prisma.subtitle.update({
      where: { id: resolvedParams.id },
      data: {
        downloadsCount: {
          increment: 1,
        },
      },
    });

    return NextResponse.json({ success: true, downloadsCount: subtitle.downloadsCount });
  } catch (error) {
    console.error('Failed to increment subtitle download count:', error);
    return NextResponse.json({ error: 'Failed to update count' }, { status: 500 });
  }
}
