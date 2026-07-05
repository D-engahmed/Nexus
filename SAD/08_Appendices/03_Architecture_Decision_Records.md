# Software Architecture Document (SAD)

## Architecture Decision Records (ADRs)

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document records key architectural decisions made for the **Nexus** platform. Each ADR includes the context, decision, rationale, and consequences.

---

## 2. ADR Format

| Field | Description |
| :--- | :--- |
| **ID** | Unique identifier for the ADR |
| **Status** | Proposed/Accepted/Deprecated/Superseded |
| **Date** | Date of decision |
| **Context** | Background and problem statement |
| **Decision** | What was decided |
| **Rationale** | Why the decision was made |
| **Consequences** | Implications of the decision |
| **Alternatives** | Alternatives considered |

---

## ADR-001: Go for Core Microservices

| Field | Value |
| :--- | :--- |
| **ID** | ADR-001 |
| **Status** | Accepted |
| **Date** | 2026-01-15 |
| **Context** | Need to choose a primary language for core microservices that offers high performance, excellent concurrency, and simplicity. |
| **Decision** | Use Go for core microservices (Order, Payment, Delivery, Dispatch, Merchant, Driver, Customer). |
| **Rationale** | Go provides excellent performance, built-in concurrency with goroutines, fast compilation, and a simple syntax that reduces complexity. |
| **Consequences** | Engineering team needs Go expertise. Some services requiring richer ecosystems will use Java or Python. |
| **Alternatives** | Java (considered too heavy), Node.js (considered not performant enough), Python (considered too slow for core services). |

---

## ADR-002: PostgreSQL as Primary Database

| Field | Value |
| :--- | :--- |
| **ID** | ADR-002 |
| **Status** | Accepted |
| **Date** | 2026-01-15 |
| **Context** | Need to choose a primary database that offers ACID compliance, reliability, and a rich ecosystem. |
| **Decision** | Use PostgreSQL as the primary transactional database. |
| **Rationale** | PostgreSQL offers ACID compliance, reliability, JSONB support, full-text search, and a rich ecosystem. |
| **Consequences** | Database per service pattern will be implemented. Read replicas for scalability. |
| **Alternatives** | MySQL (considered less feature-rich), MongoDB (considered not ACID-compliant for critical transactions). |

---

## ADR-003: Kafka for Event Streaming

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-003 |
| **Status** | Accepted |
| **Date** | 2026-01-20 |
| **Context** | Need to choose an event streaming platform for event-driven architecture. |
| **Decision** | Use Apache Kafka for event streaming. |
| **Rationale** | Kafka offers durability, high throughput, scalability, and a mature ecosystem. |
| **Consequences** | Event-driven architecture requires handling eventual consistency. Team needs Kafka expertise. |
| **Alternatives** | RabbitMQ (considered less durable), AWS SQS (considered less flexible for event streaming). |

---

## ADR-004: Kubernetes for Orchestration

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-004 |
| **Status** | Accepted |
| **Date** | 2026-01-20 |
| **Context** | Need to choose a container orchestration platform. |
| **Decision** | Use Kubernetes for container orchestration. |
| **Rationale** | Kubernetes offers portability, ecosystem, auto-scaling, and self-healing capabilities. |
| **Consequences** | Team needs Kubernetes expertise. Additional operational complexity. |
| **Alternatives** | AWS ECS (considered less portable), Docker Swarm (considered less capable). |

---

## ADR-005: Event-Driven Architecture

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-005 |
| **Status** | Accepted |
| **Date** | 2026-01-25 |
| **Context** | Need to choose a communication pattern for microservices. |
| **Decision** | Use event-driven architecture with Kafka for asynchronous communication. |
| **Rationale** | Event-driven architecture offers loose coupling, scalability, and resilience. |
| **Consequences** | Systems are eventually consistent. Saga pattern for distributed transactions. |
| **Alternatives** | Synchronous REST (considered too coupled), gRPC (considered for synchronous calls only). |

---

## ADR-006: API-First Design

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-006 |
| **Status** | Accepted |
| **Date** | 2026-01-25 |
| **Context** | Need to design APIs for external and internal consumption. |
| **Decision** | Adopt API-first design with OpenAPI 3.1 specifications. |
| **Rationale** | API-first design ensures well-defined contracts, enables parallel development, and improves developer experience. |
| **Consequences** | APIs must be versioned. Documentation must be maintained. |
| **Alternatives** | Code-first API (considered less disciplined), GraphQL (considered for specific use cases). |

---

## ADR-007: React for Web Frontend

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-007 |
| **Status** | Accepted |
| **Date** | 2026-02-01 |
| **Context** | Need to choose a web frontend framework. |
| **Decision** | Use React with TypeScript for web frontend. |
| **Rationale** | React offers a mature ecosystem, excellent performance, and strong developer experience. |
| **Consequences** | Team needs React expertise. TypeScript provides type safety. |
| **Alternatives** | Vue.js (considered but smaller ecosystem), Angular (considered too heavy). |

---

## ADR-008: Flutter for Mobile Apps

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-008 |
| **Status** | Accepted |
| **Date** | 2026-02-05 |
| **Context** | Need to choose a mobile app development framework. |
| **Decision** | Use Flutter for cross-platform mobile apps. |
| **Rationale** | Flutter offers excellent cross-platform performance, UI consistency, and developer experience. |
| **Consequences** | Team needs Flutter expertise. Single codebase for iOS and Android. |
| **Alternatives** | React Native (considered but performance concerns), Native iOS/Android (considered cost-prohibitive). |

---

## ADR-009: Prometheus & Grafana for Monitoring

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-009 |
| **Status** | Accepted |
| **Date** | 2026-02-10 |
| **Context** | Need to choose a monitoring and visualization stack. |
| **Decision** | Use Prometheus for metrics collection and Grafana for visualization. |
| **Rationale** | Both are open-source, have a mature ecosystem, and strong community support. |
| **Consequences** | Team needs Prometheus expertise. Service must expose metrics endpoints. |
| **Alternatives** | Datadog (considered too expensive), New Relic (considered too expensive). |

---

## ADR-010: Terraform for IaC

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-010 |
| **Status** | Accepted |
| **Date** | 2026-02-15 |
| **Context** | Need to choose an Infrastructure as Code (IaC) tool. |
| **Decision** | Use Terraform for infrastructure provisioning. |
| **Rationale** | Terraform offers multi-cloud support, a mature ecosystem, and strong community support. |
| **Consequences** | Team needs Terraform expertise. State management must be handled carefully. |
| **Alternatives** | AWS CloudFormation (considered cloud-specific), Pulumi (considered less mature). |

---

## ADR-011: Service Mesh for Observability

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-011 |
| **Status** | Accepted |
| **Date** | 2026-03-01 |
| **Context** | Need to choose a service mesh for observability, security, and traffic management. |
| **Decision** | Use Istio as the service mesh. |
| **Rationale** | Istio offers comprehensive features for observability (metrics, logs, traces), security (mTLS), and traffic management. |
| **Consequences** | Additional operational complexity. mTLS for all service-to-service communication. |
| **Alternatives** | Linkerd (considered less feature-rich), Consul (considered less integrated with Kubernetes). |

---

## ADR-012: Nexus Name & Branding

| Field | Value |
| :--- | :--- | 
| **ID** | ADR-012 |
| **Status** | Accepted |
| **Date** | 2026-03-15 |
| **Context** | Need to choose a platform name that reflects the product vision. |
| **Decision** | Name the platform "Nexus". |
| **Rationale** | Nexus represents connection, integration, and central hub - reflecting the platform's role as a multi-sided marketplace connecting customers, merchants, and drivers. |
| **Consequences** | All documentation, branding, and code use "Nexus". |
| **Alternatives** | Various names considered; Nexus best captured the value proposition. |

---

## 3. ADR Status Summary

| ADR | Title | Status | Date |
| :--- | :--- | :--- | :--- |
| ADR-001 | Go for Core Microservices | Accepted | 2026-01-15 |
| ADR-002 | PostgreSQL as Primary Database | Accepted | 2026-01-15 |
| ADR-003 | Kafka for Event Streaming | Accepted | 2026-01-20 |
| ADR-004 | Kubernetes for Orchestration | Accepted | 2026-01-20 |
| ADR-005 | Event-Driven Architecture | Accepted | 2026-01-25 |
| ADR-006 | API-First Design | Accepted | 2026-01-25 |
| ADR-007 | React for Web Frontend | Accepted | 2026-02-01 |
| ADR-008 | Flutter for Mobile Apps | Accepted | 2026-02-05 |
| ADR-009 | Prometheus & Grafana for Monitoring | Accepted | 2026-02-10 |
| ADR-010 | Terraform for IaC | Accepted | 2026-02-15 |
| ADR-011 | Service Mesh for Observability | Accepted | 2026-03-01 |
| ADR-012 | Nexus Name & Branding | Accepted | 2026-03-15 |

---

## 4. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial ADR documentation |