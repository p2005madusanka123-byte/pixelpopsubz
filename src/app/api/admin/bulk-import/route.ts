import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

interface CsvRow {
  title: string;
  originalTitle?: string;
  type?: string;
  description?: string;
  releaseDate?: string;
  posterPath?: string;
  backdropPath?: string;
  tmdbId?: string;
}

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });
    }

    const { rows }: { rows: CsvRow[] } = await request.json();

    if (!Array.isArray(rows) || rows.length === 0) {
      return NextResponse.json({ error: 'No data rows provided.' }, { status: 400 });
    }

    let successCount = 0;
    let failedCount = 0;
    const errors: string[] = [];

    for (let i = 0; i < rows.length; i++) {
      const row = rows[i];
      if (!row.title || !row.title.trim()) {
        failedCount++;
        errors.push(`Row #${i + 1}: Missing title`);
        continue;
      }

      try {
        const tmdbIdClean = row.tmdbId ? String(row.tmdbId).trim() : null;

        // Check if tmdbId already exists to avoid unique constraint violation
        if (tmdbIdClean) {
          const existing = await prisma.movie.findUnique({
            where: { tmdbId: tmdbIdClean },
          });
          if (existing) {
            failedCount++;
            errors.push(`Row #${i + 1} (${row.title}): TMDB ID ${tmdbIdClean} already exists.`);
            continue;
          }
        }

        await prisma.movie.create({
          data: {
            title: row.title.trim(),
            originalTitle: row.originalTitle?.trim() || null,
            type: (row.type?.trim().toUpperCase() === 'TV_SHOW' || row.type?.trim().toUpperCase() === 'TV') ? 'TV_SHOW' : 'MOVIE',
            description: row.description?.trim() || null,
            releaseDate: row.releaseDate?.trim() || null,
            posterPath: row.posterPath?.trim() || null,
            backdropPath: row.backdropPath?.trim() || null,
            tmdbId: tmdbIdClean,
          },
        });

        successCount++;
      } catch (err: any) {
        failedCount++;
        errors.push(`Row #${i + 1} (${row.title}): ${err.message || 'Insert error'}`);
      }
    }

    return NextResponse.json({
      success: true,
      successCount,
      failedCount,
      errors: errors.slice(0, 10), // return up to 10 sample errors
    });
  } catch (error: any) {
    console.error('Bulk import error:', error);
    return NextResponse.json({ error: error.message || 'Failed to process CSV import' }, { status: 500 });
  }
}
