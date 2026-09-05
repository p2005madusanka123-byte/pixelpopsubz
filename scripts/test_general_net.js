async function test() {
  console.log('Testing https://httpbin.org/get...');
  try {
    const res = await fetch('https://httpbin.org/get');
    console.log('httpbin status:', res.status);
  } catch (e) {
    console.error('httpbin error:', e.message);
  }

  console.log('\nTesting https://bymnijrmbemrqtlybees.supabase.co...');
  try {
    const res2 = await fetch('https://bymnijrmbemrqtlybees.supabase.co/rest/v1/', {
      headers: {
        'apikey': 'sb_publishable_DiOecfN4JheksfuH0x9oTA_aPAO9tci',
      },
    });
    console.log('supabase status:', res2.status);
    const text = await res2.text();
    console.log('supabase response:', text);
  } catch (e) {
    console.error('supabase error:', e.message);
  }
}

test();
