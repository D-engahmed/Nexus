
# Software Architecture Document (SAD)

## Glossary

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## Purpose

This glossary defines key terms, acronyms, and concepts used throughout the Software Architecture Document (SAD).

---

## A

### API (Application Programming Interface)
A set of definitions and protocols for building and integrating application software.

### API Gateway
A single entry point for API requests that provides routing, authentication, rate limiting, caching, and logging.

### API Key
A unique identifier used to authenticate API requests.

### Availability
A measure of the percentage of time a system or service is operational.

---

## B

### Bounded Context
A boundary within which a domain model is defined and applies.

### Blue/Green Deployment
A deployment strategy with two identical environments for zero-downtime deployments.

### Bulkhead
A resilience pattern that isolates resources to prevent cascading failures.

---

## C

### C4 Model
A framework for visualizing software architecture with Context, Container, Component, and Deployment diagrams.

### Circuit Breaker
A resilience pattern that prevents cascading failures.

### CQRS (Command Query Responsibility Segregation)
A pattern that separates read and write operations.

### Correlation ID
A unique identifier for tracing requests across services.

---

## D

### DDD (Domain-Driven Design)
An approach to software development that emphasizes modeling based on business domains.

### DEK (Data Encryption Key)
A symmetric key used to encrypt data at rest.

### Distributed Tracing
A method of tracking requests across multiple services.

### DR (Disaster Recovery)
The process of restoring systems after a catastrophic failure.

---

## E

### Error Budget
The acceptable amount of downtime allowed for a service based on its SLO.

### ETL (Extract, Transform, Load)
A data pipeline process for moving data from sources to destinations.

### Event-Driven Architecture
An architectural pattern where services communicate through events.

---

## G

### gRPC
A high-performance RPC framework.

### Grafana
An open-source analytics and monitoring platform.

### Gateway
An API Gateway providing routing, authentication, and rate limiting.

---

## I

### IaC (Infrastructure as Code)
The practice of managing infrastructure through code.

### Idempotency
The property of an operation that can be applied multiple times without changing the result.

### Istio
A service mesh for microservices.

---

## J

### Jaeger
An open-source distributed tracing system.

### JWT (JSON Web Token)
A compact, URL-safe token for securely transmitting information.

---

## K

### Kafka
A distributed streaming platform for event-driven architectures.

### KEK (Key Encryption Key)
A key used to encrypt other keys.

### Kubernetes
An open-source container orchestration platform.

---

## L

### Latency
The time it takes for a system to respond to a request.

### Load Balancer
A device that distributes network traffic across multiple servers.

### Log Aggregation
The process of collecting and centralizing logs.

---

## M

### mTLS (Mutual TLS)
A variant of TLS where both client and server authenticate.

### Microservices
An architectural style where applications are composed of small, independently deployable services.

### Monitoring
The process of collecting and analyzing system metrics.

---

## N

### Nexus
The platform name - representing connection, integration, and central hub.

---

## O

### Observability
The ability to understand a system's internal state from its external outputs.

### OpenAPI
A specification for describing REST APIs.

### OpenTelemetry
A set of APIs for collecting telemetry data.

---

## P

### P95 (95th Percentile)
The value below which 95% of observations fall.

### P99 (99th Percentile)
The value below which 99% of observations fall.

### PCI DSS
A standard for organizations that handle credit card data.

### Prometheus
An open-source monitoring and alerting toolkit.

---

## R

### RBAC (Role-Based Access Control)
A method of restricting system access based on roles.

### RPO (Recovery Point Objective)
The maximum acceptable amount of data loss.

### RTO (Recovery Time Objective)
The maximum acceptable time to restore service.

---

## S

### SLO (Service Level Objective)
A target value for a Service Level Indicator.

### SLI (Service Level Indicator)
A quantitative measure of service performance.

### SRE (Site Reliability Engineering)
A discipline that applies software engineering to operations.

### Service Mesh
A dedicated infrastructure layer for service-to-service communication.

---

## T

### Terraform
An infrastructure-as-code tool.

### TLS (Transport Layer Security)
A cryptographic protocol for secure communication.

### Tracing
The process of tracking requests across services.

---

## Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial glossary |
