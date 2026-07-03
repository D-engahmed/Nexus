# Software Requirements Specification (SRS)

## Part 01E: Customer Loyalty

**Module:** Customer Module (Part 02)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Customer Loyalty module governs the rewards, points, tiers, and gamification mechanics that incentivize repeat purchases and deepen customer engagement with the **[Platform Name]** platform. Loyalty programs are a critical driver of customer lifetime value (LTV), reducing churn and increasing average order frequency.

This module defines the rules for earning and redeeming points, tier-based benefits, referral programs, and personalized rewards that make customers feel valued and motivated to remain active on the platform.

### Objectives

- Increase customer retention and repeat purchase rate
- Drive higher average order value (AOV) through rewards incentives
- Create a sense of status and achievement through tiered memberships
- Encourage customer advocacy through referral programs
- Enable personalized, data-driven reward allocation
- Provide transparent visibility into loyalty status and benefits

---

## Chapter 2 – Loyalty Program Overview

### CUS-089 Loyalty Program Structure

| Component | Description |
| :--- | :--- |
| **Points** | Earned per order; redeemable for discounts, free items, or perks. |
| **Tiers** | Status levels with escalating benefits (Bronze → Silver → Gold → Platinum). |
| **Rewards Catalog** | Range of redeemable rewards (vouchers, free delivery, merchandise). |
| **Referrals** | Rewards for inviting friends to the platform. |
| **Challenges** | Time-bound earning opportunities (e.g., "Order 5 times this month"). |
| **Birthday Rewards** | Special rewards on customer's birthday. |
| **Anniversary Rewards** | Special rewards on account anniversary. |

### CUS-090 Loyalty Program Objectives

| Metric | Target | Description |
| :--- | :--- | :--- |
| **Repeat Purchase Rate** | > 60% | Customers who order more than once. |
| **Monthly Active Users (MAU)** | > 70% of registered | Active engagement metric. |
| **Average Order Frequency** | > 4 orders/month | Orders per active customer. |
| **Loyalty Program Adoption** | > 80% | Customers enrolled in loyalty. |
| **Points Redemption Rate** | > 60% | Points redeemed vs. issued. |
| **Referral Conversion Rate** | > 15% | Invited friends who become customers. |

---

## Chapter 3 – Points System

### CUS-091 Earning Points

Customers earn points for various actions on the platform.

| Action | Points Awarded | Priority |
| :--- | :--- | :--- |
| **Order Placement** | 10 points per $1 spent (base rate). | **Required** |
| **Order Completion** | Bonus points for timely delivery. | **Required** |
| **Review Submission** | 25 points per review. | **Required** |
| **Referral Invite** | 100 points per successful referral. | **Required** |
| **Birthday Bonus** | 500 points on birthday. | **Medium** |
| **Account Anniversary** | 200 points on account anniversary. | **Medium** |
| **Challenge Completion** | Variable (based on challenge). | **Medium** |
| **Social Share** | 10 points per share (daily limit). | **Low** |
| **App Download** | 50 points for installing the app. | **Low** |

### CUS-092 Points Earning Rules

| Rule | Description |
| :--- | :--- |
| **Base Rate** | 10 points per $1 spent (configurable). |
| **Tier Multiplier** | Silver: 1.2x, Gold: 1.5x, Platinum: 2x points per order. |
| **Capping** | Maximum points per order: 5,000 (configurable). |
| **Expiration** | Points expire 12 months after earning. |
| **Promotional Points** | Bonus points for specific campaigns (may have shorter expiry). |
| **Rounding** | Points rounded down to nearest whole number. |
| **Retroactive** | Points awarded only for completed orders (not cancelled/refunded). |

### CUS-093 Redeeming Points

Customers may redeem points for a variety of rewards.

| Redemption Option | Points Required | Description |
| :--- | :--- | :--- |
| **Discount Voucher** | 100 points = $1 discount | Redeemable on next order. |
| **Free Delivery** | 200 points | Waive delivery fee on next order. |
| **Free Item** | Variable | Redeem for specific menu item (merchant-specific). |
| **Platform Merchandise** | Variable | Branded merchandise (mugs, t-shirts, etc.). |
| **Charity Donation** | Variable | Donate points to partnered charities. |
| **Exclusive Experiences** | Variable | Cooking classes, VIP events, etc. |

### CUS-094 Points Redemption Rules

| Rule | Description |
| :--- | :--- |
| **Minimum Redemption** | Minimum 500 points per redemption. |
| **Maximum Redemption per Order** | Maximum $20 discount per order (configurable). |
| **Voucher Validity** | Discount vouchers expire 30 days after redemption. |
| **Non-Transferable** | Points cannot be transferred between accounts. |
| **No Cash Value** | Points have no cash value outside the platform. |
| **Partial Redemption** | Customers may redeem partial points for voucher. |
| **Refund Handling** | Refunded orders lose points earned; points used are restored (if applicable). |

### CUS-095 Points Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `points_id` | UUID | PRIMARY KEY | Unique points record identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Points owner |
| `order_id` | UUID | FOREIGN KEY (orders.order_id) | Associated order (if applicable) |
| `points_earned` | INTEGER | DEFAULT 0 | Points earned in this transaction |
| `points_redeemed` | INTEGER | DEFAULT 0 | Points redeemed in this transaction |
| `points_balance` | INTEGER | DEFAULT 0 | Running balance after transaction |
| `transaction_type` | VARCHAR(20) | NOT NULL | EARN/REDEEM/EXPIRE/ADJUST/REFUND |
| `description` | TEXT | | Description of transaction |
| `source` | VARCHAR(50) | | order/review/referral/birthday/challenge |
| `reference_id` | VARCHAR(100) | | External reference (order_id, review_id) |
| `expires_at` | TIMESTAMP | | Expiration timestamp for earned points |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Transaction timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 4 – Loyalty Tiers

### CUS-096 Tier Structure

| Tier | Requirements | Benefits | Icon |
| :--- | :--- | :--- | :--- |
| **Bronze** | 0-999 points (lifetime) | Base points rate, standard support. | 🥉 |
| **Silver** | 1,000-4,999 points | 1.2x points, priority support, free delivery on orders > $30. | 🥈 |
| **Gold** | 5,000-19,999 points | 1.5x points, priority support, free delivery on orders > $20, early access to promotions. | 🥇 |
| **Platinum** | 20,000+ points | 2x points, VIP support, free delivery on all orders, exclusive events, birthday gift. | 💎 |

### CUS-097 Tier Calculation

| Attribute | Description |
| :--- | :--- |
| **Tier Basis** | Lifetime points earned (not current balance). |
| **Evaluation Frequency** | Daily (recalculated at midnight). |
| **Tier Duration** | Tier valid for 12 months (re-evaluated annually). |
| **Tier Protection** | Once tier achieved, customers have 3 months grace before downgrade. |
| **Notification** | Customer notified on tier upgrade/downgrade. |
| **Progress Tracking** | Show progress to next tier in app/profile. |

### CUS-098 Tier Benefits Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `tier_id` | UUID | PRIMARY KEY | Unique tier identifier |
| `tier_name` | VARCHAR(20) | UNIQUE, NOT NULL | BRONZE/SILVER/GOLD/PLATINUM |
| `tier_level` | INTEGER | UNIQUE, NOT NULL | 1/2/3/4 |
| `minimum_points` | INTEGER | NOT NULL | Points required for tier |
| `points_multiplier` | DECIMAL(3, 2) | DEFAULT 1.0 | Points earning multiplier |
| `free_delivery_threshold` | DECIMAL(10, 2) | | Minimum order for free delivery |
| `priority_support` | BOOLEAN | DEFAULT FALSE | Priority support flag |
| `exclusive_access` | BOOLEAN | DEFAULT FALSE | Early access to promotions |
| `birthday_gift` | BOOLEAN | DEFAULT FALSE | Birthday reward flag |
| `free_delivery_all` | BOOLEAN | DEFAULT FALSE | Free delivery on all orders |
| `icon_url` | VARCHAR(255) | | URL for tier icon |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### customer_tiers

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_tier_id` | UUID | PRIMARY KEY | Unique record identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `tier_id` | UUID | FOREIGN KEY (tiers.tier_id) | Current tier |
| `tier_start_date` | TIMESTAMP | NOT NULL | When customer achieved tier |
| `tier_end_date` | TIMESTAMP | NOT NULL | When tier expires |
| `lifetime_points` | INTEGER | DEFAULT 0 | Total points earned (lifetime) |
| `points_to_next_tier` | INTEGER | | Points needed for next tier |
| `status` | VARCHAR(20) | DEFAULT 'ACTIVE' | ACTIVE/GRACE/EXPIRED |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 5 – Referral Program

### CUS-099 Referral Program Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Unique Referral Code** | Each customer gets a unique referral code/link. | **Required** |
| **Referral Sharing** | Share via SMS, email, social media, WhatsApp. | **Required** |
| **Referral Tracking** | Track referrals and conversion status. | **Required** |
| **Referral Rewards** | Rewards for referrer and referee. | **Required** |
| **Referral Dashboard** | View referral statistics and rewards earned. | **Required** |
| **Referral Limits** | Maximum rewards per customer (configurable). | **Medium** |

### CUS-100 Referral Rules

| Rule | Description |
| :--- | :--- |
| **Eligibility** | Both referrer and referee must be active customers. |
| **Reward Structure** | Referrer: $5 credit + 100 points. Referee: $5 discount on first order. |
| **Activation** | Reward triggered when referee completes their first order. |
| **Referral Limit** | Maximum 10 successful referrals per customer (configurable). |
| **Time Limit** | Referral link valid for 30 days. |
| **Fraud Prevention** | One referral per new customer; cannot self-refer. |
| **Credit Expiry** | Referral credits expire after 60 days. |

### CUS-101 Referral Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `referral_id` | UUID | PRIMARY KEY | Unique referral identifier |
| `referrer_customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Customer who referred |
| `referee_customer_id` | UUID | FOREIGN KEY (customers.customer_id) | New customer (referred) |
| `referral_code` | VARCHAR(20) | UNIQUE, NOT NULL | Unique referral code |
| `referral_link` | VARCHAR(255) | | Full referral URL |
| `referral_channel` | VARCHAR(20) | | sms/email/social/whatsapp |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/ACTIVATED/EXPIRED/REJECTED |
| `referrer_reward_credit` | DECIMAL(10, 2) | DEFAULT 0 | Credit awarded to referrer |
| `referrer_reward_points` | INTEGER | DEFAULT 0 | Points awarded to referrer |
| `referee_reward_credit` | DECIMAL(10, 2) | DEFAULT 0 | Credit awarded to referee |
| `referrer_rewarded_at` | TIMESTAMP | | When referrer got reward |
| `referee_rewarded_at` | TIMESTAMP | | When referee got reward |
| `activated_at` | TIMESTAMP | | When referee placed first order |
| `expires_at` | TIMESTAMP | | Referral link expiration |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 6 – Challenges & Gamification

### CUS-102 Challenge Types

| Challenge Type | Description | Example |
| :--- | :--- | :--- |
| **Spend Challenge** | Reach a spending target within a period. | "Spend $100 this month, get 500 bonus points." |
| **Frequency Challenge** | Place a certain number of orders. | "Order 5 times this week, get 200 bonus points." |
| **Merchant Challenge** | Order from specific merchants. | "Order from 3 new restaurants, get 100 points each." |
| **Category Challenge** | Order from specific categories. | "Order from a grocery merchant, get 50 bonus points." |
| **Streak Challenge** | Maintain a consistent ordering streak. | "Order every day for 7 days, get 300 bonus points." |
| **Social Challenge** | Share or invite friends. | "Share your order on social media, get 20 points." |

### CUS-103 Gamification Mechanics

| Mechanic | Description |
| :--- | :--- |
| **Progress Bars** | Visual progress toward challenge completion. |
| **Badges** | Digital badges for achievements (e.g., "100th Order"). |
| **Leaderboards** | Top customers by points or orders (optional). |
| **Milestone Celebrations** | Celebratory animations/notifications for milestones. |
| **Streak Tracking** | Daily/weekly streaks with bonus rewards. |
| **Surprise Rewards** | Random rewards for active engagement. |

### CUS-104 Challenge Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `challenge_id` | UUID | PRIMARY KEY | Unique challenge identifier |
| `challenge_name` | VARCHAR(100) | NOT NULL | Name of the challenge |
| `challenge_type` | VARCHAR(20) | NOT NULL | SPEND/FREQUENCY/MERCHANT/CATEGORY/STREAK/SOCIAL |
| `description` | TEXT | | Challenge description |
| `requirements` | JSONB | NOT NULL | Challenge requirements (e.g., {"min_spend": 100, "period": "monthly"}) |
| `reward_points` | INTEGER | NOT NULL | Points awarded on completion |
| `reward_credit` | DECIMAL(10, 2) | DEFAULT 0 | Credit awarded on completion |
| `reward_voucher` | VARCHAR(50) | | Voucher type (if applicable) |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `start_date` | TIMESTAMP | | Challenge start date |
| `end_date` | TIMESTAMP | | Challenge end date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### customer_challenge_progress

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `progress_id` | UUID | PRIMARY KEY | Unique progress identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `challenge_id` | UUID | FOREIGN KEY (challenges.challenge_id) | Associated challenge |
| `progress_value` | DECIMAL(10, 2) | NOT NULL | Current progress (e.g., amount spent) |
| `target_value` | DECIMAL(10, 2) | NOT NULL | Target for completion |
| `progress_percentage` | DECIMAL(5, 2) | | Completion percentage |
| `status` | VARCHAR(20) | DEFAULT 'IN_PROGRESS' | IN_PROGRESS/COMPLETED/FAILED/CLAIMED |
| `completed_at` | TIMESTAMP | | When challenge was completed |
| `claimed_at` | TIMESTAMP | | When reward was claimed |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 7 – Loyalty Notifications

### CUS-105 Loyalty Notifications

| Event | Notification Type | Description |
| :--- | :--- | :--- |
| **Points Earned** | Push/Email | "You earned 150 points from your order!" |
| **Tier Upgrade** | Push/Email | "Congratulations! You're now a Gold member!" |
| **Tier Downgrade Warning** | Push/Email | "You're close to losing your Gold status. Order more to keep it!" |
| **Points Expiry Warning** | Push/Email | "You have 500 points expiring in 7 days." |
| **Challenge Completed** | Push/Email | "You completed the 'Order 5 times' challenge! Claim your 200 points." |
| **Reward Redeemed** | Push/Email | "Your 1,000 points have been redeemed for a $10 voucher." |
| **Referral Success** | Push/Email | "Your friend Sarah just placed their first order! You earned $5 credit." |
| **Referral Reminder** | Push/Email | "Share your referral code and earn rewards!" |
| **Birthday Reward** | Push/Email | "Happy Birthday! Enjoy 500 bonus points." |
| **Anniversary Reward** | Push/Email | "Happy 1 year with us! Enjoy 200 bonus points." |

---

## Chapter 8 – Loyalty Analytics

### CUS-106 Loyalty Metrics Dashboard

| Metric | Description | Use Case |
| :--- | :--- | :--- |
| **Total Points Issued** | Total points earned by all customers. | Program health. |
| **Points Redeemed** | Total points redeemed for rewards. | Redemption rate. |
| **Points Expired** | Total points expired unused. | Program optimization. |
| **Tier Distribution** | Customer count per tier. | Program penetration. |
| **Referral Conversion Rate** | % of referrals that convert. | Referral program effectiveness. |
| **Repeat Purchase Rate** | % of customers ordering again. | Loyalty impact. |
| **Average Order Frequency** | Orders per customer per month. | Customer engagement. |
| **LTV by Tier** | Average lifetime value by tier. | ROI per tier. |

### CUS-107 Loyalty Reports

| Report | Description | Schedule |
| :--- | :--- | :--- |
| **Loyalty Program Health** | Summary of all loyalty metrics. | Monthly |
| **Points Liability** | Outstanding points by expiry date. | Monthly |
| **Referral Performance** | Referral program metrics. | Weekly |
| **Tier Movement** | Customers moving between tiers. | Monthly |
| **Reward Redemption** | Most popular rewards. | Monthly |

---

## Chapter 9 – Database Tables

### loyalty_accounts

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `loyalty_account_id` | UUID | PRIMARY KEY | Unique account identifier |
| `customer_id` | UUID | UNIQUE, FOREIGN KEY (customers.customer_id) | Associated customer |
| `total_points_earned` | INTEGER | DEFAULT 0 | Lifetime points earned |
| `total_points_redeemed` | INTEGER | DEFAULT 0 | Lifetime points redeemed |
| `total_points_expired` | INTEGER | DEFAULT 0 | Points expired |
| `current_balance` | INTEGER | DEFAULT 0 | Current available points |
| `current_tier` | VARCHAR(20) | DEFAULT 'BRONZE' | BRONZE/SILVER/GOLD/PLATINUM |
| `tier_grace_period_end` | TIMESTAMP | | End of grace period for tier |
| `tier_progress_points` | INTEGER | DEFAULT 0 | Points toward next tier |
| `referral_code` | VARCHAR(20) | UNIQUE, NOT NULL | Unique referral code |
| `referral_count` | INTEGER | DEFAULT 0 | Successful referrals |
| `referral_credits_earned` | DECIMAL(10, 2) | DEFAULT 0 | Credit earned from referrals |
| `challenges_completed` | INTEGER | DEFAULT 0 | Number of challenges completed |
| `last_activity_at` | TIMESTAMP | | Last loyalty activity timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Account creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### reward_catalog

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `reward_id` | UUID | PRIMARY KEY | Unique reward identifier |
| `reward_name` | VARCHAR(100) | NOT NULL | Name of the reward |
| `reward_type` | VARCHAR(20) | NOT NULL | VOUCHER/FREE_DELIVERY/FREE_ITEM/MERCHANDISE/CHARITY/EXPERIENCE |
| `description` | TEXT | | Reward description |
| `points_required` | INTEGER | NOT NULL | Points needed to redeem |
| `value` | DECIMAL(10, 2) | | Monetary value (if applicable) |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `is_recurring` | BOOLEAN | DEFAULT FALSE | Available for repeated redemption |
| `limited_quantity` | INTEGER | | Maximum quantity available (if limited) |
| `remaining_quantity` | INTEGER | | Remaining quantity |
| `available_from` | TIMESTAMP | | Start availability date |
| `available_until` | TIMESTAMP | | End availability date |
| `terms_conditions` | TEXT | | Terms and conditions |
| `image_url` | VARCHAR(255) | | Reward image URL |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### rewards_redemption

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `redemption_id` | UUID | PRIMARY KEY | Unique redemption identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Redeeming customer |
| `reward_id` | UUID | FOREIGN KEY (reward_catalog.reward_id) | Reward being redeemed |
| `order_id` | UUID | FOREIGN KEY (orders.order_id) | Associated order (if applicable) |
| `points_spent` | INTEGER | NOT NULL | Points spent on redemption |
| `reward_code` | VARCHAR(50) | | Generated reward code/voucher code |
| `reward_value` | DECIMAL(10, 2) | | Value of the reward |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/ACTIVATED/USED/EXPIRED/CANCELLED |
| `activated_at` | TIMESTAMP | | When reward was activated |
| `used_at` | TIMESTAMP | | When reward was used |
| `expires_at` | TIMESTAMP | | Reward expiration date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Redemption timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 10 – REST APIs

### Points APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/customers/me/loyalty` | Get loyalty account summary |
| `GET` | `/api/v1/customers/me/loyalty/points` | Get points balance |
| `GET` | `/api/v1/customers/me/loyalty/transactions` | Get points transaction history |
| `GET` | `/api/v1/customers/me/loyalty/tier` | Get current tier and progress |

### Tier APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/loyalty/tiers` | List all tiers and benefits |
| `GET` | `/api/v1/customers/me/loyalty/tier/progress` | Get progress to next tier |

### Rewards APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/loyalty/rewards` | List available rewards |
| `GET` | `/api/v1/loyalty/rewards/{id}` | Get reward details |
| `POST` | `/api/v1/customers/me/loyalty/redeem` | Redeem points for reward |
| `GET` | `/api/v1/customers/me/loyalty/redemptions` | List redemption history |
| `GET` | `/api/v1/customers/me/loyalty/redemptions/{id}` | Get redemption details |

### Referral APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/customers/me/referral` | Get referral code and stats |
| `GET` | `/api/v1/customers/me/referral/link` | Generate referral link |
| `GET` | `/api/v1/customers/me/referral/history` | List referral history |
| `POST` | `/api/v1/customers/me/referral/share` | Share referral via channel |

### Challenge APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/loyalty/challenges` | List active challenges |
| `GET` | `/api/v1/customers/me/loyalty/challenges` | Get customer challenge progress |
| `POST` | `/api/v1/customers/me/loyalty/challenges/{id}/claim` | Claim challenge reward |

---

## Chapter 11 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-LOY-001** | Points expire 12 months after earning. | **High** |
| **BR-LOY-002** | Points are non-transferable between accounts. | **High** |
| **BR-LOY-003** | Points have no cash value outside the platform. | **High** |
| **BR-LOY-004** | Tier status is recalculated daily based on lifetime points. | **High** |
| **BR-LOY-005** | Tier downgrade includes a 3-month grace period. | **Medium** |
| **BR-LOY-006** | Minimum redemption: 500 points. | **Medium** |
| **BR-LOY-007** | Maximum discount per order from points: $20. | **Medium** |
| **BR-LOY-008** | Referral rewards require referee to complete their first order. | **High** |
| **BR-LOY-009** | Maximum successful referrals per customer: 10. | **Medium** |
| **BR-LOY-010** | Refunded orders result in points earned being deducted. | **High** |
| **BR-LOY-011** | Points used for redemption are not restored on order refund. | **Medium** |
| **BR-LOY-012** | Challenges must be claimed within 7 days of completion. | **Medium** |
| **BR-LOY-013** | Birthday rewards are credited automatically on customer's birthday. | **Medium** |
| **BR-LOY-014** | Referral links expire after 30 days. | **Medium** |

---

## Chapter 12 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-LOY-001** | Customer earns points after completing an order. | **High** |
| **TEST-LOY-002** | Customer receives tier multiplier points for order (Silver: 1.2x). | **High** |
| **TEST-LOY-003** | Customer views current points balance and tier. | **High** |
| **TEST-LOY-004** | Customer views points transaction history. | **High** |
| **TEST-LOY-005** | Customer views available rewards catalog. | **High** |
| **TEST-LOY-006** | Customer redeems points for discount voucher. | **High** |
| **TEST-LOY-007** | Customer uses discount voucher on next order. | **High** |
| **TEST-LOY-008** | Customer redeems points for free delivery. | **High** |
| **TEST-LOY-009** | Insufficient points for redemption (error message). | **High** |
| **TEST-LOY-010** | Customer upgrades to Silver tier after reaching threshold. | **High** |
| **TEST-LOY-011** | Customer upgrades to Gold tier after reaching threshold. | **High** |
| **TEST-LOY-012** | Customer tier downgrade after grace period expires. | **Medium** |
| **TEST-LOY-013** | Customer sees progress to next tier. | **Medium** |
| **TEST-LOY-014** | Customer generates referral link. | **High** |
| **TEST-LOY-015** | Referred friend places first order; referrer receives reward. | **High** |
| **TEST-LOY-016** | Referred friend places first order; referee receives reward. | **High** |
| **TEST-LOY-017** | Customer views referral history. | **Medium** |
| **TEST-LOY-018** | Customer views active challenges. | **High** |
| **TEST-LOY-019** | Customer completes challenge and claims reward. | **High** |
| **TEST-LOY-020** | Customer receives birthday reward notification. | **Medium** |
| **TEST-LOY-021** | Customer receives anniversary reward. | **Medium** |
| **TEST-LOY-022** | Points expiry warning notification is sent. | **Medium** |
| **TEST-LOY-023** | Points expire after 12 months (balance reduction). | **High** |
| **TEST-LOY-024** | Refunded order: points earned are deducted. | **High** |
| **TEST-LOY-025** | Customer uses points + cash for partial payment. | **High** |
| **TEST-LOY-026** | Challenge progress updates in real-time. | **High** |
| **TEST-LOY-027** | Reward redemption generates unique voucher code. | **High** |
| **TEST-LOY-028** | Expired voucher cannot be used. | **High** |
| **TEST-LOY-029** | Customer views loyalty program summary/dashboard. | **High** |
| **TEST-LOY-030** | Admin creates new challenge; customer sees it immediately. | **Medium** |

---

## Chapter 13 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| CUS-089 | loyalty_accounts | GET /api/v1/customers/me/loyalty | TEST-LOY-001, TEST-LOY-003 |
| CUS-091 | loyalty_transactions | GET /api/v1/customers/me/loyalty/transactions | TEST-LOY-002, TEST-LOY-004 |
| CUS-093 | reward_catalog | GET /api/v1/loyalty/rewards | TEST-LOY-005 |
| CUS-094 | rewards_redemption | POST /api/v1/customers/me/loyalty/redeem | TEST-LOY-006, TEST-LOY-007, TEST-LOY-008, TEST-LOY-009 |
| CUS-096 | tiers | GET /api/v1/loyalty/tiers | TEST-LOY-010, TEST-LOY-011, TEST-LOY-012 |
| CUS-097 | customer_tiers | GET /api/v1/customers/me/loyalty/tier/progress | TEST-LOY-013 |
| CUS-099 | referrals | GET /api/v1/customers/me/referral | TEST-LOY-014, TEST-LOY-017 |
| CUS-100 | referrals | POST /api/v1/customers/me/referral/share | TEST-LOY-015, TEST-LOY-016 |
| CUS-102 | challenges | GET /api/v1/loyalty/challenges | TEST-LOY-018 |
| CUS-103 | customer_challenge_progress | GET /api/v1/customers/me/loyalty/challenges | TEST-LOY-019, TEST-LOY-026 |
| CUS-105 | loyalty_accounts | (System Notification) | TEST-LOY-020, TEST-LOY-021, TEST-LOY-022 |

---

## Chapter 14 – Summary

This document establishes the complete customer loyalty capability for the **[Platform Name]** platform. Key takeaways:

- **Points System:** Earn points on orders, reviews, referrals, and challenges with configurable earning rates and tier multipliers.
- **Tiered Membership:** Four tiers (Bronze → Silver → Gold → Platinum) with escalating benefits that incentivize higher spending and loyalty.
- **Rewards Catalog:** Diverse redemption options including discount vouchers, free delivery, free items, merchandise, and charity donations.
- **Referral Program:** Encourage customer advocacy with rewards for both referrer and referee.
- **Challenges & Gamification:** Time-bound challenges, badges, streaks, and milestones keep customers engaged and active.
- **Analytics & Reporting:** Comprehensive metrics to track program performance, redemption rates, and customer engagement.

The loyalty module is a strategic investment in customer retention. By making customers feel valued and rewarding their engagement, the platform drives repeat business, increases lifetime value, and builds a community of brand advocates.

---

**Next Document:**

`03_Merchant_Module/Part_02A_Merchant_Registration.md`

*(This transitions from the customer experience to the merchant-facing side of the platform, starting with how merchants onboard and register for the platform.)*