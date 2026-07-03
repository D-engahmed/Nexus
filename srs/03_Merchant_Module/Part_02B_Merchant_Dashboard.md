# Software Requirements Specification (SRS)

## Part 02B: Merchant Dashboard

**Module:** Merchant Module (Part 03)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Merchant Dashboard module defines the primary user interface and experience for merchants to manage their operations on the **[Platform Name]** platform. This is the command center for merchants—where they monitor orders, manage their store, track performance, view financials, and configure settings.

The dashboard is the merchant's window into the platform. A well-designed, intuitive, and informative dashboard directly impacts merchant satisfaction, operational efficiency, and retention. It must provide real-time visibility into key metrics while enabling merchants to take action on critical tasks without friction.

### Objectives

- Provide a single, unified interface for all merchant operations
- Deliver real-time visibility into orders, performance, and financials
- Enable efficient order management and fulfillment
- Surface actionable insights through analytics and reports
- Support multi-store management for chains and enterprises
- Ensure responsive design for desktop and tablet usage

---

## Chapter 2 – Dashboard Layout & Navigation

### MER-015 Dashboard Structure

| Section | Description | Priority |
| :--- | :--- | :--- |
| **Header** | Brand logo, merchant name, store selector (if multi-store), notifications, profile. | **Required** |
| **Sidebar Navigation** | Main navigation menu (Orders, Store, Analytics, Finance, Settings, Support). | **Required** |
| **Overview Dashboard** | KPI cards, quick actions, recent orders, alerts. | **Required** |
| **Content Area** | Dynamic content based on selected navigation item. | **Required** |
| **Footer** | Version info, support links, legal links. | **Low** |

### MER-016 Sidebar Navigation

| Navigation Item | Icon | Description | Priority |
| :--- | :--- | :--- | :--- |
| **Dashboard** | 📊 | Overview with KPIs and quick actions. | **Required** |
| **Orders** | 📋 | Order list and management. | **Required** |
| **Store** | 🏪 | Store profile, menu/catalog management, settings. | **Required** |
| **Analytics** | 📈 | Performance metrics, insights, reports. | **Required** |
| **Finance** | 💰 | Settlements, payouts, invoices, reports. | **Required** |
| **Settings** | ⚙️ | Account, notification, integration settings. | **Required** |
| **Support** | ❓ | Help center, support tickets, training materials. | **Required** |
| **POS/ERP Integration** | 🔗 | Connect and manage third-party integrations. | **Medium** |
| **Promotions** | 🎯 | Create and manage promotions (optional). | **Medium** |

---

## Chapter 3 – Overview Dashboard

### MER-017 KPI Cards

| KPI | Description | Update Frequency |
| :--- | :--- | :--- |
| **Today's Orders** | Total orders received today (with hour-by-hour breakdown). | Real-time |
| **Active Orders** | Orders currently in preparation or transit. | Real-time |
| **Revenue Today** | Gross revenue (before commission) for today. | Real-time |
| **Average Order Value (AOV)** | Average value of orders today. | Real-time |
| **Pending Orders** | Orders awaiting confirmation. | Real-time |
| **Preparation Time** | Average prep time for today's orders. | Real-time |
| **Customer Rating** | Average merchant rating (last 7 days). | Daily |
| **Completed Orders** | Orders delivered today. | Real-time |
| **Cancellation Rate** | % of orders cancelled today. | Real-time |
| **New Customers** | First-time customers today. | Real-time |

### MER-018 Quick Actions

| Action | Description | Priority |
| :--- | :--- | :--- |
| **View Orders** | Navigate to order management. | **Required** |
| **Update Menu** | Quickly update item availability or pricing. | **Required** |
| **View Today's Earnings** | Navigate to financial summary. | **Required** |
| **Respond to Reviews** | View and respond to customer reviews. | **Required** |
| **Open/Close Store** | Toggle store operational status. | **Required** |
| **View Customer Feedback** | Access customer feedback and ratings. | **Medium** |
| **Create Promotion** | Launch a new promotion or discount. | **Medium** |
| **Contact Support** | Open support ticket. | **Low** |

### MER-019 Recent Orders Widget

| Displayed Information | Description |
| :--- | :--- |
| **Order ID** | Unique order identifier. |
| **Customer Name** | Customer who placed the order. |
| **Order Total** | Total value of the order. |
| **Status** | Current order status (with color coding). |
| **Time Since Placement** | Time elapsed since order was placed. |
| **Action Button** | View/Manage order. |

### MER-020 Alerts & Notifications

| Alert Type | Description | Priority |
| :--- | :--- | :--- |
| **New Order Alert** | Incoming order notification. | **Required** |
| **Order Delay Alert** | Order preparation is taking longer than expected. | **Required** |
| **Low Inventory Alert** | Popular item stock is low. | **Medium** |
| **Customer Issue Alert** | Customer reported an issue with an order. | **Required** |
| **Settlement Alert** | New settlement available. | **Medium** |
| **Review Alert** | New customer review posted. | **Medium** |
| **Performance Alert** | Rating dropped below threshold. | **High** |
| **System Alert** | Technical/operational issue. | **High** |

---

## Chapter 4 – Order Management

### MER-021 Order List View

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Order Table** | Tabular view of orders with key columns. | **Required** |
| **Filtering** | Filter by status, date range, channel, customer. | **Required** |
| **Search** | Search by order ID or customer name. | **Required** |
| **Sorting** | Sort by date, total, status, or customer. | **Required** |
| **Status Filter** | Quick filters for Pending, Confirmed, Preparing, Ready, Delivered, Cancelled. | **Required** |
| **Bulk Actions** | Bulk confirm, bulk print, bulk mark as ready (future). | **Low** |
| **Export** | Export orders to CSV/Excel. | **Medium** |
| **Refresh** | Real-time refresh of order list. | **Required** |

### MER-022 Order Detail View

| Section | Displayed Information | Priority |
| :--- | :--- | :--- |
| **Order Header** | Order ID, status, customer name, order time, total, payment method. | **Required** |
| **Customer Information** | Customer name, phone, delivery address, instructions. | **Required** |
| **Order Items** | Itemized list with quantities, modifiers, prices. | **Required** |
| **Order Timeline** | Chronological list of status changes with timestamps. | **Required** |
| **Order Summary** | Subtotal, delivery fee, service fee, tax, discount, total. | **Required** |
| **Customer Notes** | Special instructions from customer. | **Required** |
| **Actions** | Confirm, Prepare, Mark as Ready, Cancel, Contact Customer, Print. | **Required** |

### MER-023 Order Action Workflow

| Action | Description | Status Transition |
| :--- | :--- | :--- |
| **Confirm Order** | Accept incoming order. | PENDING → CONFIRMED |
| **Start Preparation** | Begin preparing the order. | CONFIRMED → PREPARING |
| **Mark as Ready** | Order is ready for pickup. | PREPARING → READY |
| **Cancel Order** | Cancel order (with reason). | Any → CANCELLED |
| **Contact Customer** | In-app chat or call. | N/A |
| **Print Receipt** | Print order receipt. | N/A |
| **Note/Flag** | Add internal note or flag order. | N/A |

### MER-024 Kitchen Display System (KDS) Integration

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **KDS View** | Dedicated view for kitchen staff (orders by status). | **Required** |
| **Order Cards** | Visual cards showing order items, modifiers, and prep time. | **Required** |
| **Timer** | Prep time timer for each order. | **Required** |
| **Color Coding** | Status-based color coding (new, in-progress, urgent). | **Required** |
| **Sound Alerts** | Audible alerts for new orders. | **Required** |
| **Bumping** | Staff can "bump" orders as they move through prep stages. | **Required** |
| **Print Labels** | Print order tickets/labels. | **Medium** |
| **Pause Order Flow** | Temporarily pause incoming orders during busy periods. | **Medium** |

---

## Chapter 5 – Store Management

### MER-025 Store Profile Management

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Store Information** | Name, description, categories, contact details. | **Required** |
| **Store Location** | Address, map pin, geocoded location. | **Required** |
| **Store Images** | Logo, cover image, gallery images. | **Required** |
| **Store Hours** | Operating days and hours (with holiday exceptions). | **Required** |
| **Delivery Settings** | Delivery zones, radius, fees, minimum order. | **Required** |
| **Preparation Time** | Estimated preparation time. | **Required** |
| **Store Status** | Open/Closed toggle. | **Required** |
| **Pre-order Settings** | Enable/disable pre-ordering, cutoff times. | **Medium** |

### MER-026 Menu/Catalog Management

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Category Management** | Create, edit, delete, reorder categories. | **Required** |
| **Item Management** | Create, edit, delete, duplicate items. | **Required** |
| **Bulk Import** | Import menu via CSV/Excel (with mapping). | **Required** |
| **Bulk Export** | Export menu to CSV/Excel. | **Medium** |
| **Item Attributes** | Name, description, price, images, dietary tags. | **Required** |
| **Modifiers** | Create and manage modifiers (options, add-ons). | **Required** |
| **Availability** | Mark items as available/unavailable (bulk toggle). | **Required** |
| **Inventory** | Track inventory levels (optional/advanced). | **Medium** |
| **Pricing** | Set and update pricing (with date-range pricing for promos). | **Required** |
| **Item Ordering** | Drag-and-drop reordering of categories and items. | **Medium** |

### MER-027 Menu Item Data Model

| Field | Type | Description |
| :--- | :--- | :--- |
| `item_id` | UUID | Primary identifier |
| `store_id` | UUID | Associated store |
| `category_id` | UUID | Category the item belongs to |
| `item_name` | String | Item display name |
| `item_description` | Text | Item description |
| `price` | Decimal | Base price |
| `original_price` | Decimal | Original price (if discounted) |
| `image_url` | String | Item image URL |
| `dietary_tags` | Array | VEGAN/VEGETARIAN/GLUTEN_FREE/HALAL |
| `preparation_time` | Integer | Preparation time in minutes (override) |
| `is_available` | Boolean | Available status |
| `is_featured` | Boolean | Featured item |
| `is_vegetarian` | Boolean | Vegetarian flag |
| `is_vegan` | Boolean | Vegan flag |
| `is_gluten_free` | Boolean | Gluten-free flag |
| `is_halal` | Boolean | Halal flag |
| `sort_order` | Integer | Display order within category |
| `created_at` | Timestamp | Creation timestamp |
| `updated_at` | Timestamp | Last update timestamp |

### MER-028 Modifier Data Model

| Field | Type | Description |
| :--- | :--- | :--- |
| `modifier_id` | UUID | Primary identifier |
| `item_id` | UUID | Associated menu item |
| `modifier_group` | String | Group name (e.g., "Sauce", "Size") |
| `modifier_name` | String | Modifier name |
| `modifier_type` | Enum | SINGLE/MULTI/QUANTITY |
| `price_adjustment` | Decimal | Price adjustment (positive or negative) |
| `is_required` | Boolean | Required selection |
| `is_available` | Boolean | Available status |
| `sort_order` | Integer | Display order within group |
| `created_at` | Timestamp | Creation timestamp |
| `updated_at` | Timestamp | Last update timestamp |

### MER-029 Category Data Model

| Field | Type | Description |
| :--- | :--- | :--- |
| `category_id` | UUID | Primary identifier |
| `store_id` | UUID | Associated store |
| `category_name` | String | Category display name |
| `category_description` | Text | Category description |
| `image_url` | String | Category image URL |
| `sort_order` | Integer | Display order |
| `is_available` | Boolean | Category available status |
| `created_at` | Timestamp | Creation timestamp |
| `updated_at` | Timestamp | Last update timestamp |

---

## Chapter 6 – Performance Analytics

### MER-030 Analytics Dashboard

| Widget | Description | Priority |
| :--- | :--- | :--- |
| **Revenue Chart** | Revenue trend (daily/weekly/monthly). | **Required** |
| **Order Volume** | Order count trend. | **Required** |
| **Average Order Value** | AOV trend. | **Required** |
| **Top Selling Items** | Best-selling items by quantity/revenue. | **Required** |
| **Customer Insights** | New vs. returning customers, customer ratings. | **Required** |
| **Performance Comparison** | Compare to previous period (week-over-week, month-over-month). | **Required** |
| **Sales by Category** | Revenue breakdown by category. | **Required** |
| **Delivery Performance** | Avg prep time, delivery time, on-time %. | **Required** |
| **Hourly Sales** | Peak sales hours. | **Medium** |
| **Customer Reviews** | Review sentiment and ratings. | **Required** |

### MER-031 Reports

| Report | Description | Schedule | Priority |
| :--- | :--- | :--- | :--- |
| **Daily Sales Report** | Summary of daily sales, orders, revenue. | Daily | **Required** |
| **Weekly Performance** | Weekly performance with comparison to previous week. | Weekly | **Required** |
| **Monthly Financial Report** | Full month financials with breakdown. | Monthly | **Required** |
| **Item Performance** | Best and worst performing items. | Weekly | **Required** |
| **Customer Report** | Customer acquisition and retention. | Weekly | **Medium** |
| **Delivery Performance** | Prep time, delivery time, and on-time metrics. | Weekly | **Required** |
| **Tax Report** | Taxable sales, VAT collected. | Monthly | **Required** |
| **Commission Report** | Commission paid to platform. | Monthly | **Required** |
| **Export** | Download reports in PDF/CSV format. | On-demand | **Required** |

### MER-032 Customer Insights

| Insight | Description | Priority |
| :--- | :--- | :--- |
| **Customer Count** | Total customers, new vs. returning. | **Required** |
| **Customer Ratings** | Average rating, rating distribution. | **Required** |
| **Reviews** | List of customer reviews with responses. | **Required** |
| **Customer Retention** | Retention rates and order frequency. | **Required** |
| **Top Customers** | Highest value/frequency customers. | **Medium** |
| **Customer Demographics** | Geographic distribution of customers. | **Low** |
| **Feedback Trends** | Common themes in feedback. | **Medium** |

---

## Chapter 7 – Financial Overview

### MER-033 Financial Dashboard

| Widget | Description | Priority |
| :--- | :--- | :--- |
| **Today's Earnings** | Net earnings (after commission) for today. | **Required** |
| **This Week's Earnings** | Weekly earnings summary. | **Required** |
| **Pending Settlement** | Amount pending from completed orders. | **Required** |
| **Last Settlement** | Last settlement amount and date. | **Required** |
| **Commission Paid** | Total commission paid to platform. | **Required** |
| **Revenue Breakdown** | Gross revenue vs. net revenue (after fees). | **Required** |
| **Settlement Schedule** | Upcoming settlement dates. | **Required** |

### MER-034 Settlement Details

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Settlement History** | List of all settlements with amounts and dates. | **Required** |
| **Settlement Breakdown** | Per-order breakdown of settlement amount (order total - commission - fees). | **Required** |
| **Pending Orders** | Orders not yet settled. | **Required** |
| **Settlement Reports** | Download settlement reports. | **Required** |
| **Disputed Orders** | Orders under dispute affecting settlement. | **Required** |

### MER-035 Financial Reconciliation

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Order-Level Reconciliation** | Verify each order's financial details. | **Required** |
| **Daily Reconciliation** | End-of-day financial reconciliation. | **Required** |
| **Tax Summary** | Tax collected and remitted. | **Required** |
| **Commission Summary** | Commission charged by period. | **Required** |
| **Fees Summary** | All fees (service, delivery, platform). | **Required** |

---

## Chapter 8 – Settings & Configuration

### MER-036 Account Settings

| Setting | Description | Priority |
| :--- | :--- | :--- |
| **Profile Information** | Business name, contact details, owner information. | **Required** |
| **Password** | Change password. | **Required** |
| **Two-Factor Authentication** | Enable/disable 2FA. | **Required** |
| **Notification Preferences** | Configure notification channels (email, SMS, push). | **Required** |
| **Language** | Dashboard language preference. | **Medium** |
| **Timezone** | Dashboard timezone. | **Medium** |

### MER-037 Notification Preferences

| Notification Type | Email | SMS | Push | Priority |
| :--- | :--- | :--- | :--- | :--- |
| **New Order** | ✅ | ✅ | ✅ | **Required** |
| **Order Cancellation** | ✅ | ✅ | ✅ | **Required** |
| **Order Status Changes** | ✅ | ⚠️ | ⚠️ | **Required** |
| **Settlement Available** | ✅ | ⚠️ | ⚠️ | **Required** |
| **Customer Review** | ✅ | ❌ | ✅ | **Required** |
| **Low Inventory Alert** | ✅ | ❌ | ⚠️ | **Medium** |
| **Performance Alerts** | ✅ | ❌ | ✅ | **High** |
| **Platform Updates** | ✅ | ❌ | ❌ | **Medium** |
| **Promotion Expiry** | ✅ | ❌ | ❌ | **Medium** |

### MER-038 Integration Settings

| Integration | Description | Priority |
| :--- | :--- | :--- |
| **POS Integration** | Connect to POS system (Part 16C). | **Required** |
| **ERP Integration** | Connect to ERP system (Part 16C). | **Medium** |
| **Payment Gateway** | Configure payment gateway settings. | **Required** |
| **Printers** | Configure receipt printers, label printers. | **Medium** |
| **Kitchen Display** | Configure KDS settings. | **Medium** |
| **API Access** | Generate API keys for third-party integration. | **Medium** |

---

## Chapter 9 – Database Tables

### merchant_dashboard_preferences

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `preference_id` | UUID | PRIMARY KEY | Unique preference identifier |
| `merchant_id` | UUID | FOREIGN KEY (merchant_accounts.merchant_id) | Associated merchant |
| `dashboard_layout` | JSONB | | Custom dashboard layout configuration |
| `favorite_kpis` | TEXT[] | | List of favorite KPI widgets |
| `hidden_kpis` | TEXT[] | | Hidden KPI widgets |
| `notification_preferences` | JSONB | | Notification preferences for channels |
| `theme_preference` | VARCHAR(10) | DEFAULT 'light' | light/dark/system |
| `language_preference` | VARCHAR(5) | DEFAULT 'en' | Interface language |
| `timezone` | VARCHAR(50) | | User timezone |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_quick_actions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `action_id` | UUID | PRIMARY KEY | Unique action identifier |
| `merchant_id` | UUID | FOREIGN KEY (merchant_accounts.merchant_id) | Associated merchant |
| `action_type` | VARCHAR(50) | NOT NULL | OPEN_CLOSE/TURN_ON_OFF/VIEW_ORDERS/UPDATE_MENU/VIEW_EARNINGS/RESPOND_REVIEWS |
| `label` | VARCHAR(100) | | Custom label |
| `sort_order` | INTEGER | DEFAULT 0 | Display order |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_activity_logs

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `log_id` | UUID | PRIMARY KEY | Unique log identifier |
| `merchant_id` | UUID | FOREIGN KEY (merchant_accounts.merchant_id) | Associated merchant |
| `user_id` | UUID | | User who performed action |
| `action_type` | VARCHAR(50) | NOT NULL | LOGIN/LOGOUT/ORDER_CONFIRM/ORDER_CANCEL/MENU_UPDATE/PRICE_CHANGE/SETTINGS_UPDATE |
| `action_description` | TEXT | | Description of action |
| `ip_address` | VARCHAR(45) | | IP address of user |
| `user_agent` | TEXT | | Browser/user agent |
| `metadata` | JSONB | | Additional context |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Action timestamp |

---

## Chapter 10 – REST APIs

### Dashboard APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/dashboard/kpis` | Get KPI data for dashboard |
| `GET` | `/api/v1/merchant/dashboard/recent-orders` | Get recent orders |
| `GET` | `/api/v1/merchant/dashboard/alerts` | Get active alerts/notifications |
| `GET` | `/api/v1/merchant/dashboard/quick-actions` | Get quick actions |
| `PUT` | `/api/v1/merchant/dashboard/preferences` | Update dashboard preferences |

### Order Management APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/orders` | List orders with filters |
| `GET` | `/api/v1/merchant/orders/{id}` | Get order details |
| `PUT` | `/api/v1/merchant/orders/{id}/confirm` | Confirm order |
| `PUT` | `/api/v1/merchant/orders/{id}/prepare` | Start preparation |
| `PUT` | `/api/v1/merchant/orders/{id}/ready` | Mark order as ready |
| `PUT` | `/api/v1/merchant/orders/{id}/cancel` | Cancel order |
| `GET` | `/api/v1/merchant/orders/export` | Export orders to CSV |
| `GET` | `/api/v1/merchant/orders/{id}/timeline` | Get order timeline |

### Store Management APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/stores/{id}` | Get store details |
| `PUT` | `/api/v1/merchant/stores/{id}` | Update store details |
| `PUT` | `/api/v1/merchant/stores/{id}/status` | Open/Close store |
| `GET` | `/api/v1/merchant/stores/{id}/menu` | Get store menu |
| `POST` | `/api/v1/merchant/stores/{id}/menu/categories` | Add category |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/categories/{id}` | Update category |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/categories/{id}` | Delete category |
| `POST` | `/api/v1/merchant/stores/{id}/menu/items` | Add menu item |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/{id}` | Update menu item |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/items/{id}` | Delete menu item |
| `POST` | `/api/v1/merchant/stores/{id}/menu/import` | Bulk import menu |
| `GET` | `/api/v1/merchant/stores/{id}/menu/export` | Export menu |
| `POST` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers` | Add modifier |
| `PUT` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Update modifier |
| `DELETE` | `/api/v1/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Delete modifier |

### Analytics APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/analytics/dashboard` | Get analytics dashboard data |
| `GET` | `/api/v1/merchant/analytics/revenue` | Get revenue analytics |
| `GET` | `/api/v1/merchant/analytics/orders` | Get order analytics |
| `GET` | `/api/v1/merchant/analytics/items` | Get item performance |
| `GET` | `/api/v1/merchant/analytics/customers` | Get customer insights |
| `GET` | `/api/v1/merchant/analytics/reports/{type}` | Get specific report |
| `POST` | `/api/v1/merchant/analytics/reports/export` | Export report |

### Finance APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/dashboard` | Get financial dashboard data |
| `GET` | `/api/v1/merchant/finance/settlements` | List settlements |
| `GET` | `/api/v1/merchant/finance/settlements/{id}` | Get settlement details |
| `GET` | `/api/v1/merchant/finance/orders/pending` | Get pending settlement orders |
| `GET` | `/api/v1/merchant/finance/reports/export` | Export financial report |

### Settings APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/settings/profile` | Get profile settings |
| `PUT` | `/api/v1/merchant/settings/profile` | Update profile settings |
| `GET` | `/api/v1/merchant/settings/notifications` | Get notification preferences |
| `PUT` | `/api/v1/merchant/settings/notifications` | Update notification preferences |
| `GET` | `/api/v1/merchant/settings/integrations` | Get integration settings |
| `POST` | `/api/v1/merchant/settings/integrations/pos` | Configure POS integration |
| `POST` | `/api/v1/merchant/settings/integrations/erp` | Configure ERP integration |

---

## Chapter 11 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-DASH-001** | Merchants with multiple stores must be able to switch stores without logging out. | **High** |
| **BR-DASH-002** | New orders must trigger a visible and audible alert in the dashboard. | **High** |
| **BR-DASH-003** | Orders cannot be marked as ready without being confirmed first. | **High** |
| **BR-DASH-004** | Items marked as unavailable cannot be ordered by customers. | **High** |
| **BR-DASH-005** | Menu changes must be reflected in customer-facing menus within 5 minutes. | **High** |
| **BR-DASH-006** | Settlement reports must be available within 24 hours of settlement date. | **High** |
| **BR-DASH-007** | Dashboard analytics must reflect real-time data for today's metrics. | **High** |
| **BR-DASH-008** | Merchants must be notified of any customer issue within 5 minutes. | **High** |
| **BR-DASH-009** | Store status (open/closed) must be toggleable with immediate effect. | **High** |
| **BR-DASH-010** | Merchants must be able to view order history for at least 12 months. | **Medium** |

---

## Chapter 12 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-DASH-001** | Merchant logs into dashboard and sees KPI overview. | **High** |
| **TEST-DASH-002** | Dashboard KPI cards update in real-time. | **High** |
| **TEST-DASH-003** | New order triggers audible and visual alert. | **High** |
| **TEST-DASH-004** | Merchant navigates to order list and applies filters. | **High** |
| **TEST-DASH-005** | Merchant views order details. | **High** |
| **TEST-DASH-006** | Merchant confirms an order. | **High** |
| **TEST-DASH-007** | Merchant marks an order as preparing. | **High** |
| **TEST-DASH-008** | Merchant marks an order as ready. | **High** |
| **TEST-DASH-009** | Merchant cancels an order with reason. | **High** |
| **TEST-DASH-010** | Merchant updates store status (open/closed). | **High** |
| **TEST-DASH-011** | Merchant adds a new menu category. | **High** |
| **TEST-DASH-012** | Merchant adds a new menu item with modifiers. | **High** |
| **TEST-DASH-013** | Merchant updates item price. | **High** |
| **TEST-DASH-014** | Merchant toggles item availability. | **High** |
| **TEST-DASH-015** | Merchant imports menu via CSV/Excel. | **High** |
| **TEST-DASH-016** | Merchant exports menu to CSV/Excel. | **Medium** |
| **TEST-DASH-017** | Merchant views analytics dashboard. | **High** |
| **TEST-DASH-018** | Merchant filters analytics by date range. | **High** |
| **TEST-DASH-019** | Merchant generates a sales report. | **High** |
| **TEST-DASH-020** | Merchant exports report. | **Medium** |
| **TEST-DASH-021** | Merchant views financial dashboard. | **High** |
| **TEST-DASH-022** | Merchant views settlement history. | **High** |
| **TEST-DASH-023** | Merchant views settlement breakdown. | **High** |
| **TEST-DASH-024** | Merchant updates notification preferences. | **High** |
| **TEST-DASH-025** | Merchant switches between multiple stores. | **High** |
| **TEST-DASH-026** | Merchant responds to customer review. | **High** |
| **TEST-DASH-027** | Merchant views customer insights. | **Medium** |
| **TEST-DASH-028** | Merchant uses quick actions from dashboard. | **High** |
| **TEST-DASH-029** | Merchant activity is logged (audit trail). | **High** |
| **TEST-DASH-030** | Dashboard works on tablet/desktop (responsive). | **Medium** |

---

## Chapter 13 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| MER-017 | merchant_dashboard_preferences | GET /api/v1/merchant/dashboard/kpis | TEST-DASH-001, TEST-DASH-002 |
| MER-018 | merchant_quick_actions | GET /api/v1/merchant/dashboard/quick-actions | TEST-DASH-028 |
| MER-020 | merchant_dashboard_preferences | GET /api/v1/merchant/dashboard/alerts | TEST-DASH-003 |
| MER-021 | orders | GET /api/v1/merchant/orders | TEST-DASH-004 |
| MER-022 | orders | GET /api/v1/merchant/orders/{id} | TEST-DASH-005 |
| MER-023 | orders | PUT /api/v1/merchant/orders/{id}/confirm | TEST-DASH-006 |
| MER-023 | orders | PUT /api/v1/merchant/orders/{id}/prepare | TEST-DASH-007 |
| MER-023 | orders | PUT /api/v1/merchant/orders/{id}/ready | TEST-DASH-008 |
| MER-023 | orders | PUT /api/v1/merchant/orders/{id}/cancel | TEST-DASH-009 |
| MER-025 | merchant_stores | PUT /api/v1/merchant/stores/{id}/status | TEST-DASH-010 |
| MER-026 | menu_categories | POST /api/v1/merchant/stores/{id}/menu/categories | TEST-DASH-011 |
| MER-026 | menu_items | POST /api/v1/merchant/stores/{id}/menu/items | TEST-DASH-012 |
| MER-026 | menu_items | PUT /api/v1/merchant/stores/{id}/menu/items/{id} | TEST-DASH-013 |
| MER-026 | menu_items | PUT /api/v1/merchant/stores/{id}/menu/items/{id}/availability | TEST-DASH-014 |
| MER-026 | menu_items | POST /api/v1/merchant/stores/{id}/menu/import | TEST-DASH-015 |
| MER-030 | analytics | GET /api/v1/merchant/analytics/dashboard | TEST-DASH-017 |
| MER-031 | analytics | GET /api/v1/merchant/analytics/reports/{type} | TEST-DASH-019, TEST-DASH-020 |
| MER-033 | settlements | GET /api/v1/merchant/finance/dashboard | TEST-DASH-021 |
| MER-034 | settlements | GET /api/v1/merchant/finance/settlements | TEST-DASH-022, TEST-DASH-023 |
| MER-036 | merchant_dashboard_preferences | GET/PUT /api/v1/merchant/settings/profile | TEST-DASH-024 |
| MER-015 | merchant_stores | GET /api/v1/merchant/stores | TEST-DASH-025 |
| MER-032 | order_reviews | GET /api/v1/merchant/reviews | TEST-DASH-026 |
| MER-032 | customers | GET /api/v1/merchant/analytics/customers | TEST-DASH-027 |
| MER-015 | merchant_activity_logs | Internal | TEST-DASH-029 |

---

## Chapter 14 – Summary

This document establishes the complete merchant dashboard capability for the **[Platform Name]** platform. Key takeaways:

- **Centralized Command Center:** Single unified interface for all merchant operations including order management, store management, analytics, and finance.
- **Real-Time Visibility:** Live KPI updates, order alerts, and real-time status changes ensure merchants are always informed.
- **Efficient Order Management:** Streamlined order workflows from confirmation through to readiness, with Kitchen Display System (KDS) support.
- **Comprehensive Store Management:** Full control over store profile, menu/catalog, and operational settings.
- **Data-Driven Insights:** Analytics dashboards and reports provide merchants with actionable insights on performance, customers, and financials.
- **Flexible Configurability:** Notification preferences, dashboard customization, and integration settings put merchants in control.
- **Multi-Store Support:** Chains and enterprises can manage multiple locations from a single dashboard.

The merchant dashboard is the primary interface for merchants to run their business on the platform. Its quality, responsiveness, and completeness directly impact merchant satisfaction, operational efficiency, and long-term retention.

---

**Next Document:**

`Part_02C_Menu_Catalog_Management.md`

*(This builds on the dashboard to provide deep-dive capabilities for menu and catalog management, including bulk operations, complex modifiers, and inventory management.)*