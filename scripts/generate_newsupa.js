const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

function parseCSV(text) {
  const rows = [];
  let currentRow = [];
  let currentField = '';
  let inQuotes = false;

  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    const nextChar = text[i + 1];

    if (char === '"') {
      if (inQuotes && nextChar === '"') {
        currentField += '"';
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      currentRow.push(currentField);
      currentField = '';
    } else if ((char === '\r' || char === '\n') && !inQuotes) {
      if (char === '\r' && nextChar === '\n') {
        i++;
      }
      currentRow.push(currentField);
      currentField = '';
      if (currentRow.length > 1 || currentRow[0] !== '') {
        rows.push(currentRow);
      }
      currentRow = [];
    } else {
      currentField += char;
    }
  }

  if (currentField || currentRow.length > 0) {
    currentRow.push(currentField);
    rows.push(currentRow);
  }

  return rows;
}

function escapeCSV(val) {
  if (val === null || val === undefined) return '';
  const str = String(val);
  if (str.includes(',') || str.includes('"') || str.includes('\n') || str.includes('\r')) {
    return '"' + str.replace(/"/g, '""') + '"';
  }
  return str;
}

function cleanTags(metatags) {
  if (!metatags) return [];
  const tags = [];
  // extract content="..." from meta tags
  const regex = /content="([^"]+)"/g;
  let match;
  while ((match = regex.exec(metatags)) !== null) {
    const parts = match[1].split(',').map(s => s.trim()).filter(Boolean);
    tags.push(...parts);
  }
  if (tags.length === 0) {
    metatags.split(',').forEach(t => {
      const clean = t.replace(/<[^>]*>/g, '').trim();
      if (clean) tags.push(clean);
    });
  }
  // deduplicate
  return Array.from(new Set(tags));
}

function cleanGenres(genreStr) {
  if (!genreStr) return ['Drama'];
  return genreStr
    .split(',')
    .map(g => g.trim())
    .filter(g => g && g.toLowerCase() !== 'tv series' && g.toLowerCase() !== 'tv_show')
    .map(g => g.charAt(0).toUpperCase() + g.slice(1));
}

function extractFileName(url, defaultName) {
  if (!url) return defaultName;
  try {
    const cleanUrl = url.split('?')[0];
    const decoded = decodeURIComponent(cleanUrl);
    const basename = decoded.substring(decoded.lastIndexOf('/') + 1);
    return basename || defaultName;
  } catch {
    return defaultName;
  }
}

// Deterministic UUID for repeatable ID references
function toUUID(str) {
  const hash = crypto.createHash('md5').update(str).digest('hex');
  return `${hash.substr(0,8)}-${hash.substr(8,4)}-4${hash.substr(13,3)}-a${hash.substr(17,3)}-${hash.substr(20,12)}`;
}

const raw = fs.readFileSync(path.join(__dirname, '..', 'subtitles_rows.csv'), 'utf8');
const parsed = parseCSV(raw);
const dataRows = parsed.slice(1);

console.log(`Processing ${dataRows.length} source rows...`);

// Normalized structures
const moviesMap = new Map(); // key: normalized title
const seasonsMap = new Map(); // key: movieId_seasonNum
const episodesList = [];
const subtitlesList = [];
const telegramLinksList = [];
const unifiedRows = [];

// Admin / default user UUID for uploaders
const DEFAULT_USER_ID = '00000000-0000-0000-0000-000000000001';

dataRows.forEach((r, idx) => {
  const oldId = r[0];
  const createdAt = r[1] || new Date().toISOString();
  let title = (r[2] || '').trim();
  const downloadLink = (r[3] || '').trim();
  const imageUrl = (r[4] || '').trim();
  const genreStr = r[5] || '';
  const description = (r[6] || '').trim();
  const rating = parseFloat(r[7]) || 7.5;
  const year = parseInt(r[8]) || (new Date().getFullYear());
  const seasonNum = parseInt(r[9]) || null;
  const episodeNum = parseInt(r[10]) || null;
  const metatags = r[11] || '';
  const telegramLink = (r[12] || '').trim();
  const downloadCount = parseInt(r[13]) || 0;

  if (!title) return;

  // Title normalization (e.g. "Sons of Anarchy" vs "Sons Of Anarchy")
  const normTitleKey = title.toLowerCase().replace(/[^a-z0-9]/g, '');
  const isTv = Boolean(seasonNum || episodeNum || genreStr.toLowerCase().includes('tv series') || genreStr.toLowerCase().includes('tv_show'));

  // Ensure movie record exists
  let movie = moviesMap.get(normTitleKey);
  if (!movie) {
    const movieId = toUUID(`movie_${normTitleKey}`);
    movie = {
      id: movieId,
      title: title,
      original_title: title,
      type: isTv ? 'TV_SHOW' : 'MOVIE',
      description: description,
      release_date: `${year}-01-01`,
      year: year,
      runtime: isTv ? 50 : 120,
      imdb_rating: rating,
      imdb_id: null,
      tmdb_id: null,
      genres: cleanGenres(genreStr),
      seo_tags: cleanTags(metatags),
      language: 'Sinhala',
      country: 'USA',
      status: isTv ? 'Ongoing' : 'Released',
      total_seasons: isTv ? 1 : null,
      poster_path: imageUrl,
      backdrop_path: imageUrl,
      trailer_url: null,
      created_at: createdAt,
      updated_at: createdAt,
    };
    moviesMap.set(normTitleKey, movie);
  } else {
    // If it has a better poster or description, update
    if (!movie.poster_path && imageUrl) movie.poster_path = imageUrl;
    if (!movie.backdrop_path && imageUrl) movie.backdrop_path = imageUrl;
    if (isTv) {
      movie.type = 'TV_SHOW';
      if (seasonNum && (movie.total_seasons === null || seasonNum > movie.total_seasons)) {
        movie.total_seasons = seasonNum;
      }
    }
  }

  // Handle TV Episodes vs Movie Subtitles
  if (isTv && seasonNum) {
    const seasonKey = `${movie.id}_s${seasonNum}`;
    let season = seasonsMap.get(seasonKey);
    if (!season) {
      season = {
        id: toUUID(`season_${seasonKey}`),
        movie_id: movie.id,
        season_number: seasonNum,
        title: `Season ${seasonNum}`,
        description: `${movie.title} Season ${seasonNum}`,
        release_date: `${year}-01-01`,
        poster_path: imageUrl,
        episode_count: 1,
        created_at: createdAt,
        updated_at: createdAt,
      };
      seasonsMap.set(seasonKey, season);
    } else {
      if (episodeNum && episodeNum > season.episode_count) {
        season.episode_count = episodeNum;
      }
    }

    const epNumber = episodeNum || 1;
    const epId = toUUID(`ep_${season.id}_e${epNumber}`);
    const epTitle = `Episode ${epNumber}`;

    const episode = {
      id: epId,
      season_id: season.id,
      episode_number: epNumber,
      title: epTitle,
      description: description,
      air_date: `${year}-01-01`,
      runtime: 50,
      imdb_rating: rating,
      still_path: imageUrl,
      created_at: createdAt,
      updated_at: createdAt,
    };
    episodesList.push(episode);

    // Subtitle
    if (downloadLink) {
      const fileName = extractFileName(downloadLink, `${movie.title}.S${String(seasonNum).padStart(2,'0')}E${String(epNumber).padStart(2,'0')}.Sinhala.zip`);
      subtitlesList.push({
        id: toUUID(`sub_ep_${epId}`),
        movie_id: null,
        episode_id: epId,
        language: 'Sinhala',
        file_url: downloadLink,
        file_name: fileName,
        version: 'WEB-DL',
        downloads_count: downloadCount,
        uploader_id: DEFAULT_USER_ID,
        created_at: createdAt,
        updated_at: createdAt,
      });
    }

    // Telegram link
    if (telegramLink) {
      telegramLinksList.push({
        id: toUUID(`tg_ep_${epId}`),
        movie_id: null,
        episode_id: epId,
        quality: '1080p / 720p',
        size: null,
        download_url: telegramLink,
        label: 'Telegram Bot',
        clicks_count: downloadCount * 2,
        created_at: createdAt,
        updated_at: createdAt,
      });
    }
  } else {
    // Single Movie Subtitle
    if (downloadLink) {
      const fileName = extractFileName(downloadLink, `${movie.title}.${year}.Sinhala.zip`);
      subtitlesList.push({
        id: toUUID(`sub_movie_${movie.id}_${oldId}`),
        movie_id: movie.id,
        episode_id: null,
        language: 'Sinhala',
        file_url: downloadLink,
        file_name: fileName,
        version: 'WEB-DL',
        downloads_count: downloadCount,
        uploader_id: DEFAULT_USER_ID,
        created_at: createdAt,
        updated_at: createdAt,
      });
    }

    if (telegramLink) {
      telegramLinksList.push({
        id: toUUID(`tg_movie_${movie.id}_${oldId}`),
        movie_id: movie.id,
        episode_id: null,
        quality: '1080p Full HD',
        size: null,
        download_url: telegramLink,
        label: 'Telegram Bot',
        clicks_count: downloadCount * 2,
        created_at: createdAt,
        updated_at: createdAt,
      });
    }
  }

  // Unified row for newsupa.csv
  unifiedRows.push({
    id: oldId,
    title: movie.title,
    type: isTv ? 'TV_SHOW' : 'MOVIE',
    season: seasonNum || '',
    episode: episodeNum || '',
    year: year,
    rating: rating,
    genres: cleanGenres(genreStr).join(', '),
    download_link: downloadLink,
    telegram_link: telegramLink,
    image_url: imageUrl,
    description: description,
    metatags: cleanTags(metatags).join(', '),
    download_count: downloadCount,
    created_at: createdAt,
  });
});

console.log(`Movies created: ${moviesMap.size}`);
console.log(`Seasons created: ${seasonsMap.size}`);
console.log(`Episodes created: ${episodesList.length}`);
console.log(`Subtitles created: ${subtitlesList.length}`);
console.log(`Telegram Links created: ${telegramLinksList.length}`);

// ── 1. Generate newsupa.csv (The clean unified CSV requested by user) ────────
const unifiedHeader = [
  'id', 'title', 'type', 'season', 'episode', 'year', 'rating', 'genres',
  'download_link', 'telegram_link', 'image_url', 'description', 'metatags',
  'download_count', 'created_at'
];
const newsupaCsvContent = [
  unifiedHeader.join(','),
  ...unifiedRows.map(r => [
    escapeCSV(r.id),
    escapeCSV(r.title),
    escapeCSV(r.type),
    escapeCSV(r.season),
    escapeCSV(r.episode),
    escapeCSV(r.year),
    escapeCSV(r.rating),
    escapeCSV(r.genres),
    escapeCSV(r.download_link),
    escapeCSV(r.telegram_link),
    escapeCSV(r.image_url),
    escapeCSV(r.description),
    escapeCSV(r.metatags),
    escapeCSV(r.download_count),
    escapeCSV(r.created_at),
  ].join(','))
].join('\n');

fs.writeFileSync(path.join(__dirname, '..', 'newsupa.csv'), newsupaCsvContent, 'utf8');
console.log('Saved newsupa.csv successfully!');

// ── 2. Generate Supabase SQL direct insert script ────────────────────────────
const sqlLines = [];
sqlLines.push('-- ============================================================================');
sqlLines.push('-- PixelSubzLk – Data Migration from subtitles_rows.csv');
sqlLines.push('-- Run this in: Supabase Dashboard → SQL Editor → Run (Ctrl+Enter)');
sqlLines.push('-- ============================================================================');
sqlLines.push('');
sqlLines.push('-- Ensure default system user exists for uploader_id foreign key');
sqlLines.push(`INSERT INTO users (id, email, role) VALUES ('${DEFAULT_USER_ID}', 'admin@pixelsubz.lk', 'ADMIN') ON CONFLICT (id) DO NOTHING;`);
sqlLines.push('');

// Insert movies
sqlLines.push('-- 1. MOVIES');
for (const m of moviesMap.values()) {
  const genresArraySql = `ARRAY[${m.genres.map(g => `'${g.replace(/'/g, "''")}'`).join(',')}]::TEXT[]`;
  const seoArraySql = m.seo_tags.length > 0 ? `ARRAY[${m.seo_tags.map(t => `'${t.replace(/'/g, "''")}'`).join(',')}]::TEXT[]` : `'{}'::TEXT[]`;
  const descSql = m.description ? `'${m.description.replace(/'/g, "''")}'` : 'NULL';
  const posterSql = m.poster_path ? `'${m.poster_path.replace(/'/g, "''")}'` : 'NULL';
  const backdropSql = m.backdrop_path ? `'${m.backdrop_path.replace(/'/g, "''")}'` : 'NULL';
  const totalSeasonsSql = m.total_seasons !== null ? m.total_seasons : 'NULL';

  sqlLines.push(`INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('${m.id}', '${m.title.replace(/'/g, "''")}', '${m.original_title.replace(/'/g, "''")}', '${m.type}', ${descSql}, '${m.release_date}', ${m.year}, ${m.runtime}, ${m.imdb_rating}, ${genresArraySql}, ${seoArraySql}, '${m.language}', '${m.country}', '${m.status}', ${totalSeasonsSql}, ${posterSql}, ${backdropSql}, '${m.created_at}', '${m.updated_at}') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;`);
}
sqlLines.push('');

// Insert seasons
sqlLines.push('-- 2. SEASONS');
for (const s of seasonsMap.values()) {
  const descSql = s.description ? `'${s.description.replace(/'/g, "''")}'` : 'NULL';
  const posterSql = s.poster_path ? `'${s.poster_path.replace(/'/g, "''")}'` : 'NULL';
  sqlLines.push(`INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('${s.id}', '${s.movie_id}', ${s.season_number}, '${s.title.replace(/'/g, "''")}', ${descSql}, '${s.release_date}', ${posterSql}, ${s.episode_count}, '${s.created_at}', '${s.updated_at}') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;`);
}
sqlLines.push('');

// Insert episodes
sqlLines.push('-- 3. EPISODES');
for (const e of episodesList) {
  const descSql = e.description ? `'${e.description.replace(/'/g, "''")}'` : 'NULL';
  const stillSql = e.still_path ? `'${e.still_path.replace(/'/g, "''")}'` : 'NULL';
  sqlLines.push(`INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('${e.id}', '${e.season_id}', ${e.episode_number}, '${e.title.replace(/'/g, "''")}', ${descSql}, '${e.air_date}', ${e.runtime}, ${e.imdb_rating}, ${stillSql}, '${e.created_at}', '${e.updated_at}') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;`);
}
sqlLines.push('');

// Insert subtitles
sqlLines.push('-- 4. SUBTITLES');
for (const sub of subtitlesList) {
  const mIdSql = sub.movie_id ? `'${sub.movie_id}'` : 'NULL';
  const epIdSql = sub.episode_id ? `'${sub.episode_id}'` : 'NULL';
  sqlLines.push(`INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('${sub.id}', ${mIdSql}, ${epIdSql}, '${sub.language}', '${sub.file_url.replace(/'/g, "''")}', '${sub.file_name.replace(/'/g, "''")}', '${sub.version}', ${sub.downloads_count}, '${sub.uploader_id}', '${sub.created_at}', '${sub.updated_at}') ON CONFLICT (id) DO NOTHING;`);
}
sqlLines.push('');

// Insert telegram links
sqlLines.push('-- 5. TELEGRAM LINKS');
for (const tg of telegramLinksList) {
  const mIdSql = tg.movie_id ? `'${tg.movie_id}'` : 'NULL';
  const epIdSql = tg.episode_id ? `'${tg.episode_id}'` : 'NULL';
  const sizeSql = tg.size ? `'${tg.size}'` : 'NULL';
  sqlLines.push(`INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('${tg.id}', ${mIdSql}, ${epIdSql}, '${tg.quality}', ${sizeSql}, '${tg.download_url.replace(/'/g, "''")}', '${tg.label}', ${tg.clicks_count}, '${tg.created_at}', '${tg.updated_at}') ON CONFLICT (id) DO NOTHING;`);
}

fs.writeFileSync(path.join(__dirname, '..', 'import_newsupa.sql'), sqlLines.join('\n'), 'utf8');
console.log('Saved import_newsupa.sql successfully!');
