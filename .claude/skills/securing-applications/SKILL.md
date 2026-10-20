---
name: securing-applications
description: Applies OWASP Top 10 and ASVS secure-coding standards to code that handles authentication, authorization, user input, databases, file uploads, secrets, dependencies, APIs, or infrastructure, and runs structured security reviews. Use when writing or reviewing such code, when the user mentions security, vulnerabilities, auth, login, permissions, secrets, XSS, SQL injection, CSRF, or before shipping to production.
---

# Securing Applications

Secure by default: treat every input as hostile, every secret as leakable, and every permission check as mandatory on the server.

## Choose the workflow

- **Writing new code** → follow "Build workflow".
- **Reviewing existing code or a diff** → follow "Review workflow".
- **Auth, sessions, SSO, passwords, tokens** → also read [reference/auth.md](reference/auth.md).
- **Need the full vulnerability checklist** → read [reference/owasp-checklist.md](reference/owasp-checklist.md).

## Non-negotiable rules

1. **Secrets** never appear in code, logs, URLs, error messages, client bundles, or git history. Load from env vars or a secrets manager; confirm `.env*` is in `.gitignore`.
2. **Validate all input on the server** with a schema and allow-lists (Zod, Pydantic, Joi). Reject unknown fields. Client validation is UX only.
3. **No string-built queries or commands.** Parameterized SQL / ORM only; never pass user input to `exec`, `eval`, shell, or template compilers.
4. **Encode output for its context** (HTML, attribute, JS, URL). No `dangerouslySetInnerHTML`, `innerHTML`, or `v-html` with user data unless sanitized with DOMPurify.
5. **Authorize every request and every object** server-side: check the caller owns or may access *this* record (prevents IDOR). Deny by default.
6. **Never trust client-supplied identity or role** (`userId`, `role`, `tenantId` in body/query). Derive them from the verified session.
7. **Use proven auth** (OIDC/OAuth 2.1, SAML for enterprise SSO). Never write custom crypto or password hashing.
8. **Rate-limit** login, signup, password reset, OTP, and expensive endpoints.
9. **Fail closed** and return generic errors to users; log details server-side with a request ID.
10. **Dependencies**: pin versions with a lockfile; run `npm audit` / `pip-audit`; remove unused packages.

## Build workflow

Copy this checklist and track progress:

```
Security build checklist:
- [ ] 1. Identify trust boundaries and sensitive data in this feature
- [ ] 2. Define input schemas for every entry point
- [ ] 3. Add authentication + per-object authorization checks
- [ ] 4. Use parameterized data access and context-aware output encoding
- [ ] 5. Keep secrets in env/secret manager; add needed vars to .env.example (no values)
- [ ] 6. Add security headers / CSP / CORS allow-list if serving HTTP
- [ ] 7. Write negative tests (unauthorized user, other tenant, malformed input)
- [ ] 8. Run the review workflow on your own diff
```

**Step 1 – Threat model in one minute.** For the feature, list: who calls it, what data it touches, and what an attacker would want. Use STRIDE (Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege) as prompts.

**Step 7 – Negative tests are required.** Every protected endpoint gets at least: unauthenticated → 401, wrong user/tenant → 403 or 404, invalid payload → 400/422.

## Review workflow

1. Scan for high-signal patterns first:
   ```bash
   grep -rnE "(api[_-]?key|secret|password|token)\s*[:=]\s*['\"][^'\"]{8,}" --include=*.{js,ts,py,go,rb,java,env} .
   grep -rnE "eval\(|exec\(|innerHTML|dangerouslySetInnerHTML|shell=True|child_process" .
   grep -rnE "(SELECT|INSERT|UPDATE|DELETE).*(\+|\$\{|%s|f\")" .
   ```
2. Walk each entry point (route, handler, job, webhook) through rules 1–10.
3. Check against [reference/owasp-checklist.md](reference/owasp-checklist.md) for anything the rules missed.
4. For each finding, confirm it is exploitable (trace input → sink). Drop false positives.
5. Report using the template below, most severe first.

## Report template

```markdown
## Security review: [scope]

| # | Severity | OWASP | Location | Issue | Exploit scenario | Fix |
|---|----------|-------|----------|-------|------------------|-----|
| 1 | Critical | A01 Broken Access Control | api/invoices.ts:42 | No ownership check on GET /invoices/:id | Any logged-in user reads any invoice by changing the ID | Filter by `ownerId = session.userId`; add 404 test |

**Not reviewed / assumptions:** [list]
```

Severity: **Critical** (remote, unauthenticated, data breach), **High** (authenticated exploit or privilege escalation), **Medium** (needs unusual conditions), **Low** (defense-in-depth).

## Example

**Input:** `app.get('/api/users/:id', async (req, res) => res.json(await db.query(\`SELECT * FROM users WHERE id = ${req.params.id}\`)))`

**Output findings:**
1. Critical – A03 Injection: string-interpolated SQL → use `db.query('SELECT ... WHERE id = $1', [id])`.
2. High – A01 Access Control: no auth or ownership check → require session; allow only self or admin.
3. Medium – A02/Data exposure: `SELECT *` returns password hash → select explicit safe columns.
