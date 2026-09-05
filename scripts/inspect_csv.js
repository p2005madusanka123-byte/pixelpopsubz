const fs = require('fs');
const path = require('path');

// Simple CSV parser handling quotes and multiline fields
function parseCSV(text) {
  const rows = [];
  let currentRow = [];
  let currentField = '';
  let inQuotes = false;

  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    const nextChar = text[i + 1];

    if (char === '"') {
      if (inQuotes && nextChar === '"') {
        currentField += '"';
        i++; // skip next quote
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      currentRow.push(currentField);
      currentField = '';
    } else if ((char === '\r' || char === '\n') && !inQuotes) {
      if (char === '\r' && nextChar === '\n') {
        i++;
      }
      currentRow.push(currentField);
      currentField = '';
      if (currentRow.length > 1 || currentRow[0] !== '') {
        rows.push(currentRow);
      }
      currentRow = [];
    } else {
      currentField += char;
    }
  }

  if (currentField || currentRow.length > 0) {
    currentRow.push(currentField);
    rows.push(currentRow);
  }

  return rows;
}

const raw = fs.readFileSync(path.join(__dirname, '..', 'subtitles_rows.csv'), 'utf8');
const rows = parseCSV(raw);
const headers = rows[0];
const dataRows = rows.slice(1);

console.log('Headers:', headers);
console.log('Total parsed rows:', dataRows.length);

// Sample first 3 parsed rows
console.log('\nSample Row 1:');
headers.forEach((h, idx) => {
  console.log(`  ${h}: ${dataRows[0][idx] ? dataRows[0][idx].substring(0, 80) : ''}`);
});

console.log('\nSample Row 2:');
headers.forEach((h, idx) => {
  console.log(`  ${h}: ${dataRows[1][idx] ? dataRows[1][idx].substring(0, 80) : ''}`);
});

// Count TV vs Movie
let tvCount = 0;
let movieCount = 0;
let seasonsFound = new Set();
let titles = new Set();

dataRows.forEach(r => {
  const title = r[2];
  const season = r[9];
  const ep = r[10];
  const genre = r[5] || '';
  titles.add(title);
  if (season || ep || genre.toLowerCase().includes('tv series') || genre.toLowerCase().includes('tv_show')) {
    tvCount++;
    if (season) seasonsFound.add(`${title} S${season}`);
  } else {
    movieCount++;
  }
});

console.log('\nSummary:');
console.log('Unique titles:', titles.size);
console.log('TV / Episode rows:', tvCount);
console.log('Movie rows:', movieCount);
