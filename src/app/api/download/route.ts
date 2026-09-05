import { NextResponse } from 'next/server';

export const dynamic = 'force-dynamic';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const targetUrl = searchParams.get('url');
    const fileName = searchParams.get('name') || 'subtitle.srt';

    if (!targetUrl) {
      return NextResponse.json({ error: 'Missing file URL' }, { status: 400 });
    }

    const response = await fetch(targetUrl);
    if (!response.ok) {
      return NextResponse.redirect(targetUrl);
    }

    const contentType = response.headers.get('content-type') || 'application/x-subrip';
    const fileBuffer = await response.arrayBuffer();
    const cleanFileName = fileName.replace(/[^a-zA-Z0-9._-]/g, '_');

    return new NextResponse(fileBuffer, {
      status: 200,
      headers: {
        'Content-Type': contentType,
        'Content-Disposition': `attachment; filename="${cleanFileName}"`,
        'Content-Length': fileBuffer.byteLength.toString(),
        'Cache-Control': 'public, max-age=86400',
      },
    });
  } catch (error) {
    console.error('Download Proxy Error:', error);
    const { searchParams } = new URL(request.url);
    const targetUrl = searchParams.get('url');
    if (targetUrl) {
      return NextResponse.redirect(targetUrl);
    }
    return NextResponse.json({ error: 'Failed to download file' }, { status: 500 });
  }
}
