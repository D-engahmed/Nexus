# Software Architecture Document (SAD)

## Threat Model

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document outlines the threat model for the **Nexus** platform using the STRIDE methodology. It identifies potential threats to the system and defines mitigation strategies.

---

## 2. Assets & Trust Boundaries

### Key Assets
- **Customer PII:** Names, emails, addresses, phone numbers, payment information.
- **Merchant Data:** Menu items, inventory, business registration, bank details.
- **Driver Data:** Identity documents, location data, earnings.
- **Financial Data:** Orders, transactions, settlements, invoices.
- **Credentials:** JWT tokens, API keys, passwords.
- **Infrastructure:** Kubernetes clusters, databases, Kafka brokers.

### Trust Boundaries
| Boundary | Description |
| :--- | :--- |
| **External Client ↔ API Gateway** | Untrusted internet traffic. |
| **API Gateway ↔ Internal Services** | Internal network (DMZ). |
| **Service ↔ Service** | Internal cluster (mTLS). |
| **Service ↔ Data Store** | Internal network (Encrypted). |
| **System ↔ External Providers** | Third-party APIs (Payment, Maps, etc.). |

---

## 3. STRIDE Threat Analysis

### Spoofing (Authentication)
| Threat | Mitigation |
| :--- | :--- |
| **JWT Forgery** | Use RS256 asymmetric signing, validate signatures strictly. |
| **API Key Theft** | Store keys hashed, enforce TLS, rotate keys regularly. |
| **Impersonation via SSO** | Validate SAML/OIDC assertions with trusted IdPs. |
| **Session Hijacking** | Short-lived JWTs (15 min), refresh token rotation, HTTPS only. |

### Tampering (Integrity)
| Threat | Mitigation |
| :--- | :--- |
| **Order Data Manipulation** | Use immutable event sourcing, validate state transitions. |
| **Event Stream Poisoning** | Use schema validation (Avro/JSON Schema), sign events. |
| **Log Injection** | Sanitize inputs before logging, use structured logging. |

### Repudiation (Non-Repudiation)
| Threat | Mitigation |
| :--- | :--- |
| **Denying an Order** | Audit logs with signed events, immutable database records. |
| **Denying Payout** | Financial reconciliation, signed transaction logs. |

### Information Disclosure (Confidentiality)
| Threat | Mitigation |
| :--- | :--- |
| **PII Data Breach** | Encrypt PII at rest (AES-256) and in transit (TLS 1.3). |
| **Payment Data Exposure** | Tokenize card data (Stripe/Paymob tokens), never store raw PAN. |
| **Log Leakage** | Redact PII and credentials in logs. |
| **Internal API Exposure** | Enforce mTLS and network policies. |

### Denial of Service (Availability)
| Threat | Mitigation |
| :--- | :--- |
| **DDoS Attack** | Use AWS WAF, CloudFront, rate limiting. |
| **Service Overload** | Implement circuit breakers, retries, and bulkheads. |
| **Kafka Brokers Down** | Multi-AZ deployment, replication factor 3. |
| **Database Overload** | Connection pooling, read replicas, query optimization. |

### Elevation of Privilege (Authorization)
| Threat | Mitigation |
| :--- | :--- |
| **IDOR (Insecure Direct Object Reference)** | Implement fine-grained RBAC, validate resource ownership. |
| **Privilege Escalation via RBAC** | Principle of least privilege, regular permission audits. |
| **Admin API Abuse** | Restrict admin access to specific IPs/VPNs, enforce MFA. |
| **Service Account Overreach** | Use distinct service accounts with minimal scopes. |

---

## 4. Dependency Threats

| Threat | Mitigation |
| :--- | :--- |
| **Third-party Library Vulnerabilities** | Automated dependency scanning (Snyk), regular updates. |
| **Supply Chain Attack** | Verify package signatures, use private registries. |
| **Payment Gateway Outage** | Implement provider failover (Stripe → Checkout.com). |
| **Mapping Service API Limit** | Implement caching and batching to reduce API calls. |

---

## 5. Data Flow Diagrams (DFD) Threats

### DFD: Order Placement
- **External Entity:** Customer
- **Process:** API Gateway, Order Service, Payment Service
- **Data Store:** Order DB, Payment DB
- **Threats:** JWT interception, SQL injection, transaction double-spend.
- **Mitigations:** TLS, JWT validation, idempotency keys.

---

## 6. Risk Matrix

| Threat | Likelihood | Impact | Priority |
| :--- | :--- | :--- | :--- |
| PII Data Breach | Medium | Critical | High |
| Payment Fraud | Medium | High | High |
| DDoS Attack | High | Medium | High |
| Insider Threat | Low | High | Medium |
| Dependency Vulnerabilities | Medium | Medium | Medium |

---

## 7. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial threat model |