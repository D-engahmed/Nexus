const { WebSocketServer } = require('ws');
const { drivers, customerPos } = require('../mockData');

function setupWebSocket(server) {
  const wss = new WebSocketServer({ server });

  wss.on('connection', (ws, req) => {
    console.log('WebSocket client connected');

    ws.on('message', (data) => {
      try {
        const msg = JSON.parse(data.toString());
        handleMessage(ws, msg);
      } catch (e) {
        ws.send(JSON.stringify({ type: 'error', message: 'Invalid JSON' }));
      }
    });

    ws.on('close', () => console.log('WebSocket client disconnected'));
  });

  return wss;
}

function handleMessage(ws, msg) {
  switch (msg.type) {
    case 'subscribe_order':
      ws.orderId = msg.orderId;
      ws.send(JSON.stringify({ type: 'subscribed', orderId: msg.orderId }));
      break;

    case 'driver_location':
      broadcastDriverLocation(msg);
      break;

    default:
      ws.send(JSON.stringify({ type: 'error', message: `Unknown type: ${msg.type}` }));
  }
}

function broadcastDriverLocation(msg) {
  const { orderId, lat, lng, driverId } = msg;
  const payload = JSON.stringify({
    type: 'driver_location',
    orderId,
    driverId,
    lat,
    lng,
    timestamp: new Date().toISOString(),
  });

  wss.clients.forEach(client => {
    if (client.orderId === orderId && client.readyState === 1) {
      client.send(payload);
    }
  });
}

function simulateDelivery(orderId, merchantLat, merchantLng, driver) {
  const steps = 30;
  let step = 0;
  const interval = setInterval(() => {
    step++;
    const t = step / steps;
    const lat = merchantLat + (customerPos.lat - merchantLat) * t;
    const lng = merchantLng + (customerPos.lng - merchantLng) * t;

    broadcastDriverLocation({
      orderId,
      driverId: driver.id,
      lat,
      lng,
    });

    if (step >= steps) {
      clearInterval(interval);
    }
  }, 3000);
}

module.exports = { setupWebSocket, simulateDelivery };
