const express = require('express');
const Dealer = require('../models/Dealer');
const router = express.Router();

// GET /api/dealers?lat=19.07&long=72.87
router.get('/', async (req, res) => {
  const { lat, long } = req.query;

  try {
    const dealers = await Dealer.find({
      location: {
        $near: {
          $geometry: {
            type: "Point",
            coordinates: [parseFloat(long), parseFloat(lat)]
          },
          $maxDistance: 5000 // 5km radius
        }
      }
    });
    res.json(dealers);
  } catch (error) {
    console.error("❌ Dealer API Error:", error);

    // Check if it's an error from Google Maps API
    const googleError = error.response ? error.response.data : "No Google details";

    res.status(500).json({
      error: "Failed to fetch dealers",
      details: error.message,
      google_error: googleError // <--- This reveals the "Why"
    });
  }
});

module.exports = router;
