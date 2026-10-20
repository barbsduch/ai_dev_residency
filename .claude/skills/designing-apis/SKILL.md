---
name: designing-apis
description: Designs and reviews REST and GraphQL APIs, service architecture, and data models using contract-first OpenAPI/SDL, consistent resource naming, correct status codes, RFC 9457 problem+json errors, versioning and deprecation, cursor pagination, idempotency keys, rate-limit headers, signed webhooks, multi-tenant schemas, modular monolith boundaries, and ADRs. Use when creating or changing endpoints, routes, API contracts, webhooks, database schemas, migrations, or system architecture, or when the user mentions API design, OpenAPI, Swagger, GraphQL, REST, pagination, versioning, breaking changes, microservices, or architecture decisions.
---

# Designing APIs

Contract first, consistent everywhere, never break a published client.

## Choose the workflow

- **New endpoint, resource, or API** → follow "Design workflow".
- **Reviewing an existing API or diff** → follow "Review workflow".
- **Status codes, error bodies, pagination formats, OpenAPI snippet** → read [reference/rest-conventions.md](reference/rest-conventions.md).
- **Schemas, migrations, module boundaries, events/webhooks, ADRs** → read [reference/architecture-and-data.md](reference/architecture-and-data.md).

## Non-negotiable rules

1. **Contract first.** Write or update the OpenAPI 3.1 spec (or GraphQL SDL) before the handler; generate types/clients from it; lint it in CI (Spectral).
2. **Resources are plural nouns, kebab-case paths, camelCase JSON**: `GET /v1/invoices/{invoiceId}/line-items`. Actions that are not CRUD use a sub-resource verb: `POST /v1/invoices/{id}/send`.
3. **Status codes mean what they say.** 201 + `Location` on create, 204 on empty success, 400 malformed, 401 unauthenticated, 403 forbidden, 404 not found (also for other tenants' objects), 409 conflict, 422 validation, 429 rate-limited. Never 200 with `{"error": ...}`.
4. **Errors use RFC 9457** `application/problem+json` with `type`, `title`, `status`, `detail`, `instance`, plus `errors[]` for field-level issues and a `requestId`.
5. **Never break a published contract.** Additive changes only within a version (new optional fields, new endpoints). Removals/renames/type changes need a new major version plus `Deprecation` and `Sunset` headers and ≥ 6 months notice for external clients.
6. **Every list endpoint is paginated** with opaque cursors (`limit` default 20, max 100), stable sort with a unique tiebreaker, and allow-listed `filter`/`sort` fields.
7. **Unsafe POSTs accept `Idempotency-Key`** (payments, orders, sends); store key + request hash + response for 24 h; same key with different body → 422.
8. **Rate-limit every public endpoint** and return `RateLimit-Limit`, `RateLimit-Remaining`, `RateLimit-Reset`, and `Retry-After` on 429.
9. **Webhooks are signed** (HMAC-SHA256 over `timestamp.body`), carry a unique event `id`, retry with exponential backoff, and receivers dedupe by `id`.
10. **Data model defaults**: UUIDv7/ULID public IDs, `created_at`/`updated_at` in UTC (`timestamptz`), `tenant_id` on every tenant-owned row and in every query, soft delete (`deleted_at`) only where restore/audit is required.
11. **Record significant decisions as ADRs** in `docs/adr/NNNN-title.md` (new service, datastore, sync vs async, breaking change).

## Design workflow

Copy this checklist and track progress:

```
API design checklist:
- [ ] 1. List consumers, use cases, and the resources involved
- [ ] 2. Model resources + relationships; define IDs, timestamps, tenant scoping
- [ ] 3. Write the OpenAPI/SDL contract: paths, schemas, errors, examples
- [ ] 4. Decide pagination, filtering, sorting, idempotency, rate limits
- [ ] 5. Define auth scopes per operation
- [ ] 6. Lint the contract and check it against the rules above
- [ ] 7. Implement handler from generated types; add contract tests
- [ ] 8. Write an ADR if a rule-11 decision was made
```

**Step 3 – Every operation documents**: `operationId`, request schema with `additionalProperties: false`, every response code it can return, and one realistic example.

**Step 6 – Verification loop.** Run `npx @stoplight/spectral-cli lint openapi.yaml` (and `oasdiff breaking old.yaml new.yaml` for changes). Fix every error, re-run until clean. Any breaking change → stop and apply rule 5.

**Step 7 – Contract tests** assert each documented status code: happy path, 401, 403/404 cross-tenant, 422 invalid body, 409 conflict, and pagination across ≥ 2 pages.

## Review workflow

1. Diff the spec against the last released version (`oasdiff breaking`). Flag every breaking change.
2. Walk each operation through rules 1–10.
3. Check naming and status codes against [reference/rest-conventions.md](reference/rest-conventions.md).
4. Check schema/migration safety against [reference/architecture-and-data.md](reference/architecture-and-data.md).
5. Report using the template below, breaking issues first.

## Report template

```markdown
## API review: [scope]

| # | Severity | Rule | Location | Issue | Impact on clients | Fix |
|---|----------|------|----------|-------|-------------------|-----|
| 1 | Breaking | 5 Versioning | openapi.yaml#/paths/~1v1~1orders | `total` changed from integer to string | Typed clients fail to deserialize | Keep `total` int; add `totalFormatted` |

**Contract diff:** [added / changed / removed operations]
**Open questions / assumptions:** [list]
```

Severity: **Breaking** (existing clients fail), **High** (incorrect semantics, data leak, unbounded list), **Medium** (inconsistency, missing docs/examples), **Low** (naming/style).

## Example

**Input:** "Add an endpoint to create an order and list a customer's orders."

**Output (contract excerpt):**
```yaml
/v1/orders:
  post:
    operationId: createOrder
    parameters: [{ $ref: '#/components/parameters/IdempotencyKey' }]
    requestBody: { $ref: '#/components/requestBodies/CreateOrder' }
    responses:
      '201': { description: Created, headers: { Location: { schema: { type: string } } } }
      '409': { $ref: '#/components/responses/Problem' }
      '422': { $ref: '#/components/responses/Problem' }
  get:
    operationId: listOrders
    parameters:
      - { name: customerId, in: query, schema: { type: string } }
      - { name: cursor, in: query, schema: { type: string } }
      - { name: limit, in: query, schema: { type: integer, default: 20, maximum: 100 } }
    responses:
      '200': { description: Page of orders, content: { application/json: { schema: { $ref: '#/components/schemas/OrderPage' } } } }
```
Plus: orders table with `tenant_id`, UUIDv7 `id`, `created_at`; list sorted by `(created_at DESC, id DESC)`; contract tests for 201, replayed idempotency key, 422, and cross-tenant 404.
