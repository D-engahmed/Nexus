# Software Requirements Specification (SRS)

## API Endpoints Master List

**Module:** Platform APIs & Developer Ecosystem (Part 13)
**Version:** 1.0.0
**Last Updated:** 2026-06-30

---

## Purpose

This document provides a comprehensive master list of all API endpoints across the **[Platform Name]** platform. It serves as the single source of truth for API inventory, versioning, and documentation. This list is organized by functional module and includes endpoint methods, paths, descriptions, and authentication requirements.

---

## API Overview

### Base URLs

| Environment | Base URL |
| :--- | :--- |
| **Production** | `https://api.platform.com/api/v1` |
| **Staging** | `https://staging-api.platform.com/api/v1` |
| **Sandbox** | `https://sandbox-api.platform.com/api/v1` |
| **Development** | `http://localhost:8080/api/v1` |

### Authentication Methods

| Method | Header | Description |
| :--- | :--- | :--- |
| **Bearer Token** | `Authorization: Bearer {jwt}` | JWT-based authentication for users. |
| **API Key** | `X-API-Key: {key}` | API key-based authentication for partners. |
| **OAuth 2.1** | `Authorization: Bearer {token}` | OAuth 2.1 for third-party apps. |
| **Service Account** | `X-Service-Account: {id}` | Internal service-to-service. |

### Common Headers

| Header | Description |
| :--- | :--- |
| `Authorization` | Bearer token or API key. |
| `Accept` | `application/json` (required). |
| `Content-Type` | `application/json` (required). |
| `Idempotency-Key` | Unique key for idempotent requests. |
| `X-API-Version` | API version (e.g., `v1`). |
| `X-Trace-ID` | Trace ID for request correlation. |
| `X-Request-ID` | Request ID for correlation. |

---

## Section 1: Authentication APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/auth/register` | Register new customer | None | 10/min |
| `POST` | `/auth/login` | Login with email/password | None | 10/min |
| `POST` | `/auth/login/otp` | Login with phone OTP | None | 10/min |
| `POST` | `/auth/login/otp/verify` | Verify OTP and receive JWT | None | 10/min |
| `POST` | `/auth/login/social` | Social login with provider token | None | 10/min |
| `POST` | `/auth/refresh` | Refresh JWT | Refresh Token | 20/min |
| `POST` | `/auth/logout` | Logout current session | Bearer | 20/min |
| `POST` | `/auth/logout/all` | Logout all sessions | Bearer | 10/min |
| `POST` | `/auth/forgot-password` | Request password reset | None | 5/min |
| `POST` | `/auth/reset-password` | Reset password with token | None | 5/min |
| `POST` | `/auth/password/change` | Change password | Bearer | 10/min |
| `POST` | `/auth/verify-email` | Verify email address | None | 10/min |
| `POST` | `/auth/verify-phone` | Verify phone number with OTP | None | 10/min |
| `POST` | `/auth/mfa/enable` | Enable MFA for account | Bearer | 10/min |
| `POST` | `/auth/mfa/verify` | Verify MFA challenge | Bearer | 10/min |
| `POST` | `/auth/mfa/disable` | Disable MFA for account | Bearer | 10/min |
| `GET` | `/auth/mfa/backup-codes` | Get backup codes | Bearer | 10/min |
| `POST` | `/auth/mfa/backup-codes/regenerate` | Regenerate backup codes | Bearer | 10/min |
| `GET` | `/auth/sessions` | List active sessions | Bearer | 20/min |
| `DELETE` | `/auth/sessions/{id}` | Revoke session | Bearer | 20/min |
| `DELETE` | `/auth/sessions` | Revoke all sessions | Bearer | 10/min |
| `GET` | `/auth/saml/login` | SAML SSO login | None | N/A |
| `POST` | `/auth/saml/acs` | SAML ACS endpoint | None | N/A |
| `GET` | `/auth/saml/logout` | SAML SLO logout | None | N/A |
| `GET` | `/auth/saml/metadata` | SAML SP metadata | None | N/A |
| `GET` | `/auth/oidc/authorize` | OIDC authorization | None | N/A |
| `POST` | `/auth/oidc/token` | OIDC token endpoint | None | N/A |
| `GET` | `/auth/oidc/userinfo` | OIDC userinfo endpoint | Bearer | N/A |
| `GET` | `/auth/oidc/logout` | OIDC logout endpoint | None | N/A |
| `GET` | `/auth/oidc/jwks` | OIDC JWKS endpoint | None | N/A |

---

## Section 2: Customer APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/customers/me` | Get current customer profile | Bearer | 50/min |
| `PUT` | `/customers/me` | Update current customer profile | Bearer | 50/min |
| `POST` | `/customers/me/avatar` | Upload profile picture | Bearer | 10/min |
| `DELETE` | `/customers/me/avatar` | Remove profile picture | Bearer | 10/min |
| `PUT` | `/customers/me/password` | Change password | Bearer | 10/min |
| `PUT` | `/customers/me/email` | Change email address | Bearer | 10/min |
| `PUT` | `/customers/me/phone` | Change phone number | Bearer | 10/min |
| `GET` | `/customers/me/addresses` | List saved addresses | Bearer | 50/min |
| `POST` | `/customers/me/addresses` | Add new address | Bearer | 50/min |
| `PUT` | `/customers/me/addresses/{id}` | Update address | Bearer | 50/min |
| `DELETE` | `/customers/me/addresses/{id}` | Delete address | Bearer | 50/min |
| `PUT` | `/customers/me/addresses/{id}/default` | Set default address | Bearer | 50/min |
| `GET` | `/customers/me/consent` | Get consent preferences | Bearer | 50/min |
| `PUT` | `/customers/me/consent` | Update consent preferences | Bearer | 50/min |
| `GET` | `/customers/me/sessions` | List active sessions | Bearer | 20/min |
| `DELETE` | `/customers/me/sessions/{id}` | Revoke session | Bearer | 20/min |
| `DELETE` | `/customers/me` | Delete account (GDPR) | Bearer | 5/min |
| `GET` | `/customers/me/export` | Request data export (GDPR) | Bearer | 5/min |
| `GET` | `/customers/me/payment-methods` | List saved payment methods | Bearer | 50/min |
| `POST` | `/customers/me/payment-methods` | Add new payment method | Bearer | 50/min |
| `GET` | `/customers/me/payment-methods/{id}` | Get payment method details | Bearer | 50/min |
| `PUT` | `/customers/me/payment-methods/{id}` | Update payment method | Bearer | 50/min |
| `DELETE` | `/customers/me/payment-methods/{id}` | Remove payment method | Bearer | 50/min |
| `PUT` | `/customers/me/payment-methods/{id}/default` | Set as default | Bearer | 50/min |
| `GET` | `/customers/me/wallet` | Get wallet balance | Bearer | 50/min |
| `GET` | `/customers/me/wallet/transactions` | List wallet transactions | Bearer | 50/min |
| `POST` | `/customers/me/wallet/topup` | Top up wallet | Bearer | 20/min |
| `POST` | `/customers/me/wallet/withdraw` | Withdraw wallet balance | Bearer | 20/min |
| `PUT` | `/customers/me/wallet/auto-topup` | Configure auto top-up | Bearer | 20/min |
| `GET` | `/customers/me/tickets` | Get customer support tickets | Bearer | 50/min |
| `GET` | `/customers/me/tickets/{id}` | Get customer ticket | Bearer | 50/min |
| `POST` | `/customers/me/tickets` | Create support ticket | Bearer | 20/min |
| `POST` | `/customers/me/tickets/{id}/messages` | Add message to ticket | Bearer | 20/min |
| `GET` | `/customers/me/loyalty` | Get loyalty account summary | Bearer | 50/min |
| `GET` | `/customers/me/loyalty/points` | Get points balance | Bearer | 50/min |
| `GET` | `/customers/me/loyalty/transactions` | Get points transaction history | Bearer | 50/min |
| `GET` | `/customers/me/loyalty/tier` | Get current tier | Bearer | 50/min |
| `GET` | `/customers/me/loyalty/tier/progress` | Get progress to next tier | Bearer | 50/min |
| `POST` | `/customers/me/loyalty/redeem` | Redeem points for reward | Bearer | 20/min |
| `GET` | `/customers/me/loyalty/redemptions` | List redemption history | Bearer | 50/min |
| `GET` | `/customers/me/loyalty/redemptions/{id}` | Get redemption details | Bearer | 50/min |
| `GET` | `/customers/me/referral` | Get referral code and stats | Bearer | 50/min |
| `GET` | `/customers/me/referral/link` | Generate referral link | Bearer | 50/min |
| `GET` | `/customers/me/referral/history` | List referral history | Bearer | 50/min |
| `POST` | `/customers/me/referral/share` | Share referral via channel | Bearer | 20/min |
| `GET` | `/customers/me/loyalty/challenges` | Get customer challenge progress | Bearer | 50/min |
| `POST` | `/customers/me/loyalty/challenges/{id}/claim` | Claim challenge reward | Bearer | 20/min |

---

## Section 3: Merchant APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/merchant/application` | Start/Submit merchant application | Bearer | 10/min |
| `GET` | `/merchant/application/{id}` | Get application status and data | Bearer | 50/min |
| `PUT` | `/merchant/application/{id}` | Update application | Bearer | 50/min |
| `POST` | `/merchant/application/{id}/submit` | Submit application for review | Bearer | 10/min |
| `GET` | `/merchant/application/{id}/status` | Get current application status | Bearer | 50/min |
| `POST` | `/merchant/application/{id}/documents` | Upload document | Bearer | 20/min |
| `DELETE` | `/merchant/application/{id}/documents/{doc_id}` | Delete document | Bearer | 20/min |
| `GET` | `/merchant/account` | Get merchant account details | Bearer | 50/min |
| `PUT` | `/merchant/account` | Update merchant account details | Bearer | 50/min |
| `GET` | `/merchant/stores` | List merchant stores | Bearer | 50/min |
| `POST` | `/merchant/stores` | Create new store | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}` | Get store details | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}` | Update store details | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/settings` | Get store settings | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/settings` | Update store settings | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/operating-hours` | Get operating hours | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/operating-hours` | Update operating hours | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/status` | Get store status | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/status` | Update store status | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/menu/categories` | List categories | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/categories` | Create category | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/menu/categories/{id}` | Get category | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/categories/{id}` | Update category | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/menu/categories/{id}` | Delete category | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/categories/reorder` | Reorder categories | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/menu/items` | List items | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/items` | Create item | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/menu/items/{id}` | Get item | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/items/{id}` | Update item | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/menu/items/{id}` | Delete item | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/items/{id}/availability` | Toggle item availability | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/items/bulk-availability` | Bulk toggle availability | Bearer | 20/min |
| `PUT` | `/merchant/stores/{id}/menu/items/bulk-price` | Bulk price update | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/menu/items/{id}/modifiers` | List modifier groups | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/items/{id}/modifiers` | Create modifier group | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Update modifier group | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/menu/items/{id}/modifiers/{id}` | Delete modifier group | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/menu/modifiers/{id}/options` | List modifier options | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/modifiers/{id}/options` | Create modifier option | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/menu/modifiers/{id}/options/{id}` | Update modifier option | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/menu/modifiers/{id}/options/{id}` | Delete modifier option | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/import` | Import menu | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/menu/export` | Export menu | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/menu/import/status` | Get import status | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/menu/import/template` | Download import template | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/inventory` | List inventory | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/inventory/{item_id}` | Get inventory for item | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/inventory/{item_id}` | Update inventory | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/inventory/adjust` | Adjust inventory | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/inventory/history` | Get inventory history | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/inventory/alerts` | Get low stock alerts | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/schedule` | Get store schedule | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/schedule` | Create schedule | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/schedule/{id}` | Update schedule | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/schedule/{id}` | Delete schedule | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/holidays` | List holidays | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/holidays` | Add holiday | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/holidays/{id}` | Get holiday details | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/holidays/{id}` | Update holiday | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/holidays/{id}` | Delete holiday | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/staff` | List staff | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/staff` | Add staff | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/staff/{id}` | Get staff details | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/staff/{id}` | Update staff | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/staff/{id}` | Remove staff | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/staff/{id}/activate` | Activate/deactivate staff | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/capacity` | Get capacity configuration | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/capacity` | Update capacity configuration | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/capacity/current` | Get current capacity status | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/compliance` | List compliance documents | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/compliance` | Add compliance document | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/compliance/{id}` | Get compliance document | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/compliance/{id}` | Update compliance document | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/compliance/{id}` | Delete compliance document | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/zones` | List delivery zones | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/zones` | Add delivery zone | Bearer | 50/min |
| `GET` | `/merchant/stores/{id}/zones/{id}` | Get zone details | Bearer | 50/min |
| `PUT` | `/merchant/stores/{id}/zones/{id}` | Update zone | Bearer | 50/min |
| `DELETE` | `/merchant/stores/{id}/zones/{id}` | Delete zone | Bearer | 50/min |
| `POST` | `/merchant/stores/{id}/pause` | Pause store | Bearer | 20/min |
| `POST` | `/merchant/stores/{id}/resume` | Resume store | Bearer | 20/min |
| `GET` | `/merchant/stores/{id}/pause/history` | Get pause history | Bearer | 50/min |
| `GET` | `/merchant/orders` | List merchant orders | Bearer | 100/min |
| `GET` | `/merchant/orders/{id}` | Get order details | Bearer | 100/min |
| `PUT` | `/merchant/orders/{id}/confirm` | Confirm order | Bearer | 50/min |
| `PUT` | `/merchant/orders/{id}/prepare` | Start preparation | Bearer | 50/min |
| `PUT` | `/merchant/orders/{id}/ready` | Mark order ready | Bearer | 50/min |
| `PUT` | `/merchant/orders/{id}/cancel` | Cancel order | Bearer | 20/min |
| `GET` | `/merchant/orders/export` | Export orders to CSV | Bearer | 20/min |
| `GET` | `/merchant/orders/{id}/timeline` | Get order timeline | Bearer | 100/min |
| `GET` | `/merchant/kds/orders` | Get KDS order queue | Bearer | 50/min |
| `GET` | `/merchant/kds/orders/{id}` | Get KDS order card | Bearer | 50/min |
| `PUT` | `/merchant/kds/orders/{id}/bump` | Bump order status | Bearer | 50/min |
| `PUT` | `/merchant/kds/orders/{id}/note` | Add kitchen note | Bearer | 50/min |
| `POST` | `/merchant/kds/orders/{id}/print` | Print order ticket | Bearer | 20/min |
| `PUT` | `/merchant/kds/settings` | Update KDS configuration | Bearer | 20/min |
| `GET` | `/merchant/dashboard/kpis` | Get KPI data for dashboard | Bearer | 50/min |
| `GET` | `/merchant/dashboard/recent-orders` | Get recent orders | Bearer | 50/min |
| `GET` | `/merchant/dashboard/alerts` | Get active alerts/notifications | Bearer | 50/min |
| `GET` | `/merchant/dashboard/quick-actions` | Get quick actions | Bearer | 50/min |
| `PUT` | `/merchant/dashboard/preferences` | Update dashboard preferences | Bearer | 50/min |
| `GET` | `/merchant/analytics/dashboard` | Get merchant analytics dashboard | Bearer | 50/min |
| `GET` | `/merchant/analytics/revenue` | Get revenue analytics | Bearer | 50/min |
| `GET` | `/merchant/analytics/orders` | Get order analytics | Bearer | 50/min |
| `GET` | `/merchant/analytics/items` | Get item performance | Bearer | 50/min |
| `GET` | `/merchant/analytics/customers` | Get customer insights | Bearer | 50/min |
| `GET` | `/merchant/analytics/reports/{type}` | Get specific report | Bearer | 20/min |
| `POST` | `/merchant/analytics/reports/export` | Export report | Bearer | 20/min |
| `GET` | `/merchant/finance/dashboard` | Get financial dashboard | Bearer | 50/min |
| `GET` | `/merchant/finance/settlements` | List settlements | Bearer | 50/min |
| `GET` | `/merchant/finance/settlements/{id}` | Get settlement details | Bearer | 50/min |
| `GET` | `/merchant/finance/settlements/{id}/orders` | Get orders in settlement | Bearer | 50/min |
| `GET` | `/merchant/finance/settlements/pending` | Get pending settlement | Bearer | 50/min |
| `GET` | `/merchant/finance/payouts` | List payouts | Bearer | 50/min |
| `GET` | `/merchant/finance/payouts/{id}` | Get payout details | Bearer | 50/min |
| `GET` | `/merchant/finance/payouts/upcoming` | Get upcoming payout | Bearer | 50/min |
| `POST` | `/merchant/finance/payouts/request` | Request manual payout | Bearer | 20/min |
| `GET` | `/merchant/finance/invoices` | List invoices | Bearer | 50/min |
| `GET` | `/merchant/finance/invoices/{id}` | Get invoice details | Bearer | 50/min |
| `GET` | `/merchant/finance/invoices/{id}/download` | Download invoice PDF | Bearer | 20/min |
| `POST` | `/merchant/finance/invoices/{id}/resend` | Resend invoice email | Bearer | 20/min |
| `GET` | `/merchant/finance/commission` | Get current commission structure | Bearer | 50/min |
| `GET` | `/merchant/finance/commission/history` | Get commission history | Bearer | 50/min |
| `GET` | `/merchant/finance/balance` | Get current balance | Bearer | 50/min |
| `GET` | `/merchant/finance/disputes` | List disputes | Bearer | 50/min |
| `GET` | `/merchant/finance/disputes/{id}` | Get dispute details | Bearer | 50/min |
| `POST` | `/merchant/finance/disputes` | Initiate dispute | Bearer | 20/min |
| `GET` | `/merchant/finance/settings` | Get financial settings | Bearer | 50/min |
| `PUT` | `/merchant/finance/settings` | Update financial settings | Bearer | 20/min |
| `GET` | `/merchant/settings/profile` | Get profile settings | Bearer | 50/min |
| `PUT` | `/merchant/settings/profile` | Update profile settings | Bearer | 50/min |
| `GET` | `/merchant/settings/notifications` | Get notification preferences | Bearer | 50/min |
| `PUT` | `/merchant/settings/notifications` | Update notification preferences | Bearer | 50/min |
| `GET` | `/merchant/settings/integrations` | Get integration settings | Bearer | 50/min |
| `POST` | `/merchant/settings/integrations/pos` | Configure POS integration | Bearer | 20/min |
| `POST` | `/merchant/settings/integrations/erp` | Configure ERP integration | Bearer | 20/min |

---

## Section 4: Driver APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/driver/application` | Start/Submit driver application | Bearer | 10/min |
| `GET` | `/driver/application/{id}` | Get application status and data | Bearer | 50/min |
| `PUT` | `/driver/application/{id}` | Update application | Bearer | 50/min |
| `POST` | `/driver/application/{id}/submit` | Submit application for review | Bearer | 10/min |
| `GET` | `/driver/application/{id}/status` | Get current application status | Bearer | 50/min |
| `POST` | `/driver/application/{id}/documents` | Upload document | Bearer | 20/min |
| `DELETE` | `/driver/application/{id}/documents/{doc_id}` | Delete document | Bearer | 20/min |
| `GET` | `/driver/account` | Get driver account details | Bearer | 50/min |
| `PUT` | `/driver/account` | Update driver account details | Bearer | 50/min |
| `GET` | `/driver/vehicles` | Get driver vehicles | Bearer | 50/min |
| `POST` | `/driver/vehicles` | Add vehicle | Bearer | 50/min |
| `PUT` | `/driver/vehicles/{id}` | Update vehicle | Bearer | 50/min |
| `DELETE` | `/driver/vehicles/{id}` | Remove vehicle | Bearer | 50/min |
| `GET` | `/driver/documents` | Get documents | Bearer | 50/min |
| `POST` | `/driver/documents` | Upload document | Bearer | 20/min |
| `GET` | `/driver/onboarding` | Get onboarding progress | Bearer | 50/min |
| `POST` | `/driver/onboarding/complete` | Complete onboarding task | Bearer | 20/min |
| `GET` | `/driver/training/modules` | List training modules | Bearer | 50/min |
| `GET` | `/driver/training/modules/{id}` | Get module content | Bearer | 50/min |
| `POST` | `/driver/training/modules/{id}/start` | Start module | Bearer | 50/min |
| `POST` | `/driver/training/modules/{id}/complete` | Complete module | Bearer | 50/min |
| `POST` | `/driver/training/modules/{id}/quiz` | Submit quiz | Bearer | 50/min |
| `GET` | `/driver/training/progress` | Get training progress | Bearer | 50/min |
| `POST` | `/driver/session/online` | Go online | Bearer | 20/min |
| `POST` | `/driver/session/offline` | Go offline | Bearer | 20/min |
| `POST` | `/driver/session/break` | Take break | Bearer | 20/min |
| `POST` | `/driver/session/break/end` | End break | Bearer | 20/min |
| `GET` | `/driver/session/status` | Get current status | Bearer | 50/min |
| `GET` | `/driver/orders/pending` | Get pending orders | Bearer | 100/min |
| `GET` | `/driver/orders/active` | Get active order | Bearer | 100/min |
| `GET` | `/driver/orders/{id}` | Get order details | Bearer | 100/min |
| `POST` | `/driver/orders/{id}/accept` | Accept order | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/decline` | Decline order | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/pickup` | Confirm pickup | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/deliver` | Confirm delivery | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/cancel` | Cancel delivery | Bearer | 20/min |
| `PUT` | `/driver/orders/{id}/location` | Update GPS location | Bearer | 100/min |
| `GET` | `/driver/navigation/route` | Get route to destination | Bearer | 100/min |
| `GET` | `/driver/navigation/eta` | Get ETA to destination | Bearer | 100/min |
| `GET` | `/driver/navigation/nearby` | Get nearby merchants | Bearer | 100/min |
| `GET` | `/driver/earnings/today` | Get today's earnings | Bearer | 50/min |
| `GET` | `/driver/earnings/week` | Get this week's earnings | Bearer | 50/min |
| `GET` | `/driver/earnings/history` | Get earnings history | Bearer | 50/min |
| `GET` | `/driver/earnings/{id}` | Get earning details | Bearer | 50/min |
| `GET` | `/driver/payouts` | Get payout history | Bearer | 50/min |
| `POST` | `/driver/payouts/instant` | Request instant payout | Bearer | 20/min |
| `GET` | `/driver/payouts/methods` | Get available payout methods | Bearer | 50/min |
| `PUT` | `/driver/payouts/methods` | Update payout method | Bearer | 50/min |
| `GET` | `/driver/bank-accounts` | Get bank accounts | Bearer | 50/min |
| `POST` | `/driver/bank-accounts` | Add bank account | Bearer | 50/min |
| `PUT` | `/driver/bank-accounts/{id}` | Update bank account | Bearer | 50/min |
| `DELETE` | `/driver/bank-accounts/{id}` | Delete bank account | Bearer | 50/min |
| `POST` | `/driver/bank-accounts/{id}/verify` | Verify bank account | Bearer | 20/min |
| `GET` | `/driver/wallet` | Get wallet balance | Bearer | 50/min |
| `GET` | `/driver/wallet/transactions` | Get wallet transactions | Bearer | 50/min |
| `POST` | `/driver/wallet/withdraw` | Withdraw from wallet | Bearer | 20/min |
| `GET` | `/driver/performance` | Get driver performance summary | Bearer | 50/min |
| `GET` | `/driver/performance/metrics` | Get performance metrics | Bearer | 50/min |
| `GET` | `/driver/performance/scorecard` | Get performance scorecard | Bearer | 50/min |
| `GET` | `/driver/performance/tier` | Get driver tier | Bearer | 50/min |
| `GET` | `/driver/performance/tier/benefits` | Get tier benefits | Bearer | 50/min |
| `GET` | `/driver/ratings` | Get driver ratings | Bearer | 50/min |
| `GET` | `/driver/ratings/{id}` | Get rating details | Bearer | 50/min |
| `GET` | `/driver/ratings/feedback` | Get customer feedback | Bearer | 50/min |
| `GET` | `/driver/ratings/trend` | Get rating trend | Bearer | 50/min |
| `GET` | `/driver/incentives` | Get driver incentives | Bearer | 50/min |
| `GET` | `/driver/incentives/active` | Get active incentives | Bearer | 50/min |
| `GET` | `/driver/incentives/history` | Get incentive history | Bearer | 50/min |
| `POST` | `/driver/incentives/claim` | Claim completed incentive | Bearer | 20/min |
| `GET` | `/driver/trips/current` | Get current trip | Bearer | 50/min |
| `GET` | `/driver/trips/history` | Get trip history | Bearer | 50/min |
| `GET` | `/driver/trips/{id}` | Get trip details | Bearer | 50/min |
| `GET` | `/driver/deliveries/active` | Get active delivery | Bearer | 50/min |
| `GET` | `/driver/deliveries/{id}` | Get delivery details | Bearer | 50/min |
| `GET` | `/driver/deliveries/history` | Get delivery history | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/arrive-merchant` | Arrive at merchant | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/arrive-customer` | Arrive at customer | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/fail` | Report delivery failure | Bearer | 20/min |
| `POST` | `/driver/deliveries/{id}/return` | Return order | Bearer | 20/min |
| `GET` | `/driver/deliveries/{id}/qr` | Get QR code for verification | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/verify/qr` | Verify via QR code | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/verify/otp` | Verify via OTP | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/verify/photo` | Verify via photo | Bearer | 50/min |
| `GET` | `/driver/deliveries/{id}/messages` | Get chat history | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/messages` | Send message | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/call` | Initiate masked call | Bearer | 20/min |
| `POST` | `/driver/deliveries/{id}/issue` | Report issue | Bearer | 20/min |
| `GET` | `/driver/deliveries/{id}/issue` | Get issue status | Bearer | 50/min |
| `PUT` | `/driver/deliveries/{id}/issue` | Update issue report | Bearer | 50/min |
| `POST` | `/driver/deliveries/{id}/rate` | Rate customer/merchant | Bearer | 50/min |
| `GET` | `/driver/deliveries/{id}/rating` | Get delivery rating | Bearer | 50/min |
| `POST` | `/driver/safety/sos` | Trigger emergency SOS | Bearer | 5/min |
| `POST` | `/driver/safety/incident` | Report safety incident | Bearer | 10/min |
| `GET` | `/driver/safety/resources` | Get safety resources | Bearer | 50/min |
| `GET` | `/driver/reports/earnings` | Generate earnings report | Bearer | 20/min |
| `GET` | `/driver/reports/tax` | Generate tax report | Bearer | 20/min |
| `GET` | `/driver/reports/payouts` | Generate payout report | Bearer | 20/min |
| `POST` | `/driver/earnings/dispute` | Submit earnings dispute | Bearer | 20/min |
| `GET` | `/driver/earnings/disputes` | Get dispute history | Bearer | 50/min |
| `GET` | `/driver/earnings/disputes/{id}` | Get dispute details | Bearer | 50/min |

---

## Section 5: Order APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/orders` | List customer orders | Bearer | 100/min |
| `GET` | `/orders/{id}` | Get order details | Bearer | 100/min |
| `GET` | `/orders/{id}/status` | Get current order status | Bearer | 100/min |
| `GET` | `/orders/{id}/timeline` | Get order timeline | Bearer | 100/min |
| `GET` | `/orders/{id}/transitions` | Get order transitions | Bearer | 100/min |
| `DELETE` | `/orders/{id}` | Cancel order | Bearer | 20/min |
| `GET` | `/orders/{id}/cancellation-eligibility` | Check cancellation eligibility | Bearer | 50/min |
| `POST` | `/orders/{id}/cancel` | Cancel order | Bearer | 20/min |
| `POST` | `/orders/{id}/reorder` | Recreate cart from previous order | Bearer | 20/min |
| `PUT` | `/orders/{id}/scheduled` | Update scheduled time | Bearer | 20/min |
| `DELETE` | `/orders/{id}/scheduled` | Cancel scheduled order | Bearer | 20/min |
| `GET` | `/orders/{id}/tracking` | Get real-time tracking information | Bearer | 100/min |
| `GET` | `/orders/{id}/tracking/websocket` | WebSocket endpoint for live updates | Bearer | N/A |
| `POST` | `/orders/{id}/review` | Submit order review | Bearer | 20/min |
| `GET` | `/orders/{id}/review` | Get review for order | Bearer | 50/min |
| `PUT` | `/orders/{id}/review` | Update review | Bearer | 20/min |
| `DELETE` | `/orders/{id}/review` | Delete review | Bearer | 20/min |

---

## Section 6: Order Fulfillment APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/merchant/preparation/orders` | Get preparation orders | Bearer | 50/min |
| `GET` | `/merchant/preparation/orders/{id}` | Get preparation order details | Bearer | 50/min |
| `PUT` | `/merchant/preparation/orders/{id}/start` | Start preparation | Bearer | 50/min |
| `PUT` | `/merchant/preparation/orders/{id}/delay` | Report preparation delay | Bearer | 50/min |
| `PUT` | `/merchant/preparation/orders/{id}/resume` | Resume preparation | Bearer | 50/min |
| `PUT` | `/merchant/preparation/orders/{id}/complete` | Complete item preparation | Bearer | 50/min |
| `GET` | `/merchant/kds/orders` | Get KDS order queue | Bearer | 50/min |
| `GET` | `/merchant/kds/orders/{id}` | Get KDS order card | Bearer | 50/min |
| `PUT` | `/merchant/kds/orders/{id}/bump` | Bump order status | Bearer | 50/min |
| `PUT` | `/merchant/kds/orders/{id}/note` | Add kitchen note | Bearer | 50/min |
| `POST` | `/merchant/kds/orders/{id}/print` | Print order ticket | Bearer | 20/min |
| `PUT` | `/merchant/kds/settings` | Update KDS configuration | Bearer | 20/min |
| `PUT` | `/merchant/orders/{id}/ready` | Mark order ready | Bearer | 50/min |
| `GET` | `/merchant/orders/{id}/readiness` | Check readiness status | Bearer | 50/min |
| `GET` | `/driver/orders/{id}/pickup` | Get pickup details | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/pickup` | Confirm pickup | Bearer | 50/min |
| `POST` | `/driver/orders/{id}/pickup/verify` | Verify pickup | Bearer | 50/min |

---

## Section 7: Payment APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/payments/authorize` | Authorize payment | Bearer | 50/min |
| `POST` | `/payments/capture` | Capture authorized payment | Bearer | 50/min |
| `POST` | `/payments/refund` | Process refund | Bearer | 20/min |
| `POST` | `/payments/void` | Void authorization | Bearer | 20/min |
| `GET` | `/payments/{id}` | Get transaction details | Bearer | 50/min |
| `GET` | `/payments/order/{id}` | Get payments for order | Bearer | 50/min |
| `GET` | `/payments/status/{id}` | Get transaction status | Bearer | 50/min |
| `POST` | `/payments/validate/card` | Validate card number | Bearer | 50/min |
| `POST` | `/payments/validate/expiry` | Validate expiry date | Bearer | 50/min |
| `GET` | `/payments/card-brands/{number}` | Detect card brand | Bearer | 50/min |
| `GET` | `/payments/methods` | Get payment methods | Bearer | 50/min |
| `POST` | `/payments/methods` | Add payment method | Bearer | 50/min |
| `DELETE` | `/payments/methods/{id}` | Delete payment method | Bearer | 50/min |
| `GET` | `/payments/cod/eligibility` | Check COD eligibility | Bearer | 50/min |
| `GET` | `/merchant/cod/settings` | Get COD settings | Bearer | 50/min |
| `PUT` | `/merchant/cod/settings` | Update COD settings | Bearer | 50/min |
| `GET` | `/payments/bnpl/eligibility` | Check BNPL eligibility | Bearer | 50/min |
| `POST` | `/payments/bnpl` | Create BNPL payment | Bearer | 50/min |

---

## Section 8: Refund APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/refunds` | Request refund | Bearer | 20/min |
| `GET` | `/refunds` | List refund requests | Bearer | 50/min |
| `GET` | `/refunds/{id}` | Get refund details | Bearer | 50/min |
| `GET` | `/refunds/order/{id}` | Get refunds for order | Bearer | 50/min |
| `PUT` | `/refunds/{id}/status` | Update refund status (admin) | Admin | 20/min |
| `PUT` | `/refunds/{id}/approve` | Approve refund (admin) | Admin | 20/min |
| `PUT` | `/refunds/{id}/reject` | Reject refund (admin) | Admin | 20/min |
| `POST` | `/refunds/{id}/process` | Process refund (admin) | Admin | 20/min |

---

## Section 9: Voucher APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/vouchers` | List vouchers | Bearer | 50/min |
| `GET` | `/vouchers/{id}` | Get voucher details | Bearer | 50/min |
| `GET` | `/vouchers/validate` | Validate voucher code | Bearer | 50/min |
| `POST` | `/vouchers` | Create voucher (admin) | Admin | 20/min |

---

## Section 10: Delivery APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/deliveries` | List deliveries | Bearer | 50/min |
| `GET` | `/deliveries/{id}` | Get delivery details | Bearer | 50/min |
| `GET` | `/deliveries/{id}/tracking` | Get delivery tracking | Bearer | 100/min |
| `POST` | `/deliveries/{id}/tracking` | Update tracking | Bearer | 100/min |
| `POST` | `/deliveries/{id}/assign` | Assign driver | Bearer | 50/min |
| `POST` | `/deliveries/{id}/pickup` | Confirm pickup | Bearer | 50/min |
| `POST` | `/deliveries/{id}/deliver` | Confirm delivery | Bearer | 50/min |
| `GET` | `/deliveries/{id}/pickup` | Get pickup details | Bearer | 50/min |

---

## Section 11: Webhook APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/webhooks` | List webhook subscriptions | Bearer | 50/min |
| `GET` | `/webhooks/{id}` | Get subscription details | Bearer | 50/min |
| `POST` | `/webhooks` | Create subscription | Bearer | 20/min |
| `PUT` | `/webhooks/{id}` | Update subscription | Bearer | 20/min |
| `DELETE` | `/webhooks/{id}` | Delete subscription | Bearer | 20/min |
| `PATCH` | `/webhooks/{id}/status` | Update subscription status | Bearer | 20/min |
| `POST` | `/webhooks/{id}/rotate-secret` | Rotate webhook secret | Bearer | 20/min |
| `POST` | `/webhooks/{id}/test` | Test webhook delivery | Bearer | 20/min |
| `GET` | `/webhooks/{id}/deliveries` | Get delivery history | Bearer | 50/min |
| `POST` | `/webhooks/deliveries/{id}/retry` | Retry failed delivery | Bearer | 20/min |
| `GET` | `/webhooks/events` | Query events | Bearer | 50/min |
| `GET` | `/webhooks/events/{id}` | Get event details | Bearer | 50/min |
| `POST` | `/webhooks/events/replay` | Replay events (admin) | Admin | 10/min |

---

## Section 12: Webhook Provider Endpoints

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/webhooks/stripe` | Stripe webhook endpoint | Webhook | N/A |
| `POST` | `/webhooks/paymob` | Paymob webhook endpoint | Webhook | N/A |
| `POST` | `/webhooks/adyen` | Adyen webhook endpoint | Webhook | N/A |
| `POST` | `/webhooks/checkout` | Checkout.com webhook endpoint | Webhook | N/A |

---

## Section 13: Admin Order Management APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/orders` | List all orders | Admin | 50/min |
| `GET` | `/admin/orders/{id}` | Get order details | Admin | 50/min |
| `PUT` | `/admin/orders/{id}/status` | Force status change | Admin | 20/min |
| `PUT` | `/admin/orders/{id}/cancel` | Force cancellation | Admin | 20/min |
| `POST` | `/admin/orders/{id}/archive` | Archive order | Admin | 20/min |
| `POST` | `/admin/orders/{id}/refund` | Process refund | Admin | 20/min |
| `POST` | `/admin/orders/{id}/note` | Add order note | Admin | 50/min |

---

## Section 14: Admin Merchant Management APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/merchants` | List merchants | Admin | 50/min |
| `GET` | `/admin/merchants/{id}` | Get merchant details | Admin | 50/min |
| `PUT` | `/admin/merchants/{id}/approve` | Approve merchant | Admin | 20/min |
| `PUT` | `/admin/merchants/{id}/reject` | Reject merchant | Admin | 20/min |
| `PUT` | `/admin/merchants/{id}/suspend` | Suspend merchant | Admin | 20/min |
| `PUT` | `/admin/merchants/{id}/reactivate` | Reactivate merchant | Admin | 20/min |
| `PUT` | `/admin/merchants/{id}/commission` | Update commission | Admin | 20/min |
| `GET` | `/admin/merchants/{id}/settlements` | Get merchant settlements | Admin | 50/min |
| `POST` | `/admin/merchants/{id}/settlements/process` | Process settlement | Admin | 20/min |
| `POST` | `/admin/merchants/{id}/adjustments` | Create adjustment | Admin | 20/min |
| `POST` | `/admin/merchants/{id}/payouts/process` | Process payout | Admin | 20/min |

---

## Section 15: Admin Driver Management APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/drivers` | List drivers | Admin | 50/min |
| `GET` | `/admin/drivers/{id}` | Get driver details | Admin | 50/min |
| `PUT` | `/admin/drivers/{id}/approve` | Approve driver | Admin | 20/min |
| `PUT` | `/admin/drivers/{id}/reject` | Reject driver | Admin | 20/min |
| `PUT` | `/admin/drivers/{id}/suspend` | Suspend driver | Admin | 20/min |
| `PUT` | `/admin/drivers/{id}/reactivate` | Reactivate driver | Admin | 20/min |
| `GET` | `/admin/drivers/{id}/performance` | Get driver performance | Admin | 50/min |
| `POST` | `/admin/drivers/{id}/earnings/adjust` | Adjust driver earnings | Admin | 20/min |
| `POST` | `/admin/drivers/{id}/payouts/process` | Process payout | Admin | 20/min |

---

## Section 16: Admin Support APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/support/tickets` | List tickets | Admin | 50/min |
| `GET` | `/admin/support/tickets/{id}` | Get ticket details | Admin | 50/min |
| `POST` | `/admin/support/tickets/{id}/respond` | Respond to ticket | Admin | 50/min |
| `PUT` | `/admin/support/tickets/{id}/assign` | Assign ticket | Admin | 50/min |
| `PUT` | `/admin/support/tickets/{id}/status` | Update ticket status | Admin | 50/min |

---

## Section 17: Admin Audit APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/audit` | Get audit logs | Admin | 50/min |
| `GET` | `/admin/audit/users` | Get user activity | Admin | 50/min |
| `GET` | `/admin/audit/export` | Export audit logs | Admin | 20/min |

---

## Section 18: Admin User Management APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/users` | List admin users | Admin | 50/min |
| `POST` | `/admin/users` | Create admin user | Admin | 20/min |
| `GET` | `/admin/users/{id}` | Get user details | Admin | 50/min |
| `PUT` | `/admin/users/{id}` | Update user | Admin | 50/min |
| `DELETE` | `/admin/users/{id}` | Delete user | Admin | 20/min |
| `PUT` | `/admin/users/{id}/role` | Update user role | Admin | 20/min |

---

## Section 19: Admin Configuration APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/config` | Get platform configuration | Admin | 50/min |
| `PUT` | `/admin/config` | Update platform configuration | Admin | 20/min |
| `GET` | `/admin/config/{key}` | Get specific configuration | Admin | 50/min |
| `PUT` | `/admin/config/{key}` | Update specific configuration | Admin | 20/min |

---

## Section 20: Admin Analytics APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/analytics/dashboard` | Get analytics dashboard | Admin | 50/min |
| `GET` | `/admin/analytics/metrics` | Get platform metrics | Admin | 50/min |
| `GET` | `/admin/analytics/reports` | Get analytics reports | Admin | 20/min |
| `GET` | `/admin/analytics/export` | Export analytics data | Admin | 20/min |

---

## Section 21: Admin Fraud APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/fraud/alerts` | Get fraud alerts | Admin | 50/min |
| `GET` | `/admin/fraud/alerts/{id}` | Get alert details | Admin | 50/min |
| `PUT` | `/admin/fraud/alerts/{id}/investigate` | Investigate alert | Admin | 20/min |
| `PUT` | `/admin/fraud/alerts/{id}/resolve` | Resolve alert | Admin | 20/min |
| `GET` | `/admin/fraud/blacklist` | Get blacklist entries | Admin | 50/min |
| `POST` | `/admin/fraud/blacklist` | Add to blacklist | Admin | 20/min |
| `DELETE` | `/admin/fraud/blacklist/{id}` | Remove from blacklist | Admin | 20/min |

---

## Section 22: Admin Finance APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/admin/finance/summary` | Get financial summary | Admin | 50/min |
| `GET` | `/admin/finance/transactions` | List transactions | Admin | 50/min |
| `GET` | `/admin/finance/transactions/{id}` | Get transaction details | Admin | 50/min |
| `GET` | `/admin/finance/reconciliation` | Get reconciliation status | Admin | 50/min |
| `POST` | `/admin/finance/reconciliation/run` | Run reconciliation | Admin | 20/min |

---

## Section 23: API Key Management APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api-keys` | List API keys | Bearer | 50/min |
| `POST` | `/api-keys` | Create API key | Bearer | 20/min |
| `GET` | `/api-keys/{id}` | Get API key details | Bearer | 50/min |
| `PUT` | `/api-keys/{id}` | Update API key | Bearer | 50/min |
| `DELETE` | `/api-keys/{id}` | Delete API key | Bearer | 20/min |
| `POST` | `/api-keys/{id}/rotate` | Rotate API key | Bearer | 20/min |

---

## Section 24: API Analytics APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api-analytics` | Get API analytics | Bearer | 50/min |
| `GET` | `/api-analytics/endpoints` | Get endpoint analytics | Bearer | 50/min |
| `GET` | `/api-analytics/consumers` | Get consumer analytics | Bearer | 50/min |

---

## Section 25: API Documentation APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api-docs` | Get OpenAPI specification | None | 100/min |
| `GET` | `/api-docs/{version}` | Get version-specific spec | None | 100/min |
| `GET` | `/api-docs/versions` | Get available versions | None | 100/min |

---

## Section 26: Developer Portal APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/developer/register` | Register developer account | None | 10/min |
| `POST` | `/developer/login` | Developer login | None | 10/min |
| `POST` | `/developer/logout` | Developer logout | Bearer | 20/min |
| `POST` | `/developer/verify-email` | Verify email | None | 10/min |
| `POST` | `/developer/forgot-password` | Forgot password | None | 5/min |
| `POST` | `/developer/reset-password` | Reset password | None | 5/min |
| `GET` | `/developer/api-keys` | List API keys | Bearer | 50/min |
| `POST` | `/developer/api-keys` | Create API key | Bearer | 20/min |
| `GET` | `/developer/api-keys/{id}` | Get API key details | Bearer | 50/min |
| `PUT` | `/developer/api-keys/{id}` | Update API key | Bearer | 50/min |
| `DELETE` | `/developer/api-keys/{id}` | Delete API key | Bearer | 20/min |
| `POST` | `/developer/api-keys/{id}/rotate` | Rotate API key | Bearer | 20/min |
| `GET` | `/developer/webhooks` | List webhooks | Bearer | 50/min |
| `POST` | `/developer/webhooks` | Create webhook | Bearer | 20/min |
| `GET` | `/developer/webhooks/{id}` | Get webhook details | Bearer | 50/min |
| `PUT` | `/developer/webhooks/{id}` | Update webhook | Bearer | 50/min |
| `DELETE` | `/developer/webhooks/{id}` | Delete webhook | Bearer | 20/min |
| `POST` | `/developer/webhooks/{id}/test` | Test webhook | Bearer | 20/min |
| `GET` | `/developer/webhooks/{id}/deliveries` | Get webhook deliveries | Bearer | 50/min |
| `POST` | `/developer/webhooks/{id}/retry` | Retry delivery | Bearer | 20/min |
| `GET` | `/developer/docs` | Get documentation | Bearer | 100/min |
| `GET` | `/developer/docs/{slug}` | Get document | Bearer | 100/min |
| `GET` | `/developer/docs/search` | Search documentation | Bearer | 100/min |
| `GET` | `/developer/docs/versions` | Get API versions | Bearer | 100/min |
| `GET` | `/developer/docs/spec` | Get OpenAPI spec | Bearer | 100/min |
| `GET` | `/developer/sdk` | List SDKs | Bearer | 50/min |
| `GET` | `/developer/sdk/{language}` | Get SDK details | Bearer | 50/min |
| `GET` | `/developer/sdk/{language}/download` | Download SDK | Bearer | 50/min |
| `GET` | `/developer/sdk/{language}/docs` | Get SDK docs | Bearer | 50/min |
| `GET` | `/developer/usage` | Get usage metrics | Bearer | 50/min |
| `GET` | `/developer/usage/daily` | Get daily usage | Bearer | 50/min |
| `GET` | `/developer/usage/monthly` | Get monthly usage | Bearer | 50/min |
| `GET` | `/developer/usage/endpoints` | Get endpoint usage | Bearer | 50/min |
| `GET` | `/developer/forum` | List forum posts | Bearer | 50/min |
| `POST` | `/developer/forum` | Create forum post | Bearer | 20/min |
| `GET` | `/developer/forum/{id}` | Get forum post | Bearer | 50/min |
| `PUT` | `/developer/forum/{id}` | Update forum post | Bearer | 50/min |
| `POST` | `/developer/forum/{id}/reply` | Reply to post | Bearer | 20/min |
| `POST` | `/developer/forum/{id}/upvote` | Upvote post | Bearer | 20/min |
| `GET` | `/developer/status` | Get platform status | None | 100/min |
| `GET` | `/developer/status/history` | Get status history | None | 100/min |
| `GET` | `/developer/status/metrics` | Get status metrics | None | 100/min |

---

## Section 27: API Marketplace APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/marketplace/apis` | List APIs | Bearer | 50/min |
| `GET` | `/marketplace/apis/{id}` | Get API details | Bearer | 50/min |
| `GET` | `/marketplace/apis/categories` | Get API categories | Bearer | 50/min |
| `GET` | `/marketplace/apis/search` | Search APIs | Bearer | 50/min |
| `POST` | `/marketplace/apis` | Create API (partner) | Bearer | 20/min |
| `PUT` | `/marketplace/apis/{id}` | Update API (partner) | Bearer | 20/min |
| `DELETE` | `/marketplace/apis/{id}` | Delete API (partner) | Bearer | 20/min |
| `GET` | `/marketplace/plans` | List plans | Bearer | 50/min |
| `GET` | `/marketplace/plans/{id}` | Get plan details | Bearer | 50/min |
| `POST` | `/marketplace/plans` | Create plan (partner) | Bearer | 20/min |
| `PUT` | `/marketplace/plans/{id}` | Update plan (partner) | Bearer | 20/min |
| `DELETE` | `/marketplace/plans/{id}` | Delete plan (partner) | Bearer | 20/min |
| `GET` | `/marketplace/apis/{id}/plans` | Get API plans | Bearer | 50/min |
| `GET` | `/marketplace/subscriptions` | List subscriptions | Bearer | 50/min |
| `GET` | `/marketplace/subscriptions/{id}` | Get subscription details | Bearer | 50/min |
| `POST` | `/marketplace/subscriptions` | Create subscription | Bearer | 20/min |
| `PUT` | `/marketplace/subscriptions/{id}` | Update subscription | Bearer | 20/min |
| `DELETE` | `/marketplace/subscriptions/{id}` | Cancel subscription | Bearer | 20/min |
| `POST` | `/marketplace/subscriptions/{id}/pause` | Pause subscription | Bearer | 20/min |
| `POST` | `/marketplace/subscriptions/{id}/resume` | Resume subscription | Bearer | 20/min |
| `POST` | `/marketplace/subscriptions/{id}/upgrade` | Upgrade subscription | Bearer | 20/min |
| `POST` | `/marketplace/partners/register` | Register as partner | Bearer | 10/min |
| `GET` | `/marketplace/partners/profile` | Get partner profile | Bearer | 50/min |
| `PUT` | `/marketplace/partners/profile` | Update partner profile | Bearer | 50/min |
| `GET` | `/marketplace/partners/dashboard` | Get partner dashboard | Bearer | 50/min |
| `GET` | `/marketplace/partners/analytics` | Get partner analytics | Bearer | 50/min |
| `GET` | `/marketplace/billing/invoices` | List invoices | Bearer | 50/min |
| `GET` | `/marketplace/billing/invoices/{id}` | Get invoice details | Bearer | 50/min |
| `GET` | `/marketplace/billing/invoices/{id}/download` | Download invoice | Bearer | 20/min |
| `GET` | `/marketplace/billing/payment-methods` | Get payment methods | Bearer | 50/min |
| `POST` | `/marketplace/billing/payment-methods` | Add payment method | Bearer | 50/min |
| `DELETE` | `/marketplace/billing/payment-methods/{id}` | Delete payment method | Bearer | 50/min |
| `GET` | `/marketplace/usage` | Get usage metrics | Bearer | 50/min |
| `GET` | `/marketplace/usage/subscription/{id}` | Get subscription usage | Bearer | 50/min |
| `GET` | `/marketplace/usage/daily` | Get daily usage | Bearer | 50/min |
| `GET` | `/marketplace/usage/monthly` | Get monthly usage | Bearer | 50/min |
| `GET` | `/marketplace/analytics` | Get marketplace analytics | Admin | 50/min |
| `GET` | `/marketplace/analytics/apis` | Get API analytics | Admin | 50/min |
| `GET` | `/marketplace/analytics/partners` | Get partner analytics | Admin | 50/min |
| `GET` | `/marketplace/analytics/revenue` | Get revenue analytics | Admin | 50/min |

---

## Section 28: Integration APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/integrations/payment/providers` | List payment providers | Admin | 50/min |
| `GET` | `/integrations/payment/providers/{id}` | Get provider details | Admin | 50/min |
| `POST` | `/integrations/payment/providers` | Add payment provider | Admin | 20/min |
| `PUT` | `/integrations/payment/providers/{id}` | Update payment provider | Admin | 20/min |
| `DELETE` | `/integrations/payment/providers/{id}` | Remove payment provider | Admin | 20/min |
| `GET` | `/integrations/payment/providers/health` | Get provider health status | Admin | 50/min |
| `GET` | `/integrations/payment/reconciliations` | List reconciliations | Admin | 50/min |
| `GET` | `/integrations/payment/reconciliations/{id}` | Get reconciliation details | Admin | 50/min |
| `POST` | `/integrations/payment/reconciliations` | Run reconciliation | Admin | 20/min |
| `GET` | `/integrations/payment/reconciliations/{id}/download` | Download reconciliation report | Admin | 20/min |
| `GET` | `/integrations/payment/transactions` | List provider transactions | Admin | 50/min |
| `GET` | `/integrations/payment/transactions/{id}` | Get transaction details | Admin | 50/min |
| `GET` | `/integrations/payment/transactions/provider/{provider}` | Get transactions by provider | Admin | 50/min |
| `GET` | `/integrations/erp-pos/syncs` | List syncs | Admin | 50/min |
| `GET` | `/integrations/erp-pos/syncs/{id}` | Get sync details | Admin | 50/min |
| `POST` | `/integrations/erp-pos/syncs` | Create sync | Admin | 20/min |
| `POST` | `/integrations/erp-pos/syncs/{id}/start` | Start sync | Admin | 20/min |
| `POST` | `/integrations/erp-pos/syncs/{id}/retry` | Retry sync | Admin | 20/min |
| `GET` | `/integrations/erp-pos/syncs/status` | Get sync status | Admin | 50/min |
| `GET` | `/integrations/erp-pos/mappings` | List mappings | Admin | 50/min |
| `GET` | `/integrations/erp-pos/mappings/{id}` | Get mapping details | Admin | 50/min |
| `POST` | `/integrations/erp-pos/mappings` | Create mapping | Admin | 20/min |
| `PUT` | `/integrations/erp-pos/mappings/{id}` | Update mapping | Admin | 20/min |
| `DELETE` | `/integrations/erp-pos/mappings/{id}` | Delete mapping | Admin | 20/min |
| `GET` | `/integrations/erp-pos/connections` | List connections | Admin | 50/min |
| `GET` | `/integrations/erp-pos/connections/{id}` | Get connection details | Admin | 50/min |
| `POST` | `/integrations/erp-pos/connections` | Create connection | Admin | 20/min |
| `PUT` | `/integrations/erp-pos/connections/{id}` | Update connection | Admin | 20/min |
| `DELETE` | `/integrations/erp-pos/connections/{id}` | Delete connection | Admin | 20/min |
| `POST` | `/integrations/erp-pos/connections/{id}/test` | Test connection | Admin | 20/min |
| `GET` | `/integrations/crm/syncs` | List syncs | Admin | 50/min |
| `GET` | `/integrations/crm/syncs/{id}` | Get sync details | Admin | 50/min |
| `POST` | `/integrations/crm/syncs` | Create sync | Admin | 20/min |
| `POST` | `/integrations/crm/syncs/{id}/start` | Start sync | Admin | 20/min |
| `POST` | `/integrations/crm/syncs/{id}/retry` | Retry sync | Admin | 20/min |
| `GET` | `/integrations/crm/syncs/status` | Get sync status | Admin | 50/min |
| `GET` | `/integrations/crm/mappings` | List mappings | Admin | 50/min |
| `GET` | `/integrations/crm/mappings/{id}` | Get mapping details | Admin | 50/min |
| `POST` | `/integrations/crm/mappings` | Create mapping | Admin | 20/min |
| `PUT` | `/integrations/crm/mappings/{id}` | Update mapping | Admin | 20/min |
| `DELETE` | `/integrations/crm/mappings/{id}` | Delete mapping | Admin | 20/min |
| `GET` | `/integrations/crm/connections` | List connections | Admin | 50/min |
| `GET` | `/integrations/crm/connections/{id}` | Get connection details | Admin | 50/min |
| `POST` | `/integrations/crm/connections` | Create connection | Admin | 20/min |
| `PUT` | `/integrations/crm/connections/{id}` | Update connection | Admin | 20/min |
| `DELETE` | `/integrations/crm/connections/{id}` | Delete connection | Admin | 20/min |
| `POST` | `/integrations/crm/connections/{id}/test` | Test connection | Admin | 20/min |

---

## Section 29: Mapping APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/maps/geocode` | Forward geocoding | Bearer | 100/min |
| `POST` | `/maps/reverse-geocode` | Reverse geocoding | Bearer | 100/min |
| `POST` | `/maps/batch-geocode` | Batch geocoding | Bearer | 50/min |
| `POST` | `/maps/autocomplete` | Address autocomplete | Bearer | 100/min |
| `POST` | `/maps/validate` | Address validation | Bearer | 100/min |
| `POST` | `/maps/distance` | Calculate distance | Bearer | 100/min |
| `POST` | `/maps/distance/matrix` | Calculate distance matrix | Bearer | 50/min |
| `POST` | `/maps/distance/batch` | Batch distance calculations | Bearer | 50/min |
| `POST` | `/maps/route` | Calculate route | Bearer | 100/min |
| `POST` | `/maps/route/optimize` | Optimize multi-stop route | Bearer | 50/min |
| `GET` | `/maps/route/{id}` | Get cached route | Bearer | 100/min |
| `GET` | `/maps/tiles/{z}/{x}/{y}` | Get map tile | Bearer | 200/min |
| `GET` | `/maps/style` | Get map style configuration | Bearer | 100/min |
| `POST` | `/maps/markers` | Get marker data | Bearer | 100/min |
| `GET` | `/maps/providers` | List providers | Admin | 50/min |
| `GET` | `/maps/providers/{id}` | Get provider details | Admin | 50/min |
| `GET` | `/maps/providers/health` | Get provider health status | Admin | 50/min |
| `GET` | `/maps/providers/usage` | Get provider usage metrics | Admin | 50/min |

---

## Section 30: Federation (SSO) APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/federation/providers` | List identity providers | Admin | 50/min |
| `GET` | `/federation/providers/{id}` | Get provider details | Admin | 50/min |
| `POST` | `/federation/providers` | Create provider | Admin | 20/min |
| `PUT` | `/federation/providers/{id}` | Update provider | Admin | 20/min |
| `DELETE` | `/federation/providers/{id}` | Delete provider | Admin | 20/min |
| `GET` | `/federation/providers/{id}/metadata` | Get provider metadata | Admin | 50/min |
| `POST` | `/federation/providers/{id}/test` | Test provider connection | Admin | 20/min |
| `GET` | `/federation/mappings` | List mappings | Admin | 50/min |
| `GET` | `/federation/mappings/{id}` | Get mapping details | Admin | 50/min |
| `POST` | `/federation/mappings` | Create mapping | Admin | 20/min |
| `PUT` | `/federation/mappings/{id}` | Update mapping | Admin | 20/min |
| `DELETE` | `/federation/mappings/{id}` | Delete mapping | Admin | 20/min |
| `GET` | `/federation/audit` | List audit logs | Admin | 50/min |
| `GET` | `/federation/audit/{id}` | Get audit details | Admin | 50/min |
| `GET` | `/federation/audit/provider/{id}` | Get audit logs by provider | Admin | 50/min |

---

## Section 31: Notification APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/notifications` | Send notification | Bearer | 50/min |
| `POST` | `/notifications/schedule` | Schedule notification | Bearer | 20/min |
| `GET` | `/notifications` | List notifications | Bearer | 50/min |
| `GET` | `/notifications/{id}` | Get notification details | Bearer | 50/min |
| `GET` | `/notifications/user/{id}` | Get notifications for user | Bearer | 50/min |
| `PUT` | `/notifications/{id}/status` | Update notification status | Bearer | 50/min |
| `POST` | `/notifications/{id}/retry` | Retry failed notification | Admin | 20/min |
| `GET` | `/notifications/templates` | List templates | Bearer | 50/min |
| `GET` | `/notifications/templates/{id}` | Get template details | Bearer | 50/min |
| `POST` | `/notifications/templates` | Create template | Admin | 20/min |
| `PUT` | `/notifications/templates/{id}` | Update template | Admin | 20/min |
| `DELETE` | `/notifications/templates/{id}` | Delete template | Admin | 20/min |
| `POST` | `/notifications/templates/{id}/preview` | Preview template | Bearer | 50/min |
| `POST` | `/notifications/templates/{id}/test` | Send test notification | Bearer | 20/min |
| `GET` | `/notifications/preferences` | Get user notification preferences | Bearer | 50/min |
| `PUT` | `/notifications/preferences` | Update user notification preferences | Bearer | 50/min |
| `PUT` | `/notifications/preferences/channel` | Update channel preference | Bearer | 50/min |
| `PUT` | `/notifications/preferences/event` | Update event category preference | Bearer | 50/min |
| `POST` | `/notifications/preferences/unsubscribe` | Unsubscribe from all notifications | Bearer | 10/min |
| `GET` | `/notifications/analytics/dashboard` | Get notification analytics | Admin | 50/min |
| `GET` | `/notifications/analytics/metrics` | Get notification metrics | Admin | 50/min |
| `GET` | `/notifications/analytics/reports` | Get notification reports | Admin | 20/min |
| `POST` | `/notifications/webhooks` | Register webhook | Bearer | 20/min |
| `GET` | `/notifications/webhooks` | List webhooks | Bearer | 50/min |
| `PUT` | `/notifications/webhooks/{id}` | Update webhook | Bearer | 50/min |
| `DELETE` | `/notifications/webhooks/{id}` | Delete webhook | Bearer | 20/min |
| `POST` | `/notifications/webhooks/{id}/test` | Test webhook | Bearer | 20/min |

---

## Section 32: Push Notification APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/push/device/register` | Register device token | Bearer | 20/min |
| `POST` | `/push/device/unregister` | Unregister device token | Bearer | 20/min |
| `PUT` | `/push/device/update` | Update device metadata | Bearer | 20/min |
| `GET` | `/push/device` | Get user's devices | Bearer | 50/min |
| `DELETE` | `/push/device/{id}` | Remove device | Bearer | 20/min |
| `POST` | `/push/send` | Send push notification | Bearer | 50/min |
| `POST` | `/push/send/bulk` | Send bulk push notification | Bearer | 20/min |
| `POST` | `/push/schedule` | Schedule push notification | Bearer | 20/min |
| `GET` | `/push/notifications` | Get push notifications | Bearer | 50/min |
| `GET` | `/push/notifications/{id}` | Get notification details | Bearer | 50/min |
| `POST` | `/push/notifications/{id}/cancel` | Cancel scheduled notification | Bearer | 20/min |
| `GET` | `/push/segments` | List segments | Admin | 50/min |
| `GET` | `/push/segments/{id}` | Get segment details | Admin | 50/min |
| `POST` | `/push/segments` | Create segment | Admin | 20/min |
| `PUT` | `/push/segments/{id}` | Update segment | Admin | 20/min |
| `DELETE` | `/push/segments/{id}` | Delete segment | Admin | 20/min |
| `GET` | `/push/segments/{id}/users` | Get users in segment | Admin | 50/min |
| `GET` | `/push/analytics/dashboard` | Get push analytics dashboard | Admin | 50/min |
| `GET` | `/push/analytics/metrics` | Get push metrics | Admin | 50/min |
| `GET` | `/push/analytics/reports` | Get push reports | Admin | 20/min |
| `GET` | `/push/analytics/notification/{id}` | Get notification analytics | Admin | 50/min |

---

## Section 33: Email APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/email/send` | Send email | Bearer | 50/min |
| `POST` | `/email/send/bulk` | Send bulk email | Bearer | 20/min |
| `GET` | `/email/emails` | List emails | Bearer | 50/min |
| `GET` | `/email/emails/{id}` | Get email details | Bearer | 50/min |
| `GET` | `/email/user/{id}` | Get emails for user | Bearer | 50/min |
| `GET` | `/email/templates` | List templates | Bearer | 50/min |
| `GET` | `/email/templates/{id}` | Get template details | Bearer | 50/min |
| `POST` | `/email/templates` | Create template | Admin | 20/min |
| `PUT` | `/email/templates/{id}` | Update template | Admin | 20/min |
| `DELETE` | `/email/templates/{id}` | Delete template | Admin | 20/min |
| `POST` | `/email/templates/{id}/preview` | Preview template | Bearer | 50/min |
| `POST` | `/email/templates/{id}/test` | Send test email | Bearer | 20/min |
| `GET` | `/email/campaigns` | List campaigns | Admin | 50/min |
| `GET` | `/email/campaigns/{id}` | Get campaign details | Admin | 50/min |
| `POST` | `/email/campaigns` | Create campaign | Admin | 20/min |
| `PUT` | `/email/campaigns/{id}` | Update campaign | Admin | 20/min |
| `DELETE` | `/email/campaigns/{id}` | Delete campaign | Admin | 20/min |
| `POST` | `/email/campaigns/{id}/schedule` | Schedule campaign | Admin | 20/min |
| `POST` | `/email/campaigns/{id}/send` | Send campaign now | Admin | 20/min |
| `POST` | `/email/campaigns/{id}/pause` | Pause campaign | Admin | 20/min |
| `POST` | `/email/campaigns/{id}/resume` | Resume campaign | Admin | 20/min |
| `GET` | `/email/preferences` | Get email preferences | Bearer | 50/min |
| `PUT` | `/email/preferences` | Update email preferences | Bearer | 50/min |
| `POST` | `/email/unsubscribe` | Unsubscribe from emails | Bearer | 10/min |
| `GET` | `/email/analytics/dashboard` | Get email analytics | Admin | 50/min |
| `GET` | `/email/analytics/metrics` | Get email metrics | Admin | 50/min |
| `GET` | `/email/analytics/reports` | Get email reports | Admin | 20/min |

---

## Section 34: SMS APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/sms/send` | Send SMS | Bearer | 50/min |
| `POST` | `/sms/send/bulk` | Send bulk SMS | Bearer | 20/min |
| `GET` | `/sms/messages` | List SMS messages | Bearer | 50/min |
| `GET` | `/sms/messages/{id}` | Get SMS details | Bearer | 50/min |
| `GET` | `/sms/user/{id}` | Get SMS for user | Bearer | 50/min |
| `POST` | `/sms/messages/{id}/retry` | Retry failed SMS | Admin | 20/min |
| `GET` | `/sms/templates` | List templates | Bearer | 50/min |
| `GET` | `/sms/templates/{id}` | Get template details | Bearer | 50/min |
| `POST` | `/sms/templates` | Create template | Admin | 20/min |
| `PUT` | `/sms/templates/{id}` | Update template | Admin | 20/min |
| `DELETE` | `/sms/templates/{id}` | Delete template | Admin | 20/min |
| `POST` | `/sms/templates/{id}/preview` | Preview template | Bearer | 50/min |
| `POST` | `/sms/templates/{id}/test` | Send test SMS | Bearer | 20/min |
| `GET` | `/sms/campaigns` | List campaigns | Admin | 50/min |
| `GET` | `/sms/campaigns/{id}` | Get campaign details | Admin | 50/min |
| `POST` | `/sms/campaigns` | Create campaign | Admin | 20/min |
| `PUT` | `/sms/campaigns/{id}` | Update campaign | Admin | 20/min |
| `DELETE` | `/sms/campaigns/{id}` | Delete campaign | Admin | 20/min |
| `POST` | `/sms/campaigns/{id}/schedule` | Schedule campaign | Admin | 20/min |
| `POST` | `/sms/campaigns/{id}/send` | Send campaign now | Admin | 20/min |
| `POST` | `/sms/campaigns/{id}/pause` | Pause campaign | Admin | 20/min |
| `POST` | `/sms/campaigns/{id}/resume` | Resume campaign | Admin | 20/min |
| `POST` | `/sms/optout` | Opt out of SMS | Bearer | 10/min |
| `POST` | `/sms/optin` | Re-opt in to SMS | Bearer | 10/min |
| `GET` | `/sms/optout` | Get opt-out status | Bearer | 50/min |
| `GET` | `/sms/optout/list` | Get opt-out list (admin) | Admin | 50/min |
| `GET` | `/sms/analytics/dashboard` | Get SMS analytics | Admin | 50/min |
| `GET` | `/sms/analytics/metrics` | Get SMS metrics | Admin | 50/min |
| `GET` | `/sms/analytics/reports` | Get SMS reports | Admin | 20/min |

---

## Section 35: Messaging APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/messaging/conversations` | List conversations | Bearer | 50/min |
| `GET` | `/messaging/conversations/{id}` | Get conversation details | Bearer | 50/min |
| `POST` | `/messaging/conversations` | Create conversation | Bearer | 20/min |
| `PUT` | `/messaging/conversations/{id}` | Update conversation | Bearer | 50/min |
| `DELETE` | `/messaging/conversations/{id}` | Delete conversation | Bearer | 20/min |
| `GET` | `/messaging/conversations/{id}/messages` | Get messages | Bearer | 50/min |
| `POST` | `/messaging/conversations/{id}/messages` | Send message | Bearer | 50/min |
| `POST` | `/messaging/conversations/{id}/leave` | Leave conversation | Bearer | 20/min |
| `POST` | `/messaging/conversations/{id}/participants` | Add participant | Bearer | 20/min |
| `DELETE` | `/messaging/conversations/{id}/participants/{id}` | Remove participant | Bearer | 20/min |
| `GET` | `/messaging/messages/{id}` | Get message details | Bearer | 50/min |
| `PUT` | `/messaging/messages/{id}` | Edit message | Bearer | 50/min |
| `DELETE` | `/messaging/messages/{id}` | Delete message | Bearer | 20/min |
| `POST` | `/messaging/messages/{id}/read` | Mark message as read | Bearer | 50/min |
| `POST` | `/messaging/messages/{id}/report` | Report message | Bearer | 20/min |
| `POST` | `/messaging/messages/{id}/react` | Add reaction | Bearer | 50/min |
| `DELETE` | `/messaging/messages/{id}/react` | Remove reaction | Bearer | 50/min |
| `GET` | `/messaging/participants` | List participants | Bearer | 50/min |
| `GET` | `/messaging/participants/{id}` | Get participant details | Bearer | 50/min |
| `PUT` | `/messaging/participants/{id}` | Update participant | Bearer | 50/min |
| `PUT` | `/messaging/participants/{id}/mute` | Mute conversation | Bearer | 50/min |
| `PUT` | `/messaging/participants/{id}/unmute` | Unmute conversation | Bearer | 50/min |
| `PUT` | `/messaging/participants/{id}/block` | Block participant | Bearer | 20/min |
| `PUT` | `/messaging/participants/{id}/unblock` | Unblock participant | Bearer | 20/min |

---

## Section 36: Subscription APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/subscriptions/plans` | List available plans | Bearer | 50/min |
| `GET` | `/subscriptions/plans/{id}` | Get plan details | Bearer | 50/min |
| `GET` | `/customers/me/subscription` | Get current subscription | Bearer | 50/min |
| `POST` | `/customers/me/subscription` | Create subscription | Bearer | 20/min |
| `PUT` | `/customers/me/subscription` | Update subscription | Bearer | 20/min |
| `POST` | `/customers/me/subscription/cancel` | Cancel subscription | Bearer | 20/min |
| `POST` | `/customers/me/subscription/pause` | Pause subscription | Bearer | 20/min |
| `POST` | `/customers/me/subscription/resume` | Resume subscription | Bearer | 20/min |
| `GET` | `/customers/me/subscription/invoices` | Get subscription invoices | Bearer | 50/min |
| `GET` | `/customers/me/subscription/invoices/{id}` | Get invoice details | Bearer | 50/min |
| `GET` | `/customers/me/subscription/invoices/{id}/download` | Download invoice PDF | Bearer | 20/min |

---

## Section 37: Privacy APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/privacy/consents` | Get user consents | Bearer | 50/min |
| `PUT` | `/privacy/consents` | Update user consents | Bearer | 50/min |
| `POST` | `/privacy/consents` | Record consent | Bearer | 50/min |
| `POST` | `/privacy/sar` | Submit subject access request | Bearer | 5/min |
| `GET` | `/privacy/sar` | Get SAR status | Bearer | 50/min |
| `GET` | `/privacy/sar/{id}` | Get SAR details | Bearer | 50/min |
| `GET` | `/privacy/sar/{id}/download` | Download SAR response | Bearer | 20/min |
| `GET` | `/privacy/policy` | Get privacy policy | None | 100/min |
| `GET` | `/privacy/rights` | Get data subject rights information | None | 100/min |

---

## Section 38: Analytics APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/analytics/dashboards` | List dashboards | Admin | 50/min |
| `GET` | `/analytics/dashboards/{id}` | Get dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/executive` | Get executive dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/operations` | Get operations dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/customer` | Get customer dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/merchant` | Get merchant dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/driver` | Get driver dashboard | Admin | 50/min |
| `GET` | `/analytics/dashboards/financial` | Get financial dashboard | Admin | 50/min |
| `GET` | `/analytics/kpis` | List KPIs | Admin | 50/min |
| `GET` | `/analytics/kpis/{id}` | Get KPI details | Admin | 50/min |
| `GET` | `/analytics/kpis/trends` | Get KPI trends | Admin | 50/min |
| `GET` | `/analytics/reports` | List reports | Admin | 50/min |
| `GET` | `/analytics/reports/{id}` | Get report details | Admin | 50/min |
| `POST` | `/analytics/reports/generate` | Generate report | Admin | 20/min |
| `GET` | `/analytics/reports/{id}/download` | Download report | Admin | 20/min |
| `POST` | `/analytics/reports/schedule` | Schedule report | Admin | 20/min |
| `GET` | `/analytics/segments` | Get customer segments | Admin | 50/min |
| `GET` | `/analytics/segments/{id}` | Get segment details | Admin | 50/min |
| `GET` | `/analytics/forecast` | Get forecasts | Admin | 50/min |
| `GET` | `/analytics/predictions` | Get predictions | Admin | 50/min |
| `GET` | `/analytics/insights` | Get insights | Admin | 50/min |
| `GET` | `/analytics/data/orders` | Get order data | Admin | 50/min |
| `GET` | `/analytics/data/revenue` | Get revenue data | Admin | 50/min |
| `GET` | `/analytics/data/customers` | Get customer data | Admin | 50/min |
| `GET` | `/analytics/data/export` | Export analytics data | Admin | 20/min |

---

## Section 39: Quality APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/quality/tests` | List test suites | Admin | 50/min |
| `GET` | `/quality/tests/{id}` | Get test suite details | Admin | 50/min |
| `POST` | `/quality/tests/run` | Run test suite | Admin | 20/min |
| `GET` | `/quality/tests/status` | Get test status | Admin | 50/min |
| `GET` | `/quality/unit-tests` | List unit tests | Admin | 50/min |
| `GET` | `/quality/unit-tests/{id}` | Get unit test details | Admin | 50/min |
| `GET` | `/quality/unit-tests/coverage` | Get unit test coverage | Admin | 50/min |
| `GET` | `/quality/integration-tests` | List integration tests | Admin | 50/min |
| `GET` | `/quality/integration-tests/{id}` | Get integration test details | Admin | 50/min |
| `GET` | `/quality/contract-tests` | List contract tests | Admin | 50/min |
| `GET` | `/quality/contract-tests/{id}` | Get contract test details | Admin | 50/min |
| `GET` | `/quality/e2e-tests` | List E2E tests | Admin | 50/min |
| `GET` | `/quality/e2e-tests/{id}` | Get E2E test details | Admin | 50/min |
| `POST` | `/quality/e2e-tests/run` | Run E2E tests | Admin | 20/min |
| `GET` | `/quality/performance-tests` | List performance tests | Admin | 50/min |
| `GET` | `/quality/performance-tests/{id}` | Get performance test details | Admin | 50/min |
| `POST` | `/quality/performance-tests/run` | Run performance test | Admin | 20/min |
| `GET` | `/quality/security-tests` | List security tests | Admin | 50/min |
| `GET` | `/quality/security-tests/{id}` | Get security test details | Admin | 50/min |
| `POST` | `/quality/security-tests/run` | Run security test | Admin | 20/min |
| `GET` | `/quality/metrics` | Get quality metrics | Admin | 50/min |
| `GET` | `/quality/metrics/dashboard` | Get quality dashboard | Admin | 50/min |
| `GET` | `/quality/metrics/trends` | Get quality trends | Admin | 50/min |
| `GET` | `/quality/metrics/reports` | Get quality reports | Admin | 20/min |

---

## Section 40: Operations APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/ops/incidents` | List incidents | Admin | 50/min |
| `GET` | `/ops/incidents/{id}` | Get incident details | Admin | 50/min |
| `POST` | `/ops/incidents` | Create incident | Admin | 20/min |
| `PUT` | `/ops/incidents/{id}` | Update incident | Admin | 20/min |
| `POST` | `/ops/incidents/{id}/assign` | Assign incident | Admin | 20/min |
| `POST` | `/ops/incidents/{id}/resolve` | Resolve incident | Admin | 20/min |
| `POST` | `/ops/incidents/{id}/post-mortem` | Add post-mortem | Admin | 20/min |
| `GET` | `/ops/maintenance` | List maintenance events | Admin | 50/min |
| `GET` | `/ops/maintenance/{id}` | Get maintenance details | Admin | 50/min |
| `POST` | `/ops/maintenance` | Schedule maintenance | Admin | 20/min |
| `PUT` | `/ops/maintenance/{id}` | Update maintenance | Admin | 20/min |
| `PUT` | `/ops/maintenance/{id}/status` | Update maintenance status | Admin | 20/min |
| `POST` | `/ops/maintenance/{id}/complete` | Complete maintenance | Admin | 20/min |
| `GET` | `/ops/oncall/schedule` | Get on-call schedule | Admin | 50/min |
| `GET` | `/ops/oncall/current` | Get current on-call | Admin | 50/min |
| `POST` | `/ops/oncall/shifts` | Create shift | Admin | 20/min |
| `PUT` | `/ops/oncall/shifts/{id}` | Update shift | Admin | 20/min |
| `POST` | `/ops/oncall/shifts/{id}/handover` | Record handover | Admin | 20/min |
| `GET` | `/ops/performance/metrics` | Get performance metrics | Admin | 50/min |
| `GET` | `/ops/performance/dashboard` | Get performance dashboard | Admin | 50/min |

---

## Section 41: Security APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/security/alerts` | List security alerts | Admin | 50/min |
| `GET` | `/security/alerts/{id}` | Get alert details | Admin | 50/min |
| `PUT` | `/security/alerts/{id}/status` | Update alert status | Admin | 20/min |
| `PUT` | `/security/alerts/{id}/assign` | Assign alert to analyst | Admin | 20/min |
| `POST` | `/security/alerts/{id}/investigate` | Investigate alert | Admin | 20/min |
| `POST` | `/security/alerts/{id}/mitigate` | Mitigate alert | Admin | 20/min |
| `POST` | `/security/alerts/{id}/resolve` | Resolve alert | Admin | 20/min |
| `GET` | `/security/incidents` | List security incidents | Admin | 50/min |
| `GET` | `/security/incidents/{id}` | Get incident details | Admin | 50/min |
| `POST` | `/security/incidents` | Create incident | Admin | 20/min |
| `PUT` | `/security/incidents/{id}` | Update incident | Admin | 20/min |
| `PUT` | `/security/incidents/{id}/status` | Update incident status | Admin | 20/min |
| `POST` | `/security/incidents/{id}/contain` | Contain incident | Admin | 20/min |
| `POST` | `/security/incidents/{id}/eradicate` | Eradicate threat | Admin | 20/min |
| `POST` | `/security/incidents/{id}/recover` | Recover systems | Admin | 20/min |
| `POST` | `/security/incidents/{id}/resolve` | Resolve incident | Admin | 20/min |
| `POST` | `/security/incidents/{id}/lessons` | Add lessons learned | Admin | 20/min |
| `GET` | `/security/vulnerabilities` | List vulnerabilities | Admin | 50/min |
| `GET` | `/security/vulnerabilities/{id}` | Get vulnerability details | Admin | 50/min |
| `PUT` | `/security/vulnerabilities/{id}` | Update vulnerability | Admin | 20/min |
| `PUT` | `/security/vulnerabilities/{id}/assign` | Assign vulnerability | Admin | 20/min |
| `PUT` | `/security/vulnerabilities/{id}/remediate` | Remediate vulnerability | Admin | 20/min |
| `PUT` | `/security/vulnerabilities/{id}/verify` | Verify remediation | Admin | 20/min |
| `POST` | `/security/scan` | Initiate security scan | Admin | 20/min |
| `GET` | `/security/threat-intel` | List threat intelligence | Admin | 50/min |
| `GET` | `/security/threat-intel/{id}` | Get intelligence details | Admin | 50/min |
| `POST` | `/security/threat-intel` | Add intelligence (admin) | Admin | 20/min |
| `POST` | `/security/threat-intel/import` | Import intelligence feed | Admin | 20/min |
| `GET` | `/security/threat-intel/check` | Check indicator against intel | Admin | 50/min |
| `GET` | `/security/dashboard` | Get security dashboard | Admin | 50/min |
| `GET` | `/security/metrics` | Get security metrics | Admin | 50/min |
| `GET` | `/security/reports` | Get security reports | Admin | 20/min |

---

## Section 42: ESG APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/esg/emissions` | Get carbon emissions data | Admin | 50/min |
| `GET` | `/esg/emissions/{id}` | Get emission details | Admin | 50/min |
| `POST` | `/esg/emissions` | Add emission data | Admin | 20/min |
| `GET` | `/esg/emissions/trends` | Get emission trends | Admin | 50/min |
| `GET` | `/esg/emissions/scope/{scope}` | Get emissions by scope | Admin | 50/min |
| `GET` | `/esg/packaging` | Get packaging data | Admin | 50/min |
| `GET` | `/esg/packaging/{id}` | Get packaging details | Admin | 50/min |
| `POST` | `/esg/packaging` | Add packaging data | Admin | 20/min |
| `GET` | `/esg/packaging/trends` | Get packaging trends | Admin | 50/min |
| `GET` | `/esg/waste` | Get food waste data | Admin | 50/min |
| `GET` | `/esg/waste/{id}` | Get waste details | Admin | 50/min |
| `POST` | `/esg/waste` | Add waste data | Admin | 20/min |
| `GET` | `/esg/waste/trends` | Get waste trends | Admin | 50/min |
| `GET` | `/esg/social` | Get social impact data | Admin | 50/min |
| `GET` | `/esg/social/{id}` | Get social impact details | Admin | 50/min |
| `POST` | `/esg/social` | Add social impact data | Admin | 20/min |
| `GET` | `/esg/social/trends` | Get social impact trends | Admin | 50/min |
| `GET` | `/esg/social/jobs` | Get job creation data | Admin | 50/min |
| `GET` | `/esg/reports` | List ESG reports | Admin | 50/min |
| `GET` | `/esg/reports/{id}` | Get report details | Admin | 50/min |
| `POST` | `/esg/reports` | Create ESG report | Admin | 20/min |
| `PUT` | `/esg/reports/{id}` | Update ESG report | Admin | 20/min |
| `POST` | `/esg/reports/{id}/publish` | Publish ESG report | Admin | 20/min |
| `GET` | `/esg/reports/{id}/download` | Download ESG report | Admin | 20/min |
| `GET` | `/esg/customer/impact` | Get customer impact | Admin | 50/min |
| `GET` | `/esg/customer/impact/{id}` | Get customer impact details | Admin | 50/min |
| `GET` | `/esg/customer/badges` | Get customer sustainability badges | Admin | 50/min |
| `POST` | `/esg/green-delivery` | Opt for green delivery | Bearer | 50/min |
| `GET` | `/esg/green-delivery/options` | Get green delivery options | Bearer | 50/min |
| `POST` | `/esg/green-delivery/offset` | Offset carbon for delivery | Bearer | 20/min |

---

## Section 43: Autonomous Delivery APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/autonomous/fleet` | List autonomous vehicles | Admin | 50/min |
| `GET` | `/autonomous/fleet/{id}` | Get vehicle details | Admin | 50/min |
| `POST` | `/autonomous/fleet` | Register vehicle | Admin | 20/min |
| `PUT` | `/autonomous/fleet/{id}` | Update vehicle | Admin | 20/min |
| `DELETE` | `/autonomous/fleet/{id}` | Remove vehicle | Admin | 20/min |
| `GET` | `/autonomous/fleet/status` | Get fleet status | Admin | 50/min |
| `POST` | `/autonomous/fleet/{id}/charge` | Start charging | Admin | 20/min |
| `POST` | `/autonomous/fleet/{id}/maintenance` | Send for maintenance | Admin | 20/min |
| `GET` | `/autonomous/missions` | List missions | Admin | 50/min |
| `GET` | `/autonomous/missions/{id}` | Get mission details | Admin | 50/min |
| `POST` | `/autonomous/missions` | Create mission | Admin | 20/min |
| `POST` | `/autonomous/missions/{id}/start` | Start mission | Admin | 20/min |
| `POST` | `/autonomous/missions/{id}/complete` | Complete mission | Admin | 20/min |
| `POST` | `/autonomous/missions/{id}/cancel` | Cancel mission | Admin | 20/min |
| `GET` | `/autonomous/missions/{id}/tracking` | Get real-time tracking | Bearer | 100/min |
| `GET` | `/autonomous/lockers` | List smart lockers | Admin | 50/min |
| `GET` | `/autonomous/lockers/{id}` | Get locker details | Admin | 50/min |
| `POST` | `/autonomous/lockers` | Create locker | Admin | 20/min |
| `PUT` | `/autonomous/lockers/{id}` | Update locker | Admin | 20/min |
| `DELETE` | `/autonomous/lockers/{id}` | Delete locker | Admin | 20/min |
| `GET` | `/autonomous/lockers/{id}/availability` | Get availability | Bearer | 50/min |
| `POST` | `/autonomous/lockers/{id}/access` | Access locker compartment | Bearer | 20/min |
| `GET` | `/autonomous/dark-stores` | List dark stores | Admin | 50/min |
| `GET` | `/autonomous/dark-stores/{id}` | Get dark store details | Admin | 50/min |
| `POST` | `/autonomous/dark-stores` | Create dark store | Admin | 20/min |
| `PUT` | `/autonomous/dark-stores/{id}` | Update dark store | Admin | 20/min |
| `DELETE` | `/autonomous/dark-stores/{id}` | Delete dark store | Admin | 20/min |
| `GET` | `/autonomous/dark-stores/{id}/inventory` | Get inventory | Admin | 50/min |
| `GET` | `/autonomous/compliance` | List compliance records | Admin | 50/min |
| `GET` | `/autonomous/compliance/{id}` | Get compliance details | Admin | 50/min |
| `POST` | `/autonomous/compliance` | Create compliance record | Admin | 20/min |
| `PUT` | `/autonomous/compliance/{id}` | Update compliance record | Admin | 20/min |
| `GET` | `/autonomous/emergencies` | List emergencies | Admin | 50/min |
| `GET` | `/autonomous/emergencies/{id}` | Get emergency details | Admin | 50/min |
| `POST` | `/autonomous/emergencies` | Report emergency | Admin | 20/min |
| `PUT` | `/autonomous/emergencies/{id}` | Update emergency | Admin | 20/min |

---

## Section 44: Country APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/countries` | List countries | Admin | 50/min |
| `GET` | `/countries/{id}` | Get country details | Admin | 50/min |
| `POST` | `/countries` | Create country | Admin | 20/min |
| `PUT` | `/countries/{id}` | Update country | Admin | 20/min |
| `DELETE` | `/countries/{id}` | Delete country | Admin | 20/min |
| `GET` | `/countries/{id}/status` | Get country status | Admin | 50/min |
| `POST` | `/countries/{id}/activate` | Activate country | Admin | 20/min |
| `POST` | `/countries/{id}/suspend` | Suspend country | Admin | 20/min |

---

## Section 45: Translation APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/translations` | List translations | Admin | 50/min |
| `GET` | `/translations/{id}` | Get translation details | Admin | 50/min |
| `POST` | `/translations` | Create translation | Admin | 20/min |
| `PUT` | `/translations/{id}` | Update translation | Admin | 20/min |
| `DELETE` | `/translations/{id}` | Delete translation | Admin | 20/min |
| `GET` | `/translations/language/{lang}` | Get translations by language | Admin | 50/min |
| `POST` | `/translations/import` | Import translations | Admin | 20/min |

---

## Section 46: Regulatory APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/regulations` | List regulations | Admin | 50/min |
| `GET` | `/regulations/{id}` | Get regulation details | Admin | 50/min |
| `POST` | `/regulations` | Create regulation | Admin | 20/min |
| `PUT` | `/regulations/{id}` | Update regulation | Admin | 20/min |
| `DELETE` | `/regulations/{id}` | Delete regulation | Admin | 20/min |
| `GET` | `/regulations/country/{code}` | Get regulations by country | Admin | 50/min |

---

## Section 47: Readiness APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/readiness` | List readiness items | Admin | 50/min |
| `GET` | `/readiness/{id}` | Get readiness item details | Admin | 50/min |
| `POST` | `/readiness` | Create readiness item | Admin | 20/min |
| `PUT` | `/readiness/{id}` | Update readiness item | Admin | 20/min |
| `DELETE` | `/readiness/{id}` | Delete readiness item | Admin | 20/min |
| `GET` | `/readiness/country/{code}` | Get readiness by country | Admin | 50/min |
| `GET` | `/readiness/summary` | Get readiness summary | Admin | 50/min |

---

## Section 48: Region APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/regions` | List regions | Admin | 50/min |
| `GET` | `/regions/{id}` | Get region details | Admin | 50/min |
| `POST` | `/regions` | Create region | Admin | 20/min |
| `PUT` | `/regions/{id}` | Update region | Admin | 20/min |
| `DELETE` | `/regions/{id}` | Delete region | Admin | 20/min |

---

## Section 49: Emergency APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/emergency/sos` | Trigger emergency SOS | Bearer | 5/min |
| `POST` | `/emergency/incident` | Report emergency incident | Bearer | 10/min |

---

## Section 50: Health & Status APIs

| Method | Endpoint | Description | Auth | Rate Limit |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/health` | System health check | None | 100/min |
| `GET` | `/health/live` | Liveness probe | None | 100/min |
| `GET` | `/health/ready` | Readiness probe | None | 100/min |
| `GET` | `/health/dependencies` | Dependency health | Admin | 50/min |
| `GET` | `/status` | Platform status | None | 100/min |

---

## API Endpoint Summary

| Category | Endpoints | Auth Methods |
| :--- | :--- | :--- |
| **Authentication** | 25 | None, Bearer, Refresh Token |
| **Customer** | 65 | Bearer |
| **Merchant** | 150+ | Bearer, Admin |
| **Driver** | 80+ | Bearer, Admin |
| **Order** | 18 | Bearer |
| **Order Fulfillment** | 20 | Bearer, Admin |
| **Payment** | 20 | Bearer |
| **Refund** | 8 | Bearer, Admin |
| **Voucher** | 4 | Bearer, Admin |
| **Delivery** | 8 | Bearer |
| **Webhook** | 20 | Bearer, Admin, Webhook |
| **Admin** | 80+ | Admin |
| **API Key** | 6 | Bearer |
| **API Analytics** | 3 | Bearer |
| **API Documentation** | 3 | None |
| **Developer Portal** | 55 | Bearer, None |
| **API Marketplace** | 45 | Bearer, Admin |
| **Integration** | 40+ | Admin |
| **Mapping** | 18 | Bearer, Admin |
| **Federation** | 14 | Admin |
| **Notification** | 30 | Bearer, Admin |
| **Push** | 30 | Bearer, Admin |
| **Email** | 40 | Bearer, Admin |
| **SMS** | 35 | Bearer, Admin |
| **Messaging** | 30 | Bearer |
| **Subscription** | 10 | Bearer |
| **Privacy** | 8 | Bearer, None |
| **Analytics** | 25 | Admin |
| **Quality** | 25 | Admin |
| **Operations** | 20 | Admin |
| **Security** | 35 | Admin |
| **ESG** | 25 | Admin, Bearer |
| **Autonomous** | 35 | Admin, Bearer |
| **Country** | 8 | Admin |
| **Translation** | 7 | Admin |
| **Regulatory** | 7 | Admin |
| **Readiness** | 7 | Admin |
| **Region** | 6 | Admin |
| **Emergency** | 2 | Bearer |
| **Health** | 5 | None, Admin |
| **Total** | **~900** | - |

---

## Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-06-30 | [Author] | Initial API endpoints master list creation |

---

**Next Document:**

`Traceability_Matrix_Master.csv`

*(This continues with the traceability matrix for requirements tracking.)*