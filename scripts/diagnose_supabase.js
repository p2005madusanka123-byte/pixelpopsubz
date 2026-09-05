const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

console.log('URL:', url);
console.log('Key:', anonKey ? anonKey.substring(0, 15) + '...' : 'NONE');

const supabase = createClient(url, anonKey);

async function test() {
  console.log('\n1. Testing basic select from movies:');
  const r1 = await supabase.from('movies').select('*');
  if (r1.error) {
    console.error('Error in r1:', r1.error);
  } else {
    console.log('r1 Count:', r1.data?.length);
    if (r1.data?.length > 0) {
      console.log('First movie:', r1.data[0].title);
    }
  }

  console.log('\n2. Testing nested select with foreign keys:');
  const r2 = await supabase.from('movies').select('id, title, subtitles(id), seasons(id, episodes(id))');
  if (r2.error) {
    console.error('Error in r2:', r2.error);
  } else {
    console.log('r2 Count:', r2.data?.length);
  }
}

test();
