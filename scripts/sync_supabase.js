const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');

const logOutput = [];
function log(msg) {
  console.log(msg);
  logOutput.push(msg);
}

// 1. Read env files
let dbUrl = process.env.DATABASE_URL;
let supaUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
let supaAnon = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

['.env', '.env.local', '.env.production'].forEach(file => {
  const full = path.join(__dirname, '..', file);
  if (fs.existsSync(full)) {
    log(`Reading config from: ${file}`);
    const content = fs.readFileSync(full, 'utf8');
    content.split('\n').forEach(line => {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith('#')) return;
      const eqIdx = trimmed.indexOf('=');
      if (eqIdx !== -1) {
        const key = trimmed.substring(0, eqIdx).trim();
        let val = trimmed.substring(eqIdx + 1).trim();
        if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
          val = val.slice(1, -1);
        }
        if (key === 'DATABASE_URL') dbUrl = val;
        if (key === 'NEXT_PUBLIC_SUPABASE_URL') supaUrl = val;
        if (key === 'NEXT_PUBLIC_SUPABASE_ANON_KEY') supaAnon = val;
      }
    });
  }
});

log('-----------------------------------------------------');
log(`DATABASE_URL configured: ${Boolean(dbUrl)}`);
log(`NEXT_PUBLIC_SUPABASE_URL: ${supaUrl ? supaUrl : 'NOT_FOUND'}`);
log(`NEXT_PUBLIC_SUPABASE_ANON_KEY: ${supaAnon ? 'EXISTS (starts with ' + supaAnon.substring(0, 10) + '...)' : 'NOT_FOUND'}`);
log('-----------------------------------------------------');

if (!dbUrl) {
  log('❌ ERROR: DATABASE_URL is not found in .env or .env.local!');
  fs.writeFileSync(path.join(__dirname, '..', 'supabase_status.txt'), logOutput.join('\n'), 'utf8');
  process.exit(0);
}

// Clean connection string for pg
let connectionString = dbUrl;
// If connection string has direct pooler parameters or sslmode
const pool = new Pool({
  connectionString: connectionString,
  ssl: { rejectUnauthorized: false },
  connectionTimeoutMillis: 10000,
});

async function main() {
  try {
    log('Connecting to PostgreSQL database...');
    const client = await pool.connect();
    log('✅ Successfully connected to Supabase PostgreSQL database!');

    // Check existing tables
    const tableRes = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `);

    const tables = tableRes.rows.map(r => r.table_name);
    log(`Public Tables Found (${tables.length}): ${tables.join(', ') || 'None'}`);

    if (tables.includes('movies')) {
      const mc = await client.query('SELECT count(*) FROM movies;');
      log(`🎬 Total Movies/Series in DB: ${mc.rows[0].count}`);
    }
    if (tables.includes('seasons')) {
      const sc = await client.query('SELECT count(*) FROM seasons;');
      log(`📺 Total Seasons in DB: ${sc.rows[0].count}`);
    }
    if (tables.includes('episodes')) {
      const ec = await client.query('SELECT count(*) FROM episodes;');
      log(`🎞️ Total Episodes in DB: ${ec.rows[0].count}`);
    }
    if (tables.includes('subtitles')) {
      const subc = await client.query('SELECT count(*) FROM subtitles;');
      log(`📝 Total Subtitles in DB: ${subc.rows[0].count}`);
    }
    if (tables.includes('telegram_links')) {
      const tgc = await client.query('SELECT count(*) FROM telegram_links;');
      log(`✈️ Total Telegram Links in DB: ${tgc.rows[0].count}`);
    }

    client.release();
    await pool.end();
    log('\n🟢 Supabase configuration is ACTIVE and ready!');
  } catch (err) {
    log(`❌ Connection Error: ${err.message}`);
  }

  fs.writeFileSync(path.join(__dirname, '..', 'supabase_status.txt'), logOutput.join('\n'), 'utf8');
}

main();
