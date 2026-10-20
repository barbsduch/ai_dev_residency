# OWASP Top 10 (2021) checklist with fixes

## Contents
- A01 Broken Access Control
- A02 Cryptographic Failures
- A03 Injection
- A04 Insecure Design
- A05 Security Misconfiguration
- A06 Vulnerable and Outdated Components
- A07 Identification and Authentication Failures
- A08 Software and Data Integrity Failures
- A09 Security Logging and Monitoring Failures
- A10 Server-Side Request Forgery (SSRF)
- Security headers baseline
- File upload rules

## A01 Broken Access Control
- [ ] Every route has an explicit auth requirement (deny by default via middleware).
- [ ] Object-level checks: queries scoped by owner/tenant (`WHERE tenant_id = :sessionTenant`).
- [ ] Function-level checks: admin endpoints verify role server-side.
- [ ] CORS uses an allow-list, never `*` with credentials.
- [ ] IDs in URLs are unguessable (UUID) *and* still authorization-checked.

## A02 Cryptographic Failures
- [ ] TLS 1.2+ everywhere; HSTS `max-age=63072000; includeSubDomains`.
- [ ] Passwords hashed with Argon2id (or bcrypt cost ≥ 12); never MD5/SHA1/plain SHA256.
- [ ] Sensitive data (PII, tokens) encrypted at rest; keys in a KMS.
- [ ] No sensitive data in URLs, localStorage, or logs.

## A03 Injection
- [ ] SQL/NoSQL: parameterized queries; no `$where` or raw operators from user input.
- [ ] OS commands: avoid; if unavoidable, use arg arrays (`execFile`) with allow-listed values.
- [ ] XSS: framework auto-escaping on; sanitize any HTML with DOMPurify; CSP without `unsafe-inline`.
- [ ] Template / LDAP / XPath / header injection: never concatenate user input.

## A04 Insecure Design
- [ ] Threat model exists for features touching money, PII, or permissions.
- [ ] Business limits enforced server-side (quantity, price, rate, transfer caps).
- [ ] Sensitive flows (password reset, email change) re-authenticate and notify the user.

## A05 Security Misconfiguration
- [ ] Debug mode, stack traces, directory listing, default credentials off in production.
- [ ] Cloud storage buckets private by default.
- [ ] Unused routes, ports, sample apps removed.

## A06 Vulnerable and Outdated Components
- [ ] Lockfile committed; Dependabot/Renovate enabled.
- [ ] `npm audit --audit-level=high` / `pip-audit` clean in CI.
- [ ] No abandoned packages for security-critical functions.

## A07 Identification and Authentication Failures
- [ ] See reference/auth.md.

## A08 Software and Data Integrity Failures
- [ ] Webhooks verify HMAC signatures and timestamps (reject > 5 min old).
- [ ] No deserialization of untrusted data (`pickle`, `yaml.load`, Java serialization).
- [ ] CI/CD: protected main branch, required reviews, pinned GitHub Action SHAs.

## A09 Security Logging and Monitoring Failures
- [ ] Log: login success/failure, permission denials, admin actions, data exports.
- [ ] Never log: passwords, tokens, full card numbers, session IDs, PII payloads.
- [ ] Alerts on spikes in auth failures and 403s.

## A10 SSRF
- [ ] Server-side fetches of user-supplied URLs use an allow-list of hosts.
- [ ] Block private IP ranges (10/8, 172.16/12, 192.168/16, 127/8, 169.254.169.254).
- [ ] Disable redirects or re-validate each hop.

## Security headers baseline
```
Content-Security-Policy: default-src 'self'; frame-ancestors 'none'; object-src 'none'; base-uri 'self'
Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
```

## File upload rules
- Validate type by magic bytes, not extension or `Content-Type`.
- Enforce size limits; rename to random IDs; store outside web root or in private object storage.
- Serve with `Content-Disposition: attachment`; scan for malware when files are shared between users.
