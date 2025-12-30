const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

const Dealer = require('./models/Dealer');

async function testDealersDB() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ Connected to MongoDB');

    const dealers = await Dealer.find().limit(5);
    console.log(`✅ Found ${dealers.length} dealers in database:`);
    dealers.forEach((d, i) => {
      console.log(`   ${i + 1}. ${d.name} - Rating: ${d.rating}⭐`);
    });

    // Test geospatial query
    const nearby = await Dealer.find({
      location: {
        $near: {
          $geometry: {
            type: "Point",
            coordinates: [72.87, 19.07]
          },
          $maxDistance: 5000
        }
      }
    });

    console.log(`\n✅ Geospatial query found ${nearby.length} dealers within 5km`);
    nearby.forEach((d, i) => {
      console.log(`   ${i + 1}. ${d.name}`);
    });

    await mongoose.disconnect();
    console.log('\n✅ All database tests passed!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

testDealersDB();
