# Software Architecture Document (SAD)

## Domain Model & Bounded Contexts

**Version:** 1.0.0
**Last Updated:** 2026-06-30

---

## Purpose

This document defines the domain model and bounded contexts for the **[Platform Name]** platform using Domain-Driven Design (DDD) principles. It serves as the foundational architecture document that establishes the boundaries of each business domain, their responsibilities, aggregates, entities, value objects, and the relationships between contexts.

By clearly defining bounded contexts, the platform ensures that each microservice has a well-defined scope, evolves independently, and maintains a ubiquitous language within its domain. This document guides the decomposition of the monolith into microservices and informs the design of APIs, event-driven communication, and data persistence strategies.

---

## Domain-Driven Design Overview

### Core Principles

| Principle | Description |
| :--- | :--- |
| **Ubiquitous Language** | A shared language between domain experts and developers, embedded in code and documentation. |
| **Bounded Context** | The boundary within which a domain model is defined and applies. Each context has its own ubiquitous language. |
| **Aggregate** | A cluster of domain objects treated as a single unit. Each aggregate has a root entity (Aggregate Root) that controls access. |
| **Entity** | An object with an identity that persists over time (e.g., Customer, Order). |
| **Value Object** | An object that describes a characteristic but has no identity (e.g., Address, Money). |
| **Domain Event** | A significant occurrence within the domain that other parts of the system may react to. |
| **Context Map** | A visual representation of the relationships and integration patterns between bounded contexts. |

### Strategic Design

| Pattern | Description |
| :--- | :--- |
| **Core Domain** | The primary business differentiator; the most important domain to invest in. |
| **Supporting Subdomain** | Important but not differentiating; can be built or bought. |
| **Generic Subdomain** | Commodity functionality; often purchased or outsourced. |
| **Partnership** | Two contexts collaborate closely, often with shared models. |
| **Shared Kernel** | A shared subset of the domain model between two contexts. |
| **Customer/Supplier** | One context provides services to another; upstream/downstream relationship. |
| **Conformist** | Downstream context conforms to the upstream's model. |
| **Anticorruption Layer** | A translation layer that protects the downstream context from upstream changes. |
| **Open Host Service** | Upstream context provides a well-documented API for downstream consumers. |
| **Published Language** | A shared data format (e.g., JSON schemas) used for integration. |

---

## Bounded Contexts Overview

### Context Map

```mermaid
flowchart TD
    subgraph "Core Domains"
        OC[Order Context]
        PC[Payment Context]
        DC[Delivery Context]
        DP[Dispatch Context]
        MC[Merchant Context]
        DR[Driver Context]
        CU[Customer Context]
    end
    
    subgraph "Supporting Domains"
        FC[Finance & Settlement Context]
        NC[Notification Context]
        AC[Admin & Operations Context]
        AN[Analytics Context]
        IC[Identity & Access Context]
        IG[Integration Gateway Context]
    end
    
    subgraph "External"
        PAY[Payment Gateways]
        MAP[Mapping Services]
        NOT[Notification Providers]
        ERP[ERP Systems]
        POS[POS Systems]
        CRM[CRM Systems]
        IDP[Identity Providers]
    end
    
    CU -->|"places"| OC
    MC -->|"fulfills"| OC
    DR -->|"executes"| DC
    OC -->|"requires"| PC
    OC -->|"initiates"| DC
    DC -->|"triggers"| DP
    DP -->|"assigns"| DR
    OC -->|"settles"| FC
    DR -->|"earns"| FC
    MC -->|"receives"| FC
    OC -->|"notifies"| NC
    DC -->|"notifies"| NC
    FC -->|"notifies"| NC
    IC -->|"authenticates"| CU
    IC -->|"authenticates"| MC
    IC -->|"authenticates"| DR
    IC -->|"authenticates"| OC
    AN -->|"analyses"| OC
    AN -->|"analyses"| PC
    AN -->|"analyses"| DC
    AN -->|"analyses"| FC
    AC -->|"manages"| MC
    AC -->|"manages"| DR
    AC -->|"manages"| CU
    AC -->|"configures"| OC
    AC -->|"configures"| DP
    IG -->|"integrates"| PAY
    IG -->|"integrates"| MAP
    IG -->|"integrates"| NOT
    IG -->|"integrates"| ERP
    IG -->|"integrates"| POS
    IG -->|"integrates"| CRM
    IC -->|"federates"| IDP
```

### Context Summary

| Context | Type | Priority | Description |
| :--- | :--- | :--- | :--- |
| **Customer Context** | Core | High | Manages customer identities, profiles, preferences, and loyalty. |
| **Merchant Context** | Core | High | Manages merchant onboarding, stores, menus, and inventory. |
| **Driver Context** | Core | High | Manages driver onboarding, availability, and performance. |
| **Order Context** | Core | High | Orchestrates the order lifecycle and fulfillment process. |
| **Payment Context** | Core | High | Processes payments, refunds, wallets, and subscriptions. |
| **Delivery Context** | Core | High | Manages delivery execution, tracking, and geofencing. |
| **Dispatch Context** | Core | High | Optimizes order routing, batching, and driver assignment. |
| **Finance Context** | Supporting | High | Handles settlements, invoicing, taxation, and reconciliation. |
| **Notification Context** | Supporting | High | Manages multi-channel communication delivery. |
| **Admin Context** | Supporting | High | Provides platform administration and configuration. |
| **Analytics Context** | Supporting | Medium | Collects and analyzes platform data for insights. |
| **Identity Context** | Supporting | High | Manages authentication, authorization, and SSO. |
| **Integration Context** | Supporting | High | Manages third-party integrations and adapters. |

---

## Bounded Contexts Detailed

### 1. Customer Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage customer identities, profiles, preferences, addresses, loyalty, and consent. |
| **Aggregate Root** | `Customer` |
| **Key Entities** | `Customer`, `CustomerAddress`, `CustomerSession`, `LoyaltyAccount`, `Wallet` |
| **Value Objects** | `Address`, `Money`, `Consent`, `NotificationPreferences` |
| **Domain Events** | `CustomerRegistered`, `CustomerUpdated`, `CustomerAddressAdded`, `CustomerAddressUpdated`, `CustomerAddressRemoved`, `CustomerDeactivated`, `CustomerDeletionRequested`, `LoyaltyPointsEarned`, `LoyaltyPointsRedeemed`, `LoyaltyTierChanged` |
| **Key Use Cases** | Registration, login, profile update, address management, loyalty program, consent management. |
| **Integration Patterns** | **Open Host Service** (public API for customer data). **Customer/Supplier** with Order Context (customers place orders). |
| **Ubiquitous Language** | Customer, Address, Loyalty Points, Tier, Referral, Consent, Wallet, Balance. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class Customer {
        +UUID id
        +String firstName
        +String lastName
        +String email
        +String phone
        +String passwordHash
        +String avatarUrl
        +Date dateOfBirth
        +String languagePreference
        +String currencyPreference
        +Boolean marketingConsent
        +Boolean pushEnabled
        +Boolean emailEnabled
        +Boolean smsEnabled
        +String status
        +Boolean mfaEnabled
        +Date lastLoginAt
        +Date createdAt
        +Date updatedAt
        +void updateProfile()
        +void changePassword()
        +void verifyEmail()
        +void deactivate()
        +void requestDeletion()
        +void addAddress()
        +void updateAddress()
        +void removeAddress()
        +void setDefaultAddress()
        +void updateConsent()
        +void updatePreferences()
    }
    class CustomerAddress {
        +UUID id
        +String label
        +String addressLine1
        +String addressLine2
        +String city
        +String state
        +String postalCode
        +String country
        +Decimal latitude
        +Decimal longitude
        +Boolean isDefault
        +String instructions
        +Date createdAt
        +Date updatedAt
    }
    class LoyaltyAccount {
        +UUID id
        +UUID customerId
        +Integer totalPointsEarned
        +Integer totalPointsRedeemed
        +Integer totalPointsExpired
        +Integer currentBalance
        +String currentTier
        +Date tierGracePeriodEnd
        +Integer tierProgressPoints
        +String referralCode
        +Integer referralCount
        +BigDecimal referralCreditsEarned
        +Integer challengesCompleted
        +Date lastActivityAt
        +Date createdAt
        +Date updatedAt
        +void earnPoints()
        +void redeemPoints()
        +void updateTier()
        +void issueReferral()
    }
    class Wallet {
        +UUID id
        +UUID customerId
        +BigDecimal balance
        +BigDecimal pendingBalance
        +BigDecimal totalCredited
        +BigDecimal totalDebited
        +String currency
        +Boolean autoTopUpEnabled
        +BigDecimal autoTopUpThreshold
        +BigDecimal autoTopUpAmount
        +String status
        +Date createdAt
        +Date updatedAt
        +void credit()
        +void debit()
        +void topUp()
        +void withdraw()
    }
    Customer "1" -- "0..*" CustomerAddress : has
    Customer "1" -- "1" LoyaltyAccount : has
    Customer "1" -- "1" Wallet : has
```

---

### 2. Merchant Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage merchant onboarding, store profiles, menus, catalog, and operational settings. |
| **Aggregate Root** | `MerchantAccount`, `Store` |
| **Key Entities** | `MerchantAccount`, `Store`, `MenuCategory`, `MenuItem`, `ModifierGroup`, `ModifierOption`, `InventoryItem` |
| **Value Objects** | `Address`, `OperatingHours`, `DeliveryZone`, `CommissionRate`, `SettlementSchedule` |
| **Domain Events** | `MerchantRegistered`, `MerchantApproved`, `MerchantSuspended`, `StoreCreated`, `StoreUpdated`, `MenuItemAdded`, `MenuItemUpdated`, `MenuItemRemoved`, `InventoryUpdated` |
| **Key Use Cases** | Registration, document verification, store setup, menu management, inventory management, operating hours configuration. |
| **Integration Patterns** | **Customer/Supplier** with Order Context (merchants fulfill orders). **Anticorruption Layer** with ERP/POS integrations. |
| **Ubiquitous Language** | Merchant, Store, Menu, Category, Item, Modifier, Inventory, Operating Hours, Delivery Zone, Commission. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class MerchantAccount {
        +UUID id
        +String businessLegalName
        +String businessTradingName
        +String businessRegistrationNumber
        +String taxId
        +String businessType
        +String businessCategory
        +String primaryCuisine
        +String segment
        +BigDecimal commissionRate
        +String settlementFrequency
        +Integer settlementDayOfWeek
        +BigDecimal minimumOrderValue
        +Integer deliveryRadius
        +Integer estimatedPrepTime
        +String status
        +JSON applicationData
        +Date verifiedAt
        +Date activatedAt
        +Date suspendedAt
        +String suspensionReason
        +Date createdAt
        +Date updatedAt
        +void approve()
        +void suspend()
        +void reactivate()
        +void updateCommissionRate()
        +void updateSettlementSchedule()
    }
    class Store {
        +UUID id
        +UUID merchantId
        +String storeName
        +String storeDescription
        +String storeCategory
        +String storeSubcategory
        +Address address
        +String storePhone
        +String storeEmail
        +String storeWebsite
        +String logoUrl
        +String coverImageUrl
        +String[] storeImages
        +OperatingHours operatingHours
        +Boolean isDeliveryEnabled
        +Boolean isPickupEnabled
        +Boolean isActive
        +Boolean isVerified
        +Date createdAt
        +Date updatedAt
        +void activate()
        +void deactivate()
        +void updateOperatingHours()
        +void updateStoreDetails()
    }
    class MenuItem {
        +UUID id
        +UUID storeId
        +UUID categoryId
        +String itemName
        +String itemDescription
        +String itemShortDescription
        +BigDecimal price
        +BigDecimal compareAtPrice
        +BigDecimal costPrice
        +String primaryImage
        +String[] galleryImages
        +String sku
        +String barcode
        +BigDecimal weight
        +Integer preparationTime
        +Boolean isAvailable
        +Boolean isFeatured
        +Boolean isBestSeller
        +Boolean isNew
        +String[] dietaryTags
        +String[] allergenTags
        +String portionSize
        +Integer calories
        +JSON nutritionFacts
        +String[] tags
        +String slug
        +Integer sortOrder
        +Integer minOrderQuantity
        +Integer maxOrderQuantity
        +Boolean allowZeroPrice
        +Date createdAt
        +Date updatedAt
        +Date lastOrderedAt
        +void updatePrice()
        +void toggleAvailability()
        +void addModifierGroup()
        +void updateModifierGroup()
        +void removeModifierGroup()
    }
    class ModifierGroup {
        +UUID id
        +UUID itemId
        +String groupName
        +String groupType
        +Integer minSelections
        +Integer maxSelections
        +Boolean isRequired
        +Integer displayOrder
        +Boolean isAvailable
        +Date createdAt
        +Date updatedAt
        +void addOption()
        +void updateOption()
        +void removeOption()
    }
    class InventoryItem {
        +UUID id
        +UUID itemId
        +UUID storeId
        +Integer currentStock
        +Integer minimumStock
        +Integer maximumStock
        +Integer reorderPoint
        +Integer reorderQuantity
        +String unitType
        +Date lastUpdated
        +UUID updatedBy
        +Date createdAt
        +Date updatedAt
        +void adjustStock()
        +void deductStock()
        +void replenishStock()
    }
    MerchantAccount "1" -- "0..*" Store : owns
    Store "1" -- "0..*" MenuItem : has
    MenuItem "1" -- "0..*" ModifierGroup : has
    MenuItem "1" -- "1" InventoryItem : has
```

---

### 3. Driver Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage driver onboarding, profiles, availability, vehicle management, and performance. |
| **Aggregate Root** | `DriverAccount` |
| **Key Entities** | `DriverAccount`, `DriverVehicle`, `DriverDocument`, `DriverSession`, `DriverRating` |
| **Value Objects** | `Location`, `VehicleType`, `Document` |
| **Domain Events** | `DriverRegistered`, `DriverApproved`, `DriverSuspended`, `DriverActivated`, `DriverLocationUpdated`, `DriverStatusChanged`, `DriverRatingUpdated` |
| **Key Use Cases** | Registration, document verification, training, online/offline status, location updates, performance tracking. |
| **Integration Patterns** | **Customer/Supplier** with Dispatch Context (drivers are assigned orders). **Open Host Service** for driver availability. |
| **Ubiquitous Language** | Driver, Vehicle, Availability, Online, Offline, Busy, Rating, Earnings, Payout, Shift. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class DriverAccount {
        +UUID id
        +String firstName
        +String lastName
        +Date dateOfBirth
        +String nationality
        +String email
        +String phone
        +String alternatePhone
        +Address residentialAddress
        +String[] languagesSpoken
        +String driverType
        +JSON availability
        +String status
        +BigDecimal rating
        +Integer totalDeliveries
        +Date activeSince
        +Date lastActiveAt
        +Date createdAt
        +Date updatedAt
        +void approve()
        +void suspend()
        +void reactivate()
        +void updateAvailability()
        +void updateLocation()
        +void updateRating()
    }
    class DriverVehicle {
        +UUID id
        +UUID driverId
        +String vehicleType
        +String vehicleMake
        +String vehicleModel
        +Integer vehicleYear
        +String vehicleColor
        +String licensePlate
        +String registrationNumber
        +Date registrationExpiry
        +String insuranceProvider
        +String insurancePolicyNumber
        +Date insuranceExpiry
        +Integer vehicleCapacity
        +Boolean hasInsulatedBag
        +Boolean hasHelmet
        +String[] vehiclePhotos
        +Boolean isActive
        +Date verifiedAt
        +Date createdAt
        +Date updatedAt
        +void updateVehicleDetails()
        +void verify()
        +void deactivate()
    }
    class DriverSession {
        +UUID id
        +UUID driverId
        +String sessionType
        +Date startTime
        +Date endTime
        +Integer duration
        +Date createdAt
        +Date updatedAt
        +void start()
        +void end()
        +void takeBreak()
        +void endBreak()
    }
    class DriverRating {
        +UUID id
        +UUID driverId
        +UUID deliveryId
        +UUID customerId
        +Integer rating
        +JSON categories
        +String feedback
        +Boolean isAnonymous
        +Boolean isFlagged
        +Date createdAt
        +Date updatedAt
        +void updateRating()
    }
    DriverAccount "1" -- "0..*" DriverVehicle : owns
    DriverAccount "1" -- "0..*" DriverSession : has
    DriverAccount "1" -- "0..*" DriverRating : receives
```

---

### 4. Order Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Orchestrate the order lifecycle from creation to delivery, managing state transitions, validation, and coordination with other contexts. |
| **Aggregate Root** | `Order` |
| **Key Entities** | `Order`, `OrderItem`, `OrderStatusHistory`, `OrderTimeline` |
| **Value Objects** | `OrderStatus`, `PaymentMethod`, `DeliveryAddress`, `Money`, `OrderItemModifier` |
| **Domain Events** | `OrderCreated`, `OrderConfirmed`, `OrderPreparationStarted`, `OrderReady`, `OrderAssigned`, `OrderPickedUp`, `OrderInTransit`, `OrderArrivingSoon`, `OrderDelivered`, `OrderCancelled`, `OrderFailed`, `OrderRefunded` |
| **Key Use Cases** | Place order, confirm order, start preparation, mark ready, assign driver, pickup, deliver, cancel, refund. |
| **Integration Patterns** | **Open Host Service** (public API). **Customer/Supplier** with Payment, Delivery, Dispatch, and Notification contexts. |
| **Ubiquitous Language** | Order, Order Status, Order Item, Modifier, Cart, Checkout, Timeline, Confirmation, Preparation, Readiness, Assignment, Pickup, Delivery. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class Order {
        +UUID id
        +UUID customerId
        +UUID merchantId
        +UUID storeId
        +UUID driverId
        +String orderReference
        +String status
        +JSON orderData
        +BigDecimal subtotal
        +BigDecimal deliveryFee
        +BigDecimal serviceFee
        +BigDecimal tax
        +BigDecimal discount
        +BigDecimal total
        +String currency
        +String paymentMethod
        +String paymentStatus
        +JSON deliveryAddress
        +String customerNotes
        +String internalNotes
        +Integer preparationTimeEstimate
        +Integer preparationTimeActual
        +Integer deliveryTimeEstimate
        +Integer deliveryTimeActual
        +Boolean isScheduled
        +Date scheduledTime
        +String idempotencyKey
        +String cancellationReason
        +String cancelledBy
        +Date cancelledAt
        +Date confirmedAt
        +Date preparingAt
        +Date readyAt
        +Date assignedAt
        +Date pickedUpAt
        +Date deliveredAt
        +Boolean isArchived
        +Date archivedAt
        +Date createdAt
        +Date updatedAt
        +void confirm()
        +void startPreparation()
        +void markReady()
        +void assignDriver()
        +void pickup()
        +void deliver()
        +void cancel()
        +void fail()
        +void refund()
        +void addTimelineEvent()
    }
    class OrderItem {
        +UUID id
        +UUID orderId
        +UUID itemId
        +String itemName
        +BigDecimal itemPrice
        +Integer quantity
        +BigDecimal subtotal
        +JSON modifiers
        +String specialInstructions
        +String status
        +Date createdAt
        +Date updatedAt
        +void updateStatus()
    }
    class OrderStatusHistory {
        +UUID id
        +UUID orderId
        +String status
        +String source
        +UUID sourceId
        +String reason
        +JSON metadata
        +Date createdAt
    }
    class OrderTimeline {
        +UUID id
        +UUID orderId
        +String eventType
        +String status
        +String description
        +String sourceType
        +UUID sourceId
        +JSON location
        +JSON metadata
        +Date createdAt
    }
    Order "1" -- "0..*" OrderItem : contains
    Order "1" -- "0..*" OrderStatusHistory : has
    Order "1" -- "0..*" OrderTimeline : has
```

---

### 5. Payment Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Process payments, refunds, wallet operations, and subscriptions. |
| **Aggregate Root** | `PaymentTransaction`, `Wallet`, `Subscription` |
| **Key Entities** | `PaymentTransaction`, `PaymentMethod`, `Wallet`, `WalletTransaction`, `Subscription`, `Invoice` |
| **Value Objects** | `Money`, `PaymentStatus`, `SubscriptionPlan`, `BillingCycle` |
| **Domain Events** | `PaymentAuthorized`, `PaymentCaptured`, `PaymentFailed`, `PaymentRefunded`, `WalletCredited`, `WalletDebited`, `SubscriptionCreated`, `SubscriptionUpdated`, `SubscriptionCancelled` |
| **Key Use Cases** | Authorize payment, capture payment, refund, wallet top-up, wallet payment, create subscription, cancel subscription. |
| **Integration Patterns** | **Anticorruption Layer** with payment gateway integrations. **Shared Kernel** (Money, Currency) with Finance Context. |
| **Ubiquitous Language** | Payment, Authorization, Capture, Refund, Wallet, Balance, Top-up, Subscription, Invoice, Gateway. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class PaymentTransaction {
        +UUID id
        +UUID orderId
        +UUID customerId
        +String gatewayName
        +String gatewayTransactionId
        +String transactionType
        +BigDecimal amount
        +String currency
        +String status
        +String paymentMethod
        +JSON paymentMethodDetails
        +String idempotencyKey
        +String errorCode
        +String errorMessage
        +Date createdAt
        +Date updatedAt
        +void authorize()
        +void capture()
        +void refund()
        +void voidTransaction()
        +void fail()
    }
    class PaymentMethod {
        +UUID id
        +UUID customerId
        +String methodType
        +String provider
        +String providerToken
        +String lastFour
        +String cardBrand
        +Integer expiryMonth
        +Integer expiryYear
        +String cardholderName
        +JSON billingAddress
        +Boolean isDefault
        +Boolean isActive
        +Date lastUsedAt
        +Date createdAt
        +Date updatedAt
        +void setDefault()
        +void deactivate()
        +void updateExpiry()
    }
    class Wallet {
        +UUID id
        +UUID customerId
        +BigDecimal balance
        +BigDecimal pendingBalance
        +BigDecimal totalCredited
        +BigDecimal totalDebited
        +String currency
        +Boolean autoTopUpEnabled
        +BigDecimal autoTopUpThreshold
        +BigDecimal autoTopUpAmount
        +String status
        +Date createdAt
        +Date updatedAt
        +void credit()
        +void debit()
        +void topUp()
        +void withdraw()
        +void enableAutoTopUp()
        +void disableAutoTopUp()
    }
    class Subscription {
        +UUID id
        +UUID customerId
        +UUID planId
        +UUID paymentMethodId
        +String status
        +Date startDate
        +Date trialEndDate
        +Date nextBillingDate
        +String billingCycle
        +BigDecimal price
        +String currency
        +Date cancellationEffectiveDate
        +String cancellationReason
        +Date pauseStartDate
        +Date pauseEndDate
        +Integer consecutiveFailures
        +JSON metadata
        +Date createdAt
        +Date updatedAt
        +void activate()
        +void pause()
        +void resume()
        +void cancel()
        +void retryPayment()
        +void upgrade()
        +void downgrade()
    }
    PaymentMethod "1" -- "0..*" PaymentTransaction : used_in
    Customer "1" -- "1" Wallet : has
    Customer "1" -- "0..*" Subscription : has
```

---

### 6. Delivery Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage delivery execution, real-time tracking, geofencing, and driver-customer communication. |
| **Aggregate Root** | `Delivery` |
| **Key Entities** | `Delivery`, `DeliveryLocationHistory`, `DeliveryCommunication` |
| **Value Objects** | `Location`, `DeliveryStatus`, `VerificationMethod` |
| **Domain Events** | `DeliveryAssigned`, `DeliveryPickedUp`, `DeliveryInTransit`, `DeliveryArrivingSoon`, `DeliveryCompleted`, `DeliveryFailed` |
| **Key Use Cases** | Assign driver, track location, confirm pickup, confirm delivery, handle exceptions, communicate with customer. |
| **Integration Patterns** | **Customer/Supplier** with Order and Dispatch Contexts. **Open Host Service** for real-time tracking. |
| **Ubiquitous Language** | Delivery, Driver, Tracking, GPS, Location, Geofence, ETA, Pickup, Dropoff, Verification, QR Code, OTP, Photo Proof. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class Delivery {
        +UUID id
        +UUID orderId
        +UUID driverId
        +String status
        +Date assignedAt
        +Date pickedUpAt
        +Date inTransitAt
        +Date arrivingSoonAt
        +Date deliveredAt
        +Date failedAt
        +String failureReason
        +String qrCode
        +String otpCode
        +String verificationMethod
        +String verificationStatus
        +Boolean customerContacted
        +String instructionsUsed
        +JSON routeData
        +BigDecimal totalDistance
        +Integer totalTime
        +Date createdAt
        +Date updatedAt
        +void assignDriver()
        +void pickup()
        +void transit()
        +void arrivingSoon()
        +void complete()
        +void fail()
        +void verifyDelivery()
        +void updateLocation()
    }
    class DeliveryLocationHistory {
        +UUID id
        +UUID deliveryId
        +BigDecimal latitude
        +BigDecimal longitude
        +BigDecimal accuracy
        +BigDecimal speed
        +BigDecimal heading
        +Date recordedAt
        +Date createdAt
    }
    class DeliveryCommunication {
        +UUID id
        +UUID deliveryId
        +String senderType
        +UUID senderId
        +String receiverType
        +UUID receiverId
        +String messageType
        +String messageContent
        +String contentUrl
        +Boolean isRead
        +Date readAt
        +Date createdAt
    }
    Delivery "1" -- "0..*" DeliveryLocationHistory : has
    Delivery "1" -- "0..*" DeliveryCommunication : has
```

---

### 7. Dispatch Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Optimize order routing, batch consolidation, and driver assignment algorithms. |
| **Aggregate Root** | `AssignmentQueue`, `BatchTrip` |
| **Key Entities** | `AssignmentQueue`, `AssignmentAttempt`, `BatchTrip`, `TripStop` |
| **Value Objects** | `CompositeScore`, `Route`, `ETA` |
| **Domain Events** | `OrderQueued`, `OrderOffered`, `OrderAccepted`, `OrderDeclined`, `OrderExpired`, `BatchCreated`, `BatchCompleted` |
| **Key Use Cases** | Queue orders, calculate composite scores, offer orders, accept/decline, batch orders, optimize routes, reassign orders. |
| **Integration Patterns** | **Customer/Supplier** with Order and Delivery Contexts. **Anticorruption Layer** with mapping services for routing. |
| **Ubiquitous Language** | Queue, Offer, Accept, Decline, Score, Batch, Trip, Route, Optimization, Reassignment, Surge Pricing. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class AssignmentQueue {
        +UUID id
        +UUID orderId
        +String priorityLevel
        +Integer attemptCount
        +Integer maxAttempts
        +String status
        +UUID[] offeredDriverIds
        +UUID[] declinedDriverIds
        +Date expiryTime
        +Date createdAt
        +Date updatedAt
        +void enqueue()
        +void offerToDriver()
        +void accept()
        +void decline()
        +void expire()
        +void reattempt()
    }
    class AssignmentAttempt {
        +UUID id
        +UUID orderId
        +UUID driverId
        +Integer attemptNumber
        +BigDecimal score
        +BigDecimal distance
        +Integer eta
        +String status
        +Integer responseTime
        +String declineReason
        +Date offeredAt
        +Date respondedAt
        +Date createdAt
    }
    class BatchTrip {
        +UUID id
        +UUID driverId
        +UUID[] orderIds
        +BigDecimal totalDistance
        +Integer totalTime
        +BigDecimal totalPayout
        +String routePolyline
        +String status
        +Date offeredAt
        +Date acceptedAt
        +Date completedAt
        +Date createdAt
        +Date updatedAt
        +void createBatch()
        +void optimizeRoute()
        +void acceptBatch()
        +void completeBatch()
    }
    class TripStop {
        +UUID id
        +UUID tripId
        +String stopType
        +UUID orderId
        +UUID referenceId
        +Integer sequenceNumber
        +BigDecimal latitude
        +BigDecimal longitude
        +String address
        +String name
        +Date estimatedArrival
        +Date actualArrival
        +Date estimatedDeparture
        +Date actualDeparture
        +String status
        +Date createdAt
        +Date updatedAt
    }
    AssignmentQueue "1" -- "0..*" AssignmentAttempt : has
    BatchTrip "1" -- "0..*" TripStop : has
```

---

### 8. Finance Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Calculate merchant settlements, driver payouts, commissions, fees, taxes, and reconciliation. |
| **Aggregate Root** | `Settlement`, `Invoice`, `Reconciliation` |
| **Key Entities** | `MerchantSettlement`, `DriverPayout`, `Invoice`, `Reconciliation`, `Adjustment` |
| **Value Objects** | `Money`, `CommissionRate`, `TaxRate`, `SettlementPeriod` |
| **Domain Events** | `SettlementCalculated`, `SettlementPaid`, `PayoutProcessed`, `InvoiceGenerated`, `ReconciliationCompleted` |
| **Key Use Cases** | Calculate merchant settlements, process driver payouts, generate invoices, reconcile with gateways, handle adjustments. |
| **Integration Patterns** | **Shared Kernel** (Money, Currency) with Payment Context. **Customer/Supplier** with Merchant, Driver, and Order Contexts. |
| **Ubiquitous Language** | Settlement, Payout, Commission, Fee, Tax, Invoice, Reconciliation, Adjustment, Gross Revenue, Net Revenue. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class MerchantSettlement {
        +UUID id
        +UUID merchantId
        +UUID storeId
        +Date periodStart
        +Date periodEnd
        +Integer orderCount
        +BigDecimal grossRevenue
        +BigDecimal totalCommission
        +BigDecimal totalServiceFee
        +BigDecimal totalDeliveryFeeRetained
        +BigDecimal totalPaymentFee
        +BigDecimal totalPromotions
        +BigDecimal totalAdjustments
        +BigDecimal totalTax
        +BigDecimal netAmount
        +String currency
        +String status
        +Date settlementDate
        +UUID payoutId
        +Date createdAt
        +Date updatedAt
        +void calculate()
        +void process()
        +void complete()
        +void fail()
        +void adjust()
    }
    class DriverPayout {
        +UUID id
        +UUID driverId
        +Date periodStart
        +Date periodEnd
        +BigDecimal totalEarnings
        +BigDecimal totalTips
        +BigDecimal totalBonuses
        +BigDecimal totalFees
        +BigDecimal totalAdjustments
        +BigDecimal netAmount
        +String currency
        +String payoutMethod
        +String payoutAccount
        +String referenceNumber
        +String transactionId
        +String status
        +String failureReason
        +Date initiatedAt
        +Date completedAt
        +Date createdAt
        +Date updatedAt
        +void calculate()
        +void process()
        +void complete()
        +void fail()
        +void retry()
    }
    class Invoice {
        +UUID id
        +UUID merchantId
        +UUID storeId
        +UUID settlementId
        +String invoiceNumber
        +Date invoiceDate
        +Date periodStart
        +Date periodEnd
        +Integer orderCount
        +BigDecimal grossRevenue
        +BigDecimal totalCommission
        +BigDecimal totalServiceFee
        +BigDecimal totalDeliveryFeeRetained
        +BigDecimal totalPaymentFee
        +BigDecimal totalPromotions
        +BigDecimal totalAdjustments
        +BigDecimal totalTax
        +BigDecimal netAmount
        +String currency
        +String payoutMethod
        +Date payoutDate
        +String paymentTerms
        +String invoiceUrl
        +String status
        +Date sentAt
        +Date viewedAt
        +Date paidAt
        +Date createdAt
        +Date updatedAt
        +void generate()
        +void send()
        +void markPaid()
        +void voidInvoice()
    }
    class Reconciliation {
        +UUID id
        +String reconciliationType
        +Date periodStart
        +Date periodEnd
        +Integer totalTransactions
        +Integer matchedCount
        +Integer unmatchedCount
        +Integer discrepancyCount
        +BigDecimal totalAmount
        +BigDecimal discrepancyAmount
        +String currency
        +String status
        +UUID reconciledBy
        +Date reconciledAt
        +String reportUrl
        +Date createdAt
        +Date updatedAt
        +void run()
        +void markReconciled()
        +void flagDiscrepancy()
    }
    Invoice "1" -- "1" MerchantSettlement : references
    DriverPayout "1" -- "0..*" DriverEarning : includes
```

---

### 9. Notification Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage multi-channel notification delivery (push, email, SMS, in-app, webhook). |
| **Aggregate Root** | `Notification`, `NotificationTemplate` |
| **Key Entities** | `Notification`, `NotificationTemplate`, `NotificationPreference`, `NotificationDelivery`, `WebhookSubscription` |
| **Value Objects** | `Channel`, `DeliveryStatus`, `NotificationType` |
| **Domain Events** | `NotificationQueued`, `NotificationSent`, `NotificationDelivered`, `NotificationOpened`, `NotificationClicked`, `NotificationFailed` |
| **Key Use Cases** | Send push, email, SMS, in-app, webhook notifications; manage templates; track delivery and engagement. |
| **Integration Patterns** | **Customer/Supplier** with all contexts. **Anticorruption Layer** with notification providers. |
| **Ubiquitous Language** | Notification, Push, Email, SMS, In-App, Webhook, Template, Channel, Delivery, Open, Click, Unsubscribe. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class Notification {
        +UUID id
        +UUID userId
        +String userType
        +String eventType
        +String channel
        +UUID templateId
        +String subject
        +String body
        +JSON data
        +String status
        +String providerReference
        +Integer retryCount
        +Date sentAt
        +Date deliveredAt
        +Date openedAt
        +Date clickedAt
        +Date failedAt
        +String errorMessage
        +JSON metadata
        +Date createdAt
        +Date updatedAt
        +void queue()
        +void send()
        +void deliver()
        +void open()
        +void click()
        +void fail()
        +void retry()
    }
    class NotificationTemplate {
        +UUID id
        +String templateName
        +String templateType
        +String eventType
        +String subject
        +String body
        +String bodyHtml
        +String language
        +JSON variables
        +Integer version
        +String status
        +UUID createdBy
        +Date createdAt
        +Date updatedAt
        +void create()
        +void update()
        +void activate()
        +void archive()
    }
    class NotificationPreference {
        +UUID id
        +UUID userId
        +String userType
        +Boolean channelPush
        +Boolean channelEmail
        +Boolean channelSms
        +Boolean channelInApp
        +Boolean orderNotifications
        +Boolean deliveryNotifications
        +Boolean paymentNotifications
        +Boolean promotionalNotifications
        +Boolean systemNotifications
        +Time quietHoursStart
        +Time quietHoursEnd
        +String timezone
        +String language
        +Date createdAt
        +Date updatedAt
        +void updatePreferences()
        +void setQuietHours()
    }
    class WebhookSubscription {
        +UUID id
        +String name
        +String url
        +String[] events
        +String secret
        +JSON headers
        +JSON payloadTemplate
        +JSON retryConfig
        +Integer rateLimit
        +Boolean isActive
        +Date lastTriggeredAt
        +UUID createdBy
        +Date createdAt
        +Date updatedAt
        +void createSubscription()
        +void updateSubscription()
        +void activate()
        +void deactivate()
        +void rotateSecret()
    }
    Notification "1" -- "1" NotificationTemplate : uses
    User "1" -- "1" NotificationPreference : has
```

---

### 10. Admin & Operations Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Provide platform administration, user management, configuration, content management, and operational oversight. |
| **Aggregate Root** | `AdminUser`, `PlatformConfiguration`, `AuditLog` |
| **Key Entities** | `AdminUser`, `PlatformConfiguration`, `AuditLog`, `SupportTicket`, `ContentItem`, `Campaign` |
| **Value Objects** | `Permission`, `Role`, `ConfigurationKey` |
| **Domain Events** | `AdminUserCreated`, `AdminUserUpdated`, `ConfigurationChanged`, `AuditEventLogged`, `SupportTicketCreated`, `SupportTicketResolved` |
| **Key Use Cases** | Admin login, user management, configuration update, audit log query, support ticket management, content publishing. |
| **Integration Patterns** | **Open Host Service** (admin API). **Conformist** with other contexts for read-only operations. |
| **Ubiquitous Language** | Admin, User, Role, Permission, Configuration, Audit Log, Support Ticket, Content, Campaign, Promotion. |

**Aggregate Diagram:**

```mermaid
classDiagram
    class AdminUser {
        +UUID id
        +String email
        +String passwordHash
        +String firstName
        +String lastName
        +String role
        +String[] permissions
        +Boolean isActive
        +Boolean mfaEnabled
        +Date lastLogin
        +Date createdAt
        +Date updatedAt
        +void create()
        +void update()
        +void deactivate()
        +void changePassword()
        +void updateRole()
        +void updatePermissions()
    }
    class PlatformConfiguration {
        +UUID id
        +String configKey
        +JSON configValue
        +String configType
        +UUID referenceId
        +Boolean isActive
        +Date createdAt
        +Date updatedAt
        +void set()
        +void get()
        +void update()
        +void activate()
        +void deactivate()
    }
    class AuditLog {
        +UUID id
        +UUID userId
        +String actionType
        +String actionDescription
        +String ipAddress
        +String userAgent
        +JSON metadata
        +Date createdAt
        +void log()
    }
    class SupportTicket {
        +UUID id
        +UUID customerId
        +UUID orderId
        +String ticketType
        +String priority
        +String status
        +String subject
        +String description
        +UUID assignedTo
        +UUID assignedQueue
        +UUID createdBy
        +UUID resolvedBy
        +UUID closedBy
        +String resolution
        +Integer satisfactionScore
        +String satisfactionComment
        +Date createdAt
        +Date updatedAt
        +Date resolvedAt
        +Date closedAt
        +void create()
        +void assign()
        +void resolve()
        +void close()
        +void escalate()
        +void addMessage()
    }
    class ContentItem {
        +UUID id
        +String contentType
        +String title
        +String description
        +String status
        +Integer version
        +String language
        +JSON contentData
        +UUID createdBy
        +UUID updatedBy
        +Date publishedAt
        +Date expiresAt
        +JSON targetAudience
        +JSON metadata
        +Date createdAt
        +Date updatedAt
        +void create()
        +void update()
        +void publish()
        +void archive()
        +void schedule()
    }
```

---

### 11. Analytics Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Collect, process, and analyze platform data for business intelligence, reporting, and predictive analytics. |
| **Aggregate Root** | `AnalyticsReport`, `Dashboard` |
| **Key Entities** | `AnalyticsReport`, `Dashboard`, `KPI`, `Prediction`, `Metric` |
| **Value Objects** | `MetricValue`, `TimePeriod`, `Aggregation` |
| **Domain Events** | `DataIngested`, `ReportGenerated`, `ForecastUpdated`, `AnomalyDetected` |
| **Key Use Cases** | Generate reports, update dashboards, calculate KPIs, run predictive models, detect anomalies. |
| **Integration Patterns** | **Customer/Supplier** with all contexts (data sources). **Open Host Service** for analytics API. |
| **Ubiquitous Language** | Report, Dashboard, KPI, Metric, Trend, Forecast, Anomaly, Prediction, Cohort, Retention, Churn, LTV. |

---

### 12. Identity & Access Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage authentication, authorization, Single Sign-On (SSO), and identity federation. |
| **Aggregate Root** | `User`, `IdentityProvider` |
| **Key Entities** | `User`, `UserRole`, `UserSession`, `IdentityProvider`, `MfaSetting`, `ApiKey` |
| **Value Objects** | `Token`, `Permission`, `Scope`, `Claim` |
| **Domain Events** | `UserLoggedIn`, `UserLoggedOut`, `PasswordChanged`, `MfaEnabled`, `MfaVerified`, `TokenRevoked` |
| **Key Use Cases** | Login, logout, password reset, MFA enrollment, SSO login, token refresh, API key management. |
| **Integration Patterns** | **Open Host Service** (authentication API). **Anticorruption Layer** with identity providers (Okta, Azure AD). |
| **Ubiquitous Language** | User, Authentication, Authorization, JWT, Refresh Token, MFA, SSO, SAML, OIDC, SCIM, Role, Permission, Scope. |

---

### 13. Integration Gateway Context

| Attribute | Description |
| :--- | :--- |
| **Responsibility** | Manage third-party integrations, adapters, and data synchronization with external systems (ERP, POS, CRM, payment gateways, mapping services, notification providers). |
| **Aggregate Root** | `IntegrationConnection`, `SyncJob` |
| **Key Entities** | `IntegrationConnection`, `SyncJob`, `DataMapping`, `ProviderConfiguration` |
| **Value Objects** | `ConnectionStatus`, `SyncFrequency`, `MappingRule` |
| **Domain Events** | `ConnectionEstablished`, `SyncStarted`, `SyncCompleted`, `SyncFailed`, `DataMapped` |
| **Key Use Cases** | Configure integrations, run sync jobs, map data fields, monitor connection health, handle errors. |
| **Integration Patterns** | **Anticorruption Layer** for each external system. **Open Host Service** for internal APIs. |
| **Ubiquitous Language** | Integration, Connection, Sync, Mapping, Provider, Adapter, Webhook, Batch, Real-Time, Fallback. |

---

## Context Maps

### Context Relationship Matrix

| Context | Customer | Merchant | Driver | Order | Payment | Delivery | Dispatch | Finance | Notification | Admin | Analytics | Identity | Integration |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Customer** | - | - | - | OHS | - | - | - | - | - | - | - | C/S | - |
| **Merchant** | - | - | - | C/S | - | - | - | - | - | - | - | - | ACL |
| **Driver** | - | - | - | - | - | C/S | - | - | - | - | - | - | - |
| **Order** | C/S | C/S | - | - | C/S | C/S | C/S | - | C/S | - | - | - | - |
| **Payment** | - | - | - | C/S | - | - | - | ACL | - | - | - | - | ACL |
| **Delivery** | - | - | C/S | C/S | - | - | C/S | - | C/S | - | - | - | ACL |
| **Dispatch** | - | - | - | C/S | - | C/S | - | - | - | - | - | - | ACL |
| **Finance** | - | C/S | C/S | - | - | - | - | - | C/S | - | - | - | ACL |
| **Notification** | - | - | - | C/S | - | C/S | - | C/S | - | - | - | - | ACL |
| **Admin** | - | C/S | C/S | - | - | - | - | - | - | - | - | - | - |
| **Analytics** | - | - | - | - | - | - | - | - | - | - | - | - | - |
| **Identity** | - | - | - | - | - | - | - | - | - | - | - | - | - |
| **Integration** | - | ACL | ACL | - | ACL | ACL | ACL | ACL | ACL | - | - | - | - |

**Legend:**
- **OHS** = Open Host Service
- **C/S** = Customer/Supplier
- **ACL** = Anticorruption Layer
- **SK** = Shared Kernel
- **P** = Partnership

---

## Event Catalog Summary

| Event | Source Context | Consumers |
| :--- | :--- | :--- |
| `CustomerRegistered` | Customer | Order, Notification, Analytics, Identity |
| `CustomerUpdated` | Customer | Order, Notification, Analytics |
| `OrderCreated` | Order | Payment, Delivery, Dispatch, Notification, Analytics, Finance |
| `OrderConfirmed` | Order | Notification, Analytics, Merchant |
| `OrderPrepared` | Order | Notification, Analytics, Delivery |
| `OrderReady` | Order | Dispatch, Notification, Analytics |
| `OrderAssigned` | Dispatch | Order, Delivery, Notification |
| `OrderPickedUp` | Delivery | Order, Notification, Analytics |
| `OrderInTransit` | Delivery | Order, Notification, Analytics, Customer |
| `OrderDelivered` | Delivery | Order, Payment, Finance, Notification, Analytics, Merchant |
| `OrderCancelled` | Order | Payment, Delivery, Notification, Analytics, Finance |
| `PaymentAuthorized` | Payment | Order, Notification, Analytics |
| `PaymentCaptured` | Payment | Order, Finance, Notification, Analytics |
| `PaymentFailed` | Payment | Order, Notification, Analytics |
| `PaymentRefunded` | Payment | Order, Finance, Notification, Analytics |
| `SettlementCalculated` | Finance | Merchant, Notification, Analytics |
| `SettlementPaid` | Finance | Merchant, Notification, Analytics |
| `DriverPayoutProcessed` | Finance | Driver, Notification, Analytics |
| `DeliveryAssigned` | Dispatch | Order, Delivery, Notification |
| `DeliveryCompleted` | Delivery | Order, Finance, Notification, Analytics |
| `WalletCredited` | Payment | Customer, Notification, Analytics |
| `WalletDebited` | Payment | Customer, Notification, Analytics |
| `SubscriptionCreated` | Payment | Customer, Notification, Analytics |
| `SubscriptionCancelled` | Payment | Customer, Notification, Analytics |

---

## Architectural Decisions

### Key Decisions

| Decision | Rationale | Consequences |
| :--- | :--- | :--- |
| **Bounded Context Decomposition** | Separated by business capabilities to enable independent evolution and deployment. | Increased complexity in inter-context communication; need for robust event-driven architecture. |
| **Order Context as Orchestrator** | Order is the central flow; it coordinates payment, delivery, and dispatch. | Order service becomes a critical point; must handle failures gracefully. |
| **Event-Driven Communication** | Loose coupling and eventual consistency between contexts. | Requires Kafka; handling eventual consistency and idempotency. |
| **Shared Kernel (Money, Currency)** | Finance and Payment contexts share a common value object for monetary amounts. | Reduces duplication; requires careful versioning of the shared kernel. |
| **Anticorruption Layer for Integrations** | Protects internal domains from external system changes (payment gateways, ERP, POS). | Adds translation overhead; isolates impact of external changes. |
| **Open Host Service for Public APIs** | Well-defined, versioned APIs for external developers and partners. | Increases API surface; requires strong documentation and governance. |

---

## Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-06-30 | [Author] | Initial domain model and bounded contexts documentation |

---

**Next Document:**

`Event_Catalog.md`

*(This continues the architecture design documentation with a detailed event catalog.)*