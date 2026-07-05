import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts'

const chartData = [
  { day: 'Mon', orders: 45, deliveries: 38 },
  { day: 'Tue', orders: 52, deliveries: 44 },
  { day: 'Wed', orders: 38, deliveries: 35 },
  { day: 'Thu', orders: 61, deliveries: 55 },
  { day: 'Fri', orders: 48, deliveries: 42 },
  { day: 'Sat', orders: 72, deliveries: 65 },
  { day: 'Sun', orders: 56, deliveries: 50 },
]

const pieData = [
  { name: 'Food', value: 45, color: '#E8600A' },
  { name: 'Groceries', value: 25, color: '#22C7B8' },
  { name: 'Pharmacy', value: 15, color: '#F59E0B' },
  { name: 'Other', value: 15, color: '#6B7280' },
]

export default function Dashboard() {
  return (
    <div>
      <div className="page-header">
        <h2>Dashboard</h2>
        <div className="search-bar">🔍 Search</div>
      </div>

      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon orange">📦</div>
          <div>
            <div className="stat-label">Total Orders</div>
            <div className="stat-value">372</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon blue">🚚</div>
          <div>
            <div className="stat-label">Active Drivers</div>
            <div className="stat-value">18</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon green">💰</div>
          <div>
            <div className="stat-label">Revenue (MTD)</div>
            <div className="stat-value">$28.4k</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon orange">⏱️</div>
          <div>
            <div className="stat-label">Avg Delivery</div>
            <div className="stat-value">28 min</div>
          </div>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: 14 }}>
        <div className="card">
          <div className="card-header">
            <h3>Weekly Orders & Deliveries</h3>
          </div>
          <div style={{ height: 280 }}>
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={chartData}>
                <CartesianGrid strokeDasharray="3 3" stroke="#E8E8E8" />
                <XAxis dataKey="day" stroke="#6B7280" fontSize={12} />
                <YAxis stroke="#6B7280" fontSize={12} />
                <Tooltip />
                <Bar dataKey="orders" fill="#E8600A" radius={[6,6,0,0]} name="Orders" />
                <Bar dataKey="deliveries" fill="#22C7B8" radius={[6,6,0,0]} name="Deliveries" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
        <div className="card">
          <div className="card-header">
            <h3>Order Categories</h3>
          </div>
          <div style={{ height: 200, display: 'flex', justifyContent: 'center' }}>
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={pieData} cx="50%" cy="50%" innerRadius={50} outerRadius={80} dataKey="value" paddingAngle={3}>
                  {pieData.map((entry, i) => <Cell key={i} fill={entry.color} />)}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 12, justifyContent: 'center' }}>
            {pieData.map(d => (
              <div key={d.name} style={{ display: 'flex', alignItems: 'center', gap: 6, fontSize: 12 }}>
                <div style={{ width: 10, height: 10, borderRadius: 3, background: d.color }} />
                <span>{d.name} ({d.value}%)</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="stats-grid" style={{ marginTop: 14 }}>
        <div className="stat-card">
          <div className="stat-icon green">⭐</div>
          <div>
            <div className="stat-label">Customer Rating</div>
            <div className="stat-value">4.7</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon blue">🎯</div>
          <div>
            <div className="stat-label">On-Time Rate</div>
            <div className="stat-value">94%</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon orange">🔄</div>
          <div>
            <div className="stat-label">Repeat Rate</div>
            <div className="stat-value">68%</div>
          </div>
        </div>
      </div>
    </div>
  )
}
