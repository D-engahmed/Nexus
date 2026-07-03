# Software Requirements Specification (SRS)

## Part 02G: Merchant Financials

**Module:** Merchant Module (Part 03)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Merchant Financials module defines the complete financial management capabilities for merchants on the **[Platform Name]** platform. This encompasses settlement processing, payout management, invoice generation, financial reconciliation, commission tracking, and financial reporting.

Financial transparency and reliability are fundamental to merchant trust and retention. Merchants need clear visibility into their earnings, predictable settlement schedules, and accurate financial records for their own accounting and tax compliance. A robust financial management system reduces disputes, builds trust, and positions the platform as a reliable business partner.

### Objectives

- Provide transparent, predictable settlement processing
- Enable real-time visibility into earnings and pending settlements
- Support multiple payout methods and schedules
- Generate professional invoices and financial documents
- Provide comprehensive financial reconciliation
- Track commissions, fees, and deductions transparently
- Enable financial reporting for accounting and tax compliance
- Support dispute resolution and financial adjustments

---

## Chapter 2 – Settlement Management

### MER-136 Settlement Overview

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Settlement Schedule** | Configurable frequency (Daily, Weekly, Biweekly, Monthly). | **Required** |
| **Settlement Calculation** | Automatic calculation of net amount after commissions and fees. | **Required** |
| **Settlement History** | Complete history of all settlements. | **Required** |
| **Settlement Details** | Per-order breakdown of settlement amounts. | **Required** |
| **Pending Settlement** | View pending orders not yet settled. | **Required** |
| **Settlement Notifications** | Notification when settlement is processed. | **Required** |
| **Settlement Reports** | Downloadable settlement reports. | **Required** |

### MER-137 Settlement Calculation

| Component | Description | Formula |
| :--- | :--- | :--- |
| **Gross Revenue** | Total order value (items + delivery fees). | Sum of order totals. |
| **Platform Commission** | Percentage-based fee charged by platform. | Gross × Commission Rate. |
| **Service Fee** | Fixed or percentage-based service fee. | As configured per merchant. |
| **Delivery Fee (Platform)** | Delivery fee retained by platform. | Delivery fee portion. |
| **Payment Processing Fee** | Gateway fees for payment processing. | As charged by payment provider. |
| **Promotion/Discount** | Discounts absorbed by merchant (if applicable). | As per promotion terms. |
| **Adjustments** | Manual adjustments (credits/debits). | As approved by admin. |
| **Tax** | Tax collected on behalf of government. | Taxable amount × Tax Rate. |
| **Net Settlement** | Amount paid to merchant. | Gross - Commission - Fees - Discounts + Adjustments. |

### MER-138 Settlement Calculation Example

| Component | Amount | Notes |
| :--- | :--- | :--- |
| Gross Revenue | $1,000.00 | Total order values |
| Platform Commission (20%) | ($200.00) | 20% of gross |
| Service Fee (2%) | ($20.00) | 2% of gross |
| Delivery Fee (Platform) | ($50.00) | Delivery fees retained |
| Payment Processing Fee (2.9% + $0.30) | ($29.00 + $3.00) | Gateway fees |
| Promotions/Discounts | ($25.00) | Merchant-funded discounts |
| Adjustments | $10.00 | Manual credit |
| **Net Settlement** | **$683.00** | Amount paid to merchant |

### MER-139 Settlement Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `settlement_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `settlement_period_start` | Date | Yes | Start of settlement period |
| `settlement_period_end` | Date | Yes | End of settlement period |
| `gross_revenue` | Decimal | Yes | Total order value |
| `total_commission` | Decimal | Yes | Commission deducted |
| `total_service_fee` | Decimal | Yes | Service fees deducted |
| `total_delivery_fee_platform` | Decimal | Yes | Delivery fees retained |
| `total_payment_fee` | Decimal | Yes | Payment processing fees |
| `total_promotions` | Decimal | Yes | Promotions applied |
| `total_adjustments` | Decimal | Yes | Manual adjustments |
| `total_tax` | Decimal | Yes | Tax collected |
| `net_amount` | Decimal | Yes | Amount paid to merchant |
| `currency` | String | Yes | ISO 4217 currency code |
| `order_count` | Integer | Yes | Number of orders in settlement |
| `status` | String | Yes | PENDING/PROCESSING/COMPLETED/FAILED |
| `payout_id` | UUID | | Reference to payout |
| `settlement_date` | Date | | Date settlement was processed |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-140 Settlement Order Breakdown

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `order_id` | UUID | Associated order |
| `order_date` | Date | Order placement date |
| `order_total` | Decimal | Order total |
| `commission` | Decimal | Commission deducted |
| `fees` | Decimal | Fees deducted |
| `net_amount` | Decimal | Net amount for this order |
| `status` | String | SETTLED/PENDING |

---

## Chapter 3 – Payout Management

### MER-141 Payout Methods

| Method | Description | Priority |
| :--- | :--- | :--- |
| **Bank Transfer** | Direct deposit to merchant bank account. | **Required** |
| **Digital Wallet** | Payout to platform wallet (instant). | **Required** |
| **Check** | Physical check mailed to merchant. | **Optional** |
| **Wire Transfer** | International wire transfer. | **Medium** |
| **Local Payment Rails** | Region-specific payment methods (e.g., Fawry, Mada). | **Required** |

### MER-142 Payout Schedule Options

| Schedule | Description | Priority |
| :--- | :--- | :--- |
| **Daily** | Payout daily (next business day). | **Medium** |
| **Weekly** | Payout weekly (e.g., every Monday). | **Required** |
| **Biweekly** | Payout every two weeks. | **Required** |
| **Monthly** | Payout monthly (e.g., 1st of month). | **Required** |
| **On-Demand** | Merchant-initiated payout (manual). | **Medium** |
| **Threshold-Based** | Payout when balance exceeds threshold. | **Medium** |

### MER-143 Payout Processing

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Automated Processing** | Payouts processed automatically per schedule. | **Required** |
| **Manual Processing** | Admin can manually trigger payouts. | **Required** |
| **Payout Validation** | Validate bank account before processing. | **Required** |
| **Payout Status** | Track payout status (Pending, Processing, Completed, Failed). | **Required** |
| **Payout History** | Complete history of payouts. | **Required** |
| **Payout Notifications** | Notify merchant when payout is processed. | **Required** |
| **Payout Reversal** | Ability to reverse failed payouts. | **Required** |

### MER-144 Payout Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `payout_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `settlement_id` | UUID | Yes | Associated settlement |
| `bank_account_id` | UUID | Yes | Destination bank account |
| `amount` | Decimal | Yes | Payout amount |
| `currency` | String | Yes | ISO 4217 currency code |
| `payout_method` | String | Yes | BANK_TRANSFER/WALLET/CHECK/WIRE |
| `reference_number` | String | Yes | Platform reference |
| `transaction_id` | String | | Payment provider transaction ID |
| `status` | String | Yes | PENDING/PROCESSING/COMPLETED/FAILED |
| `failure_reason` | Text | | Reason for failure |
| `initiated_at` | Timestamp | | Payout initiation timestamp |
| `completed_at` | Timestamp | | Payout completion timestamp |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 4 – Commission Management

### MER-145 Commission Structure

| Commission Type | Description | Priority |
| :--- | :--- | :--- |
| **Fixed Percentage** | Fixed percentage of gross order value. | **Required** |
| **Tiered Percentage** | Different rates based on order volume or value. | **Required** |
| **Fixed Fee** | Fixed amount per order. | **Medium** |
| **Hybrid** | Combination of percentage and fixed fee. | **Medium** |
| **Custom** | Custom commission per merchant agreement. | **Required** |

### MER-146 Commission Tiers

| Tier | Monthly Order Volume | Commission Rate |
| :--- | :--- | :--- |
| **Standard** | 0 - 500 orders | 25% |
| **Bronze** | 501 - 1,000 orders | 22% |
| **Silver** | 1,001 - 2,500 orders | 20% |
| **Gold** | 2,501 - 5,000 orders | 18% |
| **Platinum** | 5,001+ orders | 15% |

### MER-147 Commission Calculation Rules

| Rule | Description |
| :--- | :--- |
| **Base Calculation** | Commission calculated on subtotal (excluding tax and tips). |
| **Minimum Commission** | Minimum commission per order (if applicable). |
| **Maximum Commission** | Maximum commission per order (if applicable). |
| **Promotional Adjustment** | Commission on discounted items may be adjusted. |
| **Tax Exemption** | Commission not calculated on tax amount. |
| **Tip Exclusion** | Tips are not subject to commission. |

### MER-148 Commission Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `commission_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `commission_type` | String | Yes | PERCENTAGE/TIERED/FIXED/HYBRID/CUSTOM |
| `rate` | Decimal | Yes | Commission rate (percentage or fixed) |
| `tier_structure` | JSONB | | Tiered commission structure |
| `minimum_commission` | Decimal | | Minimum commission per order |
| `maximum_commission` | Decimal | | Maximum commission per order |
| `effective_date` | Date | Yes | When commission takes effect |
| `end_date` | Date | | When commission ends |
| `is_active` | Boolean | Yes | Active status |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

### MER-149 Commission History

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `history_id` | UUID | Unique identifier |
| `order_id` | UUID | Associated order |
| `commission_rate` | Decimal | Rate applied to this order |
| `commission_amount` | Decimal | Commission deducted |
| `calculation_details` | JSONB | Detailed calculation breakdown |
| `created_at` | Timestamp | Record timestamp |

---

## Chapter 5 – Invoice Management

### MER-150 Invoice Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Invoice Generation** | Auto-generate invoices for each settlement period. | **Required** |
| **Invoice Format** | Professional, branded invoice format. | **Required** |
| **Invoice Details** | Order breakdown, commissions, fees, net amount. | **Required** |
| **Invoice Numbering** | Sequential, human-readable invoice numbers. | **Required** |
| **Invoice Download** | Download as PDF. | **Required** |
| **Invoice Email** | Email invoices to merchant. | **Required** |
| **Invoice History** | Complete history of all invoices. | **Required** |
| **Bulk Invoice** | Generate invoices for multiple periods. | **Medium** |
| **Custom Invoice Fields** | Merchant-specific invoice fields. | **Medium** |

### MER-151 Invoice Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `invoice_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `invoice_number` | String | UNIQUE | Human-readable invoice number |
| `settlement_id` | UUID | | Associated settlement |
| `invoice_date` | Date | Yes | Invoice date |
| `invoice_period_start` | Date | Yes | Period start |
| `invoice_period_end` | Date | Yes | Period end |
| `gross_amount` | Decimal | Yes | Gross revenue |
| `commission_amount` | Decimal | Yes | Commission deducted |
| `fee_amount` | Decimal | Yes | Fees deducted |
| `adjustment_amount` | Decimal | Yes | Adjustments |
| `net_amount` | Decimal | Yes | Net settlement amount |
| `currency` | String | Yes | ISO 4217 currency code |
| `tax_amount` | Decimal | Yes | Tax collected |
| `invoice_url` | String | | PDF invoice URL |
| `status` | String | Yes | GENERATED/SENT/PAID/OVERDUE |
| `sent_at` | Timestamp | | When invoice was emailed |
| `paid_at` | Timestamp | | When invoice was paid |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 6 – Financial Reconciliation

### MER-152 Reconciliation Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Order-Level Reconciliation** | Verify each order's financial details. | **Required** |
| **Daily Reconciliation** | End-of-day financial reconciliation. | **Required** |
| **Period Reconciliation** | Reconciliation by period (weekly, monthly). | **Required** |
| **Discrepancy Detection** | Identify financial discrepancies. | **Required** |
| **Discrepancy Resolution** | Track resolution of discrepancies. | **Required** |
| **Reconciliation Report** | Generate reconciliation reports. | **Required** |
| **Audit Trail** | Complete audit trail of financial activity. | **Required** |

### MER-153 Reconciliation Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `reconciliation_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `reconciliation_date` | Date | Yes | Date of reconciliation |
| `period_start` | Date | Yes | Period start |
| `period_end` | Date | Yes | Period end |
| `expected_revenue` | Decimal | Yes | Expected revenue |
| `actual_revenue` | Decimal | Yes | Actual revenue |
| `expected_commission` | Decimal | Yes | Expected commission |
| `actual_commission` | Decimal | Yes | Actual commission |
| `discrepancy_amount` | Decimal | Yes | Difference |
| `discrepancy_reason` | Text | | Reason for discrepancy |
| `status` | String | Yes | RECONCILED/DISCREPANT/PENDING |
| `reconciled_by` | UUID | | Admin who reconciled |
| `reconciled_at` | Timestamp | | Reconciliation timestamp |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 7 – Fee Management

### MER-154 Fee Types

| Fee Type | Description | Priority |
| :--- | :--- | :--- |
| **Service Fee** | Platform service fee (percentage or fixed). | **Required** |
| **Delivery Fee** | Fee charged for delivery (merchant may subsidize). | **Required** |
| **Payment Processing Fee** | Gateway fees for card processing. | **Required** |
| **Commission Fee** | Commission on order value. | **Required** |
| **Service Charge** | Additional service charge (e.g., packaging). | **Medium** |
| **Late Fee** | Fee for late payment (merchant side). | **Low** |
| **Dispute Fee** | Fee for chargeback/dispute processing. | **Medium** |

### MER-155 Fee Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `fee_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `fee_type` | String | Yes | SERVICE/DELIVERY/PAYMENT/COMMISSION |
| `fee_name` | String | Yes | Display name |
| `fee_calculation` | String | Yes | PERCENTAGE/FIXED/HYBRID |
| `fee_rate` | Decimal | Yes | Rate (percentage or fixed amount) |
| `fee_cap` | Decimal | | Maximum fee amount |
| `fee_minimum` | Decimal | | Minimum fee amount |
| `effective_date` | Date | Yes | When fee takes effect |
| `end_date` | Date | | When fee ends |
| `is_active` | Boolean | Yes | Active status |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 8 – Financial Dashboard

### MER-156 Financial Dashboard Widgets

| Widget | Description | Priority |
| :--- | :--- | :--- |
| **Today's Earnings** | Net earnings for today. | **Required** |
| **This Week's Earnings** | Net earnings for the week. | **Required** |
| **Month-to-Date** | Earnings for the current month. | **Required** |
| **Pending Settlement** | Amount pending settlement. | **Required** |
| **Last Settlement** | Last settlement amount and date. | **Required** |
| **Commission Summary** | Commission charged this period. | **Required** |
| **Revenue vs. Commission** | Visual comparison of gross vs. net. | **Required** |
| **Upcoming Payout** | Next scheduled payout amount and date. | **Required** |
| **Payment Method Status** | Bank account verification status. | **Required** |

### MER-157 Financial Widget Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `store_id` | UUID | Associated store |
| `current_balance` | Decimal | Current available balance |
| `pending_balance` | Decimal | Pending settlement amount |
| `total_earned` | Decimal | Lifetime earnings |
| `total_commission` | Decimal | Lifetime commission |
| `last_settlement_date` | Date | Last settlement date |
| `last_settlement_amount` | Decimal | Last settlement amount |
| `next_settlement_date` | Date | Next settlement date |
| `next_settlement_amount` | Decimal | Estimated next settlement |
| `updated_at` | Timestamp | Last update timestamp |

---

## Chapter 9 – Dispute Management

### MER-158 Dispute Types

| Dispute Type | Description | Priority |
| :--- | :--- | :--- |
| **Chargeback** | Customer disputes charge with bank. | **Required** |
| **Merchant Dispute** | Merchant disputes commission or fees. | **Required** |
| **Customer Dispute** | Customer disputes order/charge. | **Required** |
| **Financial Discrepancy** | Discrepancy in settlement calculation. | **Required** |

### MER-159 Dispute Workflow

1.  Dispute initiated (customer, merchant, or system).
2.  Dispute logged with details and reason.
3.  Funds involved may be held pending resolution.
4.  Investigation conducted (support, finance).
5.  Evidence collected and reviewed.
6.  Decision made (merchant wins, customer wins, partial).
7.  Settlement adjusted if necessary.
8.  Merchant notified of outcome.
9.  Dispute closed with resolution.

### MER-160 Dispute Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `dispute_id` | UUID | Yes | Unique identifier |
| `store_id` | UUID | Yes | Associated store |
| `order_id` | UUID | Yes | Associated order |
| `dispute_type` | String | Yes | CHARGEBACK/MERCHANT/CUSTOMER/DISCREPANCY |
| `initiated_by` | String | Yes | CUSTOMER/MERCHANT/PLATFORM |
| `amount` | Decimal | Yes | Disputed amount |
| `currency` | String | Yes | ISO 4217 currency code |
| `reason` | Text | Yes | Reason for dispute |
| `status` | String | Yes | PENDING/INVESTIGATING/RESOLVED/CLOSED |
| `resolution` | Text | | Resolution details |
| `resolution_date` | Timestamp | | Resolution date |
| `adjustment_amount` | Decimal | | Settlement adjustment |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 10 – Database Tables

### merchant_settlements

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `settlement_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `period_start` | DATE | NOT NULL | Period start |
| `period_end` | DATE | NOT NULL | Period end |
| `gross_revenue` | DECIMAL(12, 2) | NOT NULL | Total order value |
| `total_commission` | DECIMAL(12, 2) | NOT NULL | Commission deducted |
| `total_service_fee` | DECIMAL(12, 2) | DEFAULT 0 | Service fees deducted |
| `total_delivery_fee_platform` | DECIMAL(12, 2) | DEFAULT 0 | Delivery fees retained |
| `total_payment_fee` | DECIMAL(12, 2) | DEFAULT 0 | Payment processing fees |
| `total_promotions` | DECIMAL(12, 2) | DEFAULT 0 | Promotions applied |
| `total_adjustments` | DECIMAL(12, 2) | DEFAULT 0 | Manual adjustments |
| `total_tax` | DECIMAL(12, 2) | DEFAULT 0 | Tax collected |
| `net_amount` | DECIMAL(12, 2) | NOT NULL | Net settlement amount |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `order_count` | INTEGER | NOT NULL | Number of orders |
| `order_ids` | TEXT[] | | Order IDs in settlement |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/PROCESSING/COMPLETED/FAILED |
| `settlement_date` | DATE | | Date processed |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_settlement_details

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `detail_id` | UUID | PRIMARY KEY | Unique identifier |
| `settlement_id` | UUID | FOREIGN KEY (merchant_settlements.settlement_id) | Associated settlement |
| `order_id` | UUID | FOREIGN KEY (merchant_orders.order_id) | Associated order |
| `order_total` | DECIMAL(12, 2) | NOT NULL | Order total |
| `commission` | DECIMAL(12, 2) | NOT NULL | Commission deducted |
| `fees` | DECIMAL(12, 2) | DEFAULT 0 | Fees deducted |
| `net_amount` | DECIMAL(12, 2) | NOT NULL | Net amount for order |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |

### merchant_payouts

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payout_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `settlement_id` | UUID | FOREIGN KEY (merchant_settlements.settlement_id) | Associated settlement |
| `bank_account_id` | UUID | FOREIGN KEY (merchant_bank_accounts.bank_account_id) | Destination bank account |
| `amount` | DECIMAL(12, 2) | NOT NULL | Payout amount |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `payout_method` | VARCHAR(30) | NOT NULL | BANK_TRANSFER/WALLET/CHECK/WIRE |
| `reference_number` | VARCHAR(50) | UNIQUE | Platform reference |
| `transaction_id` | VARCHAR(100) | | Payment provider transaction ID |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/PROCESSING/COMPLETED/FAILED |
| `failure_reason` | TEXT | | Reason for failure |
| `initiated_at` | TIMESTAMP | | Initiation timestamp |
| `completed_at` | TIMESTAMP | | Completion timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_invoices

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `invoice_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `invoice_number` | VARCHAR(50) | UNIQUE | Human-readable invoice number |
| `settlement_id` | UUID | FOREIGN KEY (merchant_settlements.settlement_id) | Associated settlement |
| `invoice_date` | DATE | NOT NULL | Invoice date |
| `period_start` | DATE | NOT NULL | Period start |
| `period_end` | DATE | NOT NULL | Period end |
| `gross_amount` | DECIMAL(12, 2) | NOT NULL | Gross revenue |
| `commission_amount` | DECIMAL(12, 2) | NOT NULL | Commission deducted |
| `fee_amount` | DECIMAL(12, 2) | NOT NULL | Fees deducted |
| `adjustment_amount` | DECIMAL(12, 2) | DEFAULT 0 | Adjustments |
| `net_amount` | DECIMAL(12, 2) | NOT NULL | Net settlement amount |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `tax_amount` | DECIMAL(12, 2) | DEFAULT 0 | Tax collected |
| `invoice_url` | VARCHAR(500) | | PDF invoice URL |
| `status` | VARCHAR(20) | DEFAULT 'GENERATED' | GENERATED/SENT/PAID/OVERDUE |
| `sent_at` | TIMESTAMP | | When invoice was emailed |
| `paid_at` | TIMESTAMP | | When invoice was paid |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_commission_history

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `history_id` | UUID | PRIMARY KEY | Unique identifier |
| `order_id` | UUID | FOREIGN KEY (merchant_orders.order_id) | Associated order |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `commission_rate` | DECIMAL(5, 2) | NOT NULL | Rate applied |
| `commission_amount` | DECIMAL(12, 2) | NOT NULL | Commission deducted |
| `calculation_details` | JSONB | | Detailed calculation breakdown |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record timestamp |

### merchant_disputes

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `dispute_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `order_id` | UUID | FOREIGN KEY (merchant_orders.order_id) | Associated order |
| `dispute_type` | VARCHAR(30) | NOT NULL | CHARGEBACK/MERCHANT/CUSTOMER/DISCREPANCY |
| `initiated_by` | VARCHAR(20) | NOT NULL | CUSTOMER/MERCHANT/PLATFORM |
| `amount` | DECIMAL(12, 2) | NOT NULL | Disputed amount |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `reason` | TEXT | NOT NULL | Reason for dispute |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/INVESTIGATING/RESOLVED/CLOSED |
| `resolution` | TEXT | | Resolution details |
| `resolution_date` | TIMESTAMP | | Resolution date |
| `adjustment_amount` | DECIMAL(12, 2) | | Settlement adjustment |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### merchant_financial_settings

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `setting_id` | UUID | PRIMARY KEY | Unique identifier |
| `store_id` | UUID | UNIQUE, FOREIGN KEY (merchant_stores.store_id) | Associated store |
| `settlement_frequency` | VARCHAR(20) | DEFAULT 'WEEKLY' | DAILY/WEEKLY/BIWEEKLY/MONTHLY |
| `settlement_day` | INTEGER | | Day of week (for weekly) |
| `minimum_payout_amount` | DECIMAL(10, 2) | DEFAULT 10.00 | Minimum payout threshold |
| `payout_method` | VARCHAR(30) | DEFAULT 'BANK_TRANSFER' | Preferred payout method |
| `invoice_email` | VARCHAR(255) | | Email for invoice delivery |
| `tax_registration_number` | VARCHAR(50) | | VAT/GST number |
| `tax_rate` | DECIMAL(5, 2) | | Applicable tax rate |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 11 – REST APIs

### Settlement APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/settlements` | List settlements |
| `GET` | `/api/v1/merchant/finance/settlements/{id}` | Get settlement details |
| `GET` | `/api/v1/merchant/finance/settlements/{id}/orders` | Get orders in settlement |
| `GET` | `/api/v1/merchant/finance/settlements/pending` | Get pending settlement |

### Payout APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/payouts` | List payouts |
| `GET` | `/api/v1/merchant/finance/payouts/{id}` | Get payout details |
| `GET` | `/api/v1/merchant/finance/payouts/upcoming` | Get upcoming payout |
| `POST` | `/api/v1/merchant/finance/payouts/request` | Request manual payout |

### Invoice APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/invoices` | List invoices |
| `GET` | `/api/v1/merchant/finance/invoices/{id}` | Get invoice details |
| `GET` | `/api/v1/merchant/finance/invoices/{id}/download` | Download invoice PDF |
| `POST` | `/api/v1/merchant/finance/invoices/{id}/resend` | Resend invoice email |

### Commission APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/commission` | Get current commission structure |
| `GET` | `/api/v1/merchant/finance/commission/history` | Get commission history |

### Financial Dashboard APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/dashboard` | Get financial dashboard data |
| `GET` | `/api/v1/merchant/finance/balance` | Get current balance |

### Dispute APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/disputes` | List disputes |
| `GET` | `/api/v1/merchant/finance/disputes/{id}` | Get dispute details |
| `POST` | `/api/v1/merchant/finance/disputes` | Initiate dispute |

### Settings APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/merchant/finance/settings` | Get financial settings |
| `PUT` | `/api/v1/merchant/finance/settings` | Update financial settings |

---

## Chapter 12 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-FIN-001** | Settlements must be processed according to merchant's selected frequency. | **High** |
| **BR-FIN-002** | Minimum payout threshold: $10 (configurable). | **High** |
| **BR-FIN-003** | Commission is calculated on subtotal (excluding tax and tips). | **High** |
| **BR-FIN-004** | All settlements must have a corresponding invoice. | **High** |
| **BR-FIN-005** | Disputed orders are excluded from settlement until resolved. | **High** |
| **BR-FIN-006** | Payouts require verified bank account. | **High** |
| **BR-FIN-007** | Tax amounts must be tracked separately for reporting. | **High** |
| **BR-FIN-008** | Manual adjustments require admin approval. | **High** |
| **BR-FIN-009** | Settlement data must be retained for 7 years (regulatory). | **High** |
| **BR-FIN-010** | Commission rates are locked for the period agreed with merchant. | **High** |

---

## Chapter 13 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-FIN-001** | Merchant views financial dashboard with balance and earnings. | **High** |
| **TEST-FIN-002** | Merchant views settlement history. | **High** |
| **TEST-FIN-003** | Merchant views settlement details with order breakdown. | **High** |
| **TEST-FIN-004** | Settlement is calculated correctly (gross, commission, fees, net). | **High** |
| **TEST-FIN-005** | Settlement with multiple orders calculates correctly. | **High** |
| **TEST-FIN-006** | Payout is processed on schedule (weekly). | **High** |
| **TEST-FIN-007** | Payout is processed on schedule (monthly). | **High** |
| **TEST-FIN-008** | Merchant receives notification on payout completion. | **High** |
| **TEST-FIN-009** | Merchant views payout history. | **High** |
| **TEST-FIN-010** | Failed payout is retried (with notification). | **High** |
| **TEST-FIN-011** | Merchant requests manual payout. | **Medium** |
| **TEST-FIN-012** | Invoice is generated with settlement. | **High** |
| **TEST-FIN-013** | Merchant downloads invoice as PDF. | **High** |
| **TEST-FIN-014** | Invoice is emailed to merchant. | **High** |
| **TEST-FIN-015** | Merchant views commission history. | **High** |
| **TEST-FIN-016** | Commission tier changes based on order volume. | **High** |
| **TEST-FIN-017** | Merchant views upcoming payout estimate. | **High** |
| **TEST-FIN-018** | Merchant updates financial settings (settlement frequency). | **High** |
| **TEST-FIN-019** | Admin processes manual adjustment (credit). | **High** |
| **TEST-FIN-020** | Admin processes manual adjustment (debit). | **High** |
| **TEST-FIN-021** | Merchant initiates dispute. | **High** |
| **TEST-FIN-022** | Dispute resolved (merchant wins, adjustment applied). | **High** |
| **TEST-FIN-023** | Dispute resolved (merchant loses, adjustment applied). | **High** |
| **TEST-FIN-024** | Tax is calculated correctly on orders. | **High** |
| **TEST-FIN-025** | Merchant views tax summary report. | **High** |
| **TEST-FIN-026** | Settlement status updates correctly (Pending → Processing → Completed). | **High** |
| **TEST-FIN-027** | Bank account verification required before payout. | **High** |
| **TEST-FIN-028** | Merchant views pending settlement amount. | **High** |

---

## Chapter 14 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| MER-136 | merchant_settlements | GET /api/v1/merchant/finance/settlements | TEST-FIN-001, TEST-FIN-002, TEST-FIN-003 |
| MER-137 | merchant_settlements | GET /api/v1/merchant/finance/settlements/{id} | TEST-FIN-004, TEST-FIN-005 |
| MER-141 | merchant_payouts | GET /api/v1/merchant/finance/payouts | TEST-FIN-006, TEST-FIN-007, TEST-FIN-008, TEST-FIN-009, TEST-FIN-010 |
| MER-142 | merchant_payouts | POST /api/v1/merchant/finance/payouts/request | TEST-FIN-011 |
| MER-150 | merchant_invoices | GET /api/v1/merchant/finance/invoices | TEST-FIN-012, TEST-FIN-013, TEST-FIN-014 |
| MER-145 | merchant_commission_history | GET /api/v1/merchant/finance/commission/history | TEST-FIN-015, TEST-FIN-016 |
| MER-156 | merchant_financial_settings | GET /api/v1/merchant/finance/dashboard | TEST-FIN-017 |
| MER-141 | merchant_financial_settings | PUT /api/v1/merchant/finance/settings | TEST-FIN-018 |
| MER-137 | merchant_settlements | Admin API | TEST-FIN-019, TEST-FIN-020 |
| MER-158 | merchant_disputes | GET/POST /api/v1/merchant/finance/disputes | TEST-FIN-021, TEST-FIN-022, TEST-FIN-023 |
| MER-137 | merchant_settlements | GET /api/v1/merchant/finance/settlements/{id} | TEST-FIN-024 |
| MER-136 | merchant_settlements | GET /api/v1/merchant/finance/settlements/pending | TEST-FIN-026, TEST-FIN-028 |

---

## Chapter 15 – Summary

This document establishes the complete merchant financial management capability for the **[Platform Name]** platform. Key takeaways:

- **Comprehensive Settlement Management:** Automated settlement calculation with transparent breakdown of gross revenue, commissions, fees, and net amount.
- **Flexible Payout Options:** Support for multiple payout methods (bank transfer, wallet, check, wire) and schedules (daily, weekly, biweekly, monthly).
- **Transparent Commission Structure:** Configurable commission rates with tiered structures based on order volume or value.
- **Professional Invoicing:** Auto-generated, branded invoices with detailed order breakdowns and PDF download.
- **Financial Reconciliation:** Order-level, daily, and period reconciliation with discrepancy detection and resolution.
- **Dispute Management:** Structured workflow for chargebacks, merchant disputes, and financial discrepancies.
- **Financial Dashboard:** Real-time visibility into earnings, pending settlements, commissions, and upcoming payouts.
- **Regulatory Compliance:** Tax tracking, audit trails, and 7-year data retention for financial records.

The merchant financials module is the foundation of merchant trust and platform reliability. Transparent, accurate, and timely financial processing ensures merchants view the platform as a dependable business partner, driving long-term retention and growth.

---

**Next Document:**

`04_Driver_Courier_Module/Part_03A_Driver_Recruitment_Onboarding.md`

*(This transitions from merchant management to driver management, starting with driver recruitment and onboarding.)*