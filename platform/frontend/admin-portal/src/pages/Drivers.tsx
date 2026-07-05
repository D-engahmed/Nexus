import { useState } from 'react'

interface Driver {
  id: string; name: string; photo: string; vehicle: string; rating: number; deliveries: number; online: boolean
}

const drivers: Driver[] = [
  { id: 'd1', name: 'Ahmed Hassan', photo: 'https://i.pravatar.cc/150?u=driver1', vehicle: 'Toyota Corolla', rating: 4.8, deliveries: 342, online: true },
  { id: 'd2', name: 'Mohamed Ali', photo: 'https://i.pravatar.cc/150?u=driver2', vehicle: 'Honda Civic', rating: 4.6, deliveries: 218, online: true },
  { id: 'd3', name: 'Sara Ibrahim', photo: 'https://i.pravatar.cc/150?u=driver3', vehicle: 'Kia Rio', rating: 4.9, deliveries: 501, online: true },
  { id: 'd4', name: 'Khaled Mahmoud', photo: 'https://i.pravatar.cc/150?u=driver4', vehicle: 'Hyundai Elantra', rating: 4.7, deliveries: 156, online: false },
  { id: 'd5', name: 'Nour El-Din', photo: 'https://i.pravatar.cc/150?u=driver5', vehicle: 'Nissan Sunny', rating: 4.5, deliveries: 89, online: true },
  { id: 'd6', name: 'Fatima Zahra', photo: 'https://i.pravatar.cc/150?u=driver6', vehicle: 'Suzuki Swift', rating: 4.9, deliveries: 634, online: false },
]

export default function Drivers() {
  const [filter, setFilter] = useState<'all' | 'online' | 'offline'>('all')
  const filtered = filter === 'all' ? drivers : drivers.filter(d => filter === 'online' ? d.online : !d.online)
  const onlineCount = drivers.filter(d => d.online).length

  return (
    <div>
      <div className="page-header">
        <h2>Fleet Status</h2>
        <div className="status-badge online">● {onlineCount} Online</div>
      </div>

      <div className="filters">
        {(['all', 'online', 'offline'] as const).map(f => (
          <button key={f} className={`filter-btn ${filter === f ? 'active' : ''}`} onClick={() => setFilter(f)}>
            {f === 'all' ? `All (${drivers.length})` : f === 'online' ? `Online (${onlineCount})` : `Offline (${drivers.length - onlineCount})`}
          </button>
        ))}
      </div>

      <div className="driver-grid">
        {filtered.map(driver => (
          <div key={driver.id} className="driver-card">
            <img src={driver.photo} alt={driver.name} className="avatar" />
            <div className="info">
              <h4>{driver.name}</h4>
              <p>{driver.vehicle}</p>
              <p>⭐ {driver.rating} · {driver.deliveries} deliveries</p>
            </div>
            <div className={`status ${driver.online ? 'online' : 'offline'}`} title={driver.online ? 'Online' : 'Offline'} />
          </div>
        ))}
      </div>
    </div>
  )
}
