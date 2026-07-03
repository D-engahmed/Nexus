# Software Requirements Specification (SRS)

## Part 03E: Driver Performance

**Module:** Driver/Courier Module (Part 04)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Driver Performance module defines the comprehensive system for measuring, evaluating, and improving driver performance on the **[Platform Name]** platform. This encompasses performance metrics, rating systems, scorecards, incentives, performance tiers, coaching, and disciplinary actions.

Driver performance is the key determinant of platform quality. High-performing drivers deliver faster, provide better customer experiences, and drive platform loyalty. Conversely, poor-performing drivers damage the platform's reputation and customer retention. This module enables the platform to identify, reward, and develop top performers while addressing performance issues proactively.

### Objectives

- Provide transparent, objective performance measurement
- Enable fair and consistent driver evaluation
- Reward and incentivize high performance
- Identify performance improvement opportunities
- Support driver development and coaching
- Maintain quality standards across the driver fleet
- Enable performance-based order assignment
- Drive continuous performance improvement

---

## Chapter 2 – Performance Metrics

### DRV-112 Core Performance Metrics

| Metric | Description | Calculation | Priority |
| :--- | :--- | :--- | :--- |
| **Acceptance Rate** | % of orders accepted | Accepted Orders / Total Offered Orders | **Required** |
| **Completion Rate** | % of accepted orders completed | Completed Orders / Accepted Orders | **Required** |
| **On-Time Delivery Rate** | % of deliveries on time | On-Time Deliveries / Total Deliveries | **Required** |
| **Customer Rating** | Average customer rating | Average of all customer ratings | **Required** |
| **Average Delivery Time** | Average time from pickup to delivery | Sum of Delivery Times / Total Deliveries | **Required** |
| **Average Distance** | Average distance per delivery | Sum of Distances / Total Deliveries | **Required** |
| **Earnings Per Hour** | Average earnings per active hour | Total Earnings / Active Hours | **Required** |
| **Order Accuracy** | % of orders without issues | Accurate Orders / Total Deliveries | **Required** |
| **Customer Complaints** | Number of customer complaints | Count of complaints received | **Required** |
| **Safety Incidents** | Number of safety incidents | Count of safety incidents | **Required** |

### DRV-113 Secondary Performance Metrics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Response Time** | Time to accept orders | **Medium** |
| **Merchant Wait Time** | Time waiting at merchant | **Medium** |
| **Customer Wait Time** | Time waiting for customer | **Medium** |
| **Parking Compliance** | Compliance with parking rules | **Medium** |
| **Vehicle Condition** | Vehicle cleanliness and maintenance | **Medium** |
| **Professionalism** | Professional conduct rating | **Medium** |
| **Communication Quality** | Quality of customer communication | **Medium** |

### DRV-114 Performance Metric Targets

| Metric | Excellent | Good | Needs Improvement | Poor |
| :--- | :--- | :--- | :--- | :--- |
| **Acceptance Rate** | > 90% | 80-90% | 70-79% | < 70% |
| **Completion Rate** | > 98% | 95-98% | 90-94% | < 90% |
| **On-Time Rate** | > 95% | 90-95% | 85-89% | < 85% |
| **Customer Rating** | > 4.8 | 4.5-4.8 | 4.0-4.4 | < 4.0 |
| **Avg Delivery Time** | < 25 min | 25-30 min | 30-35 min | > 35 min |
| **Earnings Per Hour** | > $25 | $20-25 | $15-19 | < $15 |

---

## Chapter 3 – Rating System

### DRV-115 Driver Rating Calculation

| Component | Weight | Description |
| :--- | :--- | :--- |
| **Customer Rating** | 50% | Average of all customer ratings (1-5 stars). |
| **On-Time Performance** | 20% | Percentage of deliveries on time. |
| **Completion Rate** | 15% | Percentage of accepted orders completed. |
| **Acceptance Rate** | 10% | Percentage of orders accepted. |
| **Complaint History** | 5% | Deductions for valid complaints. |

**Formula:**
```
Driver Rating = (Customer_Rating × 0.5) + (On_Time_Rate × 0.2) + (Completion_Rate × 0.15) + (Acceptance_Rate × 0.1) - (Complaint_Deduction × 0.05)
```

### DRV-116 Rating Display

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Current Rating** | Display current overall rating. | **Required** |
| **Rating Breakdown** | Display component ratings. | **Required** |
| **Rating History** | Historical rating trend chart. | **Required** |
| **Customer Feedback** | Recent customer feedback/comments. | **Required** |
| **Rating Insights** | Insights on rating improvement. | **Required** |
| **Peer Comparison** | Compare to average driver rating. | **Medium** |

### DRV-117 Rating Tiers

| Tier | Rating Range | Description |
| :--- | :--- | :--- |
| **Platinum** | 4.8 - 5.0 | Top performers, priority assignment. |
| **Gold** | 4.5 - 4.79 | High performers, preferred assignment. |
| **Silver** | 4.0 - 4.49 | Average performers. |
| **Bronze** | 3.5 - 3.99 | Below average, improvement needed. |
| **Probation** | < 3.5 | Under review, risk of suspension. |

---

## Chapter 4 – Performance Scorecards

### DRV-118 Performance Scorecard

| Section | Content | Priority |
| :--- | :--- | :--- |
| **Header** | Driver name, ID, period, overall rating. | **Required** |
| **Metric Summary** | All core metrics with targets and status. | **Required** |
| **Trend Chart** | Rating trend over time. | **Required** |
| **Feedback** | Recent customer feedback and reviews. | **Required** |
| **Achievements** | Recent accomplishments and milestones. | **Required** |
| **Areas for Improvement** | Identified improvement areas. | **Required** |
| **Recommendations** | Recommended actions for improvement. | **Required** |

### DRV-119 Scorecard Frequency

| Frequency | Description | Priority |
| :--- | :--- | :--- |
| **Real-Time** | Live metrics updated continuously. | **Required** |
| **Daily** | Daily performance summary. | **Required** |
| **Weekly** | Weekly performance review. | **Required** |
| **Monthly** | Monthly performance summary. | **Required** |
| **Quarterly** | Quarterly performance review. | **Required** |

### DRV-120 Scorecard Data Model

| Attribute | Type | Description |
| :--- | :--- | :--- |
| `scorecard_id` | UUID | Unique identifier |
| `driver_id` | UUID | Associated driver |
| `period_start` | Date | Performance period start |
| `period_end` | Date | Performance period end |
| `overall_rating` | Decimal | Composite rating |
| `acceptance_rate` | Decimal | Acceptance rate |
| `completion_rate` | Decimal | Completion rate |
| `on_time_rate` | Decimal | On-time rate |
| `customer_rating` | Decimal | Average customer rating |
| `avg_delivery_time` | Integer | Average delivery time (minutes) |
| `earnings_per_hour` | Decimal | Earnings per active hour |
| `complaint_count` | Integer | Number of complaints |
| `status` | String | EXCELLENT/GOOD/NEEDS_IMPROVEMENT/POOR |
| `created_at` | Timestamp | Creation timestamp |
| `updated_at` | Timestamp | Last update timestamp |

---

## Chapter 5 – Incentives & Bonuses

### DRV-121 Incentive Types

| Incentive Type | Description | Priority |
| :--- | :--- | :--- |
| **Acceptance Bonus** | Bonus for maintaining high acceptance rate. | **Required** |
| **Completion Bonus** | Bonus for completing X orders in a period. | **Required** |
| **On-Time Bonus** | Bonus for maintaining on-time rate. | **Required** |
| **Rating Bonus** | Bonus for maintaining high rating. | **Required** |
| **Streak Bonus** | Bonus for consecutive completions. | **Required** |
| **Peak Bonus** | Bonus for working during peak hours. | **Required** |
| **Distance Bonus** | Bonus for long-distance deliveries. | **Required** |
| **Referral Bonus** | Bonus for referring new drivers. | **Medium** |
| **Safety Bonus** | Bonus for zero safety incidents. | **Medium** |
| **Anniversary Bonus** | Bonus for service milestones. | **Medium** |

### DRV-122 Incentive Calculation Examples

| Incentive | Criteria | Payout |
| :--- | :--- | :--- |
| **Acceptance Bonus** | > 90% acceptance rate in a week | $25 |
| **Completion Bonus** | Complete 100 orders in a week | $50 |
| **On-Time Bonus** | > 95% on-time rate in a week | $20 |
| **Rating Bonus** | > 4.8 rating in a week | $15 |
| **Streak Bonus** | 10 consecutive completions | $10 |
| **Peak Bonus** | 20 orders during peak hours | $30 |

### DRV-123 Driver Incentive Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `incentive_id` | UUID | Yes | Unique identifier |
| `driver_id` | UUID | Yes | Associated driver |
| `incentive_type` | String | Yes | ACCEPTANCE/COMPLETION/ON_TIME/RATING/STREAK/PEAK/DISTANCE |
| `description` | Text | | Incentive description |
| `target_metric` | String | Yes | Metric being targeted |
| `target_value` | Decimal | Yes | Target value to achieve |
| `achieved_value` | Decimal | Yes | Actual achieved value |
| `bonus_amount` | Decimal | Yes | Bonus amount |
| `period_start` | Date | Yes | Incentive period start |
| `period_end` | Date | Yes | Incentive period end |
| `status` | String | Yes | PENDING/ACHIEVED/PAID/EXPIRED |
| `completed_at` | Timestamp | | Completion timestamp |
| `paid_at` | Timestamp | | Payout timestamp |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 6 – Performance Tiers

### DRV-124 Driver Performance Tiers

| Tier | Criteria | Benefits | Priority |
| :--- | :--- | :--- | :--- |
| **Platinum** | Rating > 4.8, Acceptance > 90%, Completion > 98%, On-Time > 95% | Priority assignment, higher payout bonus, exclusive offers, dedicated support. | **Required** |
| **Gold** | Rating > 4.5, Acceptance > 85%, Completion > 95%, On-Time > 90% | Preferred assignment, moderate bonus, priority support. | **Required** |
| **Silver** | Rating > 4.0, Acceptance > 80%, Completion > 90%, On-Time > 85% | Standard assignment, standard pay. | **Required** |
| **Bronze** | Rating > 3.5, Acceptance > 75%, Completion > 85%, On-Time > 80% | Limited assignment, lower priority. | **Required** |
| **Probation** | Rating < 3.5 OR any metric below threshold | Limited orders, performance improvement plan, risk of suspension. | **Required** |

### DRV-125 Tier Benefits Details

| Benefit | Platinum | Gold | Silver | Bronze |
| :--- | :--- | :--- | :--- | :--- |
| **Order Priority** | Highest | High | Standard | Low |
| **Payout Bonus** | 10% | 5% | 0% | 0% |
| **Peak Bonus** | 2x | 1.5x | 1x | 0.5x |
| **Support Priority** | VIP | Priority | Standard | Standard |
| **Exclusive Offers** | ✅ | ✅ | ❌ | ❌ |
| **Free Insurance** | ✅ | ❌ | ❌ | ❌ |
| **Fuel Discount** | ✅ | ✅ | ❌ | ❌ |

### DRV-126 Tier Review Schedule

| Frequency | Description | Priority |
| :--- | :--- | :--- |
| **Real-Time** | Tier updates in real-time based on performance. | **Required** |
| **Weekly** | Weekly review of tier eligibility. | **Required** |
| **Monthly** | Monthly tier confirmation. | **Required** |

---

## Chapter 7 – Performance Improvement

### DRV-127 Performance Improvement Plan (PIP)

| Phase | Description | Duration |
| :--- | :--- | :--- |
| **1. Notification** | Driver notified of performance issues. | Day 1 |
| **2. Assessment** | Root cause analysis with driver. | Days 2-3 |
| **3. Action Plan** | Define improvement actions and targets. | Days 3-5 |
| **4. Implementation** | Driver implements improvement actions. | Days 5-30 |
| **5. Review** | Review progress against targets. | Day 30 |
| **6. Decision** | Continue, extend, or escalate. | Day 30+ |

### DRV-128 PIP Triggers

| Trigger | Description | Action |
| :--- | :--- | :--- |
| **Rating Below 3.5** | Customer rating falls below 3.5. | Initiate PIP immediately. |
| **Completion Rate Below 85%** | Driver failing to complete orders. | Initiate PIP immediately. |
| **On-Time Rate Below 80%** | Driver consistently late. | Initiate PIP immediately. |
| **Multiple Complaints** | 3+ complaints in 30 days. | Initiate PIP immediately. |
| **Safety Incident** | Safety incident reported. | Investigation and possible PIP. |

### DRV-129 PIP Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `pip_id` | UUID | Yes | Unique identifier |
| `driver_id` | UUID | Yes | Associated driver |
| `trigger_reason` | String | Yes | Reason for PIP |
| `description` | Text | Yes | Issue description |
| `action_plan` | Text | Yes | Improvement action plan |
| `target_metrics` | JSONB | Yes | Target metrics and values |
| `start_date` | Date | Yes | PIP start date |
| `review_date` | Date | Yes | First review date |
| `end_date` | Date | Yes | PIP end date |
| `status` | String | Yes | ACTIVE/COMPLETED/FAILED/EXTENDED |
| `outcome` | String | | SUCCESS/FAILURE/EXTENDED |
| `notes` | Text | | Review notes |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 8 – Coaching & Development

### DRV-130 Coaching Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Performance Review** | Regular one-on-one performance reviews. | **Required** |
| **Coaching Sessions** | Structured coaching sessions. | **Required** |
| **Training Recommendations** | Recommended training based on performance gaps. | **Required** |
| **Best Practices** | Sharing best practices and tips. | **Required** |
| **Peer Mentoring** | Pairing with high-performing drivers. | **Medium** |
| **Self-Assessment** | Driver self-assessment tools. | **Medium** |

### DRV-131 Coaching Topics

| Topic | Description |
| :--- | :--- |
| **Customer Service** | Improving customer interaction and satisfaction. |
| **Navigation Skills** | Improving route optimization and navigation. |
| **Time Management** | Better time management for faster deliveries. |
| **Communication** | Effective communication with customers and merchants. |
| **Safety** | Safe driving practices and personal safety. |
| **Earnings Optimization** | Maximizing earnings through smart order selection. |

---

## Chapter 9 – Performance Analytics

### DRV-132 Performance Analytics Dashboard

| Widget | Description | Priority |
| :--- | :--- | :--- |
| **Driver Rankings** | Rank drivers by performance metrics. | **Required** |
| **Performance Distribution** | Distribution of drivers by rating tier. | **Required** |
| **Metric Trends** | Trend analysis for key metrics. | **Required** |
| **Top Performers** | List of top performing drivers. | **Required** |
| **Needs Improvement** | List of drivers needing improvement. | **Required** |
| **Peer Comparison** | Driver vs. average comparison. | **Required** |
| **Performance Gaps** | Identify performance gaps by metric. | **Required** |

### DRV-133 Performance Reports

| Report | Description | Schedule | Priority |
| :--- | :--- | :--- | :--- |
| **Driver Performance Summary** | Overall performance summary. | Weekly | **Required** |
| **Top Drivers Report** | Top performing drivers. | Weekly | **Required** |
| **Improvement Report** | Drivers in PIP and improvement. | Weekly | **Required** |
| **Complaint Analysis** | Analysis of customer complaints. | Monthly | **Required** |
| **Rating Trends** | Rating trends by driver and overall. | Monthly | **Required** |

---

## Chapter 10 – Database Tables

### driver_performance_metrics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `metric_id` | UUID | PRIMARY KEY | Unique identifier |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Associated driver |
| `period_start` | DATE | NOT NULL | Period start |
| `period_end` | DATE | NOT NULL | Period end |
| `acceptance_rate` | DECIMAL(5, 2) | DEFAULT 0 | Acceptance rate (%) |
| `completion_rate` | DECIMAL(5, 2) | DEFAULT 0 | Completion rate (%) |
| `on_time_rate` | DECIMAL(5, 2) | DEFAULT 0 | On-time rate (%) |
| `customer_rating` | DECIMAL(3, 2) | DEFAULT 0 | Average customer rating |
| `avg_delivery_time` | INTEGER | DEFAULT 0 | Average delivery time (minutes) |
| `avg_distance` | DECIMAL(10, 2) | DEFAULT 0 | Average distance (km) |
| `earnings_per_hour` | DECIMAL(10, 2) | DEFAULT 0 | Earnings per active hour |
| `order_accuracy` | DECIMAL(5, 2) | DEFAULT 0 | Order accuracy (%) |
| `complaint_count` | INTEGER | DEFAULT 0 | Number of complaints |
| `safety_incidents` | INTEGER | DEFAULT 0 | Number of safety incidents |
| `overall_rating` | DECIMAL(3, 2) | DEFAULT 0 | Composite rating |
| `tier` | VARCHAR(20) | | PLATINUM/GOLD/SILVER/BRONZE/PROBATION |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### driver_ratings

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `rating_id` | UUID | PRIMARY KEY | Unique identifier |
| `delivery_id` | UUID | UNIQUE, FOREIGN KEY (driver_deliveries.delivery_id) | Associated delivery |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Rated driver |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Rating customer |
| `rating` | INTEGER | CHECK (1-5) | Star rating (1-5) |
| `categories` | JSONB | | Category ratings (timeliness, professionalism, communication, packaging) |
| `feedback` | TEXT | | Written feedback |
| `is_anonymous` | BOOLEAN | DEFAULT FALSE | Anonymous rating |
| `is_flagged` | BOOLEAN | DEFAULT FALSE | Flagged for moderation |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Rating creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### driver_incentives

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `incentive_id` | UUID | PRIMARY KEY | Unique identifier |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Associated driver |
| `incentive_type` | VARCHAR(30) | NOT NULL | ACCEPTANCE/COMPLETION/ON_TIME/RATING/STREAK/PEAK/DISTANCE |
| `description` | TEXT | | Incentive description |
| `target_metric` | VARCHAR(30) | NOT NULL | Metric being targeted |
| `target_value` | DECIMAL(10, 2) | NOT NULL | Target value |
| `achieved_value` | DECIMAL(10, 2) | | Achieved value |
| `bonus_amount` | DECIMAL(10, 2) | NOT NULL | Bonus amount |
| `period_start` | DATE | NOT NULL | Incentive period start |
| `period_end` | DATE | NOT NULL | Incentive period end |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/ACHIEVED/PAID/EXPIRED |
| `completed_at` | TIMESTAMP | | Completion timestamp |
| `paid_at` | TIMESTAMP | | Payout timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### driver_performance_plans

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `plan_id` | UUID | PRIMARY KEY | Unique identifier |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Associated driver |
| `trigger_reason` | VARCHAR(50) | NOT NULL | Reason for PIP |
| `description` | TEXT | NOT NULL | Issue description |
| `action_plan` | TEXT | NOT NULL | Improvement action plan |
| `target_metrics` | JSONB | NOT NULL | Target metrics and values |
| `start_date` | DATE | NOT NULL | PIP start date |
| `review_date` | DATE | | First review date |
| `end_date` | DATE | | PIP end date |
| `status` | VARCHAR(20) | DEFAULT 'ACTIVE' | ACTIVE/COMPLETED/FAILED/EXTENDED |
| `outcome` | VARCHAR(20) | | SUCCESS/FAILURE/EXTENDED |
| `notes` | TEXT | | Review notes |
| `created_by` | UUID | | Admin who created PIP |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### driver_performance_reviews

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `review_id` | UUID | PRIMARY KEY | Unique identifier |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Associated driver |
| `reviewer_id` | UUID | | Admin who conducted review |
| `review_date` | DATE | NOT NULL | Review date |
| `review_type` | VARCHAR(20) | NOT NULL | QUARTERLY/ANNUAL/PIP/COACHING |
| `performance_summary` | TEXT | | Performance summary |
| `strengths` | TEXT | | Identified strengths |
| `areas_for_improvement` | TEXT | | Improvement areas |
| `action_items` | JSONB | | Action items from review |
| `next_review_date` | DATE | | Next review date |
| `notes` | TEXT | | Additional notes |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### driver_complaints

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `complaint_id` | UUID | PRIMARY KEY | Unique identifier |
| `driver_id` | UUID | FOREIGN KEY (driver_accounts.driver_id) | Associated driver |
| `order_id` | UUID | FOREIGN KEY (merchant_orders.order_id) | Associated order |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Complainant |
| `complaint_type` | VARCHAR(30) | NOT NULL | LATE/RUDE/DAMAGED/WRONG_ORDER/SAFETY/OTHER |
| `description` | TEXT | NOT NULL | Complaint description |
| `status` | VARCHAR(20) | DEFAULT 'OPEN' | OPEN/INVESTIGATING/RESOLVED/DISMISSED |
| `investigation_notes` | TEXT | | Investigation findings |
| `resolution` | TEXT | | Resolution details |
| `resolved_by` | UUID | | Resolver identifier |
| `resolved_at` | TIMESTAMP | | Resolution timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 11 – REST APIs

### Performance APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/driver/performance` | Get driver performance summary |
| `GET` | `/api/v1/driver/performance/metrics` | Get performance metrics |
| `GET` | `/api/v1/driver/performance/scorecard` | Get performance scorecard |
| `GET` | `/api/v1/driver/performance/tier` | Get driver tier |
| `GET` | `/api/v1/driver/performance/tier/benefits` | Get tier benefits |

### Rating APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/driver/ratings` | Get driver ratings |
| `GET` | `/api/v1/driver/ratings/{id}` | Get rating details |
| `GET` | `/api/v1/driver/ratings/feedback` | Get customer feedback |
| `GET` | `/api/v1/driver/ratings/trend` | Get rating trend |

### Incentive APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/driver/incentives` | Get driver incentives |
| `GET` | `/api/v1/driver/incentives/active` | Get active incentives |
| `GET` | `/api/v1/driver/incentives/history` | Get incentive history |
| `POST` | `/api/v1/driver/incentives/claim` | Claim completed incentive |

### Admin APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/drivers/performance` | List driver performance (admin) |
| `GET` | `/api/v1/admin/drivers/{id}/performance` | Get driver performance (admin) |
| `GET` | `/api/v1/admin/drivers/performance/top` | Get top performers (admin) |
| `GET` | `/api/v1/admin/drivers/performance/improvement` | Get drivers needing improvement (admin) |
| `POST` | `/api/v1/admin/drivers/{id}/pip` | Create PIP (admin) |
| `PUT` | `/api/v1/admin/drivers/{id}/pip/{id}` | Update PIP (admin) |
| `POST` | `/api/v1/admin/drivers/{id}/review` | Create performance review (admin) |
| `POST` | `/api/v1/admin/drivers/{id}/incentive` | Create incentive (admin) |
| `POST` | `/api/v1/admin/drivers/{id}/suspend` | Suspend driver (admin) |

---

## Chapter 12 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-PERF-001** | Driver rating is calculated weekly based on last 30 days of data. | **High** |
| **BR-PERF-002** | Minimum rating threshold for assignment: 4.0. | **High** |
| **BR-PERF-003** | Tier is updated weekly based on performance metrics. | **High** |
| **BR-PERF-004** | Incentives are automatically calculated and awarded. | **High** |
| **BR-PERF-005** | PIP is triggered when rating falls below 3.5. | **High** |
| **BR-PERF-006** | PIP duration: 30 days with weekly reviews. | **High** |
| **BR-PERF-007** | 3 consecutive weeks of poor performance triggers suspension review. | **High** |
| **BR-PERF-008** | Customer ratings below 2 stars require reason. | **High** |
| **BR-PERF-009** | Driver can appeal rating within 7 days. | **Medium** |
| **BR-PERF-010** | Incentive payouts are processed with next payout cycle. | **High** |

---

## Chapter 13 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-PERF-001** | Driver views performance summary. | **High** |
| **TEST-PERF-002** | Driver views detailed performance metrics. | **High** |
| **TEST-PERF-003** | Driver views performance scorecard. | **High** |
| **TEST-PERF-004** | Driver views current tier and benefits. | **High** |
| **TEST-PERF-005** | Driver rating updates after customer rating. | **High** |
| **TEST-PERF-006** | Driver rating trend chart displays correctly. | **High** |
| **TEST-PERF-007** | Tier is recalculated based on performance. | **High** |
| **TEST-PERF-008** | Driver moves to higher tier (upgrade). | **High** |
| **TEST-PERF-009** | Driver moves to lower tier (downgrade). | **High** |
| **TEST-PERF-010** | Driver views active incentives. | **High** |
| **TEST-PERF-011** | Driver achieves incentive; status updates. | **High** |
| **TEST-PERF-012** | Incentive bonus is paid out. | **High** |
| **TEST-PERF-013** | Driver receives customer feedback. | **High** |
| **TEST-PERF-014** | Driver views customer complaint history. | **High** |
| **TEST-PERF-015** | PIP is triggered for poor performance. | **High** |
| **TEST-PERF-016** | Driver completes PIP successfully. | **High** |
| **TEST-PERF-017** | Driver fails PIP; suspension review triggered. | **High** |
| **TEST-PERF-018** | Admin views driver performance dashboard. | **High** |
| **TEST-PERF-019** | Admin views top performers list. | **High** |
| **TEST-PERF-020** | Admin views drivers needing improvement. | **High** |
| **TEST-PERF-021** | Admin creates PIP for driver. | **High** |
| **TEST-PERF-022** | Admin updates PIP status. | **High** |
| **TEST-PERF-023** | Admin creates performance review for driver. | **High** |
| **TEST-PERF-024** | Admin creates manual incentive for driver. | **High** |
| **TEST-PERF-025** | Admin suspends driver for performance reasons. | **High** |
| **TEST-PERF-026** | Driver rating appeals (review process). | **Medium** |
| **TEST-PERF-027** | Performance report is generated and exported. | **High** |

---

## Chapter 14 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| DRV-112 | driver_performance_metrics | GET /api/v1/driver/performance/metrics | TEST-PERF-001, TEST-PERF-002 |
| DRV-118 | driver_performance_metrics | GET /api/v1/driver/performance/scorecard | TEST-PERF-003 |
| DRV-124 | driver_performance_metrics | GET /api/v1/driver/performance/tier | TEST-PERF-004 |
| DRV-115 | driver_ratings | GET /api/v1/driver/ratings | TEST-PERF-005, TEST-PERF-006 |
| DRV-124 | driver_performance_metrics | GET /api/v1/driver/performance/tier | TEST-PERF-007, TEST-PERF-008, TEST-PERF-009 |
| DRV-121 | driver_incentives | GET /api/v1/driver/incentives/active | TEST-PERF-010, TEST-PERF-011, TEST-PERF-012 |
| DRV-116 | driver_ratings | GET /api/v1/driver/ratings/feedback | TEST-PERF-013, TEST-PERF-014 |
| DRV-127 | driver_performance_plans | GET /api/v1/admin/drivers/{id}/pip | TEST-PERF-015, TEST-PERF-016, TEST-PERF-017 |
| DRV-132 | driver_performance_metrics | GET /api/v1/admin/drivers/performance | TEST-PERF-018, TEST-PERF-019, TEST-PERF-020 |
| DRV-127 | driver_performance_plans | POST /api/v1/admin/drivers/{id}/pip | TEST-PERF-021, TEST-PERF-022 |
| DRV-130 | driver_performance_reviews | POST /api/v1/admin/drivers/{id}/review | TEST-PERF-023 |
| DRV-121 | driver_incentives | POST /api/v1/admin/drivers/{id}/incentive | TEST-PERF-024 |
| DRV-124 | driver_accounts | POST /api/v1/admin/drivers/{id}/suspend | TEST-PERF-025 |

---

## Chapter 15 – Summary

This document establishes the complete driver performance management capability for the **[Platform Name]** platform. Key takeaways:

- **Comprehensive Metrics:** Core performance metrics including acceptance rate, completion rate, on-time rate, customer rating, and earnings per hour.
- **Transparent Rating System:** Multi-component rating calculation with clear visibility into ratings, breakdowns, and trends.
- **Performance Tiers:** Platinum, Gold, Silver, Bronze, and Probation tiers with escalating benefits and incentives.
- **Performance Scorecards:** Regular performance reviews with scorecards, feedback, and improvement recommendations.
- **Incentives & Bonuses:** Multiple incentive types (acceptance, completion, on-time, rating, streak, peak, distance) to motivate high performance.
- **Performance Improvement Plans:** Structured PIP process for underperforming drivers with clear targets and review milestones.
- **Coaching & Development:** Performance reviews, coaching sessions, training recommendations, and peer mentoring.
- **Performance Analytics:** Comprehensive dashboards and reports for driver performance monitoring and improvement.
- **Complaint Management:** Structured complaint handling with investigation and resolution workflows.

The driver performance module is the engine that drives quality and continuous improvement across the driver fleet. Transparent, fair, and motivating performance management ensures drivers are incentivized to deliver exceptional service, building customer loyalty and platform reputation.

---

**Next Document:**

`Part_03F_Driver_Earnings_Payouts.md`

*(This completes the driver module by defining how driver earnings are calculated, tracked, and paid out.)*
