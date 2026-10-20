---
name: api-architecture
description: API and system architecture standards (REST/GraphQL design, versioning, errors, data modeling, integrations, docs). Use when designing endpoints, schemas, services, webhooks, or project structure.
---
# API & Architecture

## Goal
APIs other teams and customers can integrate with once and trust for years.

## Always do
1. **Contract first**: write the OpenAPI spec (or GraphQL schema) before the code.
2. **REST conventions**: plural nouns (`/invoices/{id}`), correct verbs and status codes (201 created, 400 invalid, 401 unauthenticated, 403 forbidden, 404, 409 conflict, 422, 429).
3. **Consistent error shape**: `{ "error": { "code", "message", "details", "requestId" } }`.
4. **Versioning** (`/v1/`) — never break existing clients; deprecate with notice.
5. **Pagination** (cursor-based for large sets), filtering, and sorting on all list endpoints.
6. **Idempotency keys** on POSTs that create money or records.
7. **Webhooks**: signed payloads, retries, event IDs for de-duplication.
8. **Data modeling**: normalized schema, foreign keys, `created_at`/`updated_at`, soft delete where audits require it, tenant ID on every tenant-owned table.
9. **Boundaries**: keep business logic out of controllers and UI; prefer a modular monolith over premature microservices.
10. **Document decisions** in short ADRs (Architecture Decision Records): context, decision, consequences.

## Output
For a design: endpoints table, data model, error cases, and open questions.
