import { NavLink, Outlet } from 'react-router-dom'

const navItems = [
  { to: '/orders', label: 'Deliveries', icon: '📋' },
  { to: '/dashboard', label: 'Dashboard', icon: '📊' },
  { to: '/drivers', label: 'Fleet Status', icon: '🚚' },
  { to: '/tracking', label: 'Live Tracking', icon: '📍' },
]

export default function Layout() {
  return (
    <div className="layout">
      <aside className="sidebar">
        <div className="sidebar-logo">
          <div className="icon">N</div>
          <div>
            <div className="brand">Global Logistics</div>
            <div className="sub">Admin Panel</div>
          </div>
        </div>
        <button className="create-btn">+ Create New Order</button>
        <nav className="sidebar-nav">
          {navItems.map(item => (
            <NavLink key={item.to} to={item.to} className={({ isActive }) => isActive ? 'active' : ''}>
              <span>{item.icon}</span>
              {item.label}
            </NavLink>
          ))}
        </nav>
        <div className="sidebar-footer">
          <button>❓ Support</button>
          <button>🚪 Sign Out</button>
        </div>
      </aside>
      <main className="main-content">
        <Outlet />
      </main>
    </div>
  )
}
