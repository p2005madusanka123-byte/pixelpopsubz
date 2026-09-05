const fs = require('fs');

async function run() {
  const log = [];
  const logLine = (msg) => {
    console.log(msg);
    log.push(msg);
  };

  logLine('=====================================================');
  logLine(' PixelSubzLk - Full Live System Verification Test');
  logLine('=====================================================\n');

  const routes = [
    { name: '1. Homepage (Real TV Counts & Subtitles)', url: 'http://127.0.0.1:3000/' },
    { name: '2. Search API: query "sons"', url: 'http://127.0.0.1:3000/api/search?q=sons' },
    { name: '3. Search API: query "sons "', url: 'http://127.0.0.1:3000/api/search?q=sons%20' },
    { name: '4. Search API: query "dragon"', url: 'http://127.0.0.1:3000/api/search?q=dragon' },
    { name: '5. Real TV Series Detail (Dexter)', url: 'http://127.0.0.1:3000/movies/b16bd0d7-79c7-48db-acbf-5b55d6be7840' },
    { name: '6. Real TV Episode (Dexter S01E01)', url: 'http://127.0.0.1:3000/movies/b16bd0d7-79c7-48db-acbf-5b55d6be7840/season/1/episode/1' },
    { name: '7. Admin Login Page (Sign In & Create Admin)', url: 'http://127.0.0.1:3000/admin/login' },
  ];

  let passed = 0;
  let failed = 0;

  for (const r of routes) {
    const t0 = Date.now();
    try {
      const res = await fetch(r.url, { headers: { 'User-Agent': 'LiveTest/1.0' } });
      const text = await res.text();
      const elapsed = Date.now() - t0;
      const ok = res.status >= 200 && res.status < 400;

      if (ok) passed++;
      else failed++;

      logLine(`[${ok ? '✓ PASS' : '✗ FAIL'}] ${r.name}`);
      logLine(`       URL: ${r.url}`);
      logLine(`       Status: ${res.status} ${res.statusText} (${elapsed}ms) | Size: ${(text.length / 1024).toFixed(1)} KB\n`);
    } catch (err) {
      failed++;
      logLine(`[✗ ERROR] ${r.name}`);
      logLine(`       URL: ${r.url}`);
      logLine(`       Error: ${err.message}\n`);
    }
  }

  logLine('-----------------------------------------------------');
  logLine(` Summary: ${passed} Passed, ${failed} Failed out of ${routes.length} tests`);
  logLine(` Overall Health: ${failed === 0 ? '🟢 100% HEALTHY & LIVE' : '🔴 SOME ISSUES DETECTED'}`);
  logLine('=====================================================');

  fs.writeFileSync('live_test_results.txt', log.join('\n'), 'utf8');
}

run();
