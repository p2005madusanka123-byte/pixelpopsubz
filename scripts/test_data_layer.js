const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

// Read env directly
const env = fs.readFileSync('.env', 'utf8');
let supaUrl = '';
let supaAnon = '';

env.split('\n').forEach(line => {
  const t = line.trim();
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_URL=')) supaUrl = t.substring('NEXT_PUBLIC_SUPABASE_URL='.length).replace(/["']/g, '').trim();
  if (t.startsWith('NEXT_PUBLIC_SUPABASE_ANON_KEY=')) supaAnon = t.substring('NEXT_PUBLIC_SUPABASE_ANON_KEY='.length).replace(/["']/g, '').trim();
});

const supabase = createClient(supaUrl, supaAnon);

async function testFetchAll() {
  console.log('--- 1. Fetch Movies with Counts ---');
  const { data: movies, error } = await supabase
    .from('movies')
    .select(`
      id, title, original_title, type, description, year, imdb_rating, genres, poster_path, backdrop_path,
      subtitles(count),
      telegram_links(count)
    `)
    .order('created_at', { ascending: false });

  if (error) {
    console.error('Error fetching movies:', error);
    return;
  }

  console.log(`Found ${movies.length} movies/shows in Supabase:`);
  movies.slice(0, 5).forEach(m => {
    console.log(`- [${m.type}] ${m.title} (${m.year}) - Genres: ${m.genres?.join(', ')}`);
  });

  if (movies.length > 0) {
    const firstId = movies[0].id;
    console.log(`\n--- 2. Fetch Detail for: ${movies[0].title} (${firstId}) ---`);
    const { data: movieDetail, error: detErr } = await supabase
      .from('movies')
      .select(`
        *,
        subtitles(*),
        telegram_links(*),
        seasons(
          *,
          episodes(
            *,
            subtitles(*),
            telegram_links(*)
          )
        )
      `)
      .eq('id', firstId)
      .single();

    if (detErr) {
      console.error('Error detail:', detErr);
    } else {
      console.log(`Title: ${movieDetail.title}`);
      console.log(`Seasons count: ${movieDetail.seasons?.length || 0}`);
      if (movieDetail.seasons?.length > 0) {
        const s1 = movieDetail.seasons[0];
        console.log(` Season 1 episodes: ${s1.episodes?.length || 0}`);
      }
    }
  }
}

testFetchAll();
