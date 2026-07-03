# Software Requirements Specification (SRS)

## Part 01A: Customer User Management

**Module:** Customer Module (Part 02)
**Version:** 1.0.0
**Status:** Final / For Review
**Date:** 2026-06-30

---

## Chapter 1 – Overview

### Purpose

The Customer User Management module provides the foundational identity and access management layer for all consumers of the **[Platform Name]** platform. It governs the complete lifecycle of a customer's digital identity—from initial registration and authentication to profile management, account security, and eventual deactivation.

This module is the gateway to the entire customer experience. Every order, payment, loyalty point, and interaction across the platform flows through the identity established here. As such, it must be secure, scalable, and privacy-compliant (GDPR/CCPA).

### Objectives

- Seamless, frictionless registration and login experience
- Robust security (MFA, password policies, session management)
- Privacy-first data handling (explicit consent, data portability)
- Unified customer identity across mobile apps, web, and API integrations
- Support for multiple authentication methods (social, OTP, email/password)

---

## Chapter 2 – Customer Registration

### CUS-001 Registration Methods

The platform shall support multiple registration methods to maximize conversion rates and accommodate diverse user preferences across different markets.

| Registration Method | Description | Priority |
| :--- | :--- | :--- |
| **Email + Password** | Traditional registration with email verification. | **Required** |
| **Phone Number (OTP)** | Registration via mobile number with one-time password (SMS/WhatsApp). | **Required** |
| **Social Login** | OAuth-based registration via Google, Facebook, Apple. | **Required** |
| **Guest Checkout** | Order placement without account creation (limited features). | **Required** |

### CUS-002 Registration Flow (Email/Password)

1.  User provides: Full Name, Email Address, Phone Number, Password.
2.  System validates: Email format, Phone format (E.164), Password strength (min 8 chars, mix of letters/numbers/symbols).
3.  System sends verification email to the provided address.
4.  User clicks verification link to activate the account.
5.  System creates a pending customer record with status `PENDING_VERIFICATION`.
6.  Upon verification, status transitions to `ACTIVE`.

### CUS-003 Registration Flow (Phone OTP)

1.  User provides: Full Name, Phone Number.
2.  System validates phone number format and checks if already registered.
3.  System generates a 4-6 digit OTP and sends via SMS/WhatsApp.
4.  User enters OTP within 5 minutes.
5.  Upon successful OTP validation, account is created with status `ACTIVE`.
6.  User may optionally set a password later for multi-device access.

### CUS-004 Social Login Integration

1.  User selects social provider (Google/Facebook/Apple).
2.  System redirects to OAuth provider.
3.  Upon authorization, system receives user profile data (email, name, avatar).
4.  System checks if email already exists in the platform.
5.  If existing, links social provider to existing account (account merge).
6.  If new, creates account with status `ACTIVE`.
7.  Social login access token is stored for future refresh operations.

### CUS-005 Guest Checkout

1.  User provides: Email Address, Phone Number, Delivery Address.
2.  System creates a temporary customer record with status `GUEST`.
3.  Guest users may place orders but cannot:
    - View order history
    - Save addresses for future use
    - Accumulate loyalty points
    - Access promotions requiring account
4.  Guest users are prompted to convert to registered accounts post-checkout.

---

## Chapter 3 – Customer Authentication

### CUS-006 Authentication Methods

| Method | Description | Use Case |
| :--- | :--- | :--- |
| **Email/Password** | Standard credential-based login. | Web app, mobile app |
| **Phone OTP** | Login via SMS/WhatsApp one-time password. | Quick login, low-trust devices |
| **Social Login** | OAuth-based (Google/Facebook/Apple). | Mobile app, web |
| **Biometric** | Fingerprint/Face ID via native SDK. | Mobile app (post-initial auth) |
| **Magic Link** | Email-based passwordless login. | Web app, email campaigns |

### CUS-007 Login Flow

1.  User submits credentials (or OTP).
2.  System validates credentials against secure hashed storage (bcrypt/Argon2).
3.  Upon success, system generates a JWT (JSON Web Token) containing:
    - `customer_id`
    - `email`
    - `roles` (e.g., `ROLE_CUSTOMER`)
    - `scopes` (e.g., `orders:read`, `orders:write`)
    - `iat` (issued at) and `exp` (expiration) timestamps
4.  JWT is signed using RS256 (private/public key pair).
5.  JWT is returned to the client in the response body (not a cookie).
6.  Client stores JWT securely (mobile: encrypted secure storage, web: HTTP-only secure cookie recommended).
7.  JWT is included in the `Authorization: Bearer <token>` header for all authenticated requests.

### CUS-008 Token Management

| Attribute | Specification |
| :--- | :--- |
| **Access Token Lifetime** | 15 minutes |
| **Refresh Token Lifetime** | 7 days (configurable) |
| **Token Storage** | Redis (for blacklisting), PostgreSQL (for audit) |
| **Token Revocation** | Immediate (via blacklist) |
| **Refresh Mechanism** | `POST /api/v1/auth/refresh` with valid refresh token |

### CUS-009 Password Policies

| Policy | Requirement |
| :--- | :--- |
| **Minimum Length** | 8 characters |
| **Complexity** | At least 1 uppercase, 1 lowercase, 1 number, 1 special character |
| **History** | Last 5 passwords cannot be reused |
| **Lockout** | After 5 failed attempts, account locked for 15 minutes |
| **Reset** | Via email magic link (not password reset via SMS for security) |

### CUS-010 Multi-Factor Authentication (MFA)

The platform shall support optional MFA for enhanced security.

| MFA Method | Description | Priority |
| :--- | :--- | :--- |
| **SMS OTP** | 6-digit code sent via SMS | **Required** |
| **Authenticator App** | TOTP (Google Authenticator, Authy) | **Required** |
| **Email OTP** | 6-digit code sent via email | **Optional** |
| **Backup Codes** | 10 single-use backup codes | **Required** |

**MFA Flow:**
1.  User completes primary authentication.
2.  System checks if MFA is enabled for the account.
3.  If enabled, system generates a challenge (e.g., TOTP prompt).
4.  User provides MFA verification.
5.  Upon success, full authentication is granted.
6.  System may remember device for 30 days (using device fingerprint).

---

## Chapter 4 – Customer Profile Management

### CUS-011 Profile Data Model

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `customer_id` | UUID | Yes | Primary identifier |
| `first_name` | String | Yes | Legal first name |
| `last_name` | String | Yes | Legal last name |
| `display_name` | String | No | Optional alias for public display |
| `email` | String | Yes | Primary email (unique) |
| `phone` | String | Yes | Primary phone (E.164, unique) |
| `avatar_url` | String | No | Profile picture URL (CDN) |
| `date_of_birth` | Date | No | For age verification (regulated items) |
| `language_preference` | String | Yes | ISO 639-1 code (e.g., "en", "ar") |
| `currency_preference` | String | Yes | ISO 4217 code (e.g., "USD", "AED") |
| `theme_preference` | String | No | "light" / "dark" / "system" |
| `marketing_consent` | Boolean | Yes | Explicit opt-in for marketing communications |
| `push_notification_enabled` | Boolean | Yes | Push notification preferences |
| `email_notification_enabled` | Boolean | Yes | Email notification preferences |
| `sms_notification_enabled` | Boolean | Yes | SMS notification preferences |
| `status` | Enum | Yes | `ACTIVE`, `SUSPENDED`, `DELETED`, `PENDING_VERIFICATION` |
| `created_at` | Timestamp | Yes | Account creation timestamp |
| `updated_at` | Timestamp | Yes | Last profile update timestamp |
| `last_login_at` | Timestamp | No | Last successful login timestamp |

### CUS-012 Profile Management Capabilities

| Capability | Description |
| :--- | :--- |
| **View Profile** | Retrieve own profile data. |
| **Update Profile** | Modify editable fields (name, preferences, consent). |
| **Change Password** | Current password verification + new password. |
| **Change Email** | Requires verification of new email (send verification link to new email). |
| **Change Phone** | Requires OTP verification to new phone number. |
| **Upload Avatar** | Upload image, resize to standard sizes, store in CDN. |
| **Manage Addresses** | CRUD operations on saved delivery addresses (Part 01B). |
| **Payment Methods** | Add/remove saved payment methods (Part 01D). |
| **Notification Preferences** | Granular opt-in/out for notification channels. |
| **Privacy Settings** | Data sharing preferences, consent management. |

### CUS-013 Address Management

| Field | Type | Description |
| :--- | :--- | :--- |
| `address_id` | UUID | Primary identifier |
| `customer_id` | UUID | Foreign key to customer |
| `label` | String | e.g., "Home", "Work", "Parents" |
| `address_line_1` | String | Street address / building |
| `address_line_2` | String | Apartment, suite, floor |
| `city` | String | City name |
| `state` | String | State/province (if applicable) |
| `postal_code` | String | Postal/ZIP code |
| `country` | String | ISO 3166-1 alpha-2 code |
| `latitude` | Decimal | Geocoded latitude |
| `longitude` | Decimal | Geocoded longitude |
| `is_default` | Boolean | Primary delivery address |
| `instructions` | String | Delivery instructions (e.g., gate code) |
| `created_at` | Timestamp | Creation timestamp |
| `updated_at` | Timestamp | Last update timestamp |

---

## Chapter 5 – Account Security

### CUS-014 Session Management

| Feature | Description |
| :--- | :--- |
| **Concurrent Sessions** | Maximum 5 concurrent sessions per customer (configurable). |
| **Device Tracking** | Track device ID, IP address, user agent for each session. |
| **Session Revocation** | User can revoke any active session via profile settings. |
| **Auto-Logout** | Inactive session timeout: 30 minutes (configurable). |
| **Geographic Anomaly Detection** | Flag logins from geographically improbable locations. |

### CUS-015 Account Lockout & Recovery

| Scenario | System Behavior |
| :--- | :--- |
| **Too many failed attempts (IP-based)** | CAPTCHA challenge after 10 failures from same IP. |
| **Too many failed attempts (account-based)** | Lock account for 15 minutes after 5 consecutive failures. |
| **Forgot Password** | Send password reset link (magic link) to registered email. |
| **Suspicious Activity Detection** | Trigger email/SMS alert to user; optional account freeze pending verification. |
| **Account Recovery** | For locked accounts, user can verify identity via email OTP or security questions. |

### CUS-016 Account Deletion (Right to be Forgotten - GDPR/CCPA)

1.  User initiates account deletion via profile settings.
2.  System displays a confirmation dialog with implications (data loss, order history removal).
3.  User confirms with password verification or OTP.
4.  System initiates the deletion workflow:
    - Immediately invalidates all active sessions/refresh tokens.
    - Marks account status as `DELETED`.
    - Queues data anonymization/purge job (GDPR-compliant timeline: 30 days).
    - Retains order data for financial compliance (anonymized, not linked to customer).
5.  Confirmation email is sent to the user.
6.  User may re-activate within 30 days (if deletion not yet finalized).

### CUS-017 Data Export (Data Portability)

1.  User requests data export via profile settings.
2.  System generates a ZIP archive containing:
    - Profile data (JSON)
    - Order history (CSV/JSON)
    - Payment history (masked/redacted)
    - Address book (CSV/JSON)
    - Notification preferences (JSON)
3.  Archive is prepared asynchronously (max 72 hours per GDPR).
4.  User receives a download link via email (secure, expiring in 7 days).
5.  Export is logged for audit purposes.

---

## Chapter 6 – Customer Communication Preferences

### CUS-018 Notification Opt-In/Out

| Notification Type | Default | User-Configurable | Description |
| :--- | :--- | :--- | :--- |
| **Order Updates** | Opt-In | Yes | Order confirmation, preparation, out-for-delivery, delivered |
| **Promotional Offers** | Opt-Out | Yes | Discounts, campaigns, new restaurant alerts |
| **Loyalty Updates** | Opt-In | Yes | Points earned, rewards available |
| **Security Alerts** | Opt-In | No (mandatory) | Login alerts, password changes, suspicious activity |
| **Survey/Feedback** | Opt-Out | Yes | Post-delivery satisfaction surveys |
| **Newsletter** | Opt-Out | Yes | Weekly/monthly platform newsletter |

### CUS-019 Consent Management

The platform shall maintain a clear, auditable record of all user consent events.

| Consent Type | Collection Point | Expiration | Withdrawal Method |
| :--- | :--- | :--- | :--- |
| **Marketing Communications** | Registration / Profile | Indefinite (until withdrawal) | Profile settings or unsubscribe link |
| **Data Processing** | Registration | Indefinite (until account deletion) | Account deletion |
| **Cookies (Analytics)** | First visit | 6 months | Cookie settings / browser |
| **Location Services** | First order attempt | Session / App permission | Device settings or profile |
| **Push Notifications** | First app launch | App permission | Device settings or profile |

---

## Chapter 7 – Database Tables

### customers

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_id` | UUID | PRIMARY KEY | Unique customer identifier |
| `first_name` | VARCHAR(100) | NOT NULL | Legal first name |
| `last_name` | VARCHAR(100) | NOT NULL | Legal last name |
| `display_name` | VARCHAR(100) | | Public display alias |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Primary email address |
| `phone` | VARCHAR(20) | UNIQUE, NOT NULL | E.164 formatted phone number |
| `password_hash` | VARCHAR(255) | | bcrypt/Argon2 hash (nullable for social/OTP-only) |
| `avatar_url` | VARCHAR(500) | | CDN URL for profile picture |
| `date_of_birth` | DATE | | For age verification |
| `language_preference` | VARCHAR(5) | DEFAULT 'en' | ISO 639-1 language code |
| `currency_preference` | VARCHAR(3) | DEFAULT 'USD' | ISO 4217 currency code |
| `theme_preference` | VARCHAR(10) | DEFAULT 'system' | light/dark/system |
| `marketing_consent` | BOOLEAN | DEFAULT FALSE | Opt-in for marketing |
| `push_enabled` | BOOLEAN | DEFAULT TRUE | Push notifications enabled |
| `email_enabled` | BOOLEAN | DEFAULT TRUE | Email notifications enabled |
| `sms_enabled` | BOOLEAN | DEFAULT TRUE | SMS notifications enabled |
| `status` | VARCHAR(20) | DEFAULT 'PENDING_VERIFICATION' | ACTIVE/SUSPENDED/DELETED/PENDING_VERIFICATION |
| `mfa_enabled` | BOOLEAN | DEFAULT FALSE | Multi-factor authentication enabled |
| `last_login_at` | TIMESTAMP | | Last successful login timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Account creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last profile update timestamp |
| `deleted_at` | TIMESTAMP | | Soft delete timestamp (GDPR) |

### customer_addresses

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `address_id` | UUID | PRIMARY KEY | Unique address identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Owner of the address |
| `label` | VARCHAR(50) | NOT NULL | Home/Work/Parents |
| `address_line_1` | VARCHAR(255) | NOT NULL | Street/building |
| `address_line_2` | VARCHAR(255) | | Apartment/floor/suite |
| `city` | VARCHAR(100) | NOT NULL | City name |
| `state` | VARCHAR(100) | | State/province |
| `postal_code` | VARCHAR(20) | | Postal/ZIP code |
| `country` | VARCHAR(5) | NOT NULL | ISO country code |
| `latitude` | DECIMAL(10, 8) | NOT NULL | Geocoded latitude |
| `longitude` | DECIMAL(11, 8) | NOT NULL | Geocoded longitude |
| `is_default` | BOOLEAN | DEFAULT FALSE | Primary delivery address |
| `instructions` | TEXT | | Delivery instructions |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### customer_sessions

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `session_id` | UUID | PRIMARY KEY | Unique session identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `refresh_token` | VARCHAR(255) | UNIQUE | Encrypted refresh token |
| `device_id` | VARCHAR(255) | | Unique device identifier |
| `device_name` | VARCHAR(100) | | e.g., "iPhone 15 Pro" |
| `device_type` | VARCHAR(20) | | ios/android/web |
| `ip_address` | VARCHAR(45) | | IPv4 or IPv6 address |
| `user_agent` | TEXT | | Browser/device user agent |
| `is_active` | BOOLEAN | DEFAULT TRUE | Session active status |
| `expires_at` | TIMESTAMP | NOT NULL | Session expiration timestamp |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Session creation timestamp |
| `revoked_at` | TIMESTAMP | | Session revocation timestamp |

### mfa_settings

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `mfa_id` | UUID | PRIMARY KEY | Unique MFA identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `method` | VARCHAR(20) | NOT NULL | sms/authenticator/email/backup |
| `secret` | VARCHAR(255) | | Encrypted TOTP secret |
| `phone_number` | VARCHAR(20) | | For SMS MFA |
| `email` | VARCHAR(255) | | For email MFA |
| `is_primary` | BOOLEAN | DEFAULT FALSE | Primary MFA method |
| `is_active` | BOOLEAN | DEFAULT TRUE | MFA method active status |
| `backup_codes` | TEXT | | Encrypted JSON array of backup codes |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### consent_records

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `consent_id` | UUID | PRIMARY KEY | Unique consent identifier |
| `customer_id` | UUID | FOREIGN KEY (customers.customer_id) | Associated customer |
| `consent_type` | VARCHAR(50) | NOT NULL | marketing/data_processing/cookies/location |
| `consent_value` | BOOLEAN | NOT NULL | Accepted or declined |
| `ip_address` | VARCHAR(45) | | IP address at consent time |
| `user_agent` | TEXT | | Browser/device at consent time |
| `granted_at` | TIMESTAMP | DEFAULT NOW() | Consent grant timestamp |
| `expires_at` | TIMESTAMP | | Consent expiration timestamp |
| `revoked_at` | TIMESTAMP | | Consent revocation timestamp |

---

## Chapter 8 – REST APIs

### Authentication APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/v1/auth/register` | Register new customer |
| `POST` | `/api/v1/auth/login` | Authenticate and receive JWT |
| `POST` | `/api/v1/auth/login/otp` | Request OTP for phone login |
| `POST` | `/api/v1/auth/login/otp/verify` | Verify OTP and receive JWT |
| `POST` | `/api/v1/auth/login/social` | Social login with provider token |
| `POST` | `/api/v1/auth/refresh` | Refresh JWT using refresh token |
| `POST` | `/api/v1/auth/logout` | Invalidate current session |
| `POST` | `/api/v1/auth/forgot-password` | Request password reset |
| `POST` | `/api/v1/auth/reset-password` | Reset password with token |
| `POST` | `/api/v1/auth/verify-email` | Verify email address with token |
| `POST` | `/api/v1/auth/verify-phone` | Verify phone number with OTP |
| `POST` | `/api/v1/auth/mfa/enable` | Enable MFA for account |
| `POST` | `/api/v1/auth/mfa/verify` | Verify MFA challenge |
| `POST` | `/api/v1/auth/mfa/disable` | Disable MFA for account |

### Profile Management APIs

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/v1/customers/me` | Get current customer profile |
| `PUT` | `/api/v1/customers/me` | Update current customer profile |
| `POST` | `/api/v1/customers/me/avatar` | Upload profile picture |
| `DELETE` | `/api/v1/customers/me/avatar` | Remove profile picture |
| `PUT` | `/api/v1/customers/me/password` | Change password |
| `PUT` | `/api/v1/customers/me/email` | Change email address |
| `PUT` | `/api/v1/customers/me/phone` | Change phone number |
| `GET` | `/api/v1/customers/me/addresses` | List saved addresses |
| `POST` | `/api/v1/customers/me/addresses` | Add new address |
| `PUT` | `/api/v1/customers/me/addresses/{id}` | Update address |
| `DELETE` | `/api/v1/customers/me/addresses/{id}` | Delete address |
| `PUT` | `/api/v1/customers/me/addresses/{id}/default` | Set default address |
| `GET` | `/api/v1/customers/me/consent` | Get consent preferences |
| `PUT` | `/api/v1/customers/me/consent` | Update consent preferences |
| `GET` | `/api/v1/customers/me/sessions` | List active sessions |
| `DELETE` | `/api/v1/customers/me/sessions/{id}` | Revoke specific session |
| `DELETE` | `/api/v1/customers/me/sessions` | Revoke all sessions (except current) |
| `DELETE` | `/api/v1/customers/me` | Delete account (GDPR) |
| `GET` | `/api/v1/customers/me/export` | Request data export (GDPR) |

---

## Chapter 9 – Business Rules

| Rule ID | Rule Description | Priority |
| :--- | :--- | :--- |
| **BR-CUS-001** | Email addresses must be unique across all active customer accounts. | **High** |
| **BR-CUS-002** | Phone numbers must be unique across all active customer accounts. | **High** |
| **BR-CUS-003** | Passwords must be hashed using bcrypt (cost factor 12) or Argon2id before storage. | **High** |
| **BR-CUS-004** | JWT access tokens must expire within 15 minutes; refresh tokens within 7 days. | **High** |
| **BR-CUS-005** | Accounts with 5 consecutive failed login attempts must be locked for 15 minutes. | **High** |
| **BR-CUS-006** | Password reset links must expire within 1 hour. | **High** |
| **BR-CUS-007** | OTPs must expire within 5 minutes and be invalidated after 3 failed attempts. | **High** |
| **BR-CUS-008** | Customers must explicitly opt-in to marketing communications (opt-out default). | **High** |
| **BR-CUS-009** | GDPR data export requests must be fulfilled within 72 hours. | **High** |
| **BR-CUS-010** | Account deletion must render PII inaccessible within 30 days of request. | **High** |
| **BR-CUS-011** | Guest checkout accounts may not access loyalty, promotions, or history features. | **Medium** |
| **BR-CUS-012** | Customers under 16 years of age must have parental consent (or be restricted). | **Medium** |
| **BR-CUS-013** | Social login accounts must be linked to a verified email before placing orders. | **Medium** |
| **BR-CUS-014** | A maximum of 5 concurrent sessions per customer shall be enforced. | **Medium** |

---

## Chapter 10 – Acceptance Tests

| Test ID | Test Description | Priority |
| :--- | :--- | :--- |
| **TEST-CUS-001** | Register new customer with email/password, verify email, and successfully log in. | **High** |
| **TEST-CUS-002** | Register new customer with phone OTP and successfully log in. | **High** |
| **TEST-CUS-003** | Register using Google OAuth and successfully log in. | **High** |
| **TEST-CUS-004** | Login with valid credentials receives a valid JWT token. | **High** |
| **TEST-CUS-005** | Login with invalid password triggers account lockout after 5 failures. | **High** |
| **TEST-CUS-006** | Login with valid MFA code successfully authenticates. | **High** |
| **TEST-CUS-007** | Refresh JWT using valid refresh token receives new access token. | **High** |
| **TEST-CUS-008** | Reset password via email and log in with new password. | **High** |
| **TEST-CUS-009** | Update customer profile fields persists changes correctly. | **High** |
| **TEST-CUS-010** | Add, update, and delete an address from address book. | **High** |
| **TEST-CUS-011** | Set an address as default; verify it's used in subsequent orders. | **High** |
| **TEST-CUS-012** | Upload and update profile avatar image. | **Medium** |
| **TEST-CUS-013** | Change email address and verify new email before login. | **High** |
| **TEST-CUS-014** | Change phone number with OTP verification. | **High** |
| **TEST-CUS-015** | View active sessions and revoke a specific session. | **Medium** |
| **TEST-CUS-016** | Opt-in and opt-out of marketing communications. | **Medium** |
| **TEST-CUS-017** | Request data export and receive downloadable archive within 72 hours. | **High** |
| **TEST-CUS-018** | Delete account and verify data is purged within 30 days. | **High** |
| **TEST-CUS-019** | Guest checkout flow creates temporary account; verify limited features. | **Medium** |
| **TEST-CUS-020** | Enroll in MFA (Authenticator App) and verify login with MFA. | **High** |
| **TEST-CUS-021** | Use backup codes to recover account when MFA device is lost. | **High** |
| **TEST-CUS-022** | Prevent registration with duplicate email or phone number. | **High** |
| **TEST-CUS-023** | Verify password complexity rules are enforced. | **High** |
| **TEST-CUS-024** | Auto-logout after 30 minutes of inactivity. | **Medium** |

---

## Chapter 11 – Traceability Matrix

| Requirement | Database Table | API Endpoint(s) | Acceptance Test |
| :--- | :--- | :--- | :--- |
| CUS-001 | customers | POST /api/v1/auth/register | TEST-CUS-001, TEST-CUS-002, TEST-CUS-003 |
| CUS-006 | customers | POST /api/v1/auth/login | TEST-CUS-004, TEST-CUS-005, TEST-CUS-006 |
| CUS-008 | customer_sessions | POST /api/v1/auth/refresh | TEST-CUS-007 |
| CUS-009 | customers | PUT /api/v1/customers/me/password | TEST-CUS-008 |
| CUS-011 | customers | GET /api/v1/customers/me | TEST-CUS-009 |
| CUS-013 | customer_addresses | POST/GET/PUT/DELETE /api/v1/customers/me/addresses | TEST-CUS-010, TEST-CUS-011 |
| CUS-012 | customers | PUT /api/v1/customers/me | TEST-CUS-009, TEST-CUS-012 |
| CUS-014 | customer_sessions | GET/DELETE /api/v1/customers/me/sessions | TEST-CUS-015 |
| CUS-018 | customers | PUT /api/v1/customers/me/consent | TEST-CUS-016 |
| CUS-017 | customers | GET /api/v1/customers/me/export | TEST-CUS-017 |
| CUS-016 | customers | DELETE /api/v1/customers/me | TEST-CUS-018 |
| CUS-005 | customers | POST /api/v1/auth/guest-checkout | TEST-CUS-019 |
| CUS-010 | mfa_settings | POST /api/v1/auth/mfa/enable | TEST-CUS-020, TEST-CUS-021 |

---

## Chapter 12 – Summary

This document establishes the foundational identity layer for the entire **[Platform Name]** ecosystem. Key takeaways:

- **Frictionless Onboarding:** Multiple registration methods (email, phone OTP, social) to maximize conversion rates.
- **Enterprise-Grade Security:** Password policies, MFA, session management, and account lockout mechanisms.
- **Regulatory Compliance:** GDPR/CCPA-ready with data portability and the right to be forgotten.
- **Scalable Foundation:** Stateless JWT authentication with refresh token rotation enables horizontal scaling.
- **User Control:** Granular consent management and notification preferences empower users.

---

**Next Document:**

`Part_01B_Customer_Order_Management.md`

*(This builds on the identity foundation to define how customers discover, select, and purchase items.)*