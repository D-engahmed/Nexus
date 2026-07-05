
# Software Architecture Document (SAD)

## Third-Party Integrations

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document defines all third-party integrations for the **Nexus** platform.

---

## 2. Integration Overview

### Criticality Levels

| Level | Description | Impact of Failure |
| :--- | :--- | :--- |
| **Tier 0 (Critical)** | Essential for core platform operation | Complete service outage |
| **Tier 1 (High)** | Important for platform functionality | Major feature degradation |
| **Tier 2 (Medium)** | Enhances platform capabilities | Minor feature impact |
| **Tier 3 (Low)** | Optional or non-essential | Minimal impact |

---

## 3. Payment Gateways

| Provider | Regions | Criticality | Purpose | Failover |
| :--- | :--- | :--- | :--- | :--- |
| **Stripe** | Global | Tier 0 | Primary payment processing | Checkout.com |
| **Paymob** | MENA | Tier 0 | MENA region payments | Stripe |
| **Adyen** | Global | Tier 0 | Enterprise payments | Stripe |
| **Checkout.com** | Global | Tier 1 | Global payments (fallback) | Stripe |
| **Tabby** | MENA | Tier 1 | BNPL (MENA) | N/A |
| **Tamara** | MENA | Tier 1 | BNPL (MENA) | N/A |
| **Klarna** | Europe, US | Tier 2 | BNPL | N/A |
| **Afterpay** | Australia, UK, US | Tier 2 | BNPL | N/A |
| **Affirm** | US, Canada | Tier 2 | BNPL | N/A |
| **Apple Pay** | Global | Tier 1 | Mobile wallet | N/A |
| **Google Pay** | Global | Tier 1 | Mobile wallet | N/A |

### Fallback Order

| Priority | Gateway | Use Case | Failover Time |
| :--- | :--- | :--- | :--- |
| 1 | Stripe | All regions (primary) | < 5s |
| 2 | Checkout.com | Global (fallback) | < 5s |
| 3 | Paymob | MENA (regional primary) | < 5s |
| 4 | Adyen | Enterprise (specialized) | < 5s |

### Payment Gateway Configuration

| Provider | API Version | Webhook Support | Idempotency |
| :--- | :--- | :--- | :--- |
| **Stripe** | 2023-10-16 | ✅ | ✅ |
| **Paymob** | v1 | ✅ | ✅ |
| **Adyen** | v68 | ✅ | ✅ |
| **Checkout.com** | v2 | ✅ | ✅ |

---

## 4. Mapping & Location Services

| Provider | Criticality | Purpose | Fallback |
| :--- | :--- | :--- | :--- |
| **Google Maps** | Tier 0 | Geocoding, routing, maps, traffic | Mapbox |
| **Mapbox** | Tier 1 | Geocoding, routing, maps (fallback) | OSM |
| **OpenStreetMap** | Tier 2 | Free/open fallback | N/A |
| **What3Words** | Tier 2 | Precise location addressing | N/A |

### Mapping Provider Fallback

| Priority | Provider | Use Case |
| :--- | :--- | :--- |
| 1 | Google Maps | All services (primary) |
| 2 | Mapbox | Fallback when Google unavailable |
| 3 | OpenStreetMap | Free/open fallback |

### Mapping Rate Limits

| Provider | Free Limit | Paid Limit | Burst |
| :--- | :--- | :--- | :--- |
| **Google Maps** | 1,000/day | 100,000/day | N/A |
| **Mapbox** | 50,000/month | Custom | N/A |
| **OpenStreetMap** | Unlimited | N/A | N/A |

---

## 5. Notification Providers

| Provider | Criticality | Purpose | Fallback |
| :--- | :--- | :--- | :--- |
| **FCM (Firebase)** | Tier 0 | Android push notifications | N/A |
| **APNs** | Tier 0 | iOS push notifications | N/A |
| **SendGrid** | Tier 0 | Email delivery | AWS SES |
| **AWS SES** | Tier 1 | Email delivery (fallback) | SendGrid |
| **Twilio** | Tier 0 | SMS delivery | AWS SNS |
| **AWS SNS** | Tier 1 | SMS delivery (fallback) | Twilio |

### Notification Provider Fallback

| Channel | Primary | Secondary | Fallback Time |
| :--- | :--- | :--- | :--- |
| **Push (Android)** | FCM | N/A | N/A |
| **Push (iOS)** | APNs | N/A | N/A |
| **Email** | SendGrid | AWS SES | < 5s |
| **SMS** | Twilio | AWS SNS | < 5s |

### Notification Rate Limits

| Provider | Rate Limit | Concurrent |
| :--- | :--- | :--- |
| **SendGrid** | 100 req/sec | 100 |
| **Twilio** | 100 req/sec | 100 |
| **FCM** | 1,000 req/sec | 1,000 |

---

## 6. Identity Providers

| Provider | Criticality | Purpose | Protocol |
| :--- | :--- | :--- | :--- |
| **Okta** | Tier 1 | Enterprise SSO | SAML, OIDC, SCIM |
| **Azure AD** | Tier 2 | Enterprise SSO | SAML, OIDC, SCIM |
| **Google Workspace** | Tier 2 | SSO | OIDC |

### Identity Provider Configuration

| Provider | SAML | OIDC | SCIM | MFA Support |
| :--- | :--- | :--- | :--- | :--- |
| **Okta** | ✅ | ✅ | ✅ | ✅ |
| **Azure AD** | ✅ | ✅ | ✅ | ✅ |
| **Google Workspace** | ❌ | ✅ | ✅ | ✅ |

---

## 7. Infrastructure Services

| Provider | Criticality | Purpose | Fallback |
| :--- | :--- | :--- | :--- |
| **AWS** | Tier 0 | Primary cloud provider | GCP |
| **GCP** | Tier 0 | Secondary cloud provider (DR) | AWS |
| **AWS RDS** | Tier 0 | Managed PostgreSQL | GCP Cloud SQL |
| **AWS ElastiCache** | Tier 0 | Managed Redis | GCP Memorystore |
| **AWS MSK** | Tier 0 | Managed Kafka | GCP Pub/Sub |
| **AWS S3** | Tier 1 | Object storage | GCP Storage |
| **AWS Route 53** | Tier 0 | DNS management | GCP Cloud DNS |
| **AWS CloudFront** | Tier 2 | CDN | GCP CDN |

---

## 8. Monitoring & Observability

| Provider | Criticality | Purpose | Self-Hosted |
| :--- | :--- | :--- | :--- |
| **Prometheus** | Tier 0 | Metrics collection | Yes |
| **Grafana** | Tier 1 | Dashboards | Yes |
| **ELK Stack** | Tier 0 | Log aggregation | Yes |
| **Jaeger** | Tier 1 | Distributed tracing | Yes |
| **AlertManager** | Tier 0 | Alert routing | Yes |
| **PagerDuty** | Tier 0 | Incident alerting | No |

---

## 9. API Rate Limits Summary

| Provider | Free Tier | Paid Tier | Burst |
| :--- | :--- | :--- | :--- |
| **Google Maps** | 1,000/day | 100,000/day | N/A |
| **Mapbox** | 50,000/month | Custom | N/A |
| **Stripe** | N/A | 100 req/sec | N/A |
| **SendGrid** | 100/day | 10,000/day | N/A |
| **Twilio** | N/A | 100 req/sec | N/A |
| **Okta** | N/A | 50 req/sec | N/A |
| **PagerDuty** | N/A | 10 req/sec | N/A |

---

## 10. Integration Health Monitoring

| Integration | Health Check | Frequency | Timeout |
| :--- | :--- | :--- | :--- |
| **Stripe** | API availability | 60s | 10s |
| **Google Maps** | Geocode test | 60s | 10s |
| **SendGrid** | API availability | 60s | 10s |
| **Twilio** | API availability | 60s | 10s |
| **Okta** | API availability | 60s | 10s |
| **AWS** | API availability | 60s | 10s |

### Health Statuses

| Status | Description | Action |
| :--- | :--- | :--- |
| **HEALTHY** | Integration functioning normally | Continue normal operations |
| **DEGRADED** | Integration partially available | Alert, use fallback |
| **UNHEALTHY** | Integration unavailable | Critical alert, failover |

---

## 11. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial third-party integrations |
