const dns = require('dns');

dns.lookup('bymnijrmbemrqtlybees.supabase.co', (err, address) => {
  if (err) {
    console.error('DNS Lookup Error:', err);
  } else {
    console.log('DNS Lookup Success, IP:', address);
  }
});
