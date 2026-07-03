# Software Requirements Specification (SRS)

## Appendix A: Glossary of Terms

**Version:** 1.0.0
**Last Updated:** 2026-06-30

---

## Purpose

This glossary provides definitions for all key terms, acronyms, abbreviations, and concepts used throughout the **[Platform Name]** Software Requirements Specification (SRS). It serves as a centralized reference for all stakeholders—product managers, engineers, QA, operations, and business teams—to ensure consistent understanding and communication.

---

## A

### Access Token
A security credential (typically JWT) used to authenticate API requests. Access tokens are short-lived (15 minutes) and must be refreshed using a refresh token.

### A/B Testing
A method of comparing two versions of a feature or design to determine which performs better based on predefined success metrics.

### ACID
**Atomicity, Consistency, Isolation, Durability** — A set of properties that guarantee reliable processing of database transactions.

### Active Customer
A customer who has placed at least one order within the last 30 days.

### Active Driver
A delivery driver who is currently online and available to accept orders.

### Active Merchant
A merchant who has accepted at least one order within the last 30 days.

### Address Validation
The process of verifying and standardizing a delivery address using geocoding services to ensure it is accurate and deliverable.

### Admin
A user with administrative privileges to manage platform operations, users, configuration, and content.

### AI (Artificial Intelligence)
The simulation of human intelligence processes by machines, particularly computer systems. In the platform context, AI powers predictive analytics, personalization, NLP chatbots, and computer vision.

### Allergen Tags
Labels indicating the presence of common allergens in menu items (e.g., nuts, dairy, gluten, shellfish).

### Anomaly Detection
The identification of unusual patterns or outliers in data that may indicate errors, fraud, or operational issues.

### API (Application Programming Interface)
A set of definitions and protocols for building and integrating application software. The platform exposes REST, GraphQL, gRPC, and WebSocket APIs.

### API Gateway
A single entry point for API requests that provides routing, authentication, rate limiting, caching, and logging.

### API Key
A unique identifier used to authenticate API requests from developers, partners, or internal services.

### API Marketplace
A platform where third-party developers can discover, subscribe to, and monetize APIs built on the platform.

### APNs (Apple Push Notification Service)
Apple's service for delivering push notifications to iOS devices.

### Architecture Decision Record (ADR)
A document that captures an important architectural decision made along with its context and consequences.

### AOV (Average Order Value)
A metric calculated by dividing total revenue by the number of orders. AOV = Total Revenue / Total Orders.

### Argon2id
A password hashing algorithm designed by the Password Hashing Competition. It is the recommended algorithm for secure password storage.

### Audit Log
An immutable record of all significant system events, user actions, and administrative changes for security and compliance purposes.

### Authentication (AuthN)
The process of verifying the identity of a user, device, or system (e.g., login with credentials, OTP, or SSO).

### Authorization (AuthZ)
The process of determining what resources and actions an authenticated user is permitted to access (e.g., RBAC, permissions, scopes).

### Auto-Scaling
The ability of a system to automatically adjust its computing capacity based on demand to maintain performance and optimize costs.

### Availability
A measure of the percentage of time a system or service is operational and accessible, typically measured as a percentage (e.g., 99.95% uptime).

### AVS (Address Verification Service)
A service that verifies the billing address provided by a customer against the address on file with the card issuer.

---

## B

### Backward Compatibility
The ability of a new version of an API or system to continue supporting clients built on older versions.

### Batch Order
A delivery trip containing multiple orders, typically consolidated for efficiency and cost savings.

### Batching
The process of grouping multiple orders from nearby merchants or similar routes into a single delivery trip for a driver.

### Bearer Token
A type of access token (usually JWT) sent in the `Authorization` header of HTTP requests to authenticate the client.

### Benchmarking
The process of comparing a merchant's performance metrics against industry averages, category peers, or regional competitors.

### BI (Business Intelligence)
The technologies, tools, and practices for collecting, analyzing, and presenting business data to support decision-making.

### BIN (Bank Identification Number)
The first 6 digits of a credit or debit card that identify the issuing bank and card brand.

### Blue/Green Deployment
A deployment strategy where two identical environments (blue and green) exist, with traffic switched between them to enable zero-downtime deployments.

### BNPL (Buy Now, Pay Later)
A payment method that allows customers to make purchases and pay for them in installments over time (e.g., Tabby, Tamara, Klarna).

### Bounce Rate (Email)
The percentage of emails that could not be delivered to the recipient's inbox, either due to a hard bounce (invalid address) or soft bounce (temporary issue).

### Bulk Operation
An operation that applies a change to multiple items simultaneously (e.g., bulk price update, bulk availability toggle).

---

## C

### CAC (Customer Acquisition Cost)
The average cost incurred to acquire a new customer, calculated as Marketing Spend / New Customers Acquired.

### Canary Deployment
A deployment strategy where a new version is rolled out to a small subset of users before being expanded to the entire user base.

### CAPTCHA
A challenge-response test used to determine whether a user is human, preventing automated abuse.

### Cash on Delivery (COD)
A payment method where customers pay in cash when the order is delivered.

### CDN (Content Delivery Network)
A geographically distributed network of servers that delivers web content (images, CSS, JS, map tiles) quickly to users based on their location.

### Chargeback
A transaction reversal initiated by the cardholder's bank, typically due to a dispute, fraud, or unauthorized transaction.

### CI/CD (Continuous Integration / Continuous Deployment)
A software development practice where code changes are automatically built, tested, and deployed to production through automated pipelines.

### Circuit Breaker
A resilience pattern that prevents cascading failures by stopping requests to an unhealthy service and failing fast.

### Click-Through Rate (CTR)
The percentage of users who click on a link or call-to-action after viewing it. CTR = Clicks / Impressions × 100.

### CLV / LTV (Customer Lifetime Value)
The total net profit attributed to a customer over their entire relationship with the platform. LTV = AOV × Frequency × Customer Lifespan.

### COD (Cash on Delivery)
See Cash on Delivery.

### Cohort Analysis
The analysis of user behavior grouped by a common characteristic, such as signup month, to understand retention and engagement patterns over time.

### Consolidation
The process of combining multiple orders from different merchants into a single delivery trip for one driver.

### Container
A lightweight, standalone, executable software package that includes everything needed to run an application (code, runtime, system tools, libraries).

### Contract Testing
A testing approach that verifies the interactions between a consumer (client) and a provider (API) against a shared contract to ensure compatibility.

### Correlation ID
A unique identifier assigned to a request that is propagated across all services involved in processing that request, enabling distributed tracing and log correlation.

### Counter (Metric)
A Prometheus metric type that represents a cumulative count that only increases (e.g., total requests, total orders).

### CPU Utilization
The percentage of CPU capacity being used by a system or service at any given time.

### CSAT (Customer Satisfaction Score)
A metric that measures how satisfied customers are with a specific interaction or overall experience, typically measured on a 1-5 scale.

### Customer Churn
The rate at which customers stop using the platform, calculated as Customers Lost / Total Customers × 100.

### CVV (Card Verification Value)
A 3-4 digit security code on a credit or debit card used to verify that the card is physically present during a transaction.

---

## D

### Dark Store
A delivery-only fulfillment center that is not open to the public, used to fulfill online orders.

### DAST (Dynamic Application Security Testing)
A security testing method that scans running applications for vulnerabilities by simulating attacks.

### Data Exfiltration
The unauthorized transfer of data from a system, typically indicating a security breach.

### Data Lake
A centralized repository that stores structured and unstructured data at any scale, used for analytics and machine learning.

### Data Mart
A subset of a data warehouse focused on a specific business line or team (e.g., customer data mart, merchant data mart).

### Data Warehouse
A central repository of integrated data from multiple sources, optimized for querying and analysis.

### Delivery Density
The number of deliveries per square kilometer in a given area, indicating service efficiency and demand concentration.

### DEK (Data Encryption Key)
A symmetric key used to encrypt data at rest. DEKs are typically encrypted by a Key Encryption Key (KEK).

### Dependency Scanning
The process of analyzing project dependencies for known vulnerabilities, using tools like Snyk or OWASP Dependency-Check.

### Deprecation
The process of marking an API version or feature as obsolete, with a planned sunset date, to encourage migration to newer versions.

### DevOps
A set of practices that combines software development (Dev) and IT operations (Ops) to shorten the development lifecycle and deliver features faster.

### Dietary Tags
Labels indicating dietary attributes of menu items (e.g., Vegan, Vegetarian, Gluten-Free, Halal).

### Discovery
The process by which customers find merchants, products, and services through search, browse, recommendations, and promotions.

### Distributed Tracing
A method of tracking a request as it flows through multiple services, enabling performance analysis and debugging.

### DORA Metrics
**Deployment Frequency, Lead Time for Changes, Mean Time to Restore, and Change Failure Rate** — key metrics for measuring DevOps performance.

### Drone Delivery
Autonomous delivery using unmanned aerial vehicles (drones).

### Dunning
The process of notifying customers about failed recurring payments and attempting to collect payment through retries and communications.

---

## E

### E2E (End-to-End) Testing
Testing that validates the complete system workflow from start to finish, simulating real user scenarios.

### ECDSA (Elliptic Curve Digital Signature Algorithm)
A cryptographic algorithm for digital signatures using elliptic curve cryptography.

### EDR (Endpoint Detection and Response)
A security solution that monitors endpoints (devices) for threats and responds to incidents.

### ETA (Estimated Time of Arrival)
The predicted time at which a delivery driver is expected to arrive at a destination, dynamically calculated based on distance, traffic, and other factors.

### ETL (Extract, Transform, Load)
A data pipeline process that extracts data from sources, transforms it into a usable format, and loads it into a destination (e.g., data warehouse).

### Error Budget
The acceptable amount of downtime or failure allowed for a service based on its SLO. Error Budget = 100% - SLO Target.

### Error Rate
The percentage of requests that result in errors, typically measured as HTTP 5xx responses divided by total requests.

### Event-Driven Architecture
An architectural pattern where services communicate asynchronously through events (messages) rather than direct synchronous calls.

### Event Store
A database that stores events in an immutable, append-only log, enabling event sourcing and replay.

### EV (Electric Vehicle)
A vehicle powered by electricity rather than internal combustion, used for sustainable delivery.

### Explainability (AI)
The ability to explain how an AI model arrived at a particular decision or prediction, often using tools like SHAP or LIME.

---

## F

### FCM (Firebase Cloud Messaging)
Google's service for delivering push notifications to Android, iOS, and Web applications.

### Feature Flag
A technique that enables or disables features in production without deploying new code, enabling controlled rollouts and A/B testing.

### Feature Store
A centralized repository for storing, managing, and serving machine learning features.

### FIPS (Federal Information Processing Standards)
Standards defined by the U.S. government for cryptographic modules and algorithms.

### Fraud Detection
The process of identifying and preventing fraudulent transactions or activities using rules, machine learning, and behavioral analytics.

### Funnel Analysis
The analysis of user progression through a series of steps (e.g., acquisition → activation → retention) to identify drop-off points.

### Future State
The long-term vision and strategic direction for the platform's evolution over the next 5-10 years.

---

## G

### Gauge (Metric)
A Prometheus metric type that represents a value that can increase or decrease over time (e.g., CPU usage, memory usage).

### GDPR (General Data Protection Regulation)
The European Union's regulation on data protection and privacy for all individuals within the EU and EEA.

### Geocoding
The process of converting a human-readable address into geographic coordinates (latitude, longitude).

### Geofencing
The use of GPS or RFID to create virtual geographic boundaries that trigger automated actions when a device enters or exits the boundary.

### GMV (Gross Merchandise Value)
The total value of all orders processed through the platform before deductions (commissions, fees, refunds).

### Golden Signals
The four key metrics for monitoring system performance: **Latency, Traffic, Errors, and Saturation** (from Google's SRE book).

### gRPC
A high-performance, open-source RPC (Remote Procedure Call) framework developed by Google, often used for service-to-service communication.

### GraphQL
A query language for APIs that allows clients to request exactly the data they need, reducing over-fetching and under-fetching.

### GST (Goods and Services Tax)
A value-added tax levied on most goods and services sold for domestic consumption.

---

## H

### Hashing
The process of converting input data of any size into a fixed-size string of bytes, used for password storage, data integrity, and deduplication.

### HATEOAS (Hypermedia as the Engine of Application State)
A REST architectural principle where hyperlinks in responses guide the client to available actions.

### Heatmap
A visualization technique that uses color intensity to represent data values, often used to show order density, driver activity, or customer locations.

### Histogram (Metric)
A Prometheus metric type that samples observations (e.g., request durations) and counts them in configurable buckets.

### HMAC (Hash-based Message Authentication Code)
A cryptographic hash used to verify the integrity and authenticity of a message (e.g., webhook signatures).

### Horizontal Pod Autoscaler (HPA)
A Kubernetes component that automatically scales the number of pods in a deployment based on CPU utilization or custom metrics.

### HSM (Hardware Security Module)
A physical device that securely manages cryptographic keys and performs encryption operations.

---

## I

### IaC (Infrastructure as Code)
The practice of managing and provisioning infrastructure through code and automation rather than manual processes.

### IDP (Identity Provider)
A service that provides identity and authentication services, such as Okta, Azure AD, or Google Workspace.

### Idempotency
The property of an operation that can be applied multiple times without changing the result beyond the first application. Idempotency keys prevent duplicate requests.

### IdP
See Identity Provider.

### Incident Management
The process of detecting, responding to, and resolving service incidents to restore normal operation as quickly as possible.

### Incident Severity
A classification of incidents based on their impact, from P0 (critical outage) to P4 (minor issue).

### Integration Testing
Testing that verifies the interactions and interfaces between different components or services.

### IP Reputation
A score assigned to an IP address based on its historical behavior, used for fraud detection and security.

### ISO 27001
An international standard for information security management systems (ISMS).

---

## J

### Jaeger
An open-source distributed tracing system used for monitoring and troubleshooting microservices.

### JIT (Just-in-Time) Provisioning
The automatic creation of a user account at the time of first login via SSO.

### JWT (JSON Web Token)
A compact, URL-safe token used for securely transmitting information between parties, commonly used for authentication and authorization.

---

## K

### Kafka
A distributed streaming platform used for building real-time data pipelines and event-driven applications.

### KDS (Kitchen Display System)
A digital display system used in merchant kitchens to display incoming orders, track preparation status, and manage order flow.

### KEK (Key Encryption Key)
A key used to encrypt other keys (like DEKs) as part of a key hierarchy.

### KPI (Key Performance Indicator)
A measurable value that demonstrates how effectively a company is achieving key business objectives.

### K8s / Kubernetes
An open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.

---

## L

### Latency
The time it takes for a system to respond to a request, typically measured in milliseconds.

### LIDAR (Light Detection and Ranging)
A remote sensing method that uses light in the form of a pulsed laser to measure distances, used in autonomous vehicles.

### Lint / Linting
The process of analyzing source code for potential errors, style violations, and programming errors.

### Load Balancer
A device or software that distributes incoming network traffic across multiple servers to ensure availability and reliability.

### LTV (Lifetime Value)
See Customer Lifetime Value.

### Luhn Algorithm
A simple checksum formula used to validate identification numbers, such as credit card numbers.

---

## M

### MFA (Multi-Factor Authentication)
A security method that requires users to provide two or more verification factors to access an account.

### Microservices
An architectural style where applications are composed of small, independently deployable services that communicate over APIs.

### ML / Machine Learning
A subset of AI that uses algorithms and statistical models to enable systems to learn from data and improve over time without explicit programming.

### MLOps
A set of practices for deploying, managing, and monitoring machine learning models in production.

### MTLS (Mutual TLS)
A variant of TLS where both client and server authenticate each other using certificates, used for secure service-to-service communication.

### MVP (Minimum Viable Product)
The version of a product with just enough features to be usable by early customers and gather feedback.

---

## N

### NLP (Natural Language Processing)
A branch of AI that enables computers to understand, interpret, and generate human language.

### No-Go Zone
A geographic area where delivery is restricted or prohibited for safety, regulatory, or operational reasons.

### NPS (Net Promoter Score)
A metric that measures customer loyalty and satisfaction based on the question: "How likely are you to recommend our platform to a friend?" (scale 0-10).

### NRF (Non-Repudiation Framework)
A framework ensuring that a party cannot deny the authenticity of their signature on a document or a message they sent.

---

## O

### OAuth 2.1
An open standard for access delegation, used for secure authorization between applications.

### Observability
The ability to understand the internal state of a system by examining its external outputs (logs, metrics, traces).

### OIDC (OpenID Connect)
An authentication layer built on top of OAuth 2.0 that provides identity information.

### On-Time Delivery Rate
The percentage of deliveries that are completed within the estimated delivery time window.

### OPA (Open Policy Agent)
An open-source policy engine that uses a declarative policy language (Rego) to enforce policy decisions.

### OpenAPI Specification (OAS)
A specification for describing REST APIs in a machine-readable format (formerly Swagger).

### OpenTelemetry
A set of APIs, libraries, and agents for collecting distributed traces and metrics.

### OTP (One-Time Password)
A password that is valid for only a single login session or transaction, often sent via SMS or authenticator app.

---

## P

### P95 (95th Percentile)
A metric representing the value below which 95% of observations fall. For latency, P95 indicates that 95% of requests are faster than this value.

### P99 (99th Percentile)
A metric representing the value below which 99% of observations fall. P99 latency is critical for identifying tail latencies.

### PAN (Primary Account Number)
The unique payment card number (credit/debit card number) that identifies the issuer and account.

### PCI DSS (Payment Card Industry Data Security Standard)
A standard for organizations that handle credit card data, ensuring secure processing, storage, and transmission.

### Percentile
A statistical measure indicating the value below which a given percentage of observations fall (e.g., P50, P95, P99).

### PII (Personally Identifiable Information)
Information that can be used to identify an individual, such as name, email, phone, address, or ID number.

### Ping/Pong
A keepalive mechanism used to ensure WebSocket or network connections remain active.

### Post-Mortem
A retrospective analysis of an incident to identify root causes and preventive actions, conducted in a blameless manner.

### PWA (Progressive Web App)
A web application that provides a native app-like experience, including offline support, push notifications, and home screen installation.

### PyPI (Python Package Index)
The official repository for Python packages and libraries.

---

## Q

### Q-Commerce (Quick Commerce)
The delivery of groceries and essentials within 15-30 minutes, enabled by dark stores and hyper-local fulfillment.

### QR Code (Quick Response Code)
A two-dimensional barcode that can be scanned to provide information, used for delivery verification and authentication.

### Quality Gate
A checkpoint in the CI/CD pipeline that prevents deployment if predefined quality criteria are not met (e.g., test coverage, security scan results).

### Quality of Service (QoS)
A set of metrics and policies for ensuring the reliability and performance of services.

### Queue Depth
The number of messages or jobs waiting in a queue, indicating system backlog.

---

## R

### RBAC (Role-Based Access Control)
A method of restricting system access based on the roles of individual users.

### RDS (Relational Database Service)
A managed database service that makes it easier to set up, operate, and scale a relational database.

### Reconciliation
The process of matching platform transactions with payment gateway reports, merchant settlements, and driver payouts to ensure financial accuracy.

### Redis
An in-memory data store used as a database, cache, and message broker.

### Refresh Token
A long-lived token used to obtain a new access token when the current access token expires.

### Replication Lag
The delay between when data is written to a primary database and when it is replicated to a read replica.

### REST (Representational State Transfer)
An architectural style for designing networked applications using HTTP methods (GET, POST, PUT, PATCH, DELETE).

### Reverse Geocoding
The process of converting geographic coordinates (latitude, longitude) into a human-readable address.

### RPO (Recovery Point Objective)
The maximum acceptable amount of data loss measured in time. For the platform, RPO is < 5 minutes.

### RTO (Recovery Time Objective)
The maximum acceptable time to restore service after a disaster. For the platform, RTO is < 15 minutes.

---

## S

### SAD (Software Architecture Document)
A comprehensive document describing the architecture of the platform, including C4 diagrams, domain model, event catalog, and service decomposition.

### SAST (Static Application Security Testing)
A security testing method that analyzes source code for vulnerabilities without executing the application.

### SAML (Security Assertion Markup Language)
An XML-based standard for exchanging authentication and authorization data between an identity provider and a service provider.

### Sandbox
An isolated environment for testing APIs and applications without affecting production data or services.

### SCIM (System for Cross-domain Identity Management)
A standard for automating user provisioning and deprovisioning between identity providers and applications.

### SDK (Software Development Kit)
A set of libraries, tools, and documentation for developers to integrate with the platform's APIs.

### Session
A temporary and interactive information exchange between a user and the platform, typically established after successful authentication.

### Settlement
The process of calculating and transferring funds from orders to merchants and drivers after commissions and fees are deducted.

### SIEM (Security Information and Event Management)
A solution that provides real-time analysis of security alerts generated by applications and network hardware.

### SLI (Service Level Indicator)
A quantitative measure of a service's performance or reliability (e.g., latency, error rate, availability).

### SLO (Service Level Objective)
A target value for a Service Level Indicator, representing the level of service the platform aims to provide (e.g., 99.95% availability).

### SOC 2
A standard for service organizations that ensures the security, availability, processing integrity, confidentiality, and privacy of customer data.

### SOPS (Secrets OPerationS)
An editor for encrypted files that stores secrets in Git and integrates with KMS and PGP.

### SQL Injection
A code injection technique that exploits security vulnerabilities in an application's database layer.

### SRE (Site Reliability Engineering)
A discipline that applies software engineering principles to operations, focusing on reliability, availability, and performance.

### SSE (Server-Sent Events)
A server push technology enabling real-time, one-way communication from server to client over HTTP.

### SSL/TLS (Secure Sockets Layer / Transport Layer Security)
Protocols for encrypting data transmitted over the internet to ensure secure communication.

### STO (Security Testing Orchestration)
A process for integrating security testing into the CI/CD pipeline and orchestrating security testing activities.

### Summary (Metric)
A Prometheus metric type that samples observations and calculates quantiles (e.g., request latency percentiles).

### Surge Pricing
Dynamic pricing that increases delivery fees during periods of high demand and low driver supply.

### Swagger
A suite of tools for designing, building, and documenting REST APIs using the OpenAPI Specification.

---

## T

### Take Rate
The percentage of Gross Merchandise Value (GMV) that the platform retains as revenue. Take Rate = Platform Revenue / GMV × 100.

### Tax ID / TIN (Tax Identification Number)
A number used to identify a taxpayer for tax purposes (e.g., VAT registration number, EIN).

### TCPA (Telephone Consumer Protection Act)
A U.S. law that regulates telemarketing calls, autodialed calls, prerecorded calls, and text messages.

### Terraform
An infrastructure-as-code tool for building, changing, and versioning cloud and on-premises infrastructure.

### 3DS / 3D Secure
An authentication protocol for card-not-present transactions that adds an extra layer of security through two-factor authentication.

### Throughput
The number of requests a system can process per unit of time, typically measured in requests per second (RPS).

### TOTP (Time-based One-Time Password)
An algorithm that generates one-time passwords based on a shared secret and the current time, used for MFA.

### Trace ID
A unique identifier for a request that is propagated across all services, enabling distributed tracing and correlation.

### TPS (Transactions Per Second)
The number of transactions processed by a system per second, a measure of throughput.

### Transit Gateway
A network transit hub that connects Virtual Private Clouds (VPCs) and on-premises networks.

### TLS (Transport Layer Security)
A cryptographic protocol for secure communication over a network, successor to SSL.

---

## U

### UAT (User Acceptance Testing)
Testing conducted by end-users to validate that the system meets their requirements and is ready for production.

### Uptime
The percentage of time a system or service is operational and available, typically measured as a percentage (e.g., 99.95%).

### URI (Uniform Resource Identifier)
A string of characters that identifies a resource (e.g., URL, URN).

### UTM (Urchin Tracking Module)
Parameters added to URLs to track the effectiveness of marketing campaigns.

---

## V

### VAT (Value Added Tax)
A consumption tax placed on a product whenever value is added at each stage of the supply chain.

### Velocity Checking
A fraud detection technique that monitors the frequency of transactions from a single entity (IP, device, account) to detect anomalies.

### Vulnerability Management
The process of identifying, prioritizing, and remediating security vulnerabilities in systems and applications.

### VPC (Virtual Private Cloud)
A logically isolated section of a cloud provider's network where resources can be deployed.

---

## W

### Webhook
A mechanism for sending real-time notifications from one application to another via HTTP callbacks.

### WebSocket
A communication protocol enabling full-duplex, real-time communication between client and server over a single TCP connection.

### WSS (WebSocket Secure)
The secure version of WebSocket, using TLS encryption.

### WAF (Web Application Firewall)
A security system that monitors and filters HTTP traffic to protect web applications from attacks.

### WCAG (Web Content Accessibility Guidelines)
A set of guidelines for making web content more accessible to people with disabilities.

---

## X

### X.509
A standard defining the format of public key certificates, used for TLS/SSL and digital signatures.

---

## Y

### YAML (YAML Ain't Markup Language)
A human-readable data serialization language commonly used for configuration files.

### YoY (Year-over-Year)
A comparison of a metric between one year and the same period in the previous year.

### YubiKey
A hardware authentication device that supports multiple authentication protocols, including FIDO, OTP, and smart card.

---

## Z

### Zero Trust
A security model that requires all users, devices, and services to be authenticated and authorized before accessing resources, regardless of location.

### Zero-Day Vulnerability
A security vulnerability that is unknown to the vendor and has not been patched.

### Zone
A geographic area used for delivery segmentation, pricing, and driver assignment.

### ZTNA (Zero Trust Network Access)
A security solution that implements zero trust principles for network access, replacing traditional VPNs.

---

## Acronym Index

| Acronym | Full Form | Section |
| :--- | :--- | :--- |
| A/B | A/B Testing | A |
| ACID | Atomicity, Consistency, Isolation, Durability | A |
| ADR | Architecture Decision Record | A |
| AOV | Average Order Value | A |
| API | Application Programming Interface | A |
| APNs | Apple Push Notification Service | A |
| AV | Autonomous Vehicle | A |
| AVS | Address Verification Service | A |
| BI | Business Intelligence | B |
| BIN | Bank Identification Number | B |
| BNPL | Buy Now, Pay Later | B |
| CAC | Customer Acquisition Cost | C |
| CCPA | California Consumer Privacy Act | C |
| CDN | Content Delivery Network | C |
| CI/CD | Continuous Integration / Continuous Deployment | C |
| CLV | Customer Lifetime Value | C |
| COD | Cash on Delivery | C |
| CSAT | Customer Satisfaction Score | C |
| CVV | Card Verification Value | C |
| DAST | Dynamic Application Security Testing | D |
| DEK | Data Encryption Key | D |
| DevOps | Development Operations | D |
| DORA | DevOps Research and Assessment | D |
| E2E | End-to-End | E |
| ECDSA | Elliptic Curve Digital Signature Algorithm | E |
| EDR | Endpoint Detection and Response | E |
| ETA | Estimated Time of Arrival | E |
| ETL | Extract, Transform, Load | E |
| EV | Electric Vehicle | E |
| FCM | Firebase Cloud Messaging | F |
| FIPS | Federal Information Processing Standards | F |
| GDPR | General Data Protection Regulation | G |
| GMV | Gross Merchandise Value | G |
| gRPC | gRPC Remote Procedure Call | G |
| GST | Goods and Services Tax | G |
| HPA | Horizontal Pod Autoscaler | H |
| HSM | Hardware Security Module | H |
| IaC | Infrastructure as Code | I |
| IDP | Identity Provider | I |
| IDP | Identity Provider | I |
| ISMS | Information Security Management System | I |
| ISO | International Organization for Standardization | I |
| JIT | Just-in-Time | J |
| JWT | JSON Web Token | J |
| K8s | Kubernetes | K |
| KDS | Kitchen Display System | K |
| KEK | Key Encryption Key | K |
| KPI | Key Performance Indicator | K |
| LIDAR | Light Detection and Ranging | L |
| LTV | Lifetime Value | L |
| MFA | Multi-Factor Authentication | M |
| ML | Machine Learning | M |
| MLOps | Machine Learning Operations | M |
| mTLS | Mutual Transport Layer Security | M |
| MVP | Minimum Viable Product | M |
| NLP | Natural Language Processing | N |
| NPS | Net Promoter Score | N |
| OAuth | Open Authorization | O |
| OIDC | OpenID Connect | O |
| OPA | Open Policy Agent | O |
| OTP | One-Time Password | O |
| PII | Personally Identifiable Information | P |
| POS | Point of Sale | P |
| PWA | Progressive Web App | P |
| QR | Quick Response | Q |
| RBAC | Role-Based Access Control | R |
| RDS | Relational Database Service | R |
| RPO | Recovery Point Objective | R |
| RTO | Recovery Time Objective | R |
| SAD | Software Architecture Document | S |
| SAST | Static Application Security Testing | S |
| SAML | Security Assertion Markup Language | S |
| SCIM | System for Cross-domain Identity Management | S |
| SDK | Software Development Kit | S |
| SIEM | Security Information and Event Management | S |
| SLI | Service Level Indicator | S |
| SLO | Service Level Objective | S |
| SOC | Service Organization Control | S |
| SOPS | Secrets OPerationS | S |
| SRE | Site Reliability Engineering | S |
| SSE | Server-Sent Events | S |
| SSL | Secure Sockets Layer | S |
| STO | Security Testing Orchestration | S |
| TIN | Tax Identification Number | T |
| TLS | Transport Layer Security | T |
| TOTP | Time-based One-Time Password | T |
| UAT | User Acceptance Testing | U |
| UTM | Urchin Tracking Module | U |
| VAT | Value Added Tax | V |
| VPC | Virtual Private Cloud | V |
| WAF | Web Application Firewall | W |
| WCAG | Web Content Accessibility Guidelines | W |
| WSS | WebSocket Secure | W |
| YoY | Year-over-Year | Y |
| ZTNA | Zero Trust Network Access | Z |

---

## Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-06-30 | [Author] | Initial glossary creation |

---

**Next Document:**

`B_System_Dependencies.md`

*(This continues the appendices with system dependencies.)* 