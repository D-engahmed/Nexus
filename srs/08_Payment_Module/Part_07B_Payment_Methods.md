# Software Requirements Specification (SRS)

## Part 07B: Payment Methods

**Module:** Payment Module (Part 08)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Payment Methods module defines the complete payment method framework for the **[Platform Name]** platform. This encompasses all payment methods available to customers, including credit/debit cards, digital wallets, cash on delivery (COD), buy now pay later (BNPL), mobile wallets, and regional payment alternatives.

Payment method diversity is critical for customer conversion and retention. Customers expect to pay using their preferred method, and offering a wide range of options reduces friction at checkout. This module ensures that the platform supports a comprehensive set of payment methods while maintaining security, compliance, and a seamless user experience.

### Objectives

- Support a diverse range of payment methods
- Enable secure storage and reuse of payment methods
- Provide seamless payment method management for customers
- Support regional and local payment alternatives
- Ensure PCI DSS compliance for all payment methods
- Enable payment method validation and verification
- Support default payment method selection
- Provide payment method analytics and insights

---

## Chapter 2 – Payment Method Types

### PAY-023 Supported Payment Methods

| Payment Method | Description | Priority | Regions |
| :--- | :--- | :--- | :--- |
| **Credit/Debit Cards** | Visa, Mastercard, American Express, local schemes | **Required** | Global |
| **Digital Wallets** | Platform wallet (prepaid balance) | **Required** | Global |
| **Cash on Delivery (COD)** | Pay cash upon delivery | **Required** | All |
| **Mobile Wallets** | Apple Pay, Google Pay, Samsung Pay | **Required** | Global |
| **Buy Now, Pay Later (BNPL)** | Installment payments | **Required** | Global |
| **Local Payment Methods** | Regional alternatives | **Required** | Per region |
| **Bank Transfers** | Direct bank transfer | **Medium** | Various |
| **Cryptocurrency** | Bitcoin, stablecoins | **Future** | Global |

### PAY-024 Payment Method Categories

| Category | Description | Examples |
| :--- | :--- | :--- |
| **Card-Based** | Payment via credit/debit cards | Visa, Mastercard, Amex, Mada |
| **Wallet-Based** | Prepaid or digital wallets | Platform Wallet, Apple Pay, Google Pay |
| **Cash-Based** | Physical cash payment | Cash on Delivery |
| **Credit-Based** | Buy now, pay later | Tabby, Tamara, Klarna, Afterpay |
| **Bank-Based** | Direct bank transfers | Bank Transfer, Direct Debit |
| **Regional** | Region-specific methods | STC Pay (KSA), Fawry (Egypt), Mada (KSA) |

---

## Chapter 3 – Card Payments

### PAY-025 Supported Card Schemes

| Scheme | Regions | Priority |
| :--- | :--- | :--- |
| **Visa** | Global | **Required** |
| **Mastercard** | Global | **Required** |
| **American Express** | Global | **Required** |
| **Mada** | KSA | **Required** |
| **Diners Club** | Global | **Medium** |
| **Discover** | Global | **Medium** |
| **Local Schemes** | Per region | **Required** |

### PAY-026 Card Payment Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Card Tokenization** | Secure token storage for reuse | **Required** |
| **Card Validation** | Luhn check, expiry validation | **Required** |
| **3D Secure** | 3DS2 authentication support | **Required** |
| **Card Brand Detection** | Detect card brand from number | **Required** |
| **BIN Lookup** | Bank identification number lookup | **Required** |
| **Card Art** | Display card brand logo | **Required** |
| **CVV Handling** | CVV never stored | **Required** |

### PAY-027 Card Input Fields

| Field | Required | Description |
| :--- | :--- | :--- |
| **Card Number** | Yes | Primary account number (PAN) |
| **Expiry Month** | Yes | Expiry month (MM) |
| **Expiry Year** | Yes | Expiry year (YYYY) |
| **CVV** | Yes | Card verification value |
| **Cardholder Name** | Yes | Name on card |
| **Billing Address** | Optional | Billing address (for AVS) |

### PAY-028 Card Validation Rules

| Rule | Description |
| :--- | :--- |
| **Luhn Check** | Card number passes Luhn algorithm |
| **Expiry Check** | Card not expired |
| **CVV Length** | CVV matches card brand requirements |
| **Cardholder Name** | Not empty (minimum 2 characters) |
| **BIN Validation** | Card brand matches BIN |

---

## Chapter 4 – Digital Wallets

### PAY-029 Platform Wallet

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Wallet Balance** | Customer can view wallet balance | **Required** |
| **Top-Up** | Add funds to wallet | **Required** |
| **Payment** | Pay with wallet balance | **Required** |
| **Refund to Wallet** | Refunds can go to wallet | **Required** |
| **Wallet History** | View transaction history | **Required** |
| **Auto Top-Up** | Auto-top-up when balance is low | **Medium** |

### PAY-030 Mobile Wallets

| Wallet | Integration | Priority |
| :--- | :--- | :--- |
| **Apple Pay** | Native iOS SDK | **Required** |
| **Google Pay** | Android SDK / Web | **Required** |
| **Samsung Pay** | Samsung SDK | **Required** |

### PAY-031 Mobile Wallet Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Tokenization** | Secure token for payment | **Required** |
| **Biometric Auth** | Fingerprint/Face ID authentication | **Required** |
| **Express Checkout** | One-tap payment | **Required** |
| **Device Detection** | Detect available wallets | **Required** |

---

## Chapter 5 – Cash on Delivery (COD)

### PAY-032 COD Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **COD Eligibility** | Merchant/customer eligibility check | **Required** |
| **COD Limit** | Maximum order value for COD | **Required** |
| **Cash Collection** | Driver collects cash | **Required** |
| **Change Handling** | Driver handles change | **Required** |
| **Payment Confirmation** | Driver confirms cash receipt | **Required** |
| **COD Risk Scoring** | Risk assessment for COD orders | **Required** |

### PAY-033 COD Business Rules

| Rule | Description | Priority |
| :--- | :--- | :--- |
| **Maximum Order Value** | COD only for orders under $50 (configurable) | **Required** |
| **Customer Eligibility** | Customer must have completed previous orders | **Required** |
| **Merchant Eligibility** | Merchant must accept COD | **Required** |
| **New Customer Limit** | New customers limited to $20 COD (configurable) | **Required** |
| **Repeated Offenses** | COD blocked for customers with multiple failed deliveries | **Required** |
| **Risk Scoring** | COD disabled for high-risk customers | **Required** |

---

## Chapter 6 – Buy Now, Pay Later (BNPL)

### PAY-034 BNPL Providers

| Provider | Regions | Priority |
| :--- | :--- | :--- |
| **Tabby** | KSA, UAE, MENA | **Required** |
| **Tamara** | KSA, UAE, MENA | **Required** |
| **Klarna** | Europe, US, Global | **Required** |
| **Afterpay** | Australia, UK, US | **Medium** |
| **Affirm** | US, Canada | **Medium** |

### PAY-035 BNPL Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Installment Plans** | 2-4 installments | **Required** |
| **Interest-Free** | Interest-free installments | **Required** |
| **Credit Check** | Real-time credit check | **Required** |
| **Payment Schedule** | Scheduled installment payments | **Required** |
| **Late Fees** | Late payment fees | **Required** |
| **Refund Handling** | Refund processing for BNPL | **Required** |

---

## Chapter 7 – Regional Payment Methods

### PAY-036 Regional Methods by Region

| Region | Method | Description | Priority |
| :--- | :--- | :--- | :--- |
| **MENA** | STC Pay | Saudi mobile wallet | **Required** |
| **MENA** | Mada | Saudi debit card scheme | **Required** |
| **MENA** | Fawry | Egyptian bill payment | **Required** |
| **MENA** | Benefit | Bahrain mobile wallet | **Required** |
| **Southeast Asia** | GrabPay | Grab wallet | **Required** |
| **Southeast Asia** | OVO | Indonesian wallet | **Required** |
| **Southeast Asia** | DANA | Indonesian wallet | **Required** |
| **Southeast Asia** | GCash | Philippines wallet | **Required** |
| **Europe** | iDEAL | Dutch bank transfer | **Required** |
| **Europe** | Sofort | German bank transfer | **Required** |
| **Europe** | Giropay | German bank transfer | **Required** |
| **Europe** | Bancontact | Belgian bank transfer | **Required** |

### PAY-037 Regional Method Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Localized UX** | Localized payment experience | **Required** |
| **Local Currency** | Support for local currency | **Required** |
| **Gateway Support** | Supported by payment gateways | **Required** |
| **Compliance** | Local regulatory compliance | **Required** |

---

## Chapter 8 – Payment Method Management

### PAY-038 Customer Payment Method Management

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Add Payment Method** | Add new payment method | **Required** |
| **View Payment Methods** | List saved payment methods | **Required** |
| **Set Default** | Set default payment method | **Required** |
| **Remove Payment Method** | Delete saved payment method | **Required** |
| **Update Payment Method** | Update expiry date, billing address | **Required** |
| **Payment Method Validation** | Real-time validation | **Required** |

### PAY-039 Payment Method Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payment_method_id` | UUID | PRIMARY KEY | Unique identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `method_type` | VARCHAR(30) | NOT NULL | CARD/WALLET/MOBILE_WALLET/COD/BNPL/LOCAL |
| `provider` | VARCHAR(50) | | stripe/paymob/adyen/apple_pay/google_pay |
| `provider_token` | VARCHAR(255) | | Token from payment provider |
| `last_four` | VARCHAR(4) | | Last 4 digits (for cards) |
| `card_brand` | VARCHAR(20) | | visa/mastercard/amex/mada |
| `expiry_month` | INTEGER | | Expiry month (MM) |
| `expiry_year` | INTEGER | | Expiry year (YYYY) |
| `cardholder_name` | VARCHAR(100) | | Name on card |
| `billing_address` | JSONB | | Billing address |
| `is_default` | BOOLEAN | DEFAULT FALSE | Default payment method |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 9 – Database Tables

### payment_methods

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payment_method_id` | UUID | PRIMARY KEY | Unique identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `method_type` | VARCHAR(30) | NOT NULL | CARD/WALLET/MOBILE_WALLET/COD/BNPL/LOCAL |
| `provider` | VARCHAR(50) | | stripe/paymob/adyen/apple_pay/google_pay/tabby/tamara |
| `provider_token` | VARCHAR(255) | | Token from payment provider |
| `last_four` | VARCHAR(4) | | Last 4 digits (for cards) |
| `card_brand` | VARCHAR(20) | | visa/mastercard/amex/mada |
| `expiry_month` | INTEGER | | Expiry month (MM) |
| `expiry_year` | INTEGER | | Expiry year (YYYY) |
| `cardholder_name` | VARCHAR(100) | | Name on card |
| `billing_address` | JSONB | | Billing address |
| `is_default` | BOOLEAN | DEFAULT FALSE | Default payment method |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `last_used_at` | TIMESTAMP | | Last use timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### payment_method_logs

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `log_id` | UUID | PRIMARY KEY | Unique identifier |
| `payment_method_id` | UUID | FOREIGN KEY (payment_methods.payment_method_id) | Associated payment method |
| `action` | VARCHAR(30) | NOT NULL | ADD/UPDATE/DELETE/SET_DEFAULT/USE/FAILED |
| `ip_address` | VARCHAR(45) | | IP address of action |
| `user_agent` | TEXT | | Browser/device user agent |
| `metadata` | JSONB | | Additional context |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Action timestamp |

### cod_settings

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `setting_id` | UUID | PRIMARY KEY | Unique identifier |
| `merchant_id` | UUID | FOREIGN KEY (merchant_accounts.merchant_id) | Associated merchant |
| `is_cod_enabled` | BOOLEAN | DEFAULT TRUE | COD enabled for merchant |
| `max_order_value` | DECIMAL(10, 2) | DEFAULT 50.00 | Maximum COD order value |
| `customer_eligibility_orders` | INTEGER | DEFAULT 1 | Minimum orders for COD eligibility |
| `new_customer_limit` | DECIMAL(10, 2) | DEFAULT 20.00 | New customer COD limit |
| `risk_threshold` | INTEGER | DEFAULT 70 | Risk score threshold |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### cod_risk_scores

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `risk_id` | UUID | PRIMARY KEY | Unique identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `order_id` | UUID | FOREIGN KEY (orders.order_id) | Associated order |
| `risk_score` | INTEGER | | Risk score (0-100) |
| `risk_factors` | JSONB | | Risk factors identified |
| `decision` | VARCHAR(20) | | APPROVE/REJECT/REVIEW |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |

### bnpl_transactions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `bnpl_id` | UUID | PRIMARY KEY | Unique identifier |
| `order_id` | UUID | FOREIGN KEY (orders.order_id) | Associated order |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `provider` | VARCHAR(30) | NOT NULL | tabby/tamara/klarna/afterpay/affirm |
| `provider_reference` | VARCHAR(255) | | Provider reference ID |
| `total_amount` | DECIMAL(12, 2) | NOT NULL | Total BNPL amount |
| `installment_count` | INTEGER | NOT NULL | Number of installments |
| `installment_amount` | DECIMAL(12, 2) | NOT NULL | Installment amount |
| `first_installment_date` | DATE | | First installment date |
| `status` | VARCHAR(20) | DEFAULT 'ACTIVE' | ACTIVE/PAID/DEFAULTED/CANCELLED |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 10 – REST APIs

### Payment Method APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/customers/me/payment-methods` | List payment methods |
| `POST` | `/api/v1/customers/me/payment-methods` | Add payment method |
| `GET` | `/api/v1/customers/me/payment-methods/{id}` | Get payment method details |
| `PUT` | `/api/v1/customers/me/payment-methods/{id}` | Update payment method |
| `DELETE` | `/api/v1/customers/me/payment-methods/{id}` | Delete payment method |
| `PUT` | `/api/v1/customers/me/payment-methods/{id}/default` | Set default payment method |
| `GET` | `/api/v1/customers/me/payment-methods/card-brands` | Get supported card brands |

### Card Validation APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/v1/payments/validate/card` | Validate card number |
| `POST` | `/api/v1/payments/validate/expiry` | Validate expiry date |
| `GET` | `/api/v1/payments/card-brands/{number}` | Detect card brand |

### COD APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/payments/cod/eligibility` | Check COD eligibility |
| `GET` | `/api/v1/merchant/cod/settings` | Get COD settings |
| `PUT` | `/api/v1/merchant/cod/settings` | Update COD settings |

### BNPL APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/payments/bnpl/eligibility` | Check BNPL eligibility |
| `POST` | `/api/v1/payments/bnpl` | Create BNPL payment |

---

## Chapter 11 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-PM-001** | Card numbers must pass Luhn check. | **High** |
| **BR-PM-002** | Expiry date must be in the future. | **High** |
| **BR-PM-003** | CVV must match card brand length. | **High** |
| **BR-PM-004** | Payment methods cannot be deleted if used in pending orders. | **High** |
| **BR-PM-005** | Customer can have up to 10 saved payment methods. | **High** |
| **BR-PM-006** | Only one default payment method per customer. | **High** |
| **BR-PM-007** | COD maximum order value: $50 (configurable). | **High** |
| **BR-PM-008** | COD requires customer to have at least one completed order. | **High** |
| **BR-PM-009** | BNPL eligibility requires credit check. | **High** |
| **BR-PM-010** | Payment method changes are logged for audit. | **High** |

---

## Chapter 12 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-PM-001** | Customer adds credit card payment method. | **High** |
| **TEST-PM-002** | Customer adds invalid card (validation error). | **High** |
| **TEST-PM-003** | Customer views saved payment methods. | **High** |
| **TEST-PM-004** | Customer sets default payment method. | **High** |
| **TEST-PM-005** | Customer removes payment method. | **High** |
| **TEST-PM-006** | Customer adds digital wallet (Apple Pay). | **High** |
| **TEST-PM-007** | Customer adds digital wallet (Google Pay). | **High** |
| **TEST-PM-008** | Customer pays with saved card. | **High** |
| **TEST-PM-009** | Customer pays with Apple Pay. | **High** |
| **TEST-PM-010** | Customer pays with Google Pay. | **High** |
| **TEST-PM-011** | Customer uses COD checkout. | **High** |
| **TEST-PM-012** | Customer eligibility for COD verified. | **High** |
| **TEST-PM-013** | COD order exceeds maximum value (blocked). | **High** |
| **TEST-PM-014** | New customer COD limit enforced. | **High** |
| **TEST-PM-015** | Customer uses BNPL (Tabby/Tamara). | **High** |
| **TEST-PM-016** | BNPL installment schedule created. | **High** |
| **TEST-PM-017** | Customer views wallet balance. | **High** |
| **TEST-PM-018** | Customer tops up wallet. | **High** |
| **TEST-PM-019** | Customer pays with wallet balance. | **High** |
| **TEST-PM-020** | Customer views wallet transaction history. | **High** |
| **TEST-PM-021** | Card BIN lookup returns correct card brand. | **High** |
| **TEST-PM-022** | Payment method logs capture all actions. | **High** |
| **TEST-PM-023** | Duplicate payment method detection works. | **High** |

---

## Chapter 13 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| PAY-038 | payment_methods | GET /api/v1/customers/me/payment-methods | TEST-PM-001, TEST-PM-002, TEST-PM-003 |
| PAY-038 | payment_methods | PUT /api/v1/customers/me/payment-methods/{id}/default | TEST-PM-004 |
| PAY-038 | payment_methods | DELETE /api/v1/customers/me/payment-methods/{id} | TEST-PM-005 |
| PAY-030 | payment_methods | POST /api/v1/customers/me/payment-methods | TEST-PM-006, TEST-PM-007 |
| PAY-026 | payment_methods | POST /api/v1/payments/authorize | TEST-PM-008, TEST-PM-009, TEST-PM-010 |
| PAY-032 | cod_settings | POST /api/v1/payments/authorize | TEST-PM-011, TEST-PM-012, TEST-PM-013, TEST-PM-014 |
| PAY-034 | bnpl_transactions | POST /api/v1/payments/bnpl | TEST-PM-015, TEST-PM-016 |
| PAY-029 | payment_methods | GET /api/v1/customers/me/wallet | TEST-PM-017, TEST-PM-018, TEST-PM-019, TEST-PM-020 |
| PAY-026 | payment_methods | POST /api/v1/payments/validate/card | TEST-PM-021 |
| PAY-038 | payment_method_logs | GET /api/v1/customers/me/payment-methods | TEST-PM-022 |

---

## Chapter 14 – Summary

This document establishes the complete payment methods capability for the **[Platform Name]** platform. Key takeaways:

- **Diverse Payment Methods:** Support for credit/debit cards, digital wallets, platform wallet, COD, BNPL, mobile wallets, and regional alternatives.
- **Card Payments:** Full card support with validation, tokenization, 3DS, BIN lookup, and brand detection.
- **Digital Wallets:** Platform wallet with top-up and payment, plus Apple Pay and Google Pay integration.
- **Cash on Delivery:** COD with eligibility checks, maximum limits, customer rules, and risk scoring.
- **Buy Now, Pay Later:** Integration with Tabby, Tamara, Klarna, Afterpay, and Affirm with installment plans.
- **Regional Methods:** Support for STC Pay, Mada, Fawry, iDEAL, and other region-specific payment methods.
- **Payment Method Management:** Customers can add, view, update, delete, and set default payment methods.
- **Security:** Tokenization, PCI DSS compliance, validation, and audit logging.

The payment methods module ensures customers can pay using their preferred method, reducing friction at checkout and increasing conversion rates.

---

**Next Document:**

`Part_07C_Refund_Processing.md`

*(This builds on payment methods to define the refund processing workflow for customer payments.)*