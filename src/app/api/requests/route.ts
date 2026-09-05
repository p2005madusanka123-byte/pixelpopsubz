import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    
    // Check if user is authenticated
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized. Please sign in.' }, { status: 401 });
    }

    const { title, type } = await request.json();
    if (!title || !type) {
      return NextResponse.json({ error: 'Title and Type are required.' }, { status: 400 });
    }

    // Check if user profile exists in public database users table
    // If not, sync it now
    let dbUser = await prisma.user.findUnique({
      where: { id: user.id },
    });

    if (!dbUser) {
      dbUser = await prisma.user.create({
        data: {
          id: user.id,
          email: user.email!,
          role: 'USER',
        },
      });
    }

    // Create the download request
    const downloadRequest = await prisma.downloadRequest.create({
      data: {
        title,
        type,
        userId: user.id,
      },
    });

    return NextResponse.json({ success: true, request: downloadRequest });
  } catch (error) {
    console.error('Failed to create request:', error);
    return NextResponse.json({ error: 'Failed to submit request' }, { status: 500 });
  }
}
