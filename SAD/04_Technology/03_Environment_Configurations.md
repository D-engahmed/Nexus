# Software Architecture Document (SAD)

## Environment Configurations

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document defines all environment configurations for the **Nexus** platform across Development, Staging, Production, and Disaster Recovery environments.

---

## 2. Environment Overview

### Environment Tiers

| Environment | Description | Purpose | Access |
| :--- | :--- | :--- | :--- |
| **Development** | Local developer environments | Development and unit testing | Developers |
| **Integration** | CI/CD integration testing | Automated testing | CI/CD, Developers |
| **Staging** | Pre-production validation | UAT, integration, performance | QA, Product, Developers |
| **Production** | Live customer-facing environment | Business operations | Restricted |
| **Disaster Recovery** | Failover environment | Business continuity | Restricted |

---

## 3. Common Environment Variables

| Variable | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| `ENVIRONMENT` | `development` | `staging` | `production` | `dr` |
| `LOG_LEVEL` | `debug` | `info` | `warn` | `warn` |
| `LOG_FORMAT` | `json` | `json` | `json` | `json` |
| `API_BASE_URL` | `http://localhost:8080` | `https://staging-api.nexus.com` | `https://api.nexus.com` | `https://dr-api.nexus.com` |
| `APP_URL` | `http://localhost:3000` | `https://staging.nexus.com` | `https://nexus.com` | `https://dr.nexus.com` |
| `TZ` | `UTC` | `UTC` | `UTC` | `UTC` |

---

## 4. Database Configurations

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| `DB_HOST` | `localhost` | `staging-db.nexus.com` | `prod-db.nexus.com` | `dr-db.nexus.com` |
| `DB_PORT` | `5432` | `5432` | `5432` | `5432` |
| `DB_NAME` | `nexus_dev` | `nexus_staging` | `nexus_prod` | `nexus_prod` |
| `DB_USER` | `nexus_user` | `nexus_user` | `nexus_user` | `nexus_user` |
| `DB_SSL_MODE` | `disable` | `require` | `require` | `require` |
| `DB_MAX_CONNECTIONS` | `10` | `50` | `200` | `200` |

---

## 5. Redis Configurations

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| `REDIS_HOST` | `localhost` | `staging-redis.nexus.com` | `prod-redis.nexus.com` | `dr-redis.nexus.com` |
| `REDIS_PORT` | `6379` | `6379` | `6379` | `6379` |
| `REDIS_DB` | `0` | `0` | `0` | `0` |
| `REDIS_MAX_CONNECTIONS` | `10` | `50` | `100` | `100` |
| `CACHE_DEFAULT_TTL` | `300s` | `300s` | `300s` | `300s` |

---

## 6. Kafka Configurations

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| `KAFKA_BROKERS` | `localhost:9092` | `staging-kafka.nexus.com:9092` | `prod-kafka.nexus.com:9092` | `dr-kafka.nexus.com:9092` |
| `KAFKA_GROUP_ID` | `nexus-dev` | `nexus-staging` | `nexus-prod` | `nexus-dr` |
| `KAFKA_ACKS` | `all` | `all` | `all` | `all` |
| `KAFKA_RETRIES` | `3` | `3` | `5` | `5` |
| `KAFKA_COMPRESSION` | `snappy` | `snappy` | `snappy` | `snappy` |

---

## 7. JWT Configurations

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| `JWT_SECRET` | `[DEV]` | `[STAGING]` | `[SECRET]` | `[SECRET]` |
| `JWT_ISSUER` | `nexus-dev` | `nexus-staging` | `nexus-prod` | `nexus-dr` |
| `JWT_ACCESS_TTL` | `3600s` | `900s` | `900s` | `900s` |
| `JWT_REFRESH_TTL` | `604800s` | `604800s` | `604800s` | `604800s` |
| `JWT_ALGORITHM` | `RS256` | `RS256` | `RS256` | `RS256` |

---

## 8. Feature Flags

| Feature | Development | Staging | Production |
| :--- | :--- | :--- | :--- |
| **Multi-Currency** | ✅ | ✅ | ⚠️ (Partial) |
| **Multi-Language** | ✅ | ✅ | ⚠️ (Partial) |
| **AI Dispatch** | ✅ | ✅ | ⚠️ (Limited) |
| **Dynamic Pricing** | ✅ | ✅ | ⚠️ (Limited) |
| **Surge Pricing** | ✅ | ✅ | ⚠️ (Limited) |
| **Dark Stores** | ✅ | ⚠️ (Partial) | ❌ |
| **Drone Delivery** | ⚠️ (Experimental) | ❌ | ❌ |
| **Buy Now Pay Later** | ✅ | ✅ | ✅ |
| **Referral Program** | ✅ | ✅ | ✅ |
| **Loyalty Program** | ✅ | ✅ | ✅ |

---

## 9. Environment-Specific Configurations

### Development Environment

| Parameter | Value |
| :--- | :--- |
| `DEBUG_MODE` | `true` |
| `SENTRY_ENABLED` | `false` |
| `EMAIL_ENABLED` | `false` |
| `SMS_ENABLED` | `false` |
| `PUSH_ENABLED` | `false` |
| `PAYMENT_PROCESSING` | `mock` |
| `AUTH_METHOD` | `mock` |
| `SEED_DATA_ENABLED` | `true` |

### Production Environment

| Parameter | Value |
| :--- | :--- |
| `DEBUG_MODE` | `false` |
| `SENTRY_ENABLED` | `true` |
| `EMAIL_ENABLED` | `true` |
| `SMS_ENABLED` | `true` |
| `PUSH_ENABLED` | `true` |
| `PAYMENT_PROCESSING` | `production` |
| `AUTH_METHOD` | `real` |
| `SEED_DATA_ENABLED` | `false` |
| `MAINTENANCE_MODE` | `false` |

---

## 10. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial environment configurations |