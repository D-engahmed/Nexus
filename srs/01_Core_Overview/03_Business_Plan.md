# Software Requirements Specification (SRS)

## Part 03: Business Plan

**Module:** Core Overview
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## 1. Purpose of the Business Plan

This Business Plan defines the commercial engine that powers **[Platform Name]** . It outlines the revenue model, pricing strategy, unit economics, and go-to-market approach. Crucially, it translates business objectives into the functional and non-functional requirements detailed throughout this SRS, ensuring that every feature—from dynamic dispatch algorithms to multi-currency settlement—serves a distinct commercial purpose.

We treat the platform not just as a technology product, but as a **multi-sided marketplace**. The health of this marketplace depends on balancing the incentives of three core stakeholders: Consumers (Demand), Merchants (Supply of Goods), and Drivers (Supply of Logistics).

---

## 2. Business Model Overview

**[Platform Name]** operates a hybrid **Transaction + Subscription + Advertising** model. Our primary engine is a transaction fee collected on every completed order, supplemented by recurring membership fees and value-added services.

### 2.1 Multi-Sided Marketplace Dynamics

| Stakeholder | Value Received | Platform Value Extraction (Revenue) |
| :--- | :--- | :--- |
| **Consumers** | Convenience, choice, speed, and predictability. | Service fees, delivery charges, and subscription fees. |
| **Merchants** | Customer acquisition, logistics, and digital storefront. | Commission on order value, advertising fees, and SaaS fees. |
| **Drivers / Fleet** | Flexible earnings, predictable routing, and micro-bonuses. | Platform margin on delivery fees (difference between consumer-paid and driver-earned). |

---

## 3. Revenue Streams (The "How We Make Money")

Our revenue architecture is diversified to ensure resilience against market fluctuations. We project the following revenue mix by Year 3 of operation:

| Revenue Stream | Description | Projected Revenue Share (Year 3) |
| :--- | :--- | :--- |
| **1. Merchant Commission** | % of Gross Merchandise Value (GMV) per order. | **55%** |
| **2. Consumer Service/Delivery Fees** | Fixed or dynamic fees charged to the end-user. | **20%** |
| **3. Subscriptions (Memberships)** | Recurring monthly/yearly fees (e.g., free delivery, exclusive discounts). | **10%** |
| **4. Advertising & Promotions** | Sponsored listings, promoted restaurants, and targeted campaign management. | **10%** |
| **5. API & Enterprise Services** | White-labeling, bulk procurement APIs, and premium settlement services. | **5%** |

---

### 3.1 Merchant Commission (Core Revenue)

- **Tiered Commission Model:** We employ a dynamic commission structure based on service tiers, not a one-size-fits-all approach.
    - **Basic Tier (15%):** Listing only. Merchant handles own delivery/logistics.
    - **Standard Tier (20-25%):** Full platform delivery, basic analytics, and customer support.
    - **Premium Tier (30%):** Premium placement, dedicated account management, advanced analytics, and early settlement cycles (T+1).
- **Technical Implication:** This requires the SRS to support a **highly configurable fee engine** (refer to Part 06D – Commission & Fees Calculation), allowing operations teams to adjust rates on the fly without code deployments.

### 3.2 Consumer Service & Delivery Fees

- **Dynamic Pricing:** Fees vary based on real-time demand/supply (surge), distance, and estimated prep-time.
- **Zonal Pricing:** Different fees for different geographic areas (e.g., downtown vs. suburbs).
- **Technical Implication:** This drives the requirements for the **Geocoding & Mapping Services** (Part 04F) and the **Real-Time Dispatch Engine** (Part 04B) to calculate accurate distance-based fees.

### 3.3 Subscription/Membership (The "Sticky" Revenue)

- **Product:** A monthly/annual subscription (e.g., "Prime Delivery") offering $0 delivery fees on orders above a minimum cart value.
- **Benefit:** High retention (less churn), higher order frequency, and predictable recurring revenue.
- **Technical Implication:** Requires the **Subscription Services** module (Part 15A) and deep integration with the **Payment Module** for recurring billing (Part 07E). This is a top priority for Backend Development.

### 3.4 Advertising Platform (High-Margin Revenue)

- **Product:** Pay-per-click (PPC) for merchants to appear at the top of search results.
- **Benefit:** Allows smaller merchants to compete for visibility without being penalized by algorithms.
- **Technical Implication:** Drives the requirements for the **Advertising Platform** (Part 15A), requiring modifications to the Search API to inject sponsored results and track impressions/clicks.

### 3.5 API & Developer Marketplace (Strategic Revenue)

- **Product:** Charging enterprise partners and third-party developers for high-volume API access (Rate limits & Tiered Plans).
- **Benefit:** Turns our infrastructure into a white-label logistics backbone for other apps.
- **Technical Implication:** Directly mandates the **API Marketplace** (Part 13G), requiring usage quota tracking, billing for API keys, and robust rate limiting (GW-002).

---

## 4. Pricing Strategy

We follow a **Value-Based Pricing** strategy. Prices are set based on the perceived value delivered to each stakeholder, rather than purely on cost-plus margins.

| Stakeholder | Strategy | Implementation Detail |
| :--- | :--- | :--- |
| **Consumers** | **Penetration Pricing** (Initial Phase). Low delivery fees to encourage adoption. Gradually increases to market-competitive rates. | Supported by configurable **Promotions & Campaigns** engine (Part 08D). |
| **Merchants** | **Freemium SaaS.** First 30 days free (zero commission). Transitions to tiered commission. | Supported by **Merchant Registration & Onboarding** workflows (Part 02A). |
| **Drivers** | **Surge/Earn-out Pricing.** Bonuses during peak times or bad weather to ensure supply availability. | Supported by **Dispatch Logic** (Part 04B) and **Driver Earnings** (Part 03F). |

---

## 5. Unit Economics & Key Metrics

The SRS is engineered to optimize the following unit economics per single order.

### 5.1 Contribution Margin Analysis (Per Order)

| Component | Value (Average Estimate) | Notes |
| :--- | :--- | :--- |
| **Gross Merchandise Value (GMV)** | $25.00 | Average basket size (food/groceries). |
| **Take Rate (Platform Revenue)** | $6.25 (25% of GMV) | This is our gross revenue per order. |
| **Direct Operating Costs** | ($4.50) | Driver payout, payment gateway fees, cloud infrastructure, and support. |
| **Contribution Margin** | **$1.75 (7% of GMV)** | Profit before marketing and R&D spend. |
| **Customer Acquisition Cost (CAC)** | $15.00 | Marketing spend per new active customer. |
| **Customer Lifetime Value (LTV)** | $180.00 | Average order value * frequency * lifetime months. |
| **LTV/CAC Ratio** | 12:1 | *Highly favorable, indicating strong unit economics.* |

### 5.2 How Technology Drives Unit Economics
Every technical requirement in this SRS is tied to improving these numbers:
1.  **AI Dispatch (Part 04B):** Reduces delivery time, allowing drivers to do more orders/hour. Reduces driver payout per order (economies of scale).
2.  **Multi-Vendor Consolidation (Part 04D):** Allows bundling orders from multiple merchants to the same customer/driver, increasing GMV per trip without increasing driver costs.
3.  **Fraud Detection (Part 07D):** Reduces chargeback losses, directly protecting the contribution margin.
4.  **Self-Service Admin (Part 08A):** Reduces the need for expensive human support agents, lowering operating costs.

---

## 6. Go-to-Market Strategy (Phased Rollout)

The technical architecture (microservices, feature flags) is designed to support a staged rollout.

| Phase | Focus Area | Duration | Key SRS Module Dependencies |
| :--- | :--- | :--- | :--- |
| **Phase 0: MVP** | Single city, single vertical (Food). Limited merchant onboarding. | Months 1-6 | Customer (Part 02), Merchant (Part 03), Driver (Part 04), Basic Payment (Part 07). |
| **Phase 1: Regional Growth** | Expand to 5 major cities. Introduce Grocery vertical. | Months 7-12 | Multi-tenancy, Advanced Dispatch (Part 04B), Analytics (Part 11). |
| **Phase 2: National Expansion** | Full country coverage. Launch Subscription service. | Months 13-18 | ERP/POS Integrations (Part 16C), Subscription Engine (Part 15A). |
| **Phase 3: International Launch** | Adjacent country. Multi-currency and language support. | Months 19-24 | Multi-Currency (Part 15A), Localization (Part 15A), Tax Compliance (Part 06F). |
| **Phase 4: Ecosystem Maturity** | Launch API Marketplace, AI Agents, and Ad Platform. | Months 25-36 | Developer Portal (Part 13F), AI Agents (Part 15B), Ad Platform (Part 15A). |

---

## 7. Capital Allocation & Investment Justification

For investors and the Board, this section justifies the significant R&D investment in the platform.

| Investment Area | Allocation (%) | Rationale (Tied to SRS) |
| :--- | :--- | :--- |
| **R&D (Engineering)** | **45%** | Building the AI dispatch (Part 04), Microservices, and API Gateway (Part 13). *This is our core IP.* |
| **Sales & Marketing** | **30%** | Acquiring merchants and customers. *Heavily dependent on Admin Campaigns (Part 08D) to manage ROI.* |
| **General & Admin** | **15%** | Legal (compliance), HR, and finance. *Requires robust Financial Reconciliation (Part 06G).* |
| **Infrastructure & Ops** | **10%** | Cloud hosting (AWS/GCP), CDN, and Security. *Drives Kubernetes (Part 14D) and SRE (Part 14G) requirements.* |

> **Risk Mitigation:** The SRS defines extensive **Monitoring & Observability** (Part 14E) and **Disaster Recovery** (Part 14F) to protect this R&D investment from data loss or downtime.

---

## 8. Business Rules Enabling the Model

To automate the business plan, the SRS defines specific Business Rules (BR) in subsequent parts. These must be hard-coded or configurable:

| Business Rule | Description | SRS Reference |
| :--- | :--- | :--- |
| **BR-FIN-001** | Commission is calculated on **subtotal** (excluding taxes and tips). | Part 06D |
| **BR-FIN-002** | Drivers earn **80%** of the delivery fee, platform retains **20%**. | Part 06C |
| **BR-SUB-001** | Subscription users with > $20 cart value receive **Free Delivery** (Waived Service Fee). | Part 15A |
| **BR-AD-001** | Sponsored listings cost **$0.50/CPC** (Cost Per Click). | Part 15A |
| **BR-API-001** | Free tier API calls limited to **1,000/day**. Enterprise tier unlimited (metered). | Part 13G |

---

## 9. Business Risks & Mitigation

| Risk | Impact | Mitigation Strategy (via SRS) |
| :--- | :--- | :--- |
| **Merchant Churn** | High | *Mitigation:* Provide superior analytics (Part 02F) and faster settlements (Part 06B). |
| **Driver Shortage** | High Delivery Times | *Mitigation:* Implement surge pricing (Part 04B) and instant payout capabilities (Part 06C). |
| **Regulatory Fines** | Medium/High | *Mitigation:* Build country-specific tax configuration (Part 06F) and data localization (Part 09B). |
| **Payment Fraud** | High Chargebacks | *Mitigation:* Deploy ML-based fraud detection (Part 07D) and mandatory 3DS verification. |
| **Competition Price War** | Medium | *Mitigation:* Rely on **Subscription** (sticky revenue) and **API partnerships** (diversified revenue) as moats. |

---

## 10. Conclusion

This Business Plan makes it clear that **[Platform Name]** is not a cost-center technology project; it is a revenue-generating machine. The Software Requirements Specification that follows is the operational blueprint to implement this financial model.

Every microservice, API endpoint, and database schema defined in the subsequent pages is an investment in:
1.  **Reducing Variable Costs** (AI Dispatch).
2.  **Increasing Revenue Per User** (Ad Platform, Subscriptions).
3.  **Securing Market Share** (API Ecosystem, Enterprise Integration).

We proceed with the confidence that the technology architecture is fully aligned with the commercial objectives.

---

**Next Document:**

`04_Market_Analysis.md`