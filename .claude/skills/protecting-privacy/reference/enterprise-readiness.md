# Enterprise readiness

## Contents
- Enterprise checklist
- Tenant isolation patterns
- Postgres row-level security example
- RBAC model
- SSO and SCIM
- Audit-log schema
- Retention schedule template
- DSAR handler pattern
- Security questionnaire answers

## Enterprise checklist
- [ ] SSO: SAML 2.0 and OIDC per tenant; enforce-SSO toggle disables password login.
- [ ] SCIM 2.0 provisioning: create, update, deactivate users and groups; deactivation revokes sessions within minutes.
- [ ] RBAC with at least Owner / Admin / Member / Read-only; custom roles for large tenants.
- [ ] Audit log visible to tenant admins, filterable, exportable (CSV/JSON) and streamable (webhook/SIEM).
- [ ] Tenant isolation enforced in the data layer (RLS or mandatory filter) with cross-tenant tests.
- [ ] Data residency options (e.g. EU, US) with region pinned at tenant creation, including backups and sub-processors.
- [ ] Configurable retention per tenant; admin-triggered tenant data export and deletion.
- [ ] Encryption at rest with KMS; optional customer-managed keys (BYOK) for top tier.
- [ ] Session controls: idle timeout, IP allow-list, MFA enforcement.
- [ ] Public trust page: sub-processor list, DPA, SOC 2 report on request, status page, security contact.
- [ ] Uptime SLA backed by SLOs; documented RPO/RTO.

## Tenant isolation patterns
| Pattern | Isolation | Cost | Use when |
|---------|-----------|------|----------|
| Shared tables + `tenant_id` + RLS | Logical | Low | Default for SaaS |
| Schema per tenant | Stronger | Medium | Tens–hundreds of tenants, per-tenant migrations OK |
| Database per tenant | Strongest | High | Regulated/top-tier customers, residency, BYOK |

Rules regardless of pattern:
- `tenant_id` comes from the authenticated session, never the request body or query.
- Every unique index and foreign key includes `tenant_id`.
- Caches, search indexes, object-storage prefixes, queues, and background jobs carry `tenant_id`.
- Tests: user in tenant A requesting tenant B's resource gets 404.

## Postgres row-level security example
```sql
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices FORCE ROW LEVEL SECURITY;  -- applies to table owner too

CREATE POLICY tenant_isolation ON invoices
  USING (tenant_id = current_setting('app.tenant_id')::uuid)
  WITH CHECK (tenant_id = current_setting('app.tenant_id')::uuid);

-- App connects as a non-superuser role without BYPASSRLS.
-- Per request/transaction, set the tenant from the verified session:
BEGIN;
SET LOCAL app.tenant_id = '6f1c...';   -- via parameter binding, e.g. SELECT set_config('app.tenant_id', $1, true)
SELECT * FROM invoices WHERE id = $2;  -- RLS adds the tenant predicate
COMMIT;
```
Use `SET LOCAL` / `set_config(..., true)` so the value cannot leak across pooled connections. If `app.tenant_id` is unset, the cast fails and the query returns an error (fail closed).

## RBAC model
```
permissions: invoice:read, invoice:write, member:invite, billing:manage, audit:read, settings:sso
roles:       owner  → all
             admin  → all except billing:manage
             member → invoice:read, invoice:write
             viewer → invoice:read
```
Check permissions, not role names, in code (`can(user, 'invoice:write', invoice)`). Map IdP groups to roles via SCIM.

## SSO and SCIM
- Validate SAML signatures, `Audience`, `Recipient`, `NotOnOrAfter`; reject unsigned assertions; protect against XML signature wrapping by using a maintained library.
- Bind SSO connections to verified domains; JIT-provision only for verified domains.
- SCIM endpoints: `/scim/v2/Users`, `/scim/v2/Groups`; bearer token per tenant, stored hashed; `active: false` → deactivate and revoke sessions and API tokens.

## Audit-log schema
```sql
CREATE TABLE audit_events (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id     uuid NOT NULL,
  occurred_at   timestamptz NOT NULL DEFAULT now(),
  actor_type    text NOT NULL,           -- user | api_key | system | support
  actor_id      text NOT NULL,
  action        text NOT NULL,           -- invoice.exported, member.role_changed
  target_type   text,
  target_id     text,
  outcome       text NOT NULL,           -- success | denied | error
  ip            inet,
  user_agent    text,
  request_id    text,
  metadata      jsonb NOT NULL DEFAULT '{}'  -- changed field names, not PII values
);
REVOKE UPDATE, DELETE ON audit_events FROM app_role;  -- append-only
```
Log: auth events, role/permission changes, SSO/SCIM changes, data exports, DSAR actions, API key lifecycle, support/impersonation access, settings changes. Retain ≥ 1 year (6 years for HIPAA). For tamper evidence, hash-chain rows or ship to WORM storage (e.g. S3 Object Lock).

## Retention schedule template
| Data | Class | Retention | Trigger | Deletion method |
|------|-------|-----------|---------|-----------------|
| Account profile | PII | Life of account + 30 days | Account closed | Hard delete |
| Customer content | PII | Tenant-configurable, default life of contract + 30 days | Contract end | Hard delete + storage purge |
| Application logs | Internal (redacted) | 30 days | Age | Log platform TTL |
| Audit events | Confidential | 1 year (6 years HIPAA) | Age | Partition drop |
| Backups | Mixed | 35 days | Age | Rotation |
| Analytics events | Pseudonymous | 14 months | Age | Vendor setting |

## DSAR handler pattern
Maintain a registry so new stores cannot be forgotten:
```ts
export const personalDataStores: PersonalDataStore[] = [
  { name: 'users',        export: exportUser,        erase: eraseUser },
  { name: 'comments',     export: exportComments,    erase: anonymizeComments },
  { name: 'stripe',       export: exportStripe,      erase: deleteStripeCustomer },
  { name: 'search_index', export: async () => null,  erase: purgeSearchDocs },
];
```
Run erasure as an idempotent background job with per-store status; write an audit event per store; a CI test asserts every table tagged PII is covered by the registry.

## Security questionnaire answers
Keep a maintained answer bank; typical items and the evidence to cite:
- **Encryption:** TLS 1.2+ in transit; AES-256 at rest via cloud KMS; key rotation annually.
- **Access:** SSO + MFA for all staff; least privilege; quarterly access reviews; production access logged.
- **SDLC:** code review required, CI tests + SAST + dependency scanning, separate environments, no production data in dev.
- **Tenant isolation:** describe the pattern above and the cross-tenant test suite.
- **Logging:** centralized, retained N days, PII redacted; customer audit log available.
- **BC/DR:** daily backups, PITR, tested restores, RPO/RTO values.
- **Incident response:** documented plan, customer notification commitment (e.g. within 72 hours).
- **Sub-processors:** public list, DPAs in place, advance notice of changes.
- **Certifications:** SOC 2 Type II, ISO 27001 status; latest pentest date and summary.
