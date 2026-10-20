# Architecture and data standards

## Contents
- Default architecture
- Layering
- Module boundaries (modular monolith)
- When to split a service
- Schema conventions
- Multi-tenancy
- Migration rules
- Events and webhooks
- ADR template

## Default architecture
Start with a **modular monolith**: one deployable, one database, strict internal module boundaries. Split into services only when a split criterion below is met and recorded in an ADR.

## Layering
```
transport (HTTP/GraphQL handlers, webhooks, jobs)
  → application (use cases, transactions, authz)
    → domain (entities, invariants, pure logic)
  → infrastructure (repositories, external clients, queues)
```
- Handlers parse/validate input, call one use case, map result to response. No SQL in handlers.
- Domain code has no framework, HTTP, or ORM imports.
- External APIs sit behind an interface (port) so they can be faked in tests.
- One transaction per use case; publish events via an outbox, never inside the transaction directly.

## Module boundaries (modular monolith)
```
src/modules/
  billing/   { api/, application/, domain/, infra/, index.ts }
  orders/
  identity/
```
- Modules talk only through their public `index.ts` (or published events). No reaching into another module's tables or internals.
- Each module owns its tables (prefix or schema: `billing.invoices`). Cross-module reads go through the owning module's API or a read model.
- Enforce with lint rules (`eslint-plugin-boundaries`, `dependency-cruiser`, ArchUnit, `import-linter`) in CI.
- No circular dependencies between modules.

## When to split a service
Split only if at least one holds, and write an ADR:
- Independent scaling profile (e.g. 100× the load of the rest).
- Different availability/compliance boundary (PCI scope, data residency).
- A separate team owns it end-to-end and deploy contention is measurable.
- Different runtime/tech requirement (GPU, streaming).
Costs to accept: network failures, distributed transactions (use sagas), duplicated data, observability overhead.

## Schema conventions
| Item | Convention |
|------|-----------|
| Table names | plural snake_case: `line_items` |
| Primary key | `id uuid` (UUIDv7 for time-ordering) or `bigint` internal + public `uuid`/prefixed ID |
| Foreign keys | `<entity>_id`, always with FK constraint and index |
| Timestamps | `created_at timestamptz not null default now()`, `updated_at timestamptz not null` |
| Soft delete | `deleted_at timestamptz null` only when restore/audit needed; partial unique indexes `WHERE deleted_at IS NULL` |
| Money | `bigint` minor units + `char(3)` currency; never float |
| Enums | `text` + CHECK constraint (easier to evolve than native enums) |
| Booleans | `is_`/`has_` prefix, `not null default false` |
| JSON | `jsonb` for genuinely schemaless data only; never for fields you filter/join on |
| Audit | `created_by`, `updated_by` for user-editable business records |

- Every table gets: PK, `created_at`, `updated_at`, and indexes for every FK and every list query's filter + sort.
- Prefer hard delete + audit log over soft delete for personal data (GDPR erasure).

## Multi-tenancy
- `tenant_id uuid not null` on every tenant-owned table, first column in composite indexes: `(tenant_id, created_at DESC, id)`.
- Tenant comes from the authenticated session, never from request input.
- Enforce in the data layer: repository base class auto-applies `tenant_id`, and/or Postgres Row-Level Security:
  ```sql
  ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
  CREATE POLICY tenant_isolation ON orders
    USING (tenant_id = current_setting('app.tenant_id')::uuid);
  ```
- Unique constraints are per tenant: `UNIQUE (tenant_id, external_ref)`.
- Test: every repository has a cross-tenant test returning nothing.

## Migration rules
- Migrations are forward-only, versioned, in the repo, and run in CI against a production-like snapshot.
- **Expand → migrate → contract** for breaking schema changes:
  1. Expand: add new column/table (nullable or with default); deploy code that writes both.
  2. Migrate: backfill in batches (e.g. 1 000–10 000 rows, throttled).
  3. Switch reads to the new column; deploy.
  4. Contract: drop old column in a later release.
- Never in one step: rename column, change type, add `NOT NULL` without default on a large table, drop a column still read by running code.
- Postgres: `CREATE INDEX CONCURRENTLY`; add constraints as `NOT VALID` then `VALIDATE CONSTRAINT`; set `lock_timeout` (e.g. 5s).
- Every migration is reversible or has a documented roll-forward fix.

## Events and webhooks
**Internal events (outbox pattern):**
- Write the event row to `outbox` in the same transaction as the state change; a relay publishes and marks it sent.
- Event names past tense, `<entity>.<verb>`: `invoice.paid`, `order.cancelled`.
- Consumers are idempotent (dedupe on event `id`) and tolerate out-of-order delivery (compare `occurredAt` or version).

**Webhook payload:**
```json
{
  "id": "evt_01J9Z4A7",
  "type": "invoice.paid",
  "apiVersion": "2025-01-01",
  "createdAt": "2025-03-01T12:00:00Z",
  "data": { "object": { "id": "inv_01J9...", "status": "paid" } }
}
```
**Webhook headers and signature:**
```
Webhook-Id: evt_01J9Z4A7
Webhook-Timestamp: 1740830400
Webhook-Signature: v1,<base64 HMAC-SHA256(secret, "{id}.{timestamp}.{body}")>
```
- Per-endpoint secret, rotatable with two active secrets during rotation.
- Receiver: verify signature with constant-time compare, reject timestamps > 5 min old, dedupe by `id`, respond 2xx within 5 s and process async.
- Sender retries on non-2xx/timeouts with exponential backoff + jitter (e.g. 1m, 5m, 30m, 2h, 6h, … up to ~3 days), then disables the endpoint and notifies the owner.
- Provide a dashboard/API to list deliveries and replay events; ship "thin" payloads plus an ID clients can fetch when data is sensitive.
- Follow the Standard Webhooks spec when possible.

## ADR template
File: `docs/adr/NNNN-short-title.md` (sequential, never renumber; supersede instead of editing accepted ADRs).
```markdown
# NNNN. [Decision title]

- Status: Proposed | Accepted | Superseded by NNNN
- Deciders: [names/roles]
- Date: YYYY-MM-DD

## Context
[Forces at play: requirements, constraints, scale numbers, team, deadlines.]

## Decision
[What we will do, stated in one or two sentences.]

## Options considered
| Option | Pros | Cons |
|--------|------|------|
| A (chosen) | ... | ... |
| B | ... | ... |

## Consequences
- Positive: ...
- Negative / risks: ...
- Follow-ups: ...
```
