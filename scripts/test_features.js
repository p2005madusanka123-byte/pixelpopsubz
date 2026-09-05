const { fetchMovies, fetchMovieById } = require('./lib/data');

async function test() {
  console.log('======================================================');
  console.log('Testing TV Series Counts & Search Fixes');
  console.log('======================================================\n');

  // 1. Test TV Series Subtitle Count
  console.log('1. Fetching Movies/Series from Homepage query...');
  const movies = await fetchMovies({ limit: 10 });
  console.log(`Fetched ${movies.length} titles:`);
  movies.slice(0, 8).forEach(m => {
    console.log(`- [${m.type}] ${m.title} -> Subs: ${m._count?.subtitles}, TG Links: ${m._count?.telegramLinks}, Total Episodes: ${m._count?.episodes}`);
  });

  // 2. Test Search with "sons " (trailing space)
  console.log('\n2. Testing Search with "sons "...');
  const searchSons = await fetchMovies({ search: 'sons ' });
  console.log(`Search 'sons ' found ${searchSons.length} matches:`);
  searchSons.forEach(m => console.log(`  -> ${m.title} (${m.type}) - Subs: ${m._count?.subtitles}`));

  // 3. Test Search with "dragon"
  console.log('\n3. Testing Search with "dragon"...');
  const searchDragon = await fetchMovies({ search: 'dragon' });
  console.log(`Search 'dragon' found ${searchDragon.length} matches:`);
  searchDragon.forEach(m => console.log(`  -> ${m.title} (${m.type}) - Subs: ${m._count?.subtitles}`));

  // 4. Test Search with "reacher"
  console.log('\n4. Testing Search with "reacher"...');
  const searchReacher = await fetchMovies({ search: 'reacher' });
  console.log(`Search 'reacher' found ${searchReacher.length} matches:`);
  searchReacher.forEach(m => console.log(`  -> ${m.title} (${m.type}) - Subs: ${m._count?.subtitles}`));

  console.log('\n======================================================');
}

test();
