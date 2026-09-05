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

const supabase = createClient(supaUrl, supaAnon);

async function test() {
  console.log('--- 1. Testing TV Series Subtitle Count Computation ---');
  const { data: movies, error } = await supabase
    .from('movies')
    .select(`
      id, title, type,
      subtitles(id),
      telegram_links(id),
      seasons(
        id, season_number,
        episodes(
          id, episode_number,
          subtitles(id),
          telegram_links(id)
        )
      )
    `)
    .limit(10);

  if (error) {
    console.error('Error:', error);
    return;
  }

  const out = [];
  movies.forEach(m => {
    let directSubs = m.subtitles?.length || 0;
    let epSubs = 0;
    let totalEps = 0;
    if (m.seasons) {
      for (const s of m.seasons) {
        if (s.episodes) {
          totalEps += s.episodes.length;
          for (const ep of s.episodes) {
            epSubs += ep.subtitles?.length || 0;
          }
        }
      }
    }
    const totalSubs = directSubs + epSubs;
    out.push(`- [${m.type}] ${m.title} -> Total Subs: ${totalSubs} (Episodes: ${totalEps})`);
  });

  out.push('\n--- 2. Testing Search with "sons " (trailing space) ---');
  const q = 'sons '.trim().toLowerCase();
  const { data: searchSons } = await supabase
    .from('movies')
    .select('id, title, type')
    .or(`title.ilike.%${q}%,original_title.ilike.%${q}%,description.ilike.%${q}%`);
  out.push(`Found ${searchSons?.length || 0} matches: ${JSON.stringify(searchSons?.map(s => s.title))}`);

  out.push('\n--- 3. Testing Search with "dragon" ---');
  const q2 = 'dragon'.trim().toLowerCase();
  const { data: searchDragon } = await supabase
    .from('movies')
    .select('id, title, type')
    .or(`title.ilike.%${q2}%,original_title.ilike.%${q2}%,description.ilike.%${q2}%`);
  out.push(`Found ${searchDragon?.length || 0} matches: ${JSON.stringify(searchDragon?.map(s => s.title))}`);

  fs.writeFileSync('feature_test_result.txt', out.join('\n'), 'utf8');
  console.log(out.join('\n'));
}

test();
