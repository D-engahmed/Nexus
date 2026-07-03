# Part 08C Content Management

# Software Requirements Specification (SRS)

## Part 08C: Content Management

**Module:** Admin & Operations Module (Part 09)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Content Management module defines the comprehensive capabilities for managing all content across the **[Platform Name]** platform. This encompasses banners, promotions, landing pages, categories, merchant collections, menu management, content scheduling, and multi-language content management.

Content is the primary means of communicating with customers and driving engagement. Well-managed content enables marketing campaigns, promotes merchants, guides customer discovery, and enhances the overall user experience. This module ensures that content can be created, managed, and published efficiently without requiring engineering resources.

### Objectives

- Enable efficient creation and management of all platform content
- Support content scheduling and publishing workflows
- Provide multi-language content management
- Enable content personalization and targeting
- Support A/B testing and content optimization
- Maintain content versioning and audit trails
- Provide content analytics and performance insights
- Enable self-service content management for operations teams

---

## Chapter 2 – Content Types

### CONTENT-001 Supported Content Types

| Type | Description | Priority |
| :--- | :--- | :--- |
| **Banners** | Promotional images and messaging | **Required** |
| **Promotions** | Discount offers and campaigns | **Required** |
| **Landing Pages** | Custom marketing pages | **Required** |
| **Categories** | Product/service categories | **Required** |
| **Merchant Collections** | Curated merchant groupings | **Required** |
| **Featured Items** | Highlighted menu items | **Required** |
| **Static Pages** | About, FAQ, contact, etc. | **Required** |
| **Email Templates** | Marketing and transactional emails | **Required** |
| **Push Templates** | Push notification templates | **Required** |
| **SMS Templates** | SMS notification templates | **Required** |
| **In-App Messages** | In-app notifications and alerts | **Required** |

### CONTENT-002 Content Attributes

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `content_id` | UUID | Yes | Unique identifier |
| `content_type` | String | Yes | Type of content |
| `title` | String | Yes | Content title |
| `description` | Text | No | Content description |
| `status` | String | Yes | DRAFT/REVIEW/PUBLISHED/ARCHIVED |
| `version` | Integer | Yes | Content version |
| `language` | String | Yes | ISO 639-1 language code |
| `created_by` | UUID | Yes | Creator identifier |
| `updated_by` | UUID | | Last updater |
| `published_at` | Timestamp | | Publication timestamp |
| `expires_at` | Timestamp | | Expiration timestamp |
| `target_audience` | JSONB | | Targeting criteria |
| `metadata` | JSONB | | Additional metadata |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 3 – Banners

### CONTENT-003 Banner Types

| Type | Description | Priority |
| :--- | :--- | :--- |
| **Image Banner** | Static image with overlay text | **Required** |
| **Carousel Banner** | Multiple rotating images | **Required** |
| **Video Banner** | Video content with overlay | **Required** |
| **Promotional Banner** | Banner linked to promotion | **Required** |
| **Merchant Banner** | Banner featuring merchant | **Required** |
| **Category Banner** | Banner promoting category | **Required** |
| **Seasonal Banner** | Seasonal or holiday content | **Required** |
| **Location Banner** | Location-specific banner | **Required** |

### CONTENT-004 Banner Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `banner_id` | UUID | Yes | Unique identifier |
| `banner_name` | String | Yes | Internal name |
| `banner_type` | String | Yes | Type of banner |
| `image_url` | String | Yes | Banner image URL |
| `mobile_image_url` | String | | Mobile-optimized image |
| `title` | String | | Banner title |
| `subtitle` | String | | Banner subtitle |
| `cta_text` | String | | Call-to-action text |
| `cta_link` | String | | Call-to-action link |
| `priority` | Integer | Yes | Display priority |
| `placement` | String | Yes | HERO/HOMEPAGE/CATEGORY/MERCHANT |
| `target_url` | String | | Target URL on click |
| `is_active` | Boolean | Yes | Active status |

### CONTENT-005 Banner Placement

| Placement | Description | Priority |
| :--- | :--- | :--- |
| **Hero** | Top of homepage | **Required** |
| **Homepage** | Homepage sections | **Required** |
| **Category** | Category page top | **Required** |
| **Merchant** | Merchant page | **Required** |
| **Checkout** | Checkout page | **Required** |
| **App** | Mobile app specific | **Required** |
| **Web** | Web specific | **Required** |

---

## Chapter 4 – Promotions

### CONTENT-006 Promotion Types

| Type | Description | Priority |
| :--- | :--- | :--- |
| **Percentage Discount** | % off order total | **Required** |
| **Fixed Discount** | Fixed amount off | **Required** |
| **Free Delivery** | Free delivery on orders | **Required** |
| **Buy One Get One** | BOGO promotion | **Required** |
| **Bundle Deal** | Bundle of items | **Required** |
| **Tiered Discount** | Discount based on order value | **Required** |
| **Referral** | Referral-based promotion | **Required** |
| **New Customer** | First-time customer offer | **Required** |

### CONTENT-007 Promotion Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `promotion_id` | UUID | Yes | Unique identifier |
| `promotion_name` | String | Yes | Internal name |
| `promotion_type` | String | Yes | Type of promotion |
| `discount_value` | Decimal | | Discount amount/percentage |
| `discount_type` | String | | PERCENTAGE/FIXED |
| `min_order_value` | Decimal | | Minimum order for promotion |
| `max_discount` | Decimal | | Maximum discount amount |
| `applicable_items` | JSONB | | Items/categories applicable |
| `applicable_merchants` | JSONB | | Merchants applicable |
| `applicable_customers` | JSONB | | Customer eligibility |
| `usage_limit` | Integer | | Total usage limit |
| `per_customer_limit` | Integer | | Limit per customer |
| `start_date` | Date | Yes | Promotion start date |
| `end_date` | Date | Yes | Promotion end date |
| `promo_code` | String | | Optional promo code |
| `is_active` | Boolean | Yes | Active status |

### CONTENT-008 Promotion Rules

| Rule | Description | Priority |
| :--- | :--- | :--- |
| **Minimum Order** | Promotion applies only above min order | **Required** |
| **Merchant Eligibility** | Promotion applies only to eligible merchants | **Required** |
| **Category Eligibility** | Promotion applies only to eligible categories | **Required** |
| **Item Eligibility** | Promotion applies only to eligible items | **Required** |
| **Customer Eligibility** | Promotion applies only to eligible customers | **Required** |
| **Usage Limit** | Promotion limited to X total uses | **Required** |
| **Per Customer Limit** | Each customer can use X times | **Required** |
| **Stackable** | Can be combined with other promotions | **Required** |
| **First Order Only** | Valid only for first order | **Required** |

---

## Chapter 5 – Categories

### CONTENT-009 Category Management

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Create Category** | Create new category | **Required** |
| **Update Category** | Update category details | **Required** |
| **Delete Category** | Remove category | **Required** |
| **Category Hierarchy** | Nested categories and sub-categories | **Required** |
| **Category Icons** | Icon/image per category | **Required** |
| **Category Ordering** | Drag-and-drop ordering | **Required** |
| **Category Visibility** | Show/hide categories | **Required** |

### CONTENT-010 Category Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `category_id` | UUID | Yes | Unique identifier |
| `category_name` | String | Yes | Category display name |
| `category_description` | Text | | Category description |
| `category_image` | String | | Category image URL |
| `category_icon` | String | | Category icon class |
| `parent_category_id` | UUID | | Parent category (for hierarchy) |
| `display_order` | Integer | Yes | Display order |
| `is_active` | Boolean | Yes | Active status |
| `is_featured` | Boolean | | Featured category |
| `slug` | String | Unique | URL-friendly identifier |
| `meta_title` | String | | SEO meta title |
| `meta_description` | String | | SEO meta description |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 6 – Merchant Collections

### CONTENT-011 Collection Types

| Type | Description | Priority |
| :--- | :--- | :--- |
| **Featured** | Featured merchants | **Required** |
| **Popular** | Popular merchants by orders | **Required** |
| **New** | Newly joined merchants | **Required** |
| **Top Rated** | Highest rated merchants | **Required** |
| **Curated** | Manually curated collections | **Required** |
| **Seasonal** | Seasonal collections | **Required** |
| **Category-Based** | Based on cuisine/category | **Required** |

### CONTENT-012 Collection Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `collection_id` | UUID | Yes | Unique identifier |
| `collection_name` | String | Yes | Collection name |
| `collection_description` | Text | | Collection description |
| `collection_image` | String | | Collection image |
| `collection_type` | String | Yes | FEATURED/POPULAR/NEW/TOP_RATED/CURATED/SEASONAL |
| `merchant_ids` | TEXT[] | | Included merchants |
| `display_order` | Integer | Yes | Display order |
| `is_active` | Boolean | Yes | Active status |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 7 – Landing Pages

### CONTENT-013 Landing Page Components

| Component | Description | Priority |
| :--- | :--- | :--- |
| **Hero Section** | Main banner section | **Required** |
| **Featured Section** | Featured content | **Required** |
| **Category Grid** | Category display grid | **Required** |
| **Merchant Grid** | Merchant display grid | **Required** |
| **Promotional Section** | Promotional content | **Required** |
| **Testimonials** | Customer testimonials | **Required** |
| **Call-to-Action** | CTA section | **Required** |
| **Footer** | Custom footer content | **Required** |

### CONTENT-014 Landing Page Data Model

| Attribute | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `page_id` | UUID | Yes | Unique identifier |
| `page_name` | String | Yes | Internal page name |
| `page_title` | String | Yes | Page title |
| `page_description` | Text | | Meta description |
| `page_slug` | String | Unique | URL slug |
| `sections` | JSONB | Yes | Page sections |
| `template` | String | | Page template |
| `is_active` | Boolean | Yes | Active status |
| `is_default` | Boolean | | Default page |
| `published_at` | Timestamp | | Publication timestamp |
| `created_at` | Timestamp | Yes | Creation timestamp |
| `updated_at` | Timestamp | Yes | Last update timestamp |

---

## Chapter 8 – Content Scheduling

### CONTENT-015 Scheduling Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Publish Date** | Schedule publication date | **Required** |
| **Expiry Date** | Schedule expiration date | **Required** |
| **Time Zone** | Support for time zones | **Required** |
| **Recurring** | Recurring content schedules | **Required** |
| **Seasonal** | Seasonal content scheduling | **Required** |
| **Preview** | Preview scheduled content | **Required** |

### CONTENT-016 Scheduling Workflow

1.  Content created.
2.  Content reviewed.
3.  Schedule set (publish/expiry dates).
4.  Content approved.
5.  System auto-publishes on schedule.
6.  Content active until expiry.
7.  System auto-archives on expiry.

### CONTENT-017 Scheduling Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `schedule_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `publish_at` | TIMESTAMP | | Scheduled publish time |
| `expire_at` | TIMESTAMP | | Scheduled expiry time |
| `is_recurring` | BOOLEAN | DEFAULT FALSE | Recurring schedule |
| `recurrence_pattern` | VARCHAR(50) | | DAILY/WEEKLY/MONTHLY |
| `status` | VARCHAR(20) | DEFAULT 'SCHEDULED' | SCHEDULED/PUBLISHED/EXPIRED/CANCELLED |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 9 – Multi-Language Content

### CONTENT-018 Language Features

| Feature | Description | Priority |
| :--- | :--- | :--- |
| **Multi-Language** | Content in multiple languages | **Required** |
| **Translation** | Translation management | **Required** |
| **Fallback** | Fallback language support | **Required** |
| **Localization** | Localized content | **Required** |

### CONTENT-019 Language Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `translation_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `language` | VARCHAR(5) | NOT NULL | ISO 639-1 language |
| `title` | VARCHAR(255) | | Translated title |
| `description` | TEXT | | Translated description |
| `content_data` | JSONB | | Translated content data |
| `is_fallback` | BOOLEAN | DEFAULT FALSE | Fallback language |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 10 – Content Analytics

### CONTENT-020 Analytics Metrics

| Metric | Description | Priority |
| :--- | :--- | :--- |
| **Impressions** | Number of times content was shown | **Required** |
| **Clicks** | Number of times content was clicked | **Required** |
| **CTR** | Click-through rate | **Required** |
| **Conversions** | Conversions from content | **Required** |
| **Conversion Rate** | Conversion rate from content | **Required** |
| **Revenue** | Revenue generated | **Required** |
| **Engagement** | User engagement metrics | **Required** |
| **Bounce Rate** | Bounce rate | **Required** |

### CONTENT-021 Analytics Data Model

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `date` | DATE | NOT NULL | Analytics date |
| `impressions` | INTEGER | DEFAULT 0 | Number of impressions |
| `clicks` | INTEGER | DEFAULT 0 | Number of clicks |
| `ctr` | DECIMAL(5, 2) | | Click-through rate |
| `conversions` | INTEGER | DEFAULT 0 | Number of conversions |
| `conversion_rate` | DECIMAL(5, 2) | | Conversion rate |
| `revenue` | DECIMAL(10, 2) | | Revenue generated |
| `engagement_time` | INTEGER | | Average engagement time |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 11 – Database Tables

### content_versions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `content_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_type` | VARCHAR(30) | NOT NULL | BANNER/PROMOTION/CATEGORY/COLLECTION/PAGE |
| `title` | VARCHAR(255) | NOT NULL | Content title |
| `description` | TEXT | | Content description |
| `status` | VARCHAR(20) | DEFAULT 'DRAFT' | DRAFT/REVIEW/PUBLISHED/ARCHIVED |
| `version` | INTEGER | NOT NULL | Content version |
| `language` | VARCHAR(5) | NOT NULL | ISO 639-1 language |
| `content_data` | JSONB | NOT NULL | Content data |
| `created_by` | UUID | | Creator identifier |
| `updated_by` | UUID | | Last updater |
| `published_at` | TIMESTAMP | | Publication timestamp |
| `expires_at` | TIMESTAMP | | Expiration timestamp |
| `target_audience` | JSONB | | Targeting criteria |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### content_schedules

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `schedule_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `publish_at` | TIMESTAMP | | Scheduled publish time |
| `expire_at` | TIMESTAMP | | Scheduled expiry time |
| `is_recurring` | BOOLEAN | DEFAULT FALSE | Recurring schedule |
| `recurrence_pattern` | VARCHAR(50) | | DAILY/WEEKLY/MONTHLY |
| `status` | VARCHAR(20) | DEFAULT 'SCHEDULED' | SCHEDULED/PUBLISHED/EXPIRED/CANCELLED |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### content_translations

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `translation_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `language` | VARCHAR(5) | NOT NULL | ISO 639-1 language |
| `title` | VARCHAR(255) | | Translated title |
| `description` | TEXT | | Translated description |
| `content_data` | JSONB | | Translated content data |
| `is_fallback` | BOOLEAN | DEFAULT FALSE | Fallback language |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### promotions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `promotion_id` | UUID | PRIMARY KEY | Unique identifier |
| `promotion_name` | VARCHAR(255) | NOT NULL | Promotion name |
| `promotion_type` | VARCHAR(30) | NOT NULL | PERCENTAGE/FIXED/FREE_DELIVERY/BOGO/BUNDLE/TIERED/REFERRAL/NEW_CUSTOMER |
| `discount_value` | DECIMAL(10, 2) | | Discount amount/percentage |
| `discount_type` | VARCHAR(10) | | PERCENTAGE/FIXED |
| `min_order_value` | DECIMAL(10, 2) | | Minimum order value |
| `max_discount` | DECIMAL(10, 2) | | Maximum discount |
| `applicable_items` | JSONB | | Applicable items/categories |
| `applicable_merchants` | JSONB | | Applicable merchants |
| `applicable_customers` | JSONB | | Customer eligibility |
| `usage_limit` | INTEGER | | Total usage limit |
| `per_customer_limit` | INTEGER | | Per customer limit |
| `start_date` | DATE | NOT NULL | Start date |
| `end_date` | DATE | NOT NULL | End date |
| `promo_code` | VARCHAR(50) | | Promo code |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### content_analytics

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `analytics_id` | UUID | PRIMARY KEY | Unique identifier |
| `content_id` | UUID | FOREIGN KEY (content_versions.content_id) | Associated content |
| `date` | DATE | NOT NULL | Analytics date |
| `impressions` | INTEGER | DEFAULT 0 | Impressions |
| `clicks` | INTEGER | DEFAULT 0 | Clicks |
| `ctr` | DECIMAL(5, 2) | | Click-through rate |
| `conversions` | INTEGER | DEFAULT 0 | Conversions |
| `conversion_rate` | DECIMAL(5, 2) | | Conversion rate |
| `revenue` | DECIMAL(10, 2) | | Revenue generated |
| `engagement_time` | INTEGER | | Average engagement time |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 12 – REST APIs

### Content APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/content` | List content |
| `GET` | `/api/v1/admin/content/{id}` | Get content details |
| `POST` | `/api/v1/admin/content` | Create content |
| `PUT` | `/api/v1/admin/content/{id}` | Update content |
| `DELETE` | `/api/v1/admin/content/{id}` | Delete content |
| `PUT` | `/api/v1/admin/content/{id}/publish` | Publish content |
| `PUT` | `/api/v1/admin/content/{id}/archive` | Archive content |
| `GET` | `/api/v1/admin/content/{id}/versions` | Get content versions |
| `POST` | `/api/v1/admin/content/{id}/versions/rollback` | Rollback to version |

### Banner APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/banners` | List banners |
| `GET` | `/api/v1/admin/banners/{id}` | Get banner details |
| `POST` | `/api/v1/admin/banners` | Create banner |
| `PUT` | `/api/v1/admin/banners/{id}` | Update banner |
| `DELETE` | `/api/v1/admin/banners/{id}` | Delete banner |
| `PUT` | `/api/v1/admin/banners/{id}/position` | Update banner position |

### Promotion APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/promotions` | List promotions |
| `GET` | `/api/v1/admin/promotions/{id}` | Get promotion details |
| `POST` | `/api/v1/admin/promotions` | Create promotion |
| `PUT` | `/api/v1/admin/promotions/{id}` | Update promotion |
| `DELETE` | `/api/v1/admin/promotions/{id}` | Delete promotion |
| `POST` | `/api/v1/admin/promotions/{id}/validate` | Validate promotion |

### Category APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/categories` | List categories |
| `GET` | `/api/v1/admin/categories/{id}` | Get category details |
| `POST` | `/api/v1/admin/categories` | Create category |
| `PUT` | `/api/v1/admin/categories/{id}` | Update category |
| `DELETE` | `/api/v1/admin/categories/{id}` | Delete category |
| `PUT` | `/api/v1/admin/categories/reorder` | Reorder categories |

### Collection APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/collections` | List collections |
| `GET` | `/api/v1/admin/collections/{id}` | Get collection details |
| `POST` | `/api/v1/admin/collections` | Create collection |
| `PUT` | `/api/v1/admin/collections/{id}` | Update collection |
| `DELETE` | `/api/v1/admin/collections/{id}` | Delete collection |

### Translation APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/content/{id}/translations` | Get translations |
| `POST` | `/api/v1/admin/content/{id}/translations` | Add translation |
| `PUT` | `/api/v1/admin/content/{id}/translations/{lang}` | Update translation |
| `DELETE` | `/api/v1/admin/content/{id}/translations/{lang}` | Delete translation |

### Analytics APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/admin/content/{id}/analytics` | Get content analytics |
| `GET` | `/api/v1/admin/content/analytics/dashboard` | Get analytics dashboard |

---

## Chapter 13 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-CONTENT-001** | Content must be reviewed before publishing. | **High** |
| **BR-CONTENT-002** | Banners must have valid image URLs. | **High** |
| **BR-CONTENT-003** | Promotions must have valid start/end dates. | **High** |
| **BR-CONTENT-004** | Promotions cannot overlap on same items. | **High** |
| **BR-CONTENT-005** | Categories must have unique slugs. | **High** |
| **BR-CONTENT-006** | Content versions must be retained for 30 days. | **High** |
| **BR-CONTENT-007** | Scheduled content auto-publishes at scheduled time. | **High** |
| **BR-CONTENT-008** | Expired content auto-archives at expiry. | **High** |
| **BR-CONTENT-009** | Multi-language content must have fallback. | **High** |
| **BR-CONTENT-010** | Content analytics must be collected daily. | **High** |

---

## Chapter 14 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-CONTENT-001** | Admin creates new banner content. | **High** |
| **TEST-CONTENT-002** | Admin updates banner content. | **High** |
| **TEST-CONTENT-003** | Admin schedules banner publication. | **High** |
| **TEST-CONTENT-004** | Banner auto-publishes at scheduled time. | **High** |
| **TEST-CONTENT-005** | Banner auto-archives at expiry. | **High** |
| **TEST-CONTENT-006** | Admin creates new promotion. | **High** |
| **TEST-CONTENT-007** | Promotion applies correctly at checkout. | **High** |
| **TEST-CONTENT-008** | Promotion usage limit enforced. | **High** |
| **TEST-CONTENT-009** | Per customer promotion limit enforced. | **High** |
| **TEST-CONTENT-010** | Admin creates new category. | **High** |
| **TEST-CONTENT-011** | Admin updates category. | **High** |
| **TEST-CONTENT-012** | Admin creates merchant collection. | **High** |
| **TEST-CONTENT-013** | Admin updates merchant collection. | **High** |
| **TEST-CONTENT-014** | Admin creates landing page. | **High** |
| **TEST-CONTENT-015** | Admin updates landing page. | **High** |
| **TEST-CONTENT-016** | Admin adds translation for content. | **High** |
| **TEST-CONTENT-017** | Content displays in correct language. | **High** |
| **TEST-CONTENT-018** | Content version history is maintained. | **High** |
| **TEST-CONTENT-019** | Admin rolls back to previous version. | **High** |
| **TEST-CONTENT-020** | Content analytics captured correctly. | **High** |
| **TEST-CONTENT-021** | Content analytics dashboard displays correctly. | **High** |
| **TEST-CONTENT-022** | Promotions with overlapping dates blocked. | **High** |

---

## Chapter 15 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| CONTENT-003 | content_versions | POST /api/v1/admin/banners | TEST-CONTENT-001, TEST-CONTENT-002 |
| CONTENT-015 | content_schedules | PUT /api/v1/admin/content/{id}/publish | TEST-CONTENT-003, TEST-CONTENT-004, TEST-CONTENT-005 |
| CONTENT-006 | promotions | POST /api/v1/admin/promotions | TEST-CONTENT-006, TEST-CONTENT-007 |
| CONTENT-007 | promotions | PUT /api/v1/admin/promotions/{id} | TEST-CONTENT-008, TEST-CONTENT-009 |
| CONTENT-009 | content_versions | POST /api/v1/admin/categories | TEST-CONTENT-010, TEST-CONTENT-011 |
| CONTENT-011 | content_versions | POST /api/v1/admin/collections | TEST-CONTENT-012, TEST-CONTENT-013 |
| CONTENT-013 | content_versions | POST /api/v1/admin/content | TEST-CONTENT-014, TEST-CONTENT-015 |
| CONTENT-018 | content_translations | POST /api/v1/admin/content/{id}/translations | TEST-CONTENT-016, TEST-CONTENT-017 |
| CONTENT-002 | content_versions | GET /api/v1/admin/content/{id}/versions | TEST-CONTENT-018, TEST-CONTENT-019 |
| CONTENT-020 | content_analytics | GET /api/v1/admin/content/{id}/analytics | TEST-CONTENT-020, TEST-CONTENT-021 |

---

## Chapter 16 – Summary

This document establishes the complete content management capability for the **[Platform Name]** platform. Key takeaways:

- **Comprehensive Content Types:** Banners, promotions, categories, collections, landing pages, and multi-language support.
- **Content Lifecycle:** Draft → Review → Publish → Archive with version control and rollback capabilities.
- **Scheduling:** Automated publish and expiry with time zone support and recurring schedules.
- **Promotions:** Multiple promotion types with flexible rules, usage limits, and merchant/customer eligibility.
- **Multi-Language:** Full multi-language support with translation management and fallback languages.
- **Analytics:** Content performance tracking with impressions, clicks, CTR, conversions, and revenue.
- **Audit Trail:** Complete version history and change tracking.
- **Self-Service:** Operations teams can manage content without engineering involvement.

The content management module enables marketing and operations teams to manage all platform content efficiently, driving customer engagement and revenue growth.

---

**Next Document:**

`Part_08D_Promotions_Campaigns.md`

*(This builds on content management to define promotions and campaign management capabilities.)*