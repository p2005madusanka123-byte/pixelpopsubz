const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');

// Read .env or .env.local manually
function loadEnv() {
  ['.env', '.env.local', '.env.production'].forEach(file => {
    const full = path.join(__dirname, '..', file);
    if (fs.existsSync(full)) {
      console.log(`Loading env file: ${file}`);
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
          if (!process.env[key]) {
            process.env[key] = val;
          }
        }
      });
    }
  });
}

loadEnv();

console.log('DATABASE_URL configured:', Boolean(process.env.DATABASE_URL));
console.log('NEXT_PUBLIC_SUPABASE_URL configured:', Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL));
console.log('NEXT_PUBLIC_SUPABASE_ANON_KEY configured:', Boolean(process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY));

if (!process.env.DATABASE_URL) {
  console.error('ERROR: DATABASE_URL is not set in .env!');
  process.exit(1);
}

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

async function testConnection() {
  try {
    const client = await pool.connect();
    console.log('Successfully connected to Supabase PostgreSQL database!');

    // Test tables existence
    const res = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `);
    console.log('Existing public tables:', res.rows.map(r => r.table_name));

    // Count movies
    if (res.rows.some(r => r.table_name === 'movies')) {
      const moviesCount = await client.query('SELECT count(*) FROM movies;');
      console.log('Movies count in DB:', moviesCount.rows[0].count);
    }

    client.release();
    await pool.end();
  } catch (err) {
    console.error('Database connection error:', err.message);
  }
}

testConnection();
