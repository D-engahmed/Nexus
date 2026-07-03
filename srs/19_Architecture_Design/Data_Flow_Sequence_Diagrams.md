# Software Architecture Document (SAD)

## Data Flow & Sequence Diagrams

**Version:** 1.0.0
**Last Updated:** 2026-06-30

---

## Purpose

This document provides a comprehensive view of the data flows and interaction sequences between services for the **[Platform Name]** platform. It illustrates how data moves through the system, how services collaborate to fulfill business processes, and the communication patterns used (synchronous vs. asynchronous). These diagrams serve as the blueprint for implementing service interactions, ensuring consistency and clarity across the engineering team.

---

## Data Flow Patterns Overview

| Pattern | Description | Protocols | Use Cases |
| :--- | :--- | :--- | :--- |
| **Synchronous Request-Response** | Direct service-to-service calls with immediate response. | gRPC, HTTP/REST | Order validation, payment authorization, user authentication |
| **Asynchronous Event-Driven** | Services publish events to a message broker; consumers react asynchronously. | Kafka | Order lifecycle, notifications, analytics, eventual consistency |
| **Batch Processing** | Scheduled or on-demand processing of large data sets. | ETL, SQL | Financial reconciliation, settlement calculations, reporting |
| **Real-Time Streaming** | Continuous data streams for real-time updates. | WebSocket, SSE, Kafka | GPS tracking, live order updates, driver location |

---

## Key Workflow Sequence Diagrams

### 1. Order Placement Flow

```mermaid
sequenceDiagram
    participant Client as Customer App
    participant GW as API Gateway
    participant Auth as Auth Service
    participant Order as Order Service
    participant Merch as Merchant Service
    participant Pay as Payment Service
    participant Disp as Dispatch Service
    participant Notif as Notification Service
    participant Kafka as Kafka (Event Bus)
    participant DB as Database

    Client->>GW: POST /orders (Place Order)
    GW->>Auth: Validate JWT
    Auth-->>GW: OK
    GW->>Order: Forward Request

    Order->>Merch: Validate Merchant & Items (synchronous)
    Merch-->>Order: OK (merchant open, items available)

    Order->>Order: Create Order (PENDING)
    Order->>DB: Insert Order

    Order->>Pay: Authorize Payment (synchronous)
    Pay->>Pay: Process Payment Authorization
    Pay-->>Order: Authorization Success

    Order->>Order: Update Order Status (CONFIRMED)
    Order->>DB: Update Order

    Order->>Kafka: Publish OrderCreated Event
    Order->>Notif: Send Confirmation (synchronous)
    Notif-->>Order: OK

    Order-->>GW: Order Confirmed
    GW-->>Client: Order Created (201)

    Kafka-->>Disp: OrderCreated Event (async)
    Disp->>Disp: Queue Order for Assignment
    Disp->>DB: Insert Assignment Queue

    Kafka-->>Analytics: OrderCreated Event (async)
    Analytics->>Analytics: Ingest for Analysis
```

### 2. Payment Authorization & Capture Flow

```mermaid
sequenceDiagram
    participant Order as Order Service
    participant Pay as Payment Service
    participant GW as Payment Gateway
    participant Kafka as Kafka (Event Bus)
    participant Notif as Notification Service
    participant Fin as Finance Service

    Order->>Pay: Authorize Payment (synchronous)
    Pay->>Pay: Validate Request
    Pay->>GW: PaymentIntent.create (Stripe/Adyen)
    GW-->>Pay: Authorization Response

    alt Authorization Success
        Pay->>Pay: Record Authorization
        Pay-->>Order: Success
        Order->>Order: Update Order Status (CONFIRMED)
        Order->>Kafka: Publish PaymentAuthorized Event
        Pay->>Kafka: Publish PaymentAuthorized Event
    else Authorization Failure
        Pay-->>Order: Failure
        Order->>Order: Update Order Status (FAILED)
        Order->>Kafka: Publish PaymentFailed Event
        Pay->>Kafka: Publish PaymentFailed Event
        Order->>Notif: Send Payment Failure Notification
    end

    Note over Order, Kafka: Later, after delivery...

    Order->>Pay: Capture Payment (synchronous)
    Pay->>Pay: Validate Capture
    Pay->>GW: PaymentIntent.capture
    GW-->>Pay: Capture Response

    alt Capture Success
        Pay->>Pay: Record Capture
        Pay-->>Order: Success
        Order->>Order: Update Order Status (DELIVERED)
        Order->>Kafka: Publish OrderDelivered Event
        Pay->>Kafka: Publish PaymentCaptured Event
        Pay->>Fin: Trigger Settlement (event)
        Pay->>Notif: Send Payment Confirmation
    else Capture Failure
        Pay-->>Order: Failure
        Order->>Order: Handle Capture Failure
        Order->>Kafka: Publish CaptureFailed Event
    end
```

### 3. Delivery Execution Flow

```mermaid
sequenceDiagram
    participant Order as Order Service
    participant Disp as Dispatch Service
    participant Driver as Driver App
    participant Deliv as Delivery Service
    participant Kafka as Kafka (Event Bus)
    participant Notif as Notification Service
    participant Map as Mapping Service

    Note over Order, Kafka: Order is READY and assigned

    Order->>Kafka: Publish OrderReady Event
    Kafka-->>Disp: OrderReady Event (async)
    Disp->>Disp: Find Available Driver
    Disp->>Map: Get Distance Matrix (synchronous)
    Map-->>Disp: Distance/ETA

    Disp->>Disp: Calculate Composite Score
    Disp->>Driver: Offer Order (via WebSocket)
    Driver-->>Disp: Accept/Decline

    alt Driver Accepts
        Disp->>Kafka: Publish OrderAccepted Event
        Disp->>Deliv: Create Delivery (synchronous)
        Deliv->>Deliv: Create Delivery Record
        Deliv->>Kafka: Publish DeliveryAssigned Event
        Deliv->>Notif: Notify Driver & Customer
        Deliv->>Driver: Send Route (synchronous)
        Driver-->>Deliv: Route Received

        loop GPS Location Updates
            Driver->>Deliv: WebSocket Location Update
            Deliv->>Deliv: Update Location
            Deliv->>Kafka: Publish LocationUpdated Event
            Deliv->>Map: Get ETA Update (synchronous)
            Map-->>Deliv: New ETA
            Deliv->>Notif: Push ETA Update to Customer
        end

        Driver->>Deliv: Confirm Pickup
        Deliv->>Deliv: Update Status (PICKED_UP)
        Deliv->>Kafka: Publish DeliveryPickedUp Event
        Deliv->>Notif: Notify Customer

        Driver->>Deliv: Confirm Delivery
        Deliv->>Deliv: Update Status (DELIVERED)
        Deliv->>Order: Notify Order Completion (sync)
        Order->>Order: Update Order Status (DELIVERED)
        Order->>Kafka: Publish OrderDelivered Event
        Deliv->>Kafka: Publish DeliveryCompleted Event
        Deliv->>Notif: Notify Customer & Merchant

    else Driver Declines
        Disp->>Disp: Re-offer to Next Driver
    end
```

### 4. Merchant Settlement Flow

```mermaid
sequenceDiagram
    participant Order as Order Service
    participant Pay as Payment Service
    participant Fin as Finance Service
    participant Kafka as Kafka (Event Bus)
    participant Merchant as Merchant Service
    participant Notif as Notification Service
    participant Bank as Banking Partner
    participant DB as Database

    Note over Order, Kafka: Order is DELIVERED

    Order->>Kafka: Publish OrderDelivered Event
    Kafka-->>Fin: OrderDelivered Event (async)

    Fin->>Fin: Calculate Settlement (period end)
    Fin->>DB: Store Settlement Record

    Fin->>Kafka: Publish SettlementCalculated Event
    Kafka-->>Merchant: SettlementCalculated Event (async)
    Merchant->>Merchant: Update Merchant Financial Dashboard

    Fin->>Notif: Send Settlement Notification
    Notif->>Merchant: Email/SMS Settlement Report

    Note over Fin, Bank: Payout Processing (scheduled)

    Fin->>Fin: Process Payout Batch
    Fin->>Bank: Initiate Bank Transfer
    Bank-->>Fin: Transfer Status

    alt Transfer Success
        Fin->>DB: Update Settlement Status (PAID)
        Fin->>Kafka: Publish SettlementPaid Event
        Fin->>Notif: Send Payment Confirmation
        Notif->>Merchant: Payout Notification
    else Transfer Failure
        Fin->>DB: Update Settlement Status (FAILED)
        Fin->>Kafka: Publish SettlementFailed Event
        Fin->>Notif: Send Failure Alert
        Notif->>Admin: Escalate to Operations
    end
```

### 5. Driver Payout Flow

```mermaid
sequenceDiagram
    participant Driver as Driver App
    participant Deliv as Delivery Service
    participant Fin as Finance Service
    participant Kafka as Kafka (Event Bus)
    participant Notif as Notification Service
    participant Bank as Banking Partner
    participant DB as Database

    Note over Driver, Kafka: Driver completes deliveries

    Deliv->>Kafka: Publish DeliveryCompleted Event
    Kafka-->>Fin: DeliveryCompleted Event (async)

    Fin->>Fin: Calculate Driver Earnings (period end)
    Fin->>DB: Store Earnings Record

    Fin->>Kafka: Publish PayoutCalculated Event
    Fin->>Notif: Send Earnings Notification
    Notif->>Driver: Push/Email Earnings Summary

    Note over Driver, Fin: Instant Payout Request (optional)

    Driver->>Fin: Request Instant Payout
    Fin->>Fin: Validate Request
    Fin->>Bank: Initiate Instant Transfer
    Bank-->>Fin: Transfer Status

    alt Transfer Success
        Fin->>DB: Update Payout Status (PAID)
        Fin->>Kafka: Publish PayoutProcessed Event
        Fin->>Notif: Send Payout Confirmation
        Notif->>Driver: Payout Notification
    else Transfer Failure
        Fin->>DB: Update Payout Status (FAILED)
        Fin->>Kafka: Publish PayoutFailed Event
        Fin->>Notif: Send Failure Alert
        Notif->>Driver: Payout Failed Notification
    end
```

### 6. Cancellation & Refund Flow

```mermaid
sequenceDiagram
    participant Client as Customer App
    participant Order as Order Service
    participant Pay as Payment Service
    participant Deliv as Delivery Service
    participant Disp as Dispatch Service
    participant Kafka as Kafka (Event Bus)
    participant Notif as Notification Service
    participant Fin as Finance Service

    Client->>Order: Cancel Order Request
    Order->>Order: Validate Cancellation Eligibility

    alt Eligible
        Order->>Order: Update Order Status (CANCELLED)
        Order->>Kafka: Publish OrderCancelled Event

        Order->>Pay: Process Refund (synchronous)
        Pay->>Pay: Validate Refund
        Pay->>GW: PaymentIntent.refund
        GW-->>Pay: Refund Status

        alt Refund Success
            Pay->>Kafka: Publish PaymentRefunded Event
            Pay-->>Order: Refund Success
            Order->>Notif: Send Refund Confirmation
            Notif->>Client: Refund Notification
            Pay->>Fin: Trigger Settlement Adjustment
        else Refund Failure
            Pay-->>Order: Refund Failure
            Order->>Notif: Send Refund Failure Alert
            Notif->>Admin: Escalate to Support
        end

        Deliv->>Kafka: OrderCancelled Event (async)
        Deliv->>Deliv: Cancel Delivery

        Disp->>Kafka: OrderCancelled Event (async)
        Disp->>Disp: Remove from Queue

        Fin->>Kafka: OrderCancelled Event (async)
        Fin->>Fin: Adjust Settlement

    else Not Eligible
        Order-->>Client: Cancellation Not Allowed (Error)
    end
```

### 7. Real-Time Tracking Flow

```mermaid
sequenceDiagram
    participant Client as Customer App
    participant WS as WebSocket Gateway
    participant Deliv as Delivery Service
    participant Kafka as Kafka (Event Bus)
    participant Driver as Driver App

    Client->>WS: WebSocket Connection (Order ID)
    WS->>WS: Authenticate & Subscribe

    Note over Driver, Deliv: GPS Location Updates

    Driver->>Deliv: WebSocket Location Update
    Deliv->>Deliv: Validate Location
    Deliv->>Kafka: Publish LocationUpdated Event

    Kafka-->>Deliv: LocationUpdated Event (consumed)
    Deliv->>Deliv: Update ETA (with Map Service)
    Deliv->>WS: Push Location & ETA Update

    WS->>Client: Location & ETA (Live)

    Deliv->>Kafka: Publish ETAUpdated Event
    Kafka-->>Deliv: ETAUpdated Event
    Deliv->>WS: Push ETA Update

    Note over Deliv, Kafka: Status Changes

    Deliv->>Kafka: Publish DeliveryPickedUp Event
    Kafka-->>Deliv: DeliveryPickedUp Event
    Deliv->>WS: Push Status Update (PICKED_UP)

    Deliv->>Kafka: Publish DeliveryInTransit Event
    Kafka-->>Deliv: DeliveryInTransit Event
    Deliv->>WS: Push Status Update (IN_TRANSIT)

    Deliv->>Kafka: Publish DeliveryArrivingSoon Event
    Kafka-->>Deliv: DeliveryArrivingSoon Event
    Deliv->>WS: Push Status Update (ARRIVING_SOON)

    Deliv->>Kafka: Publish DeliveryCompleted Event
    Kafka-->>Deliv: DeliveryCompleted Event
    Deliv->>WS: Push Status Update (DELIVERED)

    WS->>Client: Final Status Update
```

### 8. Customer Registration Flow

```mermaid
sequenceDiagram
    participant Client as Customer App
    participant GW as API Gateway
    participant Auth as Auth Service
    participant Cust as Customer Service
    participant Kafka as Kafka (Event Bus)
    participant Notif as Notification Service
    participant Loyalty as Loyalty Service
    participant Wallet as Wallet Service
    participant DB as Database

    Client->>GW: POST /auth/register (email/password)
    GW->>Auth: Forward Request
    Auth->>Auth: Validate Input
    Auth->>DB: Check Duplicate Email/Phone
    DB-->>Auth: No Duplicate

    Auth->>Auth: Hash Password (bcrypt/Argon2)
    Auth->>DB: Insert User Record
    DB-->>Auth: User Created

    Auth->>Cust: Create Customer Profile (sync)
    Cust->>Cust: Validate Profile Data
    Cust->>DB: Insert Customer Record
    DB-->>Cust: Profile Created

    Cust->>Wallet: Create Wallet (sync)
    Wallet->>DB: Insert Wallet Record
    DB-->>Wallet: Wallet Created
    Wallet-->>Cust: Wallet Created

    Cust->>Loyalty: Create Loyalty Account (sync)
    Loyalty->>DB: Insert Loyalty Record
    DB-->>Loyalty: Loyalty Created
    Loyalty-->>Cust: Loyalty Created

    Cust->>Kafka: Publish CustomerRegistered Event
    Cust->>Notif: Send Welcome Email (sync)
    Notif->>Notif: Send Welcome Email
    Notif-->>Cust: OK

    Cust-->>Auth: Profile Created
    Auth->>Auth: Generate JWT
    Auth-->>GW: User Registered (201)
    GW-->>Client: Registration Success

    Kafka-->>Analytics: CustomerRegistered Event (async)
    Analytics->>Analytics: Ingest for Analysis
```

---

## High-Level Data Flow Diagrams

### End-to-End Order Data Flow

```mermaid
graph TD
    subgraph "Customer"
        A[Customer App]
    end

    subgraph "Order Flow"
        B[Order Service]
        C[Payment Service]
        D[Delivery Service]
        E[Dispatch Service]
    end

    subgraph "Supporting"
        F[Finance Service]
        G[Notification Service]
        H[Analytics Service]
        I[Integration Service]
    end

    A -->|Place Order| B
    B -->|Authorize| C
    C -->|Capture| C
    C -->|Settle| F
    B -->|Dispatch| E
    E -->|Assign| D
    D -->|Track| A
    D -->|Complete| B
    B -->|Notify| G
    B -->|Log| H
    C -->|Log| H
    D -->|Log| H
    F -->|Reconcile| I
    I -->|Bank| I
```

### Event Flow: Order Lifecycle

```mermaid
graph TD
    subgraph "Producers"
        O[Order Service]
        P[Payment Service]
        D[Delivery Service]
        DP[Dispatch Service]
        F[Finance Service]
    end

    subgraph "Event Bus (Kafka)"
        K[Kafka Topics]
    end

    subgraph "Consumers"
        N[Notification Service]
        A[Analytics Service]
        M[Merchant Service]
        R[Driver Service]
        FI[Finance Service]
        DE[Delivery Service]
        DI[Dispatch Service]
    end

    O -->|order.created, order.confirmed, order.delivered| K
    P -->|payment.authorized, payment.captured, payment.refunded| K
    D -->|delivery.completed, delivery.failed| K
    DP -->|dispatch.order_offered, dispatch.order_accepted| K
    F -->|finance.settlement_calculated, finance.payout_processed| K

    K --> N
    K --> A
    K --> M
    K --> R
    K --> FI
    K --> DE
    K --> DI
```

---

## Data Consistency & Transaction Boundaries

### Saga Pattern

| Workflow | Saga Steps | Compensation Steps |
| :--- | :--- | :--- |
| **Order Placement** | 1. Reserve Inventory<br>2. Authorize Payment<br>3. Confirm Order | 1. Release Inventory<br>2. Void Authorization<br>3. Cancel Order |
| **Delivery Execution** | 1. Assign Driver<br>2. Pickup Order<br>3. Deliver Order | 1. Reassign Order<br>2. Return Order<br>3. Cancel Delivery |
| **Refund Processing** | 1. Process Refund<br>2. Update Order<br>3. Notify Customer | 1. Reverse Refund<br>2. Restore Order<br>3. Notify Customer |

### Distributed Transaction Boundaries

| Transaction Type | Pattern | Services Involved | Coordinator |
| :--- | :--- | :--- | :--- |
| **Order Placement** | Saga | Order, Payment, Inventory | Order Service |
| **Payment Capture** | Two-Phase Commit (simplified) | Order, Payment, Gateway | Payment Service |
| **Settlement** | Saga | Finance, Merchant, Driver, Banking | Finance Service |
| **Refund** | Saga | Order, Payment, Gateway | Payment Service |

---

## Data Flow Best Practices

| Practice | Description |
| :--- | :--- |
| **Idempotency** | All event consumers must handle duplicate events idempotently. |
| **Eventual Consistency** | Systems are eventually consistent; use compensation actions for failures. |
| **Correlation IDs** | All events and logs include a correlation ID for tracing. |
| **Retry & Backoff** | Event consumers implement retry with exponential backoff. |
| **Dead Letter Queue** | Failed events are routed to DLQ for manual intervention. |
| **Circuit Breakers** | Service-to-service calls use circuit breakers to prevent cascading failures. |
| **Timeouts** | All synchronous calls have timeouts (5s default). |

---

## Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-06-30 | [Author] | Initial data flow and sequence diagrams creation |

---

**Next Document:**

`README.md` (Project Overview)

*(This completes the Software Architecture Document (SAD) suite.)*