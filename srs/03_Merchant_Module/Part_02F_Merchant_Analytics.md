# Software Requirements Specification (SRS)

## Part 02F: Merchant Analytics

**Module:** Merchant Module (Part 03)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Merchant Analytics module defines the comprehensive data analysis, reporting, and business intelligence capabilities available to merchants on the **[Platform Name]** platform. This encompasses sales analytics, customer insights, operational performance, financial metrics, and predictive intelligence.

Data-driven decision-making is essential for merchant success. By providing clear, actionable insights into their business performance, merchants can optimize their operations, improve customer satisfaction, and increase profitability. Analytics also helps merchants understand market trends, identify growth opportunities, and benchmark their performance against peers.

### Objectives

- Provide real-time and historical sales analytics
- Enable deep customer insights and segmentation
- Deliver operational performance metrics (prep times, fulfillment, quality)
- Surface financial analytics (revenue, commissions, profitability)
- Provide item and menu performance analysis
- Enable comparative and trend analysis
- Support data-driven decision making
- Provide exportable reports for external analysis

---

## Chapter 2 – Analytics Dashboard

### MER-112 Analytics Dashboard Overview

| Widget | Description | Priority |
| :--- | :--- | :--- |
| **Sales Overview** | Revenue, orders, AOV with period comparison. | **Required** |
| **Sales Trend** | Daily/weekly/monthly sales trend chart. | **Required** |
| **Top Items** | Best-selling items by quantity and revenue. | **Required** |
| **Customer Insights** | New vs. returning, customer segments. | **Required** |
| **Operational Metrics** | Prep time, fulfillment time, on-time rate. | **Required** |
| **Financial Summary** | Gross revenue, commissions, net earnings. | **Required** |
| **Hourly Sales** | Sales distribution by hour of day. | **Required** |
| **Category Performance** | Sales breakdown by category. | **Required** |
| **Order Volume** | Order count trends. | **Required** |
| **Customer Ratings** | Average rating and review sentiment. | **Required** |

### MER-113 Time Period Selection

| Period | Description | Default |
| :--- | :--- | :--- |
| **Today** | Current day's data (real-time). | **Default** |
| **Yesterday** | Previous day's data. | |
| **This Week** | Current week (Mon-Sun or Sun-Sat). | |
| **Last Week** | Previous week. | |
| **This Month** | Current month to date. | |
| **Last Month** | Previous month. | |
| **Last 7 Days** | Rolling 7-day window. | |
| **Last 30 Days** | Rolling 30-day window. | |
| **Last 90 Days** | Rolling 90-day window. | |
| **Custom Range** | User-defined date range. | |

### MER-114 Comparison Periods

| Comparison | Description |
| :--- | :--- |
| **Previous Period** | Compare to previous time period of same duration. |
| **Year Over Year** | Compare to same period last year. |
| **Period Over Period** | Compare to custom period. |
| **Goal Comparison** | Compare to set goals/targets. |
| **Benchmark** | Compare to industry/peer benchmarks. |

---

## Chapter 3 – Sales Analytics

### MER-115 Revenue Analytics

| Metric | Description | Calculation |
| :--- | :--- | :--- |
| **Gross Revenue** | Total sales before deductions. | Sum of order totals. |
| **Net Revenue** | Revenue after commissions and fees. | Gross - Commission - Fees. |
| **Average Order Value (AOV)** | Average value per order. | Total Revenue / Total Orders. |
| **Revenue Per Customer** | Average revenue per customer. | Total Revenue / Total Customers. |
| **Revenue by Channel** | Revenue split by order source. | Web / Mobile / API / POS. |
| **Revenue by Category** | Revenue breakdown by product category. | Category-level revenue. |
| **Revenue by Hour** | Revenue distribution by hour. | Hourly aggregation. |
| **Revenue by Day** | Revenue by day of week. | Daily aggregation. |
| **Revenue Trends** | Revenue growth/decline over time. | Period-over-period comparison. |
| **Revenue Goals** | Progress against revenue targets. | Actual vs. Target. |

### MER-116 Order Analytics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Total Orders** | Number of orders in period. | **Required** |
| **Order Growth** | Order growth rate. | **Required** |
| **Order by Hour** | Order distribution by hour. | **Required** |
| **Order by Day** | Order distribution by day. | **Required** |
| **Peak Order Time** | Hour with most orders. | **Required** |
| **Order Status Distribution** | Orders by status (Confirmed, Preparing, Ready, Delivered, Cancelled). | **Required** |
| **Cancellation Rate** | Percentage of orders cancelled. | **Required** |
| **Repeat Order Rate** | Percentage of customers ordering again. | **Required** |
| **Average Order Frequency** | Orders per customer per period. | **Required** |

### MER-117 Sales Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `analytics_date` | Date | Date of analytics data |
| `store_id` | UUID | Associated store |
| `total_orders` | Integer | Total orders |
| `gross_revenue` | Decimal | Total revenue before deductions |
| `net_revenue` | Decimal | Revenue after commissions/fees |
| `commission` | Decimal | Commission paid to platform |
| `fees` | Decimal | Other fees |
| `aov` | Decimal | Average order value |
| `new_customers` | Integer | New customers |
| `returning_customers` | Integer | Returning customers |
| `active_customers` | Integer | Active customers in period |
| `cancellations` | Integer | Cancelled orders |
| `cancellation_rate` | Decimal | Cancellation percentage |
| `avg_prep_time` | Integer | Average preparation time |
| `avg_delivery_time` | Integer | Average delivery time |
| `on_time_rate` | Decimal | Percentage on time |
| `avg_rating` | Decimal | Average customer rating |
| `created_at` | Timestamp | Record creation timestamp |

---

## Chapter 4 – Item & Menu Analytics

### MER-118 Item Performance Metrics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Top Selling Items** | Items with highest order frequency. | **Required** |
| **Top Revenue Items** | Items with highest revenue contribution. | **Required** |
| **Item Conversion Rate** | % of customers viewing item who order it. | **Required** |
| **Item Margin** | Profitability per item. | **Required** |
| **Item Combo Analysis** | Items frequently ordered together. | **Medium** |
| **Item Rating** | Customer rating per item. | **Required** |
| **Item Modifier Analysis** | Most popular modifier combinations. | **Medium** |
| **Item Trends** | Rising and declining items. | **Required** |
| **Category Performance** | Revenue and order volume by category. | **Required** |

### MER-119 Item Performance Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `item_analytics_id` | UUID | Unique identifier |
| `store_id` | UUID | Associated store |
| `item_id` | UUID | Associated menu item |
| `analytics_date` | Date | Date of analytics |
| `orders_count` | Integer | Number of orders containing item |
| `units_sold` | Integer | Total units sold |
| `revenue` | Decimal | Revenue from item |
| `revenue_percentage` | Decimal | Percentage of total revenue |
| `conversion_rate` | Decimal | View-to-order conversion |
| `avg_rating` | Decimal | Average item rating |
| `cancellation_count` | Integer | Item cancellations |
| `created_at` | Timestamp | Record creation timestamp |

### MER-120 Category Performance Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `category_analytics_id` | UUID | Unique identifier |
| `store_id` | UUID | Associated store |
| `category_id` | UUID | Associated category |
| `analytics_date` | Date | Date of analytics |
| `orders_count` | Integer | Orders containing category items |
| `items_sold` | Integer | Total items sold in category |
| `revenue` | Decimal | Revenue from category |
| `revenue_percentage` | Decimal | Percentage of total revenue |
| `avg_rating` | Decimal | Average rating for category |
| `created_at` | Timestamp | Record creation timestamp |

---

## Chapter 5 – Customer Analytics

### MER-121 Customer Insights

| Insight | Description | Priority |
| :--- | :--- | :--- |
| **Customer Count** | Total customers, active, new, returning. | **Required** |
| **Customer Growth** | Customer acquisition rate. | **Required** |
| **Customer Retention** | Retention rate over time. | **Required** |
| **Customer Lifetime Value** | Average LTV of customers. | **Required** |
| **Repeat Purchase Rate** | % of customers ordering again. | **Required** |
| **Customer Segments** | High-value, frequent, new, at-risk. | **Required** |
| **Customer Geography** | Location heatmap of customers. | **Medium** |
| **Top Customers** | Highest value customers (anonymized). | **Medium** |
| **Customer Frequency** | Orders per customer distribution. | **Required** |

### MER-122 Customer Segments

| Segment | Description | Characteristics |
| :--- | :--- | :--- |
| **High Value** | Customers with highest spend. | Top 10% by revenue. |
| **Frequent Buyers** | Customers with highest order frequency. | > 5 orders/month. |
| **New Customers** | Customers who joined in last 30 days. | First order in last 30 days. |
| **At Risk** | Customers who haven't ordered in 60+ days. | No orders in 60 days. |
| **Dormant** | Customers who haven't ordered in 90+ days. | No orders in 90 days. |
| **Loyal** | Customers with consistent ordering. | Ordered every month for 6 months. |
| **Promotional** | Customers who respond to promotions. | High promo code usage. |

### MER-123 Customer Lifetime Value (LTV)

| Component | Description | Calculation |
| :--- | :--- | :--- |
| **Average Order Value** | Average spend per order. | Total Revenue / Total Orders. |
| **Order Frequency** | Orders per customer per month. | Total Orders / Total Customers / Months. |
| **Customer Lifetime** | Average customer lifespan. | Average months of activity. |
| **Customer Acquisition Cost** | Cost to acquire customer. | Marketing Spend / New Customers. |
| **LTV** | Lifetime value of customer. | AOV × Frequency × Lifetime. |
| **LTV:CAC Ratio** | ROI of customer acquisition. | LTV / CAC. |

### MER-124 Customer Analytics Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `customer_analytics_id` | UUID | Unique identifier |
| `store_id` | UUID | Associated store |
| `analytics_date` | Date | Date of analytics |
| `total_customers` | Integer | Total customers |
| `new_customers` | Integer | New customers in period |
| `returning_customers` | Integer | Returning customers |
| `active_customers` | Integer | Active customers (1+ orders) |
| `inactive_customers` | Integer | Inactive customers (no orders) |
| `customer_retention_rate` | Decimal | Customer retention percentage |
| `repeat_purchase_rate` | Decimal | Repeat purchase percentage |
| `avg_customer_ltv` | Decimal | Average customer lifetime value |
| `avg_customer_lifetime` | Integer | Average customer lifetime (days) |
| `created_at` | Timestamp | Record creation timestamp |

---

## Chapter 6 – Operational Analytics

### MER-125 Operational Performance Metrics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Average Preparation Time** | Time from confirmation to ready. | **Required** |
| **Average Fulfillment Time** | Time from order to delivery. | **Required** |
| **Average Time to Confirm** | Time from order to confirmation. | **Required** |
| **On-Time Rate** | Percentage of orders delivered on time. | **Required** |
| **Order Accuracy** | Percentage of orders without issues. | **Required** |
| **Preparation Time Trend** | Prep time over time. | **Required** |
| **Order Volume vs. Prep Time** | Prep time correlation with volume. | **Required** |
| **Driver Performance** | Driver pickup/delivery times. | **Required** |
| **Staff Efficiency** | Orders processed per staff member. | **Medium** |
| **Order Queue** | Average order queue length. | **Required** |

### MER-126 Operational Efficiency Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `operational_analytics_id` | UUID | Unique identifier |
| `store_id` | UUID | Associated store |
| `analytics_date` | Date | Date of analytics |
| `avg_confirmation_time` | Integer | Average time to confirm (minutes) |
| `avg_prep_time` | Integer | Average preparation time (minutes) |
| `avg_fulfillment_time` | Integer | Average fulfillment time (minutes) |
| `avg_delivery_time` | Integer | Average delivery time (minutes) |
| `on_time_rate` | Decimal | On-time delivery percentage |
| `order_accuracy` | Decimal | Order accuracy percentage |
| `avg_queue_length` | Decimal | Average order queue length |
| `peak_order_volume` | Integer | Peak order volume (hourly) |
| `busiest_hour` | Integer | Hour with most orders |
| `created_at` | Timestamp | Record creation timestamp |

---

## Chapter 7 – Financial Analytics

### MER-127 Financial Metrics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Gross Revenue** | Total sales before deductions. | **Required** |
| **Net Revenue** | Revenue after commissions and fees. | **Required** |
| **Total Commission** | Commission paid to platform. | **Required** |
| **Total Fees** | Platform fees (service, delivery, etc.). | **Required** |
| **Profit Margin** | Net revenue / Gross revenue. | **Required** |
| **Revenue by Day** | Daily revenue breakdown. | **Required** |
| **Revenue by Week** | Weekly revenue breakdown. | **Required** |
| **Revenue by Month** | Monthly revenue breakdown. | **Required** |
| **Revenue by Channel** | Revenue by order source. | **Required** |
| **Revenue by Category** | Revenue by product category. | **Required** |
| **Average Order Value** | Average value per order. | **Required** |
| **Customer Acquisition Cost** | Cost to acquire new customer. | **Medium** |
| **Customer Lifetime Value** | Lifetime value of customers. | **Required** |

### MER-128 Financial Reconciliation

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Order-Level Reconciliation** | Verify each order's financial details. | **Required** |
| **Daily Reconciliation** | End-of-day financial reconciliation. | **Required** |
| **Weekly Reconciliation** | End-of-week reconciliation. | **Required** |
| **Monthly Reconciliation** | End-of-month reconciliation. | **Required** |
| **Tax Summary** | Tax collected and remitted. | **Required** |
| **Commission Summary** | Commission charged by period. | **Required** |
| **Fees Summary** | All fees (service, delivery, platform). | **Required** |
| **Discrepancy Tracking** | Identify and track financial discrepancies. | **Required** |

### MER-129 Financial Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `financial_analytics_id` | UUID | Unique identifier |
| `store_id` | UUID | Associated store |
| `analytics_date` | Date | Date of analytics |
| `gross_revenue` | Decimal | Total revenue before deductions |
| `net_revenue` | Decimal | Revenue after commissions/fees |
| `total_commission` | Decimal | Commission paid |
| `total_fees` | Decimal | Platform fees |
| `total_tax` | Decimal | Tax collected |
| `avg_order_value` | Decimal | Average order value |
| `profit_margin` | Decimal | Net / Gross percentage |
| `created_at` | Timestamp | Record creation timestamp |

---

## Chapter 8 – Comparative & Benchmark Analytics

### MER-130 Time-Based Comparisons

| Comparison | Description | Priority |
| :--- | :--- | :--- |
| **Week Over Week** | Compare to previous week. | **Required** |
| **Month Over Month** | Compare to previous month. | **Required** |
| **Year Over Year** | Compare to same period last year. | **Required** |
| **Period Over Period** | Compare to custom date range. | **Required** |
| **Trend Analysis** | Visualize trends over time. | **Required** |
| **Growth Rate** | Calculate growth rates between periods. | **Required** |

### MER-131 Benchmark Analytics

| Benchmark | Description | Priority |
| :--- | :--- | :--- |
| **Industry Benchmarks** | Compare to industry averages. | **Medium** |
| **Peer Comparison** | Compare to similar merchants. | **Medium** |
| **Category Comparison** | Compare to merchants in same category. | **Medium** |
| **Regional Comparison** | Compare to merchants in same region. | **Medium** |
| **Size Comparison** | Compare to merchants of similar size. | **Medium** |
| **Performance Ranking** | Rank against peers. | **Medium** |

---

## Chapter 9 – Reporting

### MER-132 Available Reports

| Report | Description | Schedule | Priority |
| :--- | :--- | :--- | :--- |
| **Daily Sales Report** | Sales, orders, AOV, and cancellations. | Daily | **Required** |
| **Weekly Sales Report** | Weekly performance summary. | Weekly | **Required** |
| **Monthly Sales Report** | Full month financials with trends. | Monthly | **Required** |
| **Item Performance Report** | Best and worst performing items. | Monthly | **Required** |
| **Customer Report** | Customer acquisition, retention, LTV. | Monthly | **Required** |
| **Operational Report** | Prep times, fulfillment, on-time rates. | Weekly | **Required** |
| **Financial Report** | Revenue, commissions, net earnings. | Monthly | **Required** |
| **Category Report** | Category performance breakdown. | Monthly | **Required** |
| **Tax Report** | Taxable sales, tax collected. | Quarterly | **Required** |
| **Commission Report** | Commission breakdown by period. | Monthly | **Required** |
| **Hourly Sales Report** | Sales distribution by hour. | Weekly | **Required** |
| **Day of Week Report** | Sales distribution by day. | Monthly | **Required** |

### MER-133 Report Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Scheduled Delivery** | Auto-deliver reports via email. | **Required** |
| **Export Formats** | PDF, CSV, Excel, JSON. | **Required** |
| **Custom Reports** | User-defined report builder. | **Medium** |
| **Report Scheduling** | Set custom schedule for reports. | **Required** |
| **Report Sharing** | Share reports with team members. | **Medium** |
| **Report History** | View past report versions. | **Required** |
| **Report Favorites** | Save frequently used reports. | **Medium** |
| **Report Templates** | Pre-built report templates. | **Medium** |

---

## Chapter 10 – Data Export

### MER-134 Export Capabilities

| Export Type | Description | Priority |
| :--- | :--- | :--- |
| **Sales Data** | Export sales transaction data. | **Required** |
| **Order Data** | Export order details. | **Required** |
| **Item Data** | Export menu item performance data. | **Required** |
| **Customer Data** | Export customer analytics data. | **Required** |
| **Financial Data** | Export financial reconciliation data. | **Required** |
| **Operational Data** | Export operational metrics. | **Required** |
| **Full Export** | Export all data (bulk). | **Medium** |

### MER-135 Export Specifications

| Specification | Description |
| :--- | :--- |
| **Supported Formats** | CSV, Excel (.xlsx), PDF, JSON, XML |
| **Date Range** | User-selectable date range for export |
| **Filtering** | Filter by order status, category, customer segment |
| **Data Volume** | Support up to 100,000 records per export |
| **Processing Time** | Asynchronous for large exports |
| **Notification** | Email notification when export is ready |
| **Storage** | Exports available for 7 days |
| **Security** | Exports encrypted and access-controlled |

---

## Chapter 11 – Database Tables

### merchant_analytics_sales

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `analytics_date` | DATE | NOT NULL | Date of analytics |
| `total_orders` | INTEGER | DEFAULT 0 | Total orders |
| `gross_revenue` | DECIMAL(12, 2) | DEFAULT 0 | Revenue before deductions |
| `net_revenue` | DECIMAL(12, 2) | DEFAULT 0 | Revenue after commissions/fees |
| `commission` | DECIMAL(12, 2) | DEFAULT 0 | Commission paid |
| `fees` | DECIMAL(12, 2) | DEFAULT 0 | Platform fees |
| `aov` | DECIMAL(10, 2) | DEFAULT 0 | Average order value |
| `new_customers` | INTEGER | DEFAULT 0 | New customers |
| `returning_customers` | INTEGER | DEFAULT 0 | Returning customers |
| `active_customers` | INTEGER | DEFAULT 0 | Active customers |
| `cancellations` | INTEGER | DEFAULT 0 | Cancelled orders |
| `cancellation_rate` | DECIMAL(5, 2) | DEFAULT 0 | Cancellation percentage |
| `avg_prep_time` | INTEGER | DEFAULT 0 | Average prep time (minutes) |
| `avg_delivery_time` | INTEGER | DEFAULT 0 | Average delivery time (minutes) |
| `on_time_rate` | DECIMAL(5, 2) | DEFAULT 0 | On-time delivery percentage |
| `avg_rating` | DECIMAL(3, 2) | DEFAULT 0 | Average customer rating |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_item_analytics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `item_analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `item_id` | UUID | FOREIGN KEY (menu_items.item_id) | Associated menu item |
| `analytics_date` | DATE | NOT NULL | Date of analytics |
| `orders_count` | INTEGER | DEFAULT 0 | Orders containing item |
| `units_sold` | INTEGER | DEFAULT 0 | Total units sold |
| `revenue` | DECIMAL(12, 2) | DEFAULT 0 | Revenue from item |
| `revenue_percentage` | DECIMAL(5, 2) | DEFAULT 0 | Percentage of total revenue |
| `conversion_rate` | DECIMAL(5, 2) | DEFAULT 0 | View-to-order conversion |
| `avg_rating` | DECIMAL(3, 2) | DEFAULT 0 | Average item rating |
| `cancellation_count` | INTEGER | DEFAULT 0 | Item cancellations |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_customer_analytics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `analytics_date` | DATE | NOT NULL | Date of analytics |
| `total_customers` | INTEGER | DEFAULT 0 | Total customers |
| `new_customers` | INTEGER | DEFAULT 0 | New customers |
| `returning_customers` | INTEGER | DEFAULT 0 | Returning customers |
| `active_customers` | INTEGER | DEFAULT 0 | Active customers |
| `inactive_customers` | INTEGER | DEFAULT 0 | Inactive customers |
| `retention_rate` | DECIMAL(5, 2) | DEFAULT 0 | Customer retention rate |
| `repeat_purchase_rate` | DECIMAL(5, 2) | DEFAULT 0 | Repeat purchase rate |
| `avg_ltv` | DECIMAL(10, 2) | DEFAULT 0 | Average lifetime value |
| `avg_lifetime_days` | INTEGER | DEFAULT 0 | Average customer lifetime (days) |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_financial_analytics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `financial_analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `analytics_date` | DATE | NOT NULL | Date of analytics |
| `gross_revenue` | DECIMAL(12, 2) | DEFAULT 0 | Revenue before deductions |
| `net_revenue` | DECIMAL(12, 2) | DEFAULT 0 | Revenue after deductions |
| `total_commission` | DECIMAL(12, 2) | DEFAULT 0 | Total commission |
| `total_fees` | DECIMAL(12, 2) | DEFAULT 0 | Platform fees |
| `total_tax` | DECIMAL(12, 2) | DEFAULT 0 | Tax collected |
| `avg_order_value` | DECIMAL(10, 2) | DEFAULT 0 | Average order value |
| `profit_margin` | DECIMAL(5, 2) | DEFAULT 0 | Profit margin percentage |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_operational_analytics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `operational_analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `analytics_date` | DATE | NOT NULL | Date of analytics |
| `avg_confirmation_time` | INTEGER | DEFAULT 0 | Avg time to confirm (minutes) |
| `avg_prep_time` | INTEGER | DEFAULT 0 | Avg prep time (minutes) |
| `avg_fulfillment_time` | INTEGER | DEFAULT 0 | Avg fulfillment time (minutes) |
| `avg_delivery_time` | INTEGER | DEFAULT 0 | Avg delivery time (minutes) |
| `on_time_rate` | DECIMAL(5, 2) | DEFAULT 0 | On-time delivery percentage |
| `order_accuracy` | DECIMAL(5, 2) | DEFAULT 0 | Order accuracy percentage |
| `avg_queue_length` | DECIMAL(5, 2) | DEFAULT 0 | Average queue length |
| `peak_order_volume` | INTEGER | DEFAULT 0 | Peak order volume |
| `busiest_hour` | INTEGER | DEFAULT 0 | Busiest hour |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_reports

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `report_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `report_name` | VARCHAR(100) | NOT NULL | Report name |
| `report_type` | VARCHAR(50) | NOT NULL | SALES/ITEMS/CUSTOMERS/FINANCIAL/OPERATIONAL |
| `schedule` | VARCHAR(20) | | DAILY/WEEKLY/MONTHLY/ON_DEMAND |
| `parameters` | JSONB | | Report parameters (date range, filters) |
| `format` | VARCHAR(10) | DEFAULT 'PDF' | PDF/CSV/EXCEL/JSON |
| `recipients` | TEXT[] | | Email recipients |
| `last_generated` | TIMESTAMP | | Last generation timestamp |
| `next_generation` | TIMESTAMP | | Next scheduled generation |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_report_history

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `history_id` | UUID | PRIMARY KEY | Unique identifier |
| `report_id` | UUID | FOREIGN KEY (merchant_reports.report_id) | Associated report |
| `generated_at` | TIMESTAMP | NOT NULL | Generation timestamp |
| `file_url` | VARCHAR(500) | NOT NULL | Storage URL |
| `file_size` | INTEGER | | File size in bytes |
| `records_count` | INTEGER | | Number of records |
| `status` | VARCHAR(20) | DEFAULT 'SUCCESS' | SUCCESS/FAILED/PROCESSING |
| `error_message` | TEXT | | Error message (if failed) |

---

## Chapter 12 – REST APIs

### Analytics Dashboard APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/analytics/dashboard` | Get analytics dashboard |
| `GET` | `/api/v1/merchant/analytics/sales` | Get sales analytics |
| `GET` | `/api/v1/merchant/analytics/orders` | Get order analytics |
| `GET` | `/api/v1/merchant/analytics/items` | Get item performance |
| `GET` | `/api/v1/merchant/analytics/customers` | Get customer insights |
| `GET` | `/api/v1/merchant/analytics/financial` | Get financial analytics |
| `GET` | `/api/v1/merchant/analytics/operational` | Get operational analytics |

### Report APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/reports` | List reports |
| `POST` | `/api/v1/merchant/reports` | Create report |
| `GET` | `/api/v1/merchant/reports/{id}` | Get report details |
| `PUT` | `/api/v1/merchant/reports/{id}` | Update report |
| `DELETE` | `/api/v1/merchant/reports/{id}` | Delete report |
| `POST` | `/api/v1/merchant/reports/{id}/generate` | Generate report now |
| `GET` | `/api/v1/merchant/reports/{id}/history` | Get report generation history |
| `GET` | `/api/v1/merchant/reports/{id}/download` | Download latest report |

### Export APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/v1/merchant/export/sales` | Export sales data |
| `POST` | `/api/v1/merchant/export/orders` | Export order data |
| `POST` | `/api/v1/merchant/export/items` | Export item data |
| `POST` | `/api/v1/merchant/export/customers` | Export customer data |
| `POST` | `/api/v1/merchant/export/financial` | Export financial data |
| `GET` | `/api/v1/merchant/export/status/{job_id}` | Get export job status |
| `GET` | `/api/v1/merchant/export/download/{job_id}` | Download exported file |

---

## Chapter 13 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-ANA-001** | Analytics data must be updated daily (at minimum). | **High** |
| **BR-ANA-002** | Real-time metrics (today) must update within 5 minutes. | **High** |
| **BR-ANA-003** | Historical data must be retained for at least 24 months. | **High** |
| **BR-ANA-004** | Revenue calculations must reconcile with financial transactions. | **High** |
| **BR-ANA-005** | AOV calculation must exclude cancelled orders. | **High** |
| **BR-ANA-006** | Customer LTV calculation must use a minimum of 12 months of data. | **Medium** |
| **BR-ANA-007** | Reports must not contain customer PII (anonymized). | **High** |
| **BR-ANA-008** | Export file limits: 100,000 records per export. | **Medium** |
| **BR-ANA-009** | Benchmark data must be anonymized and aggregated. | **High** |
| **BR-ANA-010** | Analytics data must be auditable and non-repudiable. | **High** |

---

## Chapter 14 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-ANA-001** | Merchant views sales dashboard with KPIs. | **High** |
| **TEST-ANA-002** | Sales trend chart displays correctly. | **High** |
| **TEST-ANA-003** | Merchant filters analytics by date range. | **High** |
| **TEST-ANA-004** | Merchant compares current period to previous period. | **High** |
| **TEST-ANA-005** | Merchant views top selling items. | **High** |
| **TEST-ANA-006** | Merchant views category performance. | **High** |
| **TEST-ANA-007** | Merchant views hourly sales distribution. | **High** |
| **TEST-ANA-008** | Merchant views customer insights (new vs. returning). | **High** |
| **TEST-ANA-009** | Merchant views customer retention rate. | **High** |
| **TEST-ANA-010** | Merchant views operational metrics (prep time, fulfillment). | **High** |
| **TEST-ANA-011** | Merchant views financial analytics (gross vs. net revenue). | **High** |
| **TEST-ANA-012** | Merchant views commission and fees summary. | **High** |
| **TEST-ANA-013** | Merchant creates a custom report. | **High** |
| **TEST-ANA-014** | Merchant schedules a report. | **High** |
| **TEST-ANA-015** | Scheduled report is delivered via email. | **High** |
| **TEST-ANA-016** | Merchant exports sales data to CSV. | **High** |
| **TEST-ANA-017** | Merchant exports order data to Excel. | **High** |
| **TEST-ANA-018** | Merchant exports customer data to CSV. | **High** |
| **TEST-ANA-019** | Large export processes asynchronously (notification on completion). | **High** |
| **TEST-ANA-020** | Merchant views item performance trends. | **High** |
| **TEST-ANA-021** | Merchant views customer LTV. | **High** |
| **TEST-ANA-022** | Merchant views on-time delivery rate. | **High** |
| **TEST-ANA-023** | Merchant views cancellation rate by reason. | **High** |
| **TEST-ANA-024** | Merchant views revenue by channel (web/mobile/API). | **High** |
| **TEST-ANA-025** | Merchant views revenue by day of week. | **High** |
| **TEST-ANA-026** | Dashboard shows "Today's" data in real-time. | **High** |
| **TEST-ANA-027** | Merchant compares to industry benchmarks. | **Medium** |
| **TEST-ANA-028** | Merchant downloads PDF report. | **Medium** |

---

## Chapter 15 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| MER-112 | merchant_analytics_sales | GET /api/v1/merchant/analytics/dashboard | TEST-ANA-001 |
| MER-114 | merchant_analytics_sales | GET /api/v1/merchant/analytics/sales | TEST-ANA-003, TEST-ANA-004 |
| MER-115 | merchant_analytics_sales | GET /api/v1/merchant/analytics/sales | TEST-ANA-011, TEST-ANA-012 |
| MER-116 | merchant_analytics_sales | GET /api/v1/merchant/analytics/orders | TEST-ANA-002, TEST-ANA-007, TEST-ANA-024, TEST-ANA-025 |
| MER-118 | merchant_item_analytics | GET /api/v1/merchant/analytics/items | TEST-ANA-005, TEST-ANA-006, TEST-ANA-020 |
| MER-121 | merchant_customer_analytics | GET /api/v1/merchant/analytics/customers | TEST-ANA-008, TEST-ANA-009, TEST-ANA-021 |
| MER-125 | merchant_operational_analytics | GET /api/v1/merchant/analytics/operational | TEST-ANA-010, TEST-ANA-022, TEST-ANA-023 |
| MER-127 | merchant_financial_analytics | GET /api/v1/merchant/analytics/financial | TEST-ANA-011, TEST-ANA-012 |
| MER-132 | merchant_reports | POST/GET/PUT/DELETE /api/v1/merchant/reports | TEST-ANA-013, TEST-ANA-014, TEST-ANA-015 |
| MER-134 | merchant_export | POST /api/v1/merchant/export/* | TEST-ANA-016, TEST-ANA-017, TEST-ANA-018, TEST-ANA-019 |

---

## Chapter 16 – Summary

This document establishes the comprehensive merchant analytics capability for the **[Platform Name]** platform. Key takeaways:

- **Comprehensive Dashboard:** Real-time and historical views of sales, orders, items, customers, financials, and operational metrics.
- **Sales Analytics:** Revenue, order volume, AOV, trends, and distribution by time, category, and channel.
- **Item & Menu Analytics:** Item performance, top sellers, conversion rates, category analysis, and trend identification.
- **Customer Analytics:** Customer segments, retention, LTV, acquisition, and behavior patterns.
- **Operational Analytics:** Prep times, fulfillment times, on-time rates, accuracy, and queue management.
- **Financial Analytics:** Gross/net revenue, commissions, fees, profit margins, and reconciliation.
- **Comparative Analytics:** Period-over-period comparisons, year-over-year, and industry benchmarks.
- **Reporting:** Scheduled and on-demand reports with multiple export formats (PDF, CSV, Excel, JSON).
- **Data Export:** Comprehensive data export capabilities for external analysis.

The merchant analytics module empowers merchants with the data-driven insights they need to optimize their operations, grow their business, and maximize profitability on the platform.

---

**Next Document:**

`Part_02G_Merchant_Financials.md`

*(This builds on analytics to define merchant financial management, including settlements, payouts, invoicing, and financial reconciliation.)*