# Software Architecture Document (SAD)

## Domain Model & Bounded Contexts

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document defines the domain model and bounded contexts for the **Nexus** platform using Domain-Driven Design (DDD) principles.

---

## 2. Bounded Contexts Summary

| Context | Responsibility | Core Domain? |
| :--- | :--- | :--- |
| **Customer** | Identity, profile, addresses, loyalty, wallet | Yes |
| **Merchant** | Onboarding, stores, menus, inventory | Yes |
| **Driver** | Onboarding, vehicles, availability, location | Yes |
| **Order** | Lifecycle orchestration, cart, validation | Yes |
| **Payment** | Authorization, capture, refund, subscriptions | Yes |
| **Delivery** | Execution, tracking, geofencing | Yes |
| **Dispatch** | Routing, assignment, batching | Yes |
| **Finance** | Settlements, payouts, invoices, taxes | No |
| **Notification** | Multi-channel messaging | No |
| **Admin** | Operations, content, support, analytics | No |
| **Analytics** | Business intelligence, reporting | No |
| **Identity** | Authentication, authorization, SSO | No |
| **Integration** | Third-party APIs, data sync | No |

---

## 3. Customer Context

**Aggregate Root:** Customer

**Entities:**
- `Customer` (id, firstName, lastName, email, phone, status)
- `CustomerAddress` (id, label, address, coordinates)
- `LoyaltyAccount` (id, points, tier)
- `Wallet` (id, balance)

**Value Objects:**
- `Address`, `Money`, `Consent`

**Domain Events:**
- `CustomerRegistered`, `CustomerUpdated`, `LoyaltyPointsEarned`, `WalletCredited`

---

## 4. Merchant Context

**Aggregate Root:** MerchantAccount / Store

**Entities:**
- `MerchantAccount` (id, legalName, taxId, status)
- `Store` (id, name, address, operatingHours)
- `MenuItem` (id, name, description, price)
- `ModifierGroup` (id, name, options)
- `InventoryItem` (id, stockLevel)

**Value Objects:**
- `Address`, `OperatingHours`, `Money`

**Domain Events:**
- `MerchantRegistered`, `StoreCreated`, `MenuItemAdded`, `InventoryUpdated`

---

## 5. Driver Context

**Aggregate Root:** DriverAccount

**Entities:**
- `DriverAccount` (id, name, phone, status)
- `DriverVehicle` (id, type, plate, insurance)
- `DriverSession` (id, status, location)
- `DriverRating` (id, score, feedback)

**Value Objects:**
- `Location`, `VehicleType`

**Domain Events:**
- `DriverRegistered`, `DriverStatusChanged`, `DriverLocationUpdated`

---

## 6. Order Context

**Aggregate Root:** Order

**Entities:**
- `Order` (id, status, items, total, timeline)
- `OrderItem` (id, itemId, quantity, modifiers)

**Value Objects:**
- `OrderStatus`, `Money`, `DeliveryAddress`

**Domain Events:**
- `OrderCreated`, `OrderConfirmed`, `OrderPrepared`, `OrderPickedUp`, `OrderDelivered`, `OrderCancelled`

---

## 7. Payment Context

**Aggregate Root:** PaymentTransaction

**Entities:**
- `PaymentTransaction` (id, amount, status, gatewayId)
- `PaymentMethod` (id, type, token, lastFour)

**Value Objects:**
- `Money`, `PaymentStatus`

**Domain Events:**
- `PaymentAuthorized`, `PaymentCaptured`, `PaymentRefunded`, `PaymentFailed`

---

## 8. Delivery Context

**Aggregate Root:** Delivery

**Entities:**
- `Delivery` (id, orderId, driverId, status, route)
- `DeliveryLocationHistory` (id, coordinates, timestamp)

**Value Objects:**
- `Location`, `DeliveryStatus`

**Domain Events:**
- `DeliveryAssigned`, `DeliveryPickedUp`, `DeliveryInTransit`, `DeliveryCompleted`, `DeliveryFailed`

---

## 9. Dispatch Context

**Aggregate Root:** AssignmentQueue

**Entities:**
- `AssignmentQueue` (id, orderId, priority)
- `BatchTrip` (id, orderIds, driverId, route)

**Value Objects:**
- `CompositeScore`, `Route`

**Domain Events:**
- `OrderQueued`, `OrderOffered`, `OrderAccepted`, `BatchCreated`

---

## 10. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial domain model |