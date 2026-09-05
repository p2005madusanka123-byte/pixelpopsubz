const fs = require('fs');
const { Pool } = require('pg');

const env = fs.readFileSync('.env', 'utf8');
let password = '';
const match = env.match(/DATABASE_URL=["']?postgresql:\/\/[^:]+:([^@]+)@/);
if (match) {
  password = match[1];
}

const projectRef = 'bymnijrmbemrqtlybees';

const hostsToTry = [
  // Direct connection
  { name: 'Direct (db.projectRef.supabase.co:5432)', host: `db.${projectRef}.supabase.co`, port: 5432, user: 'postgres' },
  { name: 'Direct (db.projectRef.supabase.co:6543)', host: `db.${projectRef}.supabase.co`, port: 6543, user: 'postgres' },
  // Poolers
  { name: 'Pooler ap-southeast-1 (6543)', host: 'aws-0-ap-southeast-1.pooler.supabase.com', port: 6543, user: `postgres.${projectRef}` },
  { name: 'Pooler ap-southeast-1 (5432)', host: 'aws-0-ap-southeast-1.pooler.supabase.com', port: 5432, user: `postgres.${projectRef}` },
  { name: 'Pooler ap-southeast-2 (6543)', host: 'aws-0-ap-southeast-2.pooler.supabase.com', port: 6543, user: `postgres.${projectRef}` },
  { name: 'Pooler us-east-1 (6543)', host: 'aws-0-us-east-1.pooler.supabase.com', port: 6543, user: `postgres.${projectRef}` },
  { name: 'Pooler eu-central-1 (6543)', host: 'aws-0-eu-central-1.pooler.supabase.com', port: 6543, user: `postgres.${projectRef}` },
  { name: 'Pooler ap-south-1 (6543)', host: 'aws-0-ap-south-1.pooler.supabase.com', port: 6543, user: `postgres.${projectRef}` },
];

async function testOne(h) {
  const pool = new Pool({
    host: h.host,
    port: h.port,
    user: h.user,
    password: decodeURIComponent(password),
    database: 'postgres',
    ssl: { rejectUnauthorized: false },
    connectionTimeoutMillis: 5000,
  });

  try {
    const client = await pool.connect();
    const res = await client.query('SELECT 1 as test');
    client.release();
    await pool.end();
    return { ...h, ok: true };
  } catch (err) {
    await pool.end().catch(() => {});
    return { ...h, ok: false, error: err.message };
  }
}

(async () => {
  console.log('Testing Supabase DB endpoints...');
  for (const h of hostsToTry) {
    process.stdout.write(`Testing ${h.name}... `);
    const res = await testOne(h);
    if (res.ok) {
      console.log('✅ SUCCESS!');
      console.log(`\nWORKING CONNECTION DETAILS:`);
      console.log(`Host: ${h.host}`);
      console.log(`Port: ${h.port}`);
      console.log(`User: ${h.user}`);
      return;
    } else {
      console.log(`❌ Failed: ${res.error}`);
    }
  }
})();
