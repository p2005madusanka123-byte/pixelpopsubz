const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supaUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supaKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

const supabase = createClient(supaUrl, supaKey);

async function main() {
  const { data: movies, error } = await supabase.from('movies').select('id, title, type').limit(10);
  if (error) {
    console.error('Supabase error:', error);
    return;
  }
  console.log('Real Database Movies:', movies);
}

main();
