---
name: security
description: Secure coding rules based on OWASP Top 10 and ASVS. Use for any code touching auth, user input, databases, APIs, files, secrets, dependencies, or infrastructure — and in every code review.
---
# Security

## Goal
Secure by default. Assume every input is hostile and every secret will leak if it's in code.

## Always do
1. **Secrets**: never in code, logs, URLs, or git. Use env vars or a secrets manager; ensure `.env*` is gitignored.
2. **Input**: validate on the server with allow-lists and schemas (e.g. Zod, Pydantic); client-side validation is UX only.
3. **Injection**: parameterized queries / ORM only; never string-build SQL, shell commands, or HTML.
4. **Output**: escape by context; avoid `dangerouslySetInnerHTML` / `eval`; set a Content Security Policy.
5. **AuthN**: use a proven provider (OAuth/OIDC, SSO/SAML for enterprise); MFA; secure, httpOnly, SameSite cookies; never roll your own crypto.
6. **AuthZ**: check permissions server-side on *every* request and object (prevents IDOR); deny by default; least privilege.
7. **Transport**: HTTPS everywhere, HSTS, secure headers.
8. **Dependencies**: pin versions, run `npm audit` / Dependabot, remove unused packages.
9. **Rate limiting** on login, signup, password reset, and expensive endpoints.
10. **Logging**: log security events (logins, permission denials) without PII or secrets.

## Never
- Disable TLS verification, commit credentials, trust client-supplied IDs/roles, or expose stack traces to users.

## Review output
For each finding: **Severity – OWASP category – File:line – Exploit scenario – Fix**.
