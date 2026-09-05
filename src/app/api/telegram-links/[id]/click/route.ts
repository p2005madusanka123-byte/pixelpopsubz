import prisma from '@/lib/db';
import { NextResponse } from 'next/server';

interface RouteParams {
  params: Promise<{ id: string }>;
}

export async function POST(request: Request, { params }: RouteParams) {
  try {
    const resolvedParams = await params;
    const link = await prisma.telegramLink.update({
      where: { id: resolvedParams.id },
      data: {
        clicksCount: {
          increment: 1,
        },
      },
    });

    return NextResponse.json({ success: true, clicksCount: link.clicksCount });
  } catch (error) {
    console.error('Failed to increment Telegram link click count:', error);
    return NextResponse.json({ error: 'Failed to update count' }, { status: 500 });
  }
}
