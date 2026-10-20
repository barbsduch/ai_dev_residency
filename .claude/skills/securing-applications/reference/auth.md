# Authentication and session standards

## Contents
- Default choice
- Passwords
- Sessions and cookies
- Tokens (JWT)
- MFA and account recovery
- Enterprise SSO

## Default choice
Use a managed identity provider (Auth0, Clerk, Cognito, Supabase Auth, Entra ID, Okta) or a vetted framework library (NextAuth/Auth.js, Django auth, Devise). Build custom auth only when explicitly required.

## Passwords
- Minimum 8 characters (NIST 800-63B), allow 64+; check against breached-password lists; no forced composition rules or periodic rotation.
- Hash with Argon2id (memory ≥ 19 MiB, iterations ≥ 2) or bcrypt cost ≥ 12.
- Identical error message for unknown user and wrong password ("Email or password is incorrect").
- Lock or slow down after repeated failures (rate limit per account and per IP).

## Sessions and cookies
```
Set-Cookie: session=<random 128-bit+>; HttpOnly; Secure; SameSite=Lax; Path=/; Max-Age=...
```
- Regenerate session ID on login and privilege change.
- Idle timeout (e.g. 30 min for admin, configurable for enterprise tenants) and absolute timeout.
- Server-side invalidation on logout and password change.
- CSRF protection for cookie-authenticated state-changing requests (SameSite + CSRF token).

## Tokens (JWT)
- Prefer opaque session cookies for first-party web apps.
- If using JWT: short expiry (≤ 15 min) + rotating refresh tokens; validate `alg` (reject `none`), `iss`, `aud`, `exp`.
- Never store tokens in localStorage; never put PII or permissions you can't revoke in the payload.

## MFA and account recovery
- Offer TOTP and passkeys (WebAuthn); SMS only as fallback.
- Reset tokens: single-use, random, expire in ≤ 1 hour, stored hashed.
- Notify the user by email on password, email, or MFA changes.

## Enterprise SSO
- Support SAML 2.0 and OIDC; SCIM 2.0 for provisioning/deprovisioning.
- Enforce SSO per tenant when the admin enables it; disable password login for those users.
- Map IdP groups to app roles; deprovisioned users lose access immediately (revoke sessions).
