const express = require('express');
const jwt = require('jsonwebtoken');
const { users, drivers } = require('../mockData');

const router = express.Router();

router.post('/login', (req, res) => {
  const { email, password, role } = req.body;
  let user;

  if (role === 'driver') {
    user = drivers.find(d => d.email === email && d.password === password);
  } else {
    user = users.find(u => u.email === email && u.password === password);
  }

  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }

  const token = jwt.sign(
    { id: user.id, email: user.email, role: user.role || role },
    process.env.JWT_SECRET || 'dev-secret',
    { expiresIn: '24h' }
  );

  const { password: _, ...safeUser } = user;
  res.json({ token, user: safeUser });
});

router.get('/me', (req, res) => {
  const auth = req.headers.authorization;
  if (!auth) return res.status(401).json({ error: 'No token' });

  try {
    const decoded = jwt.verify(auth.replace('Bearer ', ''), process.env.JWT_SECRET || 'dev-secret');
    const allUsers = [...users, ...drivers];
    const user = allUsers.find(u => u.id === decoded.id);
    if (!user) return res.status(404).json({ error: 'User not found' });
    const { password: _, ...safeUser } = user;
    res.json(safeUser);
  } catch {
    res.status(401).json({ error: 'Invalid token' });
  }
});

module.exports = router;
