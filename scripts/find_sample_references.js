const fs = require('fs');
const path = require('path');

function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(file => {
    const p = path.join(dir, file);
    const stat = fs.statSync(p);
    if (stat && stat.isDirectory()) {
      results = results.concat(walk(p));
    } else if (file.endsWith('.ts') || file.endsWith('.tsx') || file.endsWith('.js')) {
      results.push(p);
    }
  });
  return results;
}

const files = walk('./src');
const found = [];

files.forEach(f => {
  const content = fs.readFileSync(f, 'utf8');
  const lines = content.split('\n');
  lines.forEach((l, idx) => {
    if (l.toLowerCase().includes('sample') && !l.includes('downloadSampleCsv') && !l.includes('Sample CSV Template')) {
      found.push(`${f}:${idx + 1}: ${l.trim()}`);
    }
  });
});

console.log('Found occurrences:', found.length);
found.forEach(item => console.log(item));
fs.writeFileSync('sample_check.txt', found.join('\n'), 'utf8');
