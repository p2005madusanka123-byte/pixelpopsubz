const os = require('os');
const fs = require('fs');

const nets = os.networkInterfaces();
const ips = [];

for (const name of Object.keys(nets)) {
  for (const net of nets[name]) {
    // Skip over non-IPv4 and internal (i.e. 127.0.0.1) addresses
    if (net.family === 'IPv4' && !net.internal) {
      ips.push({ interface: name, address: net.address });
    }
  }
}

console.log('Local IP Addresses:', JSON.stringify(ips, null, 2));
fs.writeFileSync('local_ips.json', JSON.stringify(ips, null, 2), 'utf8');
