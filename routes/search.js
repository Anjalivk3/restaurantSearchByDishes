// routes/search.js
const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/dishes', async (req, res) => {
  try {
    const { name, minPrice, maxPrice } = req.query;

    // Validate required parameters
    if (!name || minPrice === undefined || maxPrice === undefined) {
      return res.status(400).json({ error: 'Missing required query parameters: name, minPrice, maxPrice' });
    }

    const min = parseFloat(minPrice);
    const max = parseFloat(maxPrice);
    if (Number.isNaN(min) || Number.isNaN(max) || min > max) {
      return res.status(400).json({ error: 'Invalid price range' });
    }

    const sql = `
      SELECT
        r.id AS restaurantId,
        r.name AS restaurantName,
        r.city AS city,
        mi.name AS dishName,
        mi.price AS dishPrice,
        COUNT(o.id) AS orderCount
      FROM restaurants r
      JOIN menu_items mi ON mi.restaurant_id = r.id
      LEFT JOIN orders o ON o.menu_item_id = mi.id
      WHERE LOWER(mi.name) LIKE CONCAT('%', LOWER(?), '%')
        AND mi.price BETWEEN ? AND ?
      GROUP BY r.id, mi.id
      HAVING orderCount > 0
      ORDER BY orderCount DESC
      LIMIT 10;
    `;

    const [rows] = await pool.execute(sql, [name, min, max]);

    return res.json({ restaurants: rows });
  } catch (err) {
    console.error('Search error:', err);
    return res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
