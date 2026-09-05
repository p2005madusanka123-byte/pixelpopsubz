const fs = require('fs');

async function main() {
  console.log('Testing http://127.0.0.1:3000/...');
  try {
    const res = await fetch('http://127.0.0.1:3000/');
    console.log('Status:', res.status, res.statusText);
    const text = await res.text();
    fs.writeFileSync('html_err.txt', text, 'utf8');
    console.log('HTML snippet:', text.substring(0, 500));
  } catch (err) {
    console.error('Error:', err.message);
    fs.writeFileSync('single_test.txt', `Error: ${err.message}`, 'utf8');
  }
}

main();
