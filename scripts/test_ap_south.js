const fs = require('fs');
const { Pool } = require('pg');

const env = fs.readFileSync('.env', 'utf8');
let password = '';
const match = env.match(/DATABASE_URL=["']?postgresql:\/\/[^:]+:([^@]+)@/);
if (match) {
  password = decodeURIComponent(match[1]);
}

const pool = new Pool({
  host: 'aws-0-ap-south-1.pooler.supabase.com',
  port: 6543,
  user: 'postgres.bymnijrmbemrqtlybees',
  password: password,
  database: 'postgres',
  ssl: { rejectUnauthorized: false },
  connectionTimeoutMillis: 7000,
});

async function main() {
  try {
    const client = await pool.connect();
    const res = await client.query('SELECT 1 as test');
    console.log('✅ CONNECTED TO SUPABASE (ap-south-1 Pooler)! Result:', res.rows);

    const tables = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `);
    console.log('Public tables in Supabase:', tables.rows.map(r => r.table_name));

    client.release();
    await pool.end();
  } catch (err) {
    console.log('❌ Error with ap-south-1 pooler:', err.message);
    await pool.end().catch(() => {});
  }
}

main();
