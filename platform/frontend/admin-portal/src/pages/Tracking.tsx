import { useState, useEffect } from 'react'

interface DriverPosition { orderId: string; driverId: string; lat: number; lng: number; timestamp: string }

const customerPos = { lat: 30.0626, lng: 31.2497 }
const merchantPos = { name: 'Pizza Roma', lat: 30.0444, lng: 31.2357 }

function project(lat: number, lng: number, minLat: number, maxLat: number, minLng: number, maxLng: number, w: number, h: number) {
  return {
    x: ((lng - minLng) / (maxLng - minLng)) * (w - 60) + 30,
    y: ((maxLat - lat) / (maxLat - minLat)) * (h - 60) + 30,
  }
}

export default function Tracking() {
  const [positions, setPositions] = useState<Record<string, DriverPosition>>({})

  useEffect(() => {
    const ws = new WebSocket('ws://localhost:3000')
    ws.onopen = () => {
      ws.send(JSON.stringify({ type: 'subscribe_order', orderId: 'NEX-0001' }))
    }
    ws.onmessage = (event) => {
      const data = JSON.parse(event.data)
      if (data.type === 'driver_location') {
        setPositions(prev => ({ ...prev, [data.orderId]: data }))
      }
    }
    return () => ws.close()
  }, [])

  const pos = positions['NEX-0001']
  const allLats = [customerPos.lat, merchantPos.lat, ...(pos ? [pos.lat] : [])]
  const allLngs = [customerPos.lng, merchantPos.lng, ...(pos ? [pos.lng] : [])]

  const minLat = Math.min(...allLats) - 0.003
  const maxLat = Math.max(...allLats) + 0.003
  const minLng = Math.min(...allLngs) - 0.003
  const maxLng = Math.max(...allLngs) + 0.003

  const mp = project(merchantPos.lat, merchantPos.lng, minLat, maxLat, minLng, maxLng, 800, 400)
  const cp = project(customerPos.lat, customerPos.lng, minLat, maxLat, minLng, maxLng, 800, 400)
  const dp = pos ? project(pos.lat, pos.lng, minLat, maxLat, minLng, maxLng, 800, 400) : mp

  return (
    <div>
      <div className="page-header">
        <h2>Live Tracking</h2>
        <div className="status-badge online">● Live</div>
      </div>

      <div className="card">
        <div className="card-header">
          <h3>Fleet Overview</h3>
          <span style={{ fontSize: 13, color: 'var(--text-secondary)' }}>
            {Object.keys(positions).length} active deliveries
          </span>
        </div>
        <div className="map-container">
          <svg width="100%" height="100%" viewBox="0 0 800 400" preserveAspectRatio="xMidYMid meet">
            <rect width="800" height="400" fill="#E8F5E9" rx="14" />
            {Array.from({ length: 20 }).map((_, i) => (
              <line key={`v${i}`} x1={i * 40} y1={0} x2={i * 40} y2={400} stroke="rgba(255,255,255,0.5)" strokeWidth={1} />
            ))}
            {Array.from({ length: 10 }).map((_, i) => (
              <line key={`h${i}`} x1={0} y1={i * 40} x2={800} y2={i * 40} stroke="rgba(255,255,255,0.5)" strokeWidth={1} />
            ))}
            <line x1={mp.x} y1={mp.y} x2={cp.x} y2={cp.y} stroke="#E8600A" strokeWidth={3} strokeDasharray="8,4" opacity={0.5} />
            <circle cx={mp.x} cy={mp.y} r={10} fill="#F59E0B" stroke="white" strokeWidth={2} />
            <text x={mp.x} y={mp.y - 16} textAnchor="middle" fontSize={11} fill="#1A1A2E" fontWeight={700}>{merchantPos.name}</text>
            <circle cx={cp.x} cy={cp.y} r={8} fill="#10B981" stroke="white" strokeWidth={2} />
            <text x={cp.x} y={cp.y - 14} textAnchor="middle" fontSize={11} fill="#1A1A2E" fontWeight={700}>Customer</text>
            {pos && (
              <>
                <circle cx={dp.x} cy={dp.y} r={12} fill="#E8600A" stroke="white" strokeWidth={3} />
                <circle cx={dp.x} cy={dp.y} r={20} fill="none" stroke="#E8600A" strokeWidth={2} opacity={0.3}>
                  <animate attributeName="r" values="12;28;12" dur="2s" repeatCount="indefinite" />
                  <animate attributeName="opacity" values="0.6;0;0.6" dur="2s" repeatCount="indefinite" />
                </circle>
                <text x={dp.x} y={dp.y - 22} textAnchor="middle" fontSize={11} fill="#E8600A" fontWeight={800}>NEX-0001</text>
              </>
            )}
          </svg>
        </div>
      </div>

      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon orange">🚚</div>
          <div>
            <div className="stat-label">Active Deliveries</div>
            <div className="stat-value">{Object.keys(positions).length}</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon blue">⚡</div>
          <div>
            <div className="stat-label">Avg Speed</div>
            <div className="stat-value">32 km/h</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon green">🎯</div>
          <div>
            <div className="stat-label">ETA Accuracy</div>
            <div className="stat-value">92%</div>
          </div>
        </div>
      </div>
    </div>
  )
}
