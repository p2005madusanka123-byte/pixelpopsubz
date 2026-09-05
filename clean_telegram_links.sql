-- ============================================================================
-- PixelSubzLk: Clean Quality, Size Data and Drop Size Column
-- Run this in: Supabase Dashboard -> SQL Editor -> New Query -> Run
-- ============================================================================

-- 1. Make quality column nullable so links work without requiring a quality tag
ALTER TABLE telegram_links ALTER COLUMN quality DROP NOT NULL;

-- 2. Clear existing quality values
UPDATE telegram_links SET quality = NULL;

-- 3. Drop the size column completely from telegram_links
ALTER TABLE telegram_links DROP COLUMN IF EXISTS size;

-- Also drop file_size from subtitles if present
ALTER TABLE subtitles DROP COLUMN IF EXISTS file_size;
