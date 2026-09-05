import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });
    }

    const requests = await prisma.downloadRequest.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        user: { select: { email: true } },
      },
    });

    return NextResponse.json({ requests });
  } catch (error: any) {
    return NextResponse.json({ error: error.message || 'Failed to fetch requests' }, { status: 500 });
  }
}

export async function PUT(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });
    }

    const { id, status } = await request.json();

    if (!id || !status) {
      return NextResponse.json({ error: 'Request ID and Status are required.' }, { status: 400 });
    }

    const updated = await prisma.downloadRequest.update({
      where: { id },
      data: { status },
    });

    return NextResponse.json({ success: true, request: updated });
  } catch (error: any) {
    return NextResponse.json({ error: error.message || 'Failed to update request' }, { status: 500 });
  }
}
