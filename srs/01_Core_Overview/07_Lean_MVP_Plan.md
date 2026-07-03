# Lean MVP Plan

**Module:** Core Overview
**Version:** 1.0.0
**Status:** Draft
**Date:** 2026-07-01

---

## 1. Goal

Build the smallest useful end-to-end flow from the SRS that delivers a working customer order experience through merchant acceptance and admin visibility.

### First milestone

The first milestone is: **A customer can create an order, a merchant can accept it, and an admin can view its status.**

---

## 2. MVP Scope

### Boundaries
- One city
- One merchant type
- One order type
- One payment method
- Basic delivery status updates only
- No driver app, no real routing, no advanced payments

### Included
- Customer signup and login
- Customer product browsing and cart
- Checkout with a mock payment confirmation
- Order creation and status lifecycle
- Merchant dashboard to accept/reject orders
- Admin order status dashboard
- Basic roles and authorization

### Excluded for MVP
- Loyalty, recommendations, subscriptions
- Multi-merchant / multi-vendor routing
- Advanced analytics, AI dispatch
- Full payment gateway integration
- Driver assignment and driver mobile app
- Complex tax/compliance handling

---

## 3. Lean User Stories

### Customer
- As a customer, I want to sign up so I can place orders.
- As a customer, I want to browse available products so I can decide what to order.
- As a customer, I want to place an order with a payment stub so I can complete checkout.
- As a customer, I want to see my order status so I know if it is accepted and being prepared.

### Merchant
- As a merchant, I want to see new incoming orders so I can accept or reject them.
- As a merchant, I want to update order status so the customer and admin can see progress.

### Admin
- As an admin, I want to view order status and key order metadata so I can monitor live operations.

---

## 4. Core Backend Components

- Authentication and user roles
- Product catalog and categories
- Cart and checkout flow
- Order model and lifecycle status
- Merchant order intake and status updates
- Admin order listing and filtering
- Basic API endpoints for frontend consumption

---

## 5. Minimum Frontend Deliverables

- Customer app/web page with:
  - signup/login
  - product browsing
  - cart and checkout
  - order status screen
- Merchant dashboard with:
  - incoming order queue
  - order accept/reject
  - order status update controls
- Admin panel with:
  - order list
  - order details
  - status filters

---

## 6. Payment Stub Strategy

Use a mock payment flow for MVP:
- Single payment method only
- Payment is confirmed by a simulated success response
- No external gateway integration
- Collect minimal transaction metadata for order records

---

## 7. Recommended Development Phases

| Phase | Goal | Deliverable |
| :--- | :--- | :--- |
| 1 | Scope and planning | MVP requirements, key user stories, acceptance criteria |
| 2 | Foundation | Project setup, database schema, auth, roles |
| 3 | Core commerce | Product catalog, cart, checkout, order creation |
| 4 | Operations | Merchant acceptance/rejection, order status updates |
| 5 | Launch | Admin view, end-to-end testing, deployment |

---

## 8. Success Criteria

- Customer can create an order end to end
- Merchant can accept or reject orders
- Order status is visible to customer and admin
- Core APIs and role permissions work correctly
- MVP can be deployed and validated in one city

---

## 9. Next Step

Once this first slice is stable, expand in the next iteration to:
- add delivery assignment and driver status
- support a second merchant type or order vertical
- integrate a real payment provider
- add notifications and tracking
