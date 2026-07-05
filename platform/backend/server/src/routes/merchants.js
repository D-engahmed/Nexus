const express = require('express');
const { merchants, menus } = require('../mockData');

const router = express.Router();

router.get('/', (req, res) => {
  res.json(merchants);
});

router.get('/:id', (req, res) => {
  const merchant = merchants.find(m => m.id === req.params.id);
  if (!merchant) return res.status(404).json({ error: 'Merchant not found' });
  res.json(merchant);
});

router.get('/:id/menu', (req, res) => {
  const menu = menus[req.params.id];
  if (!menu) return res.status(404).json({ error: 'Menu not found' });
  res.json(menu);
});

module.exports = router;
