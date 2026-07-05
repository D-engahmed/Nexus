require('dotenv').config();
const express = require('express');
const cors = require('cors');
const http = require('http');
const authRoutes = require('./routes/auth');
const merchantRoutes = require('./routes/merchants');
const orderRoutes = require('./routes/orders');
const { setupWebSocket } = require('./websocket/tracking');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.use('/api/auth', authRoutes);
app.use('/api/merchants', merchantRoutes);
app.use('/api/orders', orderRoutes);

const server = http.createServer(app);

setupWebSocket(server);

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Nexus Backend running on http://0.0.0.0:${PORT}`);
  console.log(`WebSocket available on ws://0.0.0.0:${PORT}`);
});
