const http = require('http');

// Test dealers endpoint
console.log('Testing /api/dealers endpoint at http://localhost:5000/api/dealers?lat=19.07&long=72.87...\n');

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/dealers?lat=19.07&long=72.87',
  method: 'GET',
  headers: {
    'Content-Type': 'application/json'
  }
};

const req = http.request(options, (res) => {
  let data = '';
  
  console.log(`✅ Status Code: ${res.statusCode}`);
  console.log(`✅ Headers:`, res.headers);
  
  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    try {
      const dealers = JSON.parse(data);
      console.log('\n✅ Dealers API is Working!');
      console.log(`✅ Found ${dealers.length} dealers nearby\n`);
      dealers.forEach((d, i) => {
        console.log(`   ${i + 1}. ${d.name}`);
        console.log(`      Rating: ${d.rating} ⭐`);
        console.log(`      Stock: ${d.stock.join(', ')}`);
      });
      console.log('\n✅ Backend is fully functional!');
      process.exit(0);
    } catch (e) {
      console.error('❌ Error parsing response:', e.message);
      console.error('Response:', data);
      process.exit(1);
    }
  });
});

req.on('error', (e) => {
  console.error('❌ Connection Error:', e.message);
  console.error('Make sure backend is running on port 5000');
  process.exit(1);
});

req.end();
