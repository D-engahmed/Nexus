# Software Requirements Specification (SRS)

## Part 15D: Multi-Country Expansion

**Module:** Future Roadmap & Platform Evolution (Part 15)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Multi-Country Expansion module defines the comprehensive capabilities for expanding the **[Platform Name]** platform across multiple countries and regions. This encompasses country configuration, localization, regulatory compliance, payment localization, operational readiness, and phased expansion strategy.

Multi-country expansion is the primary growth driver for the platform. By entering new markets, the platform increases its total addressable market, diversifies revenue streams, and builds a global brand. This module ensures that the platform can be rapidly configured, deployed, and operated in new countries with minimal engineering effort.

### Objectives

- Enable rapid country configuration and deployment
- Support localization (language, currency, time zones)
- Ensure regulatory compliance in each country
- Support local payment methods
- Enable operational readiness and partner onboarding
- Provide a phased expansion strategy
- Maintain platform consistency across countries
- Drive global growth and market leadership

---

## Chapter 2 – Expansion Strategy

### MC-001 Expansion Phases

| Phase | Description | Regions | Priority |
| :--- | :--- | :--- | :--- |
| **Phase 1: MENA** | Middle East & North Africa | UAE, KSA, Egypt | **Required** |
| **Phase 2: Europe** | Western Europe | UK, Germany, France | **Required** |
| **Phase 3: Southeast Asia** | ASEAN region | Singapore, Malaysia, Indonesia | **Required** |
| **Phase 4: Americas** | North & South America | Canada, USA, Brazil | **Required** |
| **Phase 5: Asia Pacific** | East Asia & Pacific | Australia, Japan, South Korea | **Required** |
| **Phase 6: Expansion** | Additional markets | India, Mexico, Turkey | **Required** |

### MC-002 Expansion Criteria

| Criteria | Description | Priority |
| :--- | :--- | :--- |
| **Market Size** | Total addressable market size | **Required** |
| **Growth Potential** | Market growth rate | **Required** |
| **Regulatory Environment** | Ease of doing business | **Required** |
| **Digital Adoption** | Smartphone and internet penetration | **Required** |
| **Logistics Infrastructure** | Delivery infrastructure quality | **Required** |
| **Competitive Landscape** | Competition intensity | **Required** |
| **Local Partnerships** | Availability of local partners | **Required** |

### MC-003 Country Readiness Checklist

| Item | Description | Priority |
| :--- | :--- | :--- |
| **Legal Entity** | Establish local legal entity | **Required** |
| **Regulatory Approval** | Obtain necessary licenses | **Required** |
| **Payment Integration** | Integrate local payment methods | **Required** |
| **Banking Setup** | Local bank accounts | **Required** |
| **Tax Registration** | Register for local taxes | **Required** |
| **Local Team** | Hire local operations team | **Required** |
| **Merchant Outreach** | Onboard local merchants | **Required** |
| **Driver Recruitment** | Recruit local drivers | **Required** |
| **Marketing** | Launch local marketing campaign | **Required** |
| **Support** | Local customer support | **Required** |

---

## Chapter 3 – Country Configuration

### MC-004 Configurable Parameters

| Parameter | Description | Priority |
| :--- | :--- | :--- |
| **Currency** | ISO 4217 currency code | **Required** |
| **Language** | Default language (ISO 639-1) | **Required** |
| **Time Zone** | IANA time zone | **Required** |
| **Tax Rate** | Default VAT/GST rate | **Required** |
| **Tax Rules** | Tax calculation rules | **Required** |
| **Payment Methods** | Supported payment methods | **Required** |
| **Delivery Zones** | Geographic delivery zones | **Required** |
| **Business Hours** | Local business hours | **Required** |
| **Holidays** | National holidays | **Required** |
| **Regulatory Policies** | Local regulations | **Required** |

### MC-005 Country Configuration Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `country_config_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | UNIQUE | ISO country code |
| `country_name` | VARCHAR(100) | NOT NULL | Country name |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `currency_symbol` | VARCHAR(5) | | Currency symbol |
| `default_language` | VARCHAR(5) | | ISO 639-1 language |
| `timezone` | VARCHAR(50) | | IANA timezone |
| `default_tax_rate` | DECIMAL(5, 2) | | Default tax rate |
| `tax_inclusive` | BOOLEAN | DEFAULT FALSE | Prices include tax |
| `status` | VARCHAR(20) | DEFAULT 'PLANNED' | PLANNED/READY/ACTIVE/SUSPENDED |
| `launch_date` | DATE | | Launch date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### MC-006 Regional Settings Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `region_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `region_name` | VARCHAR(100) | NOT NULL | Region name |
| `region_type` | VARCHAR(20) | NOT NULL | CITY/STATE/PROVINCE/EMIRATE |
| `delivery_zone` | JSONB` | | Geospatial delivery zone |
| `delivery_fee` | DECIMAL(10, 2) | | Default delivery fee |
| `min_order_value` | DECIMAL(10, 2) | | Minimum order value |
| `max_delivery_distance` | INTEGER | | Max delivery distance (km) |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 4 – Localization

### MC-007 Language Support

| Language | Regions | Priority |
| :--- | :--- | :--- |
| **English** | Global | **Required** |
| **Arabic** | MENA | **Required** |
| **French** | Europe, Africa | **Required** |
| **German** | Europe | **Required** |
| **Spanish** | Americas | **Required** |
| **Portuguese** | Brazil | **Required** |
| **Bahasa Indonesia** | Indonesia | **Required** |
| **Malay** | Malaysia, Singapore | **Required** |
| **Mandarin** | Global, APAC | **Required** |
| **Japanese** | Japan | **Required** |
| **Korean** | South Korea | **Required** |
| **Hindi** | India | **Required** |
| **Turkish** | Turkey | **Required** |

### MC-008 Localization Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **UI Translation** | Translate all user interfaces | **Required** |
| **Content Translation** | Translate all content | **Required** |
| **Notification Translation** | Translate all notifications | **Required** |
| **Email Translation** | Translate all emails | **Required** |
| **SMS Translation** | Translate all SMS | **Required** |
| **RTL Support** | Right-to-left text support (Arabic, Hebrew) | **Required** |
| **Date/Time Formatting** | Local date/time formats | **Required** |
| **Number Formatting** | Local number formatting | **Required** |
| **Currency Formatting** | Local currency formatting | **Required** |

### MC-009 Translation Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `translation_id` | UUID | PRIMARY KEY | Unique identifier |
| `translation_key` | VARCHAR(255) | NOT NULL | Translation key |
| `language` | VARCHAR(5) | NOT NULL | ISO 639-1 language |
| `translation_value` | TEXT | NOT NULL | Translated value |
| `context` | VARCHAR(100) | | Translation context |
| `version` | VARCHAR(20) | DEFAULT '1.0' | Version number |
| `status` | VARCHAR(20) | DEFAULT 'APPROVED' | DRAFT/APPROVED/DEPRECATED |
| `reviewed_by` | UUID | | Reviewer identifier |
| `reviewed_at` | TIMESTAMP` | | Review timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 5 – Local Payment Methods

### MC-010 Regional Payment Methods

| Region | Payment Methods | Priority |
| :--- | :--- | :--- |
| **MENA** | STC Pay, Mada, Fawry, Benefit, KNET | **Required** |
| **Europe** | iDEAL, Sofort, Giropay, Bancontact, Klarna | **Required** |
| **SE Asia** | GrabPay, OVO, DANA, GCash, PayMaya | **Required** |
| **Americas** | Pix, Mercado Pago, Interac, Venmo | **Required** |
| **APAC** | PayPay, Alipay, WeChat Pay, LINE Pay | **Required** |
| **India** | UPI, Paytm, PhonePe, Google Pay (India) | **Required** |

### MC-011 Local Payment Method Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payment_method_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `method_name` | VARCHAR(100) | NOT NULL | Payment method name |
| `method_type` | VARCHAR(30) | NOT NULL | WALLET/CARD/BANK_TRANSFER/COD/BNPL |
| `provider` | VARCHAR(50) | | Payment provider |
| `provider_config` | JSONB` | | Provider-specific configuration |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 6 – Legal & Regulatory Compliance

### MC-012 Regulatory Areas

| Area | Description | Priority |
| :--- | :--- | :--- |
| **Data Privacy** | GDPR, CCPA, PDPA, LGPD compliance | **Required** |
| **Tax Compliance** | VAT, GST, sales tax compliance | **Required** |
| **Labor Laws** | Driver classification, working hours | **Required** |
| **Consumer Protection** | Consumer rights and protections | **Required** |
| **Food Safety** | Food handling and safety regulations | **Required** |
| **Transportation** | Delivery vehicle regulations | **Required** |
| **Insurance** | Liability and worker insurance | **Required** |

### MC-013 Regulatory Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `regulation_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `regulation_type` | VARCHAR(30) | NOT NULL | DATA_PRIVACY/TAX/LABOR/CONSUMER/FOOD_SAFETY/TRANSPORTATION/INSURANCE |
| `regulation_name` | VARCHAR(100) | NOT NULL | Regulation name |
| `regulation_description` | TEXT | | Regulation description |
| `compliance_status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/IN_PROGRESS/COMPLIANT/NON_COMPLIANT |
| `last_reviewed` | DATE | | Last review date |
| `next_review` | DATE | | Next review date |
| `responsible_party` | UUID | | Responsible party |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 7 – Operational Readiness

### MC-014 Operational Requirements

| Requirement | Description | Priority |
| :--- | :--- | :--- |
| **Local Team** | Hire country manager, operations team | **Required** |
| **Office Setup** | Establish local office | **Required** |
| **Customer Support** | Local language support team | **Required** |
| **Merchant Onboarding** | Local merchant sales team | **Required** |
| **Driver Recruitment** | Local driver recruitment team | **Required** |
| **Marketing** | Local marketing and advertising | **Required** |
| **Legal Support** | Local legal counsel | **Required** |
| **Finance** | Local finance and accounting | **Required** |
| **IT Support** | Local IT support | **Required** |

### MC-015 Operational Readiness Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `readiness_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `category` | VARCHAR(30) | NOT NULL | TEAM/OFFICE/SUPPORT/MERCHANT/DRIVER/MARKETING/LEGAL/FINANCE/IT |
| `item_name` | VARCHAR(100) | NOT NULL | Item name |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/IN_PROGRESS/COMPLETED/BLOCKED |
| `completion_date` | DATE` | | Completion date |
| `responsible_party` | UUID | | Responsible party |
| `notes` | TEXT` | | Additional notes |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 8 – Phased Expansion Plan

### MC-016 Phase 1: MENA (Year 1-2)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **UAE** | Month 1-6 | **Required** |
| **KSA** | Month 7-12 | **Required** |
| **Egypt** | Month 13-18 | **Required** |

**Key Requirements:**
- Arabic language support (RTL)
- VAT compliance (5% UAE, 15% KSA, 14% Egypt)
- Payment methods: STC Pay, Mada, Fawry
- Local partnerships for logistics

### MC-017 Phase 2: Europe (Year 2-3)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **UK** | Month 19-24 | **Required** |
| **Germany** | Month 25-30 | **Required** |
| **France** | Month 31-36 | **Required** |

**Key Requirements:**
- GDPR compliance
- Multi-language support (English, German, French)
- VAT compliance (20% UK, 19% DE, 20% FR)
- Payment methods: iDEAL, Sofort, Bancontact, Klarna
- Local delivery regulations

### MC-018 Phase 3: Southeast Asia (Year 3-4)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **Singapore** | Month 37-42 | **Required** |
| **Malaysia** | Month 43-48 | **Required** |
| **Indonesia** | Month 49-54 | **Required** |

**Key Requirements:**
- Multi-language support (English, Malay, Bahasa)
- GST compliance
- Payment methods: GrabPay, OVO, DANA
- Tropical weather logistics

### MC-019 Phase 4: Americas (Year 4-5)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **Canada** | Month 55-60 | **Required** |
| **USA** | Month 61-66 | **Required** |
| **Brazil** | Month 67-72 | **Required** |

**Key Requirements:**
- CCPA compliance (US)
- Multi-language support (English, Spanish, Portuguese)
- Sales tax compliance (US state-level)
- Payment methods: Interac, Pix, Mercado Pago

### MC-020 Phase 5: Asia Pacific (Year 5-6)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **Australia** | Month 73-78 | **Required** |
| **Japan** | Month 79-84 | **Required** |
| **South Korea** | Month 85-90 | **Required** |

**Key Requirements:**
- Privacy Act compliance (Australia)
- Multi-language support (English, Japanese, Korean)
- GST compliance (Australia)
- Payment methods: PayPay, LINE Pay

### MC-021 Phase 6: Additional Markets (Year 6-7)

| Country | Timeline | Priority |
| :--- | :--- | :--- |
| **India** | Month 91-96 | **Required** |
| **Mexico** | Month 97-102 | **Required** |
| **Turkey** | Month 103-108 | **Required** |

**Key Requirements:**
- PDPA compliance (India)
- Multi-language support (Hindi, Spanish, Turkish)
- GST compliance (India)
- Payment methods: UPI, Paytm

---

## Chapter 9 – Database Tables

### country_configs

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `country_config_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | UNIQUE | ISO country code |
| `country_name` | VARCHAR(100) | NOT NULL | Country name |
| `currency` | VARCHAR(3) | NOT NULL | ISO 4217 currency |
| `currency_symbol` | VARCHAR(5) | | Currency symbol |
| `default_language` | VARCHAR(5) | | ISO 639-1 language |
| `timezone` | VARCHAR(50) | | IANA timezone |
| `default_tax_rate` | DECIMAL(5, 2) | | Default tax rate |
| `tax_inclusive` | BOOLEAN | DEFAULT FALSE | Prices include tax |
| `status` | VARCHAR(20) | DEFAULT 'PLANNED' | PLANNED/READY/ACTIVE/SUSPENDED |
| `launch_date` | DATE | | Launch date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### translations

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `translation_id` | UUID | PRIMARY KEY | Unique identifier |
| `translation_key` | VARCHAR(255) | NOT NULL | Translation key |
| `language` | VARCHAR(5) | NOT NULL | ISO 639-1 language |
| `translation_value` | TEXT | NOT NULL | Translated value |
| `context` | VARCHAR(100) | | Translation context |
| `version` | VARCHAR(20) | DEFAULT '1.0' | Version number |
| `status` | VARCHAR(20) | DEFAULT 'APPROVED' | DRAFT/APPROVED/DEPRECATED |
| `reviewed_by` | UUID | | Reviewer identifier |
| `reviewed_at` | TIMESTAMP | | Review timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### local_payment_methods

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `payment_method_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `method_name` | VARCHAR(100) | NOT NULL | Payment method name |
| `method_type` | VARCHAR(30) | NOT NULL | WALLET/CARD/BANK_TRANSFER/COD/BNPL |
| `provider` | VARCHAR(50) | | Payment provider |
| `provider_config` | JSONB | | Provider-specific configuration |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### regulations

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `regulation_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `regulation_type` | VARCHAR(30) | NOT NULL | DATA_PRIVACY/TAX/LABOR/CONSUMER/FOOD_SAFETY/TRANSPORTATION/INSURANCE |
| `regulation_name` | VARCHAR(100) | NOT NULL | Regulation name |
| `regulation_description` | TEXT | | Regulation description |
| `compliance_status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/IN_PROGRESS/COMPLIANT/NON_COMPLIANT |
| `last_reviewed` | DATE | | Last review date |
| `next_review` | DATE | | Next review date |
| `responsible_party` | UUID | | Responsible party |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### operational_readiness

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `readiness_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `category` | VARCHAR(30) | NOT NULL | TEAM/OFFICE/SUPPORT/MERCHANT/DRIVER/MARKETING/LEGAL/FINANCE/IT |
| `item_name` | VARCHAR(100) | NOT NULL | Item name |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/IN_PROGRESS/COMPLETED/BLOCKED |
| `completion_date` | DATE | | Completion date |
| `responsible_party` | UUID | | Responsible party |
| `notes` | TEXT | | Additional notes |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### regional_settings

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `region_id` | UUID | PRIMARY KEY | Unique identifier |
| `country_code` | VARCHAR(5) | FOREIGN KEY (country_configs.country_code) | Associated country |
| `region_name` | VARCHAR(100) | NOT NULL | Region name |
| `region_type` | VARCHAR(20) | NOT NULL | CITY/STATE/PROVINCE/EMIRATE |
| `delivery_zone` | JSONB | | Geospatial delivery zone |
| `delivery_fee` | DECIMAL(10, 2) | | Default delivery fee |
| `min_order_value` | DECIMAL(10, 2) | | Minimum order value |
| `max_delivery_distance` | INTEGER | | Max delivery distance (km) |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 10 – REST APIs

### Country APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/countries` | List countries |
| `GET` | `/api/v1/countries/{id}` | Get country details |
| `POST` | `/api/v1/countries` | Create country |
| `PUT` | `/api/v1/countries/{id}` | Update country |
| `DELETE` | `/api/v1/countries/{id}` | Delete country |
| `GET` | `/api/v1/countries/{id}/status` | Get country status |
| `POST` | `/api/v1/countries/{id}/activate` | Activate country |
| `POST` | `/api/v1/countries/{id}/suspend` | Suspend country |

### Translation APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/translations` | List translations |
| `GET` | `/api/v1/translations/{id}` | Get translation details |
| `POST` | `/api/v1/translations` | Create translation |
| `PUT` | `/api/v1/translations/{id}` | Update translation |
| `DELETE` | `/api/v1/translations/{id}` | Delete translation |
| `GET` | `/api/v1/translations/language/{lang}` | Get translations by language |
| `POST` | `/api/v1/translations/import` | Import translations |

### Payment Method APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/payment-methods` | List payment methods |
| `GET` | `/api/v1/payment-methods/{id}` | Get payment method details |
| `POST` | `/api/v1/payment-methods` | Create payment method |
| `PUT` | `/api/v1/payment-methods/{id}` | Update payment method |
| `DELETE` | `/api/v1/payment-methods/{id}` | Delete payment method |
| `GET` | `/api/v1/payment-methods/country/{code}` | Get payment methods by country |

### Regulation APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/regulations` | List regulations |
| `GET` | `/api/v1/regulations/{id}` | Get regulation details |
| `POST` | `/api/v1/regulations` | Create regulation |
| `PUT` | `/api/v1/regulations/{id}` | Update regulation |
| `DELETE` | `/api/v1/regulations/{id}` | Delete regulation |
| `GET` | `/api/v1/regulations/country/{code}` | Get regulations by country |

### Operational Readiness APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/readiness` | List readiness items |
| `GET` | `/api/v1/readiness/{id}` | Get readiness item details |
| `POST` | `/api/v1/readiness` | Create readiness item |
| `PUT` | `/api/v1/readiness/{id}` | Update readiness item |
| `DELETE` | `/api/v1/readiness/{id}` | Delete readiness item |
| `GET` | `/api/v1/readiness/country/{code}` | Get readiness by country |
| `GET` | `/api/v1/readiness/summary` | Get readiness summary |

### Regional Settings APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/regions` | List regions |
| `GET` | `/api/v1/regions/{id}` | Get region details |
| `POST` | `/api/v1/regions` | Create region |
| `PUT` | `/api/v1/regions/{id}` | Update region |
| `DELETE` | `/api/v1/regions/{id}` | Delete region |

---

## Chapter 11 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-MC-001** | Countries must have valid legal entities before launch. | **High** |
| **BR-MC-002** | Countries must be configured before activation. | **High** |
| **BR-MC-003** | Local payment methods must be integrated before launch. | **High** |
| **BR-MC-004** | Tax compliance must be verified before launch. | **High** |
| **BR-MC-005** | Language translations must be approved before launch. | **High** |
| **BR-MC-006** | Operational readiness checklist must be complete. | **High** |
| **BR-MC-007** | Country-specific regulations must be compliant. | **High** |
| **BR-MC-008** | Launch requires local team in place. | **High** |
| **BR-MC-009** | Country expansion must follow phased approach. | **High** |
| **BR-MC-010** | Local partnerships must be established before launch. | **High** |

---

## Chapter 12 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-MC-001** | Country configuration created successfully. | **High** |
| **TEST-MC-002** | Country configuration updated successfully. | **High** |
| **TEST-MC-003** | Country activated successfully. | **High** |
| **TEST-MC-004** | Translation added successfully. | **High** |
| **TEST-MC-005** | Translation updated successfully. | **High** |
| **TEST-MC-006** | RTL layout works correctly. | **High** |
| **TEST-MC-007** | Local payment method added successfully. | **High** |
| **TEST-MC-008** | Local payment method works correctly. | **High** |
| **TEST-MC-009** | Regulation compliance tracked correctly. | **High** |
| **TEST-MC-010** | Operational readiness checklist works correctly. | **High** |
| **TEST-MC-011** | Regional settings configured correctly. | **High** |
| **TEST-MC-012** | Country launch completes successfully. | **High** |
| **TEST-MC-013** | Multi-language support works correctly. | **High** |
| **TEST-MC-014** | Currency formatting works correctly. | **High** |
| **TEST-MC-015** | Date/time formatting works correctly. | **High** |
| **TEST-MC-016** | Tax rates applied correctly per country. | **High** |
| **TEST-MC-017** | Local team setup completed. | **High** |
| **TEST-MC-018** | Local support works correctly. | **High** |
| **TEST-MC-019** | Country expansion status tracked correctly. | **High** |
| **TEST-MC-020** | Multi-country reporting works correctly. | **High** |

---

## Chapter 13 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| MC-004 | country_configs | POST /api/v1/countries | TEST-MC-001, TEST-MC-002, TEST-MC-003 |
| MC-007 | translations | POST /api/v1/translations | TEST-MC-004, TEST-MC-005, TEST-MC-006, TEST-MC-013 |
| MC-009 | translations | GET /api/v1/translations/language/{lang} | TEST-MC-014, TEST-MC-015 |
| MC-010 | local_payment_methods | POST /api/v1/payment-methods | TEST-MC-007, TEST-MC-008 |
| MC-012 | regulations | POST /api/v1/regulations | TEST-MC-009, TEST-MC-016 |
| MC-014 | operational_readiness | POST /api/v1/readiness | TEST-MC-010, TEST-MC-017, TEST-MC-018 |
| MC-006 | regional_settings | POST /api/v1/regions | TEST-MC-011 |
| MC-001 | country_configs | POST /api/v1/countries/{id}/activate | TEST-MC-012, TEST-MC-019 |
| MC-001 | country_configs | GET /api/v1/countries | TEST-MC-020 |

---

## Chapter 14 – Summary

This document establishes the complete multi-country expansion capability for the **[Platform Name]** platform. Key takeaways:

- **Expansion Phases:** Six phases spanning 7+ years—MENA (Year 1-2), Europe (Year 2-3), Southeast Asia (Year 3-4), Americas (Year 4-5), Asia Pacific (Year 5-6), and Additional Markets (Year 6-7).
- **Country Configuration:** Configurable parameters including currency, language, time zone, tax rate, payment methods, delivery zones, business hours, and holidays.
- **Localization:** Multi-language support (12+ languages), RTL support, and localized formatting (date/time, number, currency).
- **Local Payment Methods:** Regional payment methods including STC Pay, Mada, Fawry, iDEAL, Sofort, GrabPay, OVO, Pix, UPI, and more.
- **Regulatory Compliance:** Data privacy (GDPR, CCPA, PDPA, LGPD), tax compliance (VAT, GST), labor laws, consumer protection, food safety, transportation, and insurance.
- **Operational Readiness:** Local team, office, support, merchant onboarding, driver recruitment, marketing, legal, finance, and IT.
- **Phased Expansion:** Detailed country-by-country timeline with key requirements and milestones.

The multi-country expansion module enables rapid, compliant, and successful entry into new markets across the globe.

---

**Next Document:**

`Part_15E_Sustainability_ESG.md`

*(This completes the Future Roadmap module by defining sustainability and ESG capabilities.)*