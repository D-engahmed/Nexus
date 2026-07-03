# Software Requirements Specification (SRS)

## Part 13B: Public REST API

**Module:** Platform APIs & Developer Ecosystem (Part 13)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Public REST API module defines the comprehensive REST API specifications for external developers, partners, and integrators building on the **[Platform Name]** platform. This encompasses endpoint definitions, request/response schemas, authentication requirements, error handling, pagination, filtering, sorting, and field selection.

The public REST API is the primary interface for third-party developers to integrate with the platform. Well-designed, consistent, and comprehensive APIs enable partners to build innovative applications, merchants to integrate their systems, and developers to extend the platform's capabilities. This module ensures that the API is intuitive, secure, and production-ready.

### Objectives

- Define all public REST API endpoints
- Establish consistent request/response formats
- Enable secure API access
- Support efficient data fetching (pagination, filtering, sorting)
- Provide comprehensive error handling
- Enable API versioning
- Support webhook integration
- Ensure API discoverability and documentation

---

## Chapter 2 – API Standards

### PUBLICAPI-001 Base URL

| Environment | URL | Priority |
| :--- | :--- | :--- |
| **Production** | `https://api.platform.com/api/v1` | **Required** |
| **Sandbox** | `https://sandbox-api.platform.com/api/v1` | **Required** |
| **Staging** | `https://staging-api.platform.com/api/v1` | **Required** |

### PUBLICAPI-002 HTTP Methods

| Method | Usage | Priority |
| :--- | :--- | :--- |
| `GET` | Retrieve resources | **Required** |
| `POST` | Create resources | **Required** |
| `PUT` | Replace resources (full update) | **Required** |
| `PATCH` | Partial update | **Required** |
| `DELETE` | Delete resources | **Required** |

### PUBLICAPI-003 HTTP Status Codes

| Status Code | Description | Priority |
| :--- | :--- | :--- |
| `200 OK` | Request successful | **Required** |
| `201 Created` | Resource created | **Required** |
| `202 Accepted` | Request accepted (async) | **Required** |
| `204 No Content` | Request successful, no content | **Required** |
| `400 Bad Request` | Invalid request | **Required** |
| `401 Unauthorized` | Authentication required | **Required** |
| `403 Forbidden` | Insufficient permissions | **Required** |
| `404 Not Found` | Resource not found | **Required** |
| `405 Method Not Allowed` | Invalid HTTP method | **Required** |
| `409 Conflict` | Resource conflict | **Required** |
| `422 Unprocessable Entity` | Validation error | **Required** |
| `429 Too Many Requests` | Rate limit exceeded | **Required** |
| `500 Internal Server Error` | Server error | **Required** |
| `503 Service Unavailable` | Service unavailable | **Required** |

### PUBLICAPI-004 Response Format

```json
{
  "data": {},
  "metadata": {
    "trace_id": "550e8400-e29b-41d4-a716-446655440000",
    "timestamp": "2026-06-30T14:30:45.123Z",
    "version": "v1"
  },
  "pagination": {
    "current_page": 1,
    "total_pages": 10,
    "total_items": 100,
    "items_per_page": 10,
    "next_page": 2,
    "previous_page": null
  }
}
```

### PUBLICAPI-005 Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": [
      {
        "field": "customer_id",
        "message": "Customer ID is required",
        "code": "REQUIRED"
      }
    ],
    "trace_id": "550e8400-e29b-41d4-a716-446655440000",
    "timestamp": "2026-06-30T14:30:45.123Z"
  }
}
```

### PUBLICAPI-006 Common Headers

| Header | Description | Priority |
| :--- | :--- | :--- |
| `Authorization` | Bearer token or API key | **Required** |
| `Accept` | `application/json` | **Required** |
| `Content-Type` | `application/json` | **Required** |
| `Idempotency-Key` | Unique key for idempotent requests | **Required** |
| `X-API-Version` | API version (e.g., `v1`) | **Required** |
| `X-Trace-ID` | Trace ID for request correlation | **Required** |

---

## Chapter 3 – Authentication

### PUBLICAPI-007 Authentication Methods

| Method | Description | Priority |
| :--- | :--- | :--- |
| **Bearer Token** | JWT token in Authorization header | **Required** |
| **API Key** | API key in `X-API-Key` header | **Required** |
| **OAuth 2.1** | OAuth 2.1 flow for third-party apps | **Required** |

### PUBLICAPI-008 Authentication Headers

```
Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...
X-API-Key: pk_live_abc123def456...
```

---

## Chapter 4 – Pagination

### PUBLICAPI-009 Pagination Parameters

| Parameter | Description | Priority |
| :--- | :--- | :--- |
| `page` | Page number (default: 1) | **Required** |
| `per_page` | Items per page (default: 20, max: 100) | **Required** |
| `page` (cursor) | Cursor for cursor-based pagination | **Required** |

### PUBLICAPI-010 Pagination Example

```
GET /api/v1/orders?page=2&per_page=20
```

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "current_page": 2,
    "total_pages": 10,
    "total_items": 200,
    "items_per_page": 20,
    "next_page": 3,
    "previous_page": 1
  }
}
```

---

## Chapter 5 – Filtering & Sorting

### PUBLICAPI-011 Filtering Parameters

| Parameter | Description | Priority |
| :--- | :--- | :--- |
| `status` | Filter by status | **Required** |
| `customer_id` | Filter by customer | **Required** |
| `merchant_id` | Filter by merchant | **Required** |
| `driver_id` | Filter by driver | **Required** |
| `date_from` | Start date (ISO 8601) | **Required** |
| `date_to` | End date (ISO 8601) | **Required** |
| `min_amount` | Minimum amount | **Required** |
| `max_amount` | Maximum amount | **Required** |

### PUBLICAPI-012 Sorting Parameters

| Parameter | Description | Priority |
| :--- | :--- | :--- |
| `sort_by` | Field to sort by | **Required** |
| `sort_order` | `asc` or `desc` (default: `asc`) | **Required** |

**Example:**
```
GET /api/v1/orders?sort_by=created_at&sort_order=desc
```

### PUBLICAPI-013 Field Selection

| Parameter | Description | Priority |
| :--- | :--- | :--- |
| `fields` | Comma-separated list of fields to include | **Required** |

**Example:**
```
GET /api/v1/orders?fields=id,status,total,created_at
```

---

## Chapter 6 – Customer APIs

### PUBLICAPI-014 Customer Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/customers` | List customers | **Required** |
| `GET` | `/customers/{id}` | Get customer details | **Required** |
| `POST` | `/customers` | Create customer | **Required** |
| `PUT` | `/customers/{id}` | Update customer | **Required** |
| `PATCH` | `/customers/{id}` | Partial update customer | **Required** |
| `DELETE` | `/customers/{id}` | Delete customer | **Required** |
| `GET` | `/customers/{id}/orders` | Get customer orders | **Required** |
| `GET` | `/customers/{id}/addresses` | Get customer addresses | **Required** |
| `POST` | `/customers/{id}/addresses` | Add customer address | **Required** |
| `PUT` | `/customers/{id}/addresses/{address_id}` | Update address | **Required** |
| `DELETE` | `/customers/{id}/addresses/{address_id}` | Delete address | **Required** |

### PUBLICAPI-015 Customer Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@example.com",
  "phone": "+971501234567",
  "display_name": "JohnD",
  "avatar_url": "https://platform.com/avatars/123.jpg",
  "language": "en",
  "currency": "USD",
  "status": "ACTIVE",
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 7 – Merchant APIs

### PUBLICAPI-016 Merchant Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/merchants` | List merchants | **Required** |
| `GET` | `/merchants/{id}` | Get merchant details | **Required** |
| `POST` | `/merchants` | Create merchant | **Required** |
| `PUT` | `/merchants/{id}` | Update merchant | **Required** |
| `PATCH` | `/merchants/{id}` | Partial update merchant | **Required** |
| `DELETE` | `/merchants/{id}` | Delete merchant | **Required** |
| `GET` | `/merchants/{id}/orders` | Get merchant orders | **Required** |
| `GET` | `/merchants/{id}/menu` | Get merchant menu | **Required** |
| `POST` | `/merchants/{id}/menu/items` | Add menu item | **Required** |
| `PUT` | `/merchants/{id}/menu/items/{item_id}` | Update menu item | **Required** |
| `DELETE` | `/merchants/{id}/menu/items/{item_id}` | Delete menu item | **Required** |
| `GET` | `/merchants/{id}/analytics` | Get merchant analytics | **Required** |
| `GET` | `/merchants/{id}/settlements` | Get merchant settlements | **Required** |

### PUBLICAPI-017 Merchant Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "business_name": "Joe's Pizza Palace",
  "trading_name": "Joe's Pizza",
  "business_type": "RESTAURANT",
  "cuisine": "Italian",
  "email": "joe@joespizza.com",
  "phone": "+971501234567",
  "address": {
    "line1": "123 Main Street",
    "city": "Dubai",
    "state": "Dubai",
    "postal_code": "12345",
    "country": "AE"
  },
  "latitude": 25.2048,
  "longitude": 55.2708,
  "rating": 4.8,
  "status": "ACTIVE",
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 8 – Driver APIs

### PUBLICAPI-018 Driver Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/drivers` | List drivers | **Required** |
| `GET` | `/drivers/{id}` | Get driver details | **Required** |
| `POST` | `/drivers` | Create driver | **Required** |
| `PUT` | `/drivers/{id}` | Update driver | **Required** |
| `PATCH` | `/drivers/{id}` | Partial update driver | **Required** |
| `DELETE` | `/drivers/{id}` | Delete driver | **Required** |
| `GET` | `/drivers/{id}/deliveries` | Get driver deliveries | **Required** |
| `GET` | `/drivers/{id}/earnings` | Get driver earnings | **Required** |
| `PUT` | `/drivers/{id}/location` | Update driver location | **Required** |
| `GET` | `/drivers/{id}/status` | Get driver status | **Required** |

### PUBLICAPI-019 Driver Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "first_name": "Ahmed",
  "last_name": "Mohammed",
  "email": "ahmed@example.com",
  "phone": "+971501234567",
  "vehicle_type": "MOTORCYCLE",
  "license_plate": "ABC1234",
  "rating": 4.9,
  "status": "ONLINE",
  "current_location": {
    "latitude": 25.2048,
    "longitude": 55.2708
  },
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 9 – Order APIs

### PUBLICAPI-020 Order Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/orders` | List orders | **Required** |
| `GET` | `/orders/{id}` | Get order details | **Required** |
| `POST` | `/orders` | Create order | **Required** |
| `PUT` | `/orders/{id}` | Update order | **Required** |
| `PATCH` | `/orders/{id}` | Partial update order | **Required** |
| `DELETE` | `/orders/{id}` | Cancel order | **Required** |
| `GET` | `/orders/{id}/status` | Get order status | **Required** |
| `GET` | `/orders/{id}/tracking` | Get order tracking | **Required** |
| `POST` | `/orders/{id}/tracking` | Update tracking | **Required** |
| `GET` | `/orders/{id}/timeline` | Get order timeline | **Required** |

### PUBLICAPI-021 Order Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "order_reference": "ORD-2026-001",
  "customer_id": "550e8400-e29b-41d4-a716-446655440001",
  "merchant_id": "550e8400-e29b-41d4-a716-446655440002",
  "driver_id": "550e8400-e29b-41d4-a716-446655440003",
  "items": [
    {
      "item_id": "550e8400-e29b-41d4-a716-446655440004",
      "name": "Margherita Pizza",
      "quantity": 1,
      "price": 45.00,
      "modifiers": [
        {
          "name": "Extra Cheese",
          "price": 5.00
        }
      ]
    }
  ],
  "subtotal": 45.00,
  "delivery_fee": 5.00,
  "service_fee": 1.00,
  "tax": 2.50,
  "discount": 0.00,
  "total": 53.50,
  "currency": "USD",
  "status": "DELIVERED",
  "payment_status": "CAPTURED",
  "delivery_address": {
    "line1": "456 Oak Avenue",
    "city": "Dubai",
    "state": "Dubai",
    "postal_code": "12345",
    "country": "AE"
  },
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 10 – Payment APIs

### PUBLICAPI-022 Payment Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/payments` | List payments | **Required** |
| `GET` | `/payments/{id}` | Get payment details | **Required** |
| `POST` | `/payments` | Create payment | **Required** |
| `POST` | `/payments/{id}/refund` | Refund payment | **Required** |
| `GET` | `/payments/order/{id}` | Get payments for order | **Required** |
| `GET` | `/payments/methods` | Get payment methods | **Required** |
| `POST` | `/payments/methods` | Add payment method | **Required** |
| `DELETE` | `/payments/methods/{id}` | Delete payment method | **Required** |

### PUBLICAPI-023 Payment Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "order_id": "550e8400-e29b-41d4-a716-446655440001",
  "amount": 53.50,
  "currency": "USD",
  "status": "CAPTURED",
  "payment_method": "CARD",
  "card_brand": "VISA",
  "last_four": "4242",
  "gateway": "stripe",
  "gateway_transaction_id": "pi_123456789",
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 11 – Delivery APIs

### PUBLICAPI-024 Delivery Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/deliveries` | List deliveries | **Required** |
| `GET` | `/deliveries/{id}` | Get delivery details | **Required** |
| `GET` | `/deliveries/{id}/tracking` | Get delivery tracking | **Required** |
| `POST` | `/deliveries/{id}/tracking` | Update tracking | **Required** |
| `POST` | `/deliveries/{id}/assign` | Assign driver | **Required** |
| `POST` | `/deliveries/{id}/pickup` | Confirm pickup | **Required** |
| `POST` | `/deliveries/{id}/deliver` | Confirm delivery | **Required** |

### PUBLICAPI-025 Delivery Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "order_id": "550e8400-e29b-41d4-a716-446655440001",
  "driver_id": "550e8400-e29b-41d4-a716-446655440002",
  "status": "IN_TRANSIT",
  "pickup_location": {
    "latitude": 25.2048,
    "longitude": 55.2708
  },
  "dropoff_location": {
    "latitude": 25.3048,
    "longitude": 55.3708
  },
  "current_location": {
    "latitude": 25.2548,
    "longitude": 55.3208
  },
  "eta": 600,
  "distance": 8.5,
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

---

## Chapter 12 – Webhook APIs

### PUBLICAPI-026 Webhook Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/webhooks` | List webhooks | **Required** |
| `POST` | `/webhooks` | Create webhook | **Required** |
| `GET` | `/webhooks/{id}` | Get webhook details | **Required** |
| `PUT` | `/webhooks/{id}` | Update webhook | **Required** |
| `DELETE` | `/webhooks/{id}` | Delete webhook | **Required** |
| `POST` | `/webhooks/{id}/test` | Test webhook | **Required** |
| `GET` | `/webhooks/{id}/deliveries` | Get webhook deliveries | **Required** |
| `POST` | `/webhooks/{id}/retry` | Retry failed delivery | **Required** |

### PUBLICAPI-027 Webhook Schema

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Order Notifications",
  "url": "https://partner.example.com/webhooks",
  "events": [
    "order.created",
    "order.updated",
    "order.delivered"
  ],
  "secret": "whsec_abc123def456",
  "is_active": true,
  "retry_count": 3,
  "created_at": "2026-06-30T14:30:45.123Z",
  "updated_at": "2026-06-30T14:30:45.123Z"
}
```

### PUBLICAPI-028 Webhook Payload

```json
{
  "event": "order.created",
  "timestamp": "2026-06-30T14:30:45.123Z",
  "data": {
    "order_id": "550e8400-e29b-41d4-a716-446655440000",
    "customer_id": "550e8400-e29b-41d4-a716-446655440001",
    "merchant_id": "550e8400-e29b-41d4-a716-446655440002",
    "total": 53.50,
    "status": "PENDING"
  }
}
```

---

## Chapter 13 – Analytics APIs

### PUBLICAPI-029 Analytics Endpoints

| Method | Endpoint | Description | Priority |
| :--- | :--- | :--- | :--- |
| `GET` | `/analytics/orders` | Get order analytics | **Required** |
| `GET` | `/analytics/revenue` | Get revenue analytics | **Required** |
| `GET` | `/analytics/customers` | Get customer analytics | **Required** |
| `GET` | `/analytics/merchants` | Get merchant analytics | **Required** |
| `GET` | `/analytics/drivers` | Get driver analytics | **Required** |
| `GET` | `/analytics/deliveries` | Get delivery analytics | **Required** |

---

## Chapter 14 – Database Tables

### api_keys

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `api_key_id` | UUID | PRIMARY KEY | Unique identifier |
| `name` | VARCHAR(100) | NOT NULL | API key name |
| `key_prefix` | VARCHAR(10) | | Key prefix |
| `key_hash` | VARCHAR(255) | NOT NULL | Hashed API key |
| `scopes` | TEXT[] | | Authorization scopes |
| `rate_limit_tier` | VARCHAR(20) | DEFAULT 'STANDARD' | FREE/STANDARD/PREMIUM/ENTERPRISE |
| `expires_at` | TIMESTAMP | | Expiration timestamp |
| `last_used_at` | TIMESTAMP | | Last usage timestamp |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_by` | UUID | | Creator identifier |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### webhook_subscriptions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `webhook_id` | UUID | PRIMARY KEY | Unique identifier |
| `name` | VARCHAR(100) | NOT NULL | Webhook name |
| `url` | VARCHAR(500) | NOT NULL | Webhook URL |
| `events` | TEXT[] | NOT NULL | Event types |
| `secret` | VARCHAR(255) | NOT NULL | Webhook secret |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `retry_count` | INTEGER | DEFAULT 3 | Max retries |
| `last_triggered_at` | TIMESTAMP | | Last trigger timestamp |
| `created_by` | UUID | | Creator identifier |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### webhook_deliveries

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `delivery_id` | UUID | PRIMARY KEY | Unique identifier |
| `webhook_id` | UUID | FOREIGN KEY (webhook_subscriptions.webhook_id) | Associated webhook |
| `event_type` | VARCHAR(50) | NOT NULL | Event type |
| `payload` | JSONB | NOT NULL | Webhook payload |
| `status` | VARCHAR(20) | DEFAULT 'PENDING' | PENDING/SUCCESS/FAILED/RETRYING |
| `response_code` | INTEGER | | HTTP response code |
| `response_body` | TEXT | | Response body |
| `attempt_count` | INTEGER | DEFAULT 0 | Attempt count |
| `next_retry_at` | TIMESTAMP | | Next retry timestamp |
| `completed_at` | TIMESTAMP | | Completion timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

---

## Chapter 15 – REST APIs

### Authentication APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/auth/oauth/token` | Get OAuth token |
| `POST` | `/auth/oauth/refresh` | Refresh OAuth token |
| `POST` | `/auth/oauth/revoke` | Revoke OAuth token |

### Customer APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/customers` | List customers |
| `GET` | `/customers/{id}` | Get customer details |
| `POST` | `/customers` | Create customer |
| `PUT` | `/customers/{id}` | Update customer |
| `PATCH` | `/customers/{id}` | Partial update customer |
| `DELETE` | `/customers/{id}` | Delete customer |
| `GET` | `/customers/{id}/orders` | Get customer orders |
| `GET` | `/customers/{id}/addresses` | Get customer addresses |
| `POST` | `/customers/{id}/addresses` | Add customer address |
| `PUT` | `/customers/{id}/addresses/{address_id}` | Update address |
| `DELETE` | `/customers/{id}/addresses/{address_id}` | Delete address |

### Merchant APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/merchants` | List merchants |
| `GET` | `/merchants/{id}` | Get merchant details |
| `POST` | `/merchants` | Create merchant |
| `PUT` | `/merchants/{id}` | Update merchant |
| `PATCH` | `/merchants/{id}` | Partial update merchant |
| `DELETE` | `/merchants/{id}` | Delete merchant |
| `GET` | `/merchants/{id}/orders` | Get merchant orders |
| `GET` | `/merchants/{id}/menu` | Get merchant menu |
| `POST` | `/merchants/{id}/menu/items` | Add menu item |
| `PUT` | `/merchants/{id}/menu/items/{item_id}` | Update menu item |
| `DELETE` | `/merchants/{id}/menu/items/{item_id}` | Delete menu item |
| `GET` | `/merchants/{id}/analytics` | Get merchant analytics |
| `GET` | `/merchants/{id}/settlements` | Get merchant settlements |

### Driver APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/drivers` | List drivers |
| `GET` | `/drivers/{id}` | Get driver details |
| `POST` | `/drivers` | Create driver |
| `PUT` | `/drivers/{id}` | Update driver |
| `PATCH` | `/drivers/{id}` | Partial update driver |
| `DELETE` | `/drivers/{id}` | Delete driver |
| `GET` | `/drivers/{id}/deliveries` | Get driver deliveries |
| `GET` | `/drivers/{id}/earnings` | Get driver earnings |
| `PUT` | `/drivers/{id}/location` | Update driver location |
| `GET` | `/drivers/{id}/status` | Get driver status |

### Order APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/orders` | List orders |
| `GET` | `/orders/{id}` | Get order details |
| `POST` | `/orders` | Create order |
| `PUT` | `/orders/{id}` | Update order |
| `PATCH` | `/orders/{id}` | Partial update order |
| `DELETE` | `/orders/{id}` | Cancel order |
| `GET` | `/orders/{id}/status` | Get order status |
| `GET` | `/orders/{id}/tracking` | Get order tracking |
| `POST` | `/orders/{id}/tracking` | Update tracking |
| `GET` | `/orders/{id}/timeline` | Get order timeline |

### Payment APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/payments` | List payments |
| `GET` | `/payments/{id}` | Get payment details |
| `POST` | `/payments` | Create payment |
| `POST` | `/payments/{id}/refund` | Refund payment |
| `GET` | `/payments/order/{id}` | Get payments for order |
| `GET` | `/payments/methods` | Get payment methods |
| `POST` | `/payments/methods` | Add payment method |
| `DELETE` | `/payments/methods/{id}` | Delete payment method |

### Delivery APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/deliveries` | List deliveries |
| `GET` | `/deliveries/{id}` | Get delivery details |
| `GET` | `/deliveries/{id}/tracking` | Get delivery tracking |
| `POST` | `/deliveries/{id}/tracking` | Update tracking |
| `POST` | `/deliveries/{id}/assign` | Assign driver |
| `POST` | `/deliveries/{id}/pickup` | Confirm pickup |
| `POST` | `/deliveries/{id}/deliver` | Confirm delivery |

### Webhook APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/webhooks` | List webhooks |
| `POST` | `/webhooks` | Create webhook |
| `GET` | `/webhooks/{id}` | Get webhook details |
| `PUT` | `/webhooks/{id}` | Update webhook |
| `DELETE` | `/webhooks/{id}` | Delete webhook |
| `POST` | `/webhooks/{id}/test` | Test webhook |
| `GET` | `/webhooks/{id}/deliveries` | Get webhook deliveries |
| `POST` | `/webhooks/{id}/retry` | Retry failed delivery |

### Analytics APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/analytics/orders` | Get order analytics |
| `GET` | `/analytics/revenue` | Get revenue analytics |
| `GET` | `/analytics/customers` | Get customer analytics |
| `GET` | `/analytics/merchants` | Get merchant analytics |
| `GET` | `/analytics/drivers` | Get driver analytics |
| `GET` | `/analytics/deliveries` | Get delivery analytics |

---

## Chapter 16 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-PUBAPI-001** | GET request to `/customers` returns list. | **High** |
| **TEST-PUBAPI-002** | GET request to `/customers/{id}` returns customer. | **High** |
| **TEST-PUBAPI-003** | POST request to `/customers` creates customer. | **High** |
| **TEST-PUBAPI-004** | PUT request to `/customers/{id}` updates customer. | **High** |
| **TEST-PUBAPI-005** | DELETE request to `/customers/{id}` deletes customer. | **High** |
| **TEST-PUBAPI-006** | GET request to `/merchants` returns list. | **High** |
| **TEST-PUBAPI-007** | GET request to `/merchants/{id}` returns merchant. | **High** |
| **TEST-PUBAPI-008** | GET request to `/orders` returns list. | **High** |
| **TEST-PUBAPI-009** | GET request to `/orders/{id}` returns order. | **High** |
| **TEST-PUBAPI-010** | POST request to `/orders` creates order. | **High** |
| **TEST-PUBAPI-011** | DELETE request to `/orders/{id}` cancels order. | **High** |
| **TEST-PUBAPI-012** | GET request to `/deliveries` returns list. | **High** |
| **TEST-PUBAPI-013** | GET request to `/deliveries/{id}` returns delivery. | **High** |
| **TEST-PUBAPI-014** | POST request to `/payments` creates payment. | **High** |
| **TEST-PUBAPI-015** | POST request to `/payments/{id}/refund` refunds payment. | **High** |
| **TEST-PUBAPI-016** | GET request to `/webhooks` returns list. | **High** |
| **TEST-PUBAPI-017** | POST request to `/webhooks` creates webhook. | **High** |
| **TEST-PUBAPI-018** | POST request to `/webhooks/{id}/test` tests webhook. | **High** |
| **TEST-PUBAPI-019** | Pagination works correctly (`page` and `per_page`). | **High** |
| **TEST-PUBAPI-020** | Filtering works correctly (`status`, `date_from`, `date_to`). | **High** |
| **TEST-PUBAPI-021** | Sorting works correctly (`sort_by`, `sort_order`). | **High** |
| **TEST-PUBAPI-022** | Field selection works correctly (`fields`). | **High** |
| **TEST-PUBAPI-023** | Error response format is consistent. | **High** |
| **TEST-PUBAPI-024** | Rate limiting enforced correctly. | **High** |
| **TEST-PUBAPI-025** | OAuth 2.1 authentication works correctly. | **High** |

---

## Chapter 17 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| PUBLICAPI-014 | customers | GET /api/v1/customers | TEST-PUBAPI-001 |
| PUBLICAPI-014 | customers | GET /api/v1/customers/{id} | TEST-PUBAPI-002 |
| PUBLICAPI-014 | customers | POST /api/v1/customers | TEST-PUBAPI-003 |
| PUBLICAPI-014 | customers | PUT /api/v1/customers/{id} | TEST-PUBAPI-004 |
| PUBLICAPI-014 | customers | DELETE /api/v1/customers/{id} | TEST-PUBAPI-005 |
| PUBLICAPI-016 | merchants | GET /api/v1/merchants | TEST-PUBAPI-006 |
| PUBLICAPI-016 | merchants | GET /api/v1/merchants/{id} | TEST-PUBAPI-007 |
| PUBLICAPI-020 | orders | GET /api/v1/orders | TEST-PUBAPI-008 |
| PUBLICAPI-020 | orders | GET /api/v1/orders/{id} | TEST-PUBAPI-009 |
| PUBLICAPI-020 | orders | POST /api/v1/orders | TEST-PUBAPI-010 |
| PUBLICAPI-020 | orders | DELETE /api/v1/orders/{id} | TEST-PUBAPI-011 |
| PUBLICAPI-024 | deliveries | GET /api/v1/deliveries | TEST-PUBAPI-012 |
| PUBLICAPI-024 | deliveries | GET /api/v1/deliveries/{id} | TEST-PUBAPI-013 |
| PUBLICAPI-022 | payments | POST /api/v1/payments | TEST-PUBAPI-014 |
| PUBLICAPI-022 | payments | POST /api/v1/payments/{id}/refund | TEST-PUBAPI-015 |
| PUBLICAPI-026 | webhook_subscriptions | GET /api/v1/webhooks | TEST-PUBAPI-016 |
| PUBLICAPI-026 | webhook_subscriptions | POST /api/v1/webhooks | TEST-PUBAPI-017 |
| PUBLICAPI-026 | webhook_deliveries | POST /api/v1/webhooks/{id}/test | TEST-PUBAPI-018 |
| PUBLICAPI-009 | api_keys | GET /api/v1/orders?page=2&per_page=20 | TEST-PUBAPI-019 |
| PUBLICAPI-011 | api_keys | GET /api/v1/orders?status=DELIVERED | TEST-PUBAPI-020 |
| PUBLICAPI-012 | api_keys | GET /api/v1/orders?sort_by=created_at&sort_order=desc | TEST-PUBAPI-021 |
| PUBLICAPI-013 | api_keys | GET /api/v1/orders?fields=id,status,total | TEST-PUBAPI-022 |
| PUBLICAPI-005 | api_usage_logs | GET /api/v1/orders/invalid | TEST-PUBAPI-023 |
| PUBLICAPI-011 | api_usage_logs | GET /api/v1/orders | TEST-PUBAPI-024 |
| PUBLICAPI-007 | api_keys | POST /api/v1/auth/oauth/token | TEST-PUBAPI-025 |

---

## Chapter 18 – Summary

This document establishes the complete public REST API specification for the **[Platform Name]** platform. Key takeaways:

- **Comprehensive API Coverage:** Customers, merchants, drivers, orders, payments, deliveries, webhooks, and analytics.
- **Consistent Standards:** Base URL, HTTP methods, status codes, response formats, and error handling.
- **Secure Authentication:** Bearer token, API key, and OAuth 2.1 with scope-based authorization.
- **Pagination:** Page-based pagination with configurable items per page (max 100).
- **Filtering & Sorting:** Flexible filtering by status, date, amount, and sorting by any field.
- **Field Selection:** Clients can request specific fields to reduce payload size.
- **Webhooks:** Event-driven notifications with retry logic and delivery tracking.
- **Idempotency:** Idempotency keys for safe retries of mutating operations.
- **Comprehensive Documentation:** OpenAPI/Swagger specification with interactive API explorer.

The public REST API module provides developers with a secure, consistent, and comprehensive interface to build applications on top of the platform.

---

**Next Document:**

`Part_13C_Internal_Services_API.md`

*(This builds on the public REST API to define internal service APIs.)*