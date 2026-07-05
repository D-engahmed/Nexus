import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import Orders from './pages/Orders'
import Drivers from './pages/Drivers'
import Tracking from './pages/Tracking'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="orders" element={<Orders />} />
          <Route path="drivers" element={<Drivers />} />
          <Route path="tracking" element={<Tracking />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
