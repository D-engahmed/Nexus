
# Software Architecture Document (SAD)

## Data Flow & Sequence Diagrams

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document illustrates the key data flows and interaction sequences between services for the **Nexus** platform.

---

## 2. Order Placement Flow

```mermaid
sequenceDiagram
    participant Client
    participant GW as API Gateway
    participant AUTH as Auth Service
    participant ORD as Order Service
    participant PAY as Payment Service
    participant DISP as Dispatch Service
    participant NOTIF as Notification Service

    Client->>GW: Place Order
    GW->>AUTH: Validate JWT
    AUTH-->>GW: OK
    GW->>ORD: Forward Request
    ORD->>ORD: Validate & Create Order (PENDING)
    ORD->>PAY: Authorize Payment
    PAY-->>ORD: Authorization Success
    ORD->>ORD: Update Status (CONFIRMED)
    ORD->>NOTIF: Send Confirmation
    ORD->>DISP: Queue Order for Assignment
    ORD-->>GW: Order Confirmed
    GW-->>Client: 201 Created
```

---

## 3. Payment Authorization & Capture Flow

```mermaid
sequenceDiagram
    participant ORD as Order Service
    participant PAY as Payment Service
    participant GW as Payment Gateway
    participant FIN as Finance Service

    ORD->>PAY: Authorize Payment
    PAY->>GW: PaymentIntent.create
    GW-->>PAY: Auth Response
    alt Success
        PAY-->>ORD: Success
        ORD->>ORD: Status -> CONFIRMED
        PAY->>FIN: Trigger Settlement (event)
    else Failure
        PAY-->>ORD: Failure
        ORD->>ORD: Status -> FAILED
    end
    Note over ORD,GW: Later...
    ORD->>PAY: Capture Payment
    PAY->>GW: PaymentIntent.capture
    GW-->>PAY: Capture Response
    PAY-->>ORD: Capture Success
    PAY->>FIN: Settlement Event
```

---

## 4. Delivery Execution Flow

```mermaid
sequenceDiagram
    participant DISP as Dispatch Service
    participant DRIVER as Driver App
    participant DELIV as Delivery Service
    participant MAP as Mapping Service
    participant NOTIF as Notification Service

    DISP->>DRIVER: Offer Order
    DRIVER-->>DISP: Accept
    DISP->>DELIV: Create Delivery
    DELIV->>DRIVER: Send Route
    loop GPS Updates
        DRIVER->>DELIV: Location Update
        DELIV->>MAP: Get ETA Update
        MAP-->>DELIV: New ETA
        DELIV->>NOTIF: Push ETA to Customer
    end
    DRIVER->>DELIV: Confirm Pickup
    DRIVER->>DELIV: Confirm Delivery
    DELIV->>NOTIF: Notify Customer & Merchant
```

---

## 5. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial flow diagrams |
