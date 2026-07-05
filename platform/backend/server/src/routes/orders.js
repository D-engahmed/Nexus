const express = require('express');
const jwt = require('jsonwebtoken');
const { orders, orderCounter } = require('../mockData');

const router = express.Router();

function auth(req, res, next) {
  const auth = req.headers.authorization;
  if (!auth) return res.status(401).json({ error: 'No token' });
  try {
    req.user = jwt.verify(auth.replace('Bearer ', ''), process.env.JWT_SECRET || 'dev-secret');
    next();
  } catch {
    res.status(401).json({ error: 'Invalid token' });
  }
}

router.use(auth);

router.get('/', (req, res) => {
  const userOrders = orders.filter(o => o.customerId === req.user.id || o.driverId === req.user.id);
  res.json(userOrders);
});

router.post('/', (req, res) => {
  const { merchantId, items, total, address } = req.body;
  const order = {
    id: `NEX-${(orders.length + 1).toString().padStart(4, '0')}`,
    customerId: req.user.id,
    merchantId,
    items,
    total,
    address: address || '42 Nile St, Garden City',
    status: 'CONFIRMED',
    createdAt: new Date().toISOString(),
    driverId: null,
  };
  orders.unshift(order);
  res.status(201).json(order);
});

router.get('/:id', (req, res) => {
  const order = orders.find(o => o.id === req.params.id);
  if (!order) return res.status(404).json({ error: 'Order not found' });
  res.json(order);
});

router.patch('/:id/status', (req, res) => {
  const order = orders.find(o => o.id === req.params.id);
  if (!order) return res.status(404).json({ error: 'Order not found' });
  order.status = req.body.status;
  if (req.body.driverId) order.driverId = req.body.driverId;
  res.json(order);
});

module.exports = router;
