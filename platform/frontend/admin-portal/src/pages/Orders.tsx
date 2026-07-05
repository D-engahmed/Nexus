import { useState } from 'react'

interface Order {
  id: string
  merchantId: string
  customerName: string
  customerType: string
  items: string
  total: number
  status: string
  elapsed: string
}

const mockOrders: Order[] = [
  { id: '#4920', merchantId: 'm3', customerName: 'Marcus Sterling', customerType: 'Regular Customer', items: '2x Combo Meals,\n1x Extra Fries', total: 42.50, status: 'Pending', elapsed: '04:15' },
  { id: '#4918', merchantId: 'm1', customerName: 'Sarah Jenkins', customerType: 'New Customer', items: '1x Family Feast,\n4x Sodas', total: 89.00, status: 'Preparing', elapsed: '12:48' },
  { id: '#4915', merchantId: 'm2', customerName: 'David Chen', customerType: 'Corporate Account', items: '12x Breakfast Wraps\n(Large Order)', total: 126.20, status: 'Ready', elapsed: '18:23' },
  { id: '#4921', merchantId: 'm4', customerName: 'Elena Rodriguez', customerType: 'Frequent Diner', items: '1x Veggie Stack,\n1x Salad', total: 28.15, status: 'Pending', elapsed: '01:33' },
]

function statusBadge(status: string) {
  const map: Record<string, string> = {
    Pending: 'badge pending',
    Preparing: 'badge preparing',
    Ready: 'badge ready',
    Delayed: 'badge delayed',
  }
  return map[status] || 'badge pending'
}

export default function Orders() {
  const [filter, setFilter] = useState('All')
  const statuses = ['All', 'Pending', 'Preparing', 'Ready']
  const filtered = filter === 'All' ? mockOrders : mockOrders.filter(o => o.status === filter)

  return (
    <div>
      <div className="page-header">
        <h2>Order Queue</h2>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <div className="search-bar">🔍 Search by Order ID or Customer</div>
          <span style={{ color: 'var(--text-hint)' }}>🔔 ❓ ⚙️</span>
          <div className="status-toggle">
            <span style={{ fontSize: 13, color: 'var(--text-secondary)' }}>NAN:NAN</span>
            <div className="toggle active" />
          </div>
        </div>
      </div>

      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon orange">📦</div>
          <div>
            <div className="stat-label">Pending Orders</div>
            <div className="stat-value">12</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon blue">👨‍🍳</div>
          <div>
            <div className="stat-label">In Preparation</div>
            <div className="stat-value">08</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon green">✅</div>
          <div>
            <div className="stat-label">Ready for Pickup</div>
            <div className="stat-value">24</div>
          </div>
        </div>
      </div>

      <div className="filters">
        <span style={{ fontSize: 13, color: 'var(--text-secondary)' }}>▼ All Statuses</span>
        {statuses.map(s => (
          <button key={s} className={`filter-btn ${filter === s ? 'active' : ''}`} onClick={() => setFilter(s)}>{s}</button>
        ))}
      </div>

      <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Items</th>
                <th>Value</th>
                <th>Status</th>
                <th>Elapsed</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map(order => (
                <tr key={order.id}>
                  <td><strong style={{ color: 'var(--primary)' }}>{order.id}</strong></td>
                  <td>
                    <div style={{ fontWeight: 600 }}>{order.customerName}</div>
                    <div style={{ fontSize: 12, color: 'var(--text-secondary)' }}>{order.customerType}</div>
                  </td>
                  <td><div style={{ whiteSpace: 'pre-line', fontSize: 13 }}>{order.items}</div></td>
                  <td><strong>${order.total.toFixed(2)}</strong></td>
                  <td><span className={statusBadge(order.status)}>{order.status}</span></td>
                  <td><span className="elapsed">{order.elapsed}</span></td>
                  <td>
                    {order.status === 'Pending' && <button className="action-btn accept">Accept</button>}
                    {order.status === 'Preparing' && <button className="action-btn mark-ready">Mark Ready</button>}
                    {order.status === 'Ready' && <button className="action-btn hand-over">Hand Over</button>}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
