const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

const env = fs.readFileSync('.env', 'utf8');
let supaUrl = '';
let supaAnon = '';

env.split('\n').forEach(line => {
  const t = line.trim();
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_URL=')) supaUrl = t.substring('NEXT_PUBLIC_SUPABASE_URL='.length).replace(/["']/g, '').trim();
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_ANON_KEY=')) supaAnon = t.substring('NEXT_PUBLIC_SUPABASE_ANON_KEY='.length).replace(/["']/g, '').trim();
});

console.log('Supabase URL:', supaUrl);
const supabase = createClient(supaUrl, supaAnon);

async function check() {
  const out = [];
  out.push('Supabase URL: ' + supaUrl);
  const { data: users, error } = await supabase.from('users').select('*');
  if (error) {
    out.push('Error querying public.users: ' + error.message);
  } else {
    out.push('Users in public.users table: ' + JSON.stringify(users));
  }
  fs.writeFileSync('auth_status.txt', out.join('\n'), 'utf8');
  console.log(out.join('\n'));
}

check();
