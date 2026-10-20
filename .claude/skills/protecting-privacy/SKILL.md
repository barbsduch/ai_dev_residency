---
name: protecting-privacy
description: Applies privacy-by-design and compliance engineering (GDPR, CCPA/CPRA, SOC 2, HIPAA, ISO 27001) to code that collects, stores, processes, logs, exports, or deletes personal data, and reviews features for enterprise readiness. Covers data minimization, data classification, consent and cookie banners, DSAR export/delete, retention schedules, audit logs, multi-tenant isolation with row-level security, RBAC, SSO, SCIM, sub-processors, DPAs, and encryption. Use when building user accounts, analytics, tracking, forms, logging, data exports, account deletion, B2B/multi-tenant features, or when the user mentions privacy, PII, personal data, GDPR, CCPA, HIPAA, SOC 2, compliance, consent, retention, audit trail, or enterprise customers.
---

# Protecting Privacy

Collect the least data, keep it the shortest time, prove who touched it, and let users take it or erase it. This is engineering guidance, not legal advice; flag legal questions for counsel.

## Choose the workflow

- **Building a feature that touches personal data** → follow "Build workflow".
- **Reviewing code or a diff for privacy/compliance** → follow "Review workflow".
- **Need what a specific regulation requires engineers to build** → read [reference/regulations.md](reference/regulations.md).
- **B2B / enterprise / multi-tenant / security questionnaire** → read [reference/enterprise-readiness.md](reference/enterprise-readiness.md).

## Data classification

| Class | Examples | Required handling |
|-------|----------|-------------------|
| **Public** | Marketing copy, published docs | None |
| **Internal** | Feature flags, aggregate metrics | Auth required |
| **Confidential (PII)** | Name, email, IP, device ID, customer content | Encrypted at rest, access-logged, in DSAR scope, retention set |
| **Restricted** | Health (PHI), financial, government ID, biometrics, precise location, children's data, credentials | Field-level encryption, need-to-know RBAC, no third-party sharing without DPA/BAA, every read audited |

## Non-negotiable rules

1. **Minimize.** Every new field needs a stated purpose. If no feature reads it, don't collect it. Prefer derived/aggregated values (age bracket over birthdate, city over GPS).
2. **Classify on creation.** Tag each column/field with its class (schema comment, annotation, or data catalog) so DSAR, retention, and logging tools can find it.
3. **No tracking before opt-in.** Non-essential cookies, analytics, ad pixels, and session replay load only after explicit consent (EU/UK). Honor `Sec-GPC: 1` / Global Privacy Control as a CCPA opt-out. Reject is as easy as accept.
4. **PII never in logs, URLs, analytics events, error trackers, or LLM prompts** sent to third parties without a DPA. Log user IDs, not emails; redact at the logger.
5. **DSAR-ready.** Every store of PII is reachable by user ID for export (Art. 15/20, machine-readable JSON) and deletion (Art. 17), including backups' expiry, search indexes, caches, and sub-processors.
6. **Retention is code.** Each PII table has a TTL and a scheduled purge job; "keep forever" requires a documented reason.
7. **Tenant isolation at the data layer.** Every multi-tenant query is scoped by `tenant_id` derived from the session, enforced by row-level security or a mandatory repository filter.
8. **Audit sensitive actions** to an append-only log: who, what, when, from where, on which resource. Never store PII values in the audit payload.
9. **Encrypt** in transit (TLS 1.2+) and at rest (AES-256, keys in KMS); field-level encryption for Restricted data.
10. **Third parties are sub-processors.** Adding an SDK/API that receives personal data requires a DPA (BAA for PHI), an entry in the public sub-processor list, and region check.

## Build workflow

Copy this checklist and track progress:

```
Privacy build checklist:
- [ ] 1. List each personal-data field, its class, purpose, and lawful basis
- [ ] 2. Remove fields without a purpose; coarsen what you can
- [ ] 3. Set retention per field/table and add the purge job
- [ ] 4. Gate non-essential tracking behind consent; respect GPC
- [ ] 5. Scope data access by tenant + role; add RLS or repository filter
- [ ] 6. Add audit events for create/read-sensitive/update/delete/export
- [ ] 7. Register new stores in DSAR export + delete handlers
- [ ] 8. Verify: logs, URLs, analytics payloads contain no PII (grep + test)
- [ ] 9. Record new sub-processors and update the data map
```

**Step 8 – Verification loop.** Run the feature, then search captured logs and analytics payloads for the test user's email/name. Any hit → fix the redaction and rerun until zero hits. Add a test asserting the DSAR delete leaves no rows for the user ID.

## Review workflow

1. Scan for high-signal patterns:
   ```bash
   grep -rnE "(log|logger|console)\.(info|debug|warn|error|log)\(.*(email|phone|ssn|dob|address|password|token)" .
   grep -rnE "(\?|&)(email|phone|name|token|ssn)=" .
   grep -rnE "(gtag|fbq|analytics\.(track|identify)|posthog|mixpanel|hotjar|segment)" .
   grep -rnE "SELECT .* FROM .*" . | grep -viE "tenant_id|org_id"
   ```
2. Walk each data flow (collect → store → use → share → delete) through rules 1–10.
3. Check the regulation(s) in scope against [reference/regulations.md](reference/regulations.md).
4. Report using the template below, most severe first.

## Report template

```markdown
## Privacy review: [scope]

| # | Severity | Rule / Regulation | Location | Issue | Risk | Fix |
|---|----------|-------------------|----------|-------|------|-----|
| 1 | High | R3 Consent / GDPR Art. 6, ePrivacy | app/layout.tsx:12 | GA loads on page load | Tracking without consent; regulator fine | Load gtag only after `consent.analytics === true` |

**Data map changes:** [new fields, stores, sub-processors]
**Not reviewed / assumptions:** [list]
**Legal questions for counsel:** [list]
```

Severity: **Critical** (cross-tenant leak, Restricted data exposed), **High** (PII to third party or logs, no deletion path), **Medium** (missing retention, audit gaps), **Low** (minimization, documentation).

## Example

**Input:** "Add a newsletter signup storing email, full name, birthdate, and IP; send events to Mixpanel with the email as distinct_id."

**Output findings:**
1. High – R4/R10: email used as Mixpanel `distinct_id` → use a random pseudonymous ID; confirm Mixpanel DPA and EU residency.
2. High – R3: Mixpanel loads without consent → gate behind analytics consent; honor GPC.
3. Medium – R1: birthdate and IP have no purpose for a newsletter → drop both (keep consent timestamp + source instead).
4. Medium – R5/R6: no unsubscribe-and-delete path or retention → add DSAR delete hook and purge 30 days after unsubscribe.
