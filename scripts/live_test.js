const http = require('http');

const BASE_URL = 'http://127.0.0.1:3000';

const endpoints = [
  { name: 'Homepage (Browse all)', path: '/' },
  { name: 'Movies Filter', path: '/?type=MOVIE' },
  { name: 'TV Series Filter', path: '/?type=TV_SHOW' },
  { name: 'Movie Detail (Deadpool)', path: '/movies/sample-1' },
  { name: 'TV Series Detail (Stranger Things)', path: '/movies/sample-2' },
  { name: 'Dedicated Episode Page (S01E01)', path: '/movies/sample-2/season/1/episode/1' },
  { name: 'Dedicated Episode Page (S01E02)', path: '/movies/sample-2/season/1/episode/2' },
  { name: 'Dedicated Episode Page (S02E01)', path: '/movies/sample-2/season/2/episode/1' },
  { name: 'Dedicated Episode Page (The Last of Us)', path: '/movies/sample-7/season/1/episode/1' },
  { name: 'Admin Login Page', path: '/admin/login' },
  { name: 'Search API', path: '/api/search?q=deadpool' },
];

function testEndpoint(ep) {
  return new Promise((resolve) => {
    const start = Date.now();
    const req = http.get(BASE_URL + ep.path, (res) => {
      let data = '';
      res.on('data', chunk => { data += chunk; });
      res.on('end', () => {
        const duration = Date.now() - start;
        resolve({
          name: ep.name,
          path: ep.path,
          status: res.statusCode,
          duration: `${duration}ms`,
          bytes: data.length,
          ok: res.statusCode === 200,
        });
      });
    });

    req.on('error', (err) => {
      resolve({
        name: ep.name,
        path: ep.path,
        status: 'ERROR',
        error: err.message,
        ok: false,
      });
    });

    req.setTimeout(120000, () => {
      req.destroy();
      resolve({
        name: ep.name,
        path: ep.path,
        status: 'TIMEOUT',
        ok: false,
      });
    });
  });
}

(async () => {
  console.log('Starting PixelSubzLk Live Test on http://localhost:3000 ...\n');
  const results = [];
  for (const ep of endpoints) {
    process.stdout.write(`Testing ${ep.name} (${ep.path})... `);
    const res = await testEndpoint(ep);
    console.log(`[Status: ${res.status}] (${res.duration || ''}) - ${res.ok ? '✓ PASS' : '✗ FAIL'}`);
    results.push(res);
  }

  console.log('\n=============================================');
  console.log('LIVE TEST SUMMARY');
  console.log('=============================================');
  const allPassed = results.every(r => r.ok);
  console.log(`Total Endpoints Tested: ${results.length}`);
  console.log(`Passed: ${results.filter(r => r.ok).length}`);
  console.log(`Failed: ${results.filter(r => !r.ok).length}`);
  console.log(`Overall Result: ${allPassed ? 'ALL SYSTEMS OPERATIONAL (100% PASS)' : 'SOME TESTS FAILED'}`);
  console.log('=============================================\n');
})();
