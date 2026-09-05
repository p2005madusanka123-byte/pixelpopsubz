const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

const env = fs.readFileSync('.env', 'utf8');
let supaUrl = '';
let supaAnon = '';

env.split('\n').forEach(line => {
  const t = line.trim();
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_URL=')) {
    supaUrl = t.substring('NEXT_PUBLIC_SUPABASE_URL='.length).replace(/["']/g, '').trim();
  }
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_ANON_KEY=')) {
    supaAnon = t.substring('NEXT_PUBLIC_SUPABASE_ANON_KEY='.length).replace(/["']/g, '').trim();
  }
});

console.log('URL:', supaUrl);
console.log('Anon Key exists:', Boolean(supaAnon));

const supabase = createClient(supaUrl, supaAnon);

async function test() {
  const out = [];
  try {
    const { data, error } = await supabase.from('movies').select('id, title').limit(5);
    if (error) {
      out.push(`Query result: ${error.message}`);
    } else {
      out.push(`✅ Supabase REST API connected successfully! Movies count: ${data.length}`);
      out.push(`Data: ${JSON.stringify(data)}`);
    }
  } catch (err) {
    out.push(`Fetch exception: ${err.message}`);
  }
  fs.writeFileSync('supa_client_result.txt', out.join('\n'), 'utf8');
  console.log(out.join('\n'));
}

test();
