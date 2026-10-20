# REST conventions

## Contents
- URLs and naming
- Methods and semantics
- Status code table
- Error format (RFC 9457)
- Pagination, filtering, sorting
- Idempotency
- Rate limiting
- Versioning and deprecation
- GraphQL notes
- OpenAPI component snippet

## URLs and naming
- Base: `https://api.example.com/v1`. Version in the path for public APIs.
- Plural nouns, kebab-case segments: `/v1/payment-methods`, `/v1/users/{userId}/api-keys`.
- Nest at most one level (`/customers/{id}/orders`); beyond that, use top-level with a filter (`/orders?customerId=`).
- JSON fields camelCase; enums `SCREAMING_SNAKE` or lowercase strings, consistently. Never change enum casing.
- Timestamps ISO 8601 UTC with `Z`: `"createdAt": "2025-03-01T12:00:00Z"`. Money as integer minor units + currency: `{"amount": 1999, "currency": "EUR"}`.
- IDs are strings (even if numeric internally); optional type prefix for debuggability: `ord_01J9...`.
- Non-CRUD actions: `POST /v1/invoices/{id}/void`, `POST /v1/exports` (creates an export job).

## Methods and semantics
| Method | Use | Idempotent | Body |
|--------|-----|------------|------|
| GET | Read resource/collection | Yes | No |
| POST | Create, or trigger action | No (use Idempotency-Key) | Yes |
| PUT | Full replace | Yes | Yes |
| PATCH | Partial update (JSON Merge Patch, `application/merge-patch+json`) | Should be | Yes |
| DELETE | Remove | Yes (second call → 404 or 204, pick one, document it) | No |

Optimistic concurrency: return `ETag`; require `If-Match` on PUT/PATCH for contended resources; mismatch → 412.

## Status code table
| Code | When |
|------|------|
| 200 OK | Successful GET, PUT, PATCH with body |
| 201 Created | POST created a resource; include `Location` header and the resource |
| 202 Accepted | Async job accepted; return job resource with status URL |
| 204 No Content | Successful DELETE or action with no body |
| 304 Not Modified | Conditional GET matched `If-None-Match` |
| 400 Bad Request | Malformed JSON, wrong types, unknown query params |
| 401 Unauthorized | Missing/invalid credentials; include `WWW-Authenticate` |
| 403 Forbidden | Authenticated but lacks permission on a resource it may know exists |
| 404 Not Found | Missing, or belongs to another tenant (do not leak existence) |
| 405 Method Not Allowed | Include `Allow` header |
| 409 Conflict | State conflict: duplicate unique key, invalid state transition, idempotency key in flight |
| 412 Precondition Failed | `If-Match` ETag mismatch |
| 415 Unsupported Media Type | Wrong `Content-Type` |
| 422 Unprocessable Content | Well-formed but fails validation/business rules |
| 429 Too Many Requests | Rate limited; include `Retry-After` |
| 500 Internal Server Error | Unexpected; generic message + requestId |
| 503 Service Unavailable | Maintenance/overload; include `Retry-After` |

## Error format (RFC 9457)
`Content-Type: application/problem+json`
```json
{
  "type": "https://api.example.com/problems/validation-error",
  "title": "Request validation failed",
  "status": 422,
  "detail": "2 fields are invalid.",
  "instance": "/v1/orders",
  "requestId": "req_01J9Z3K8",
  "errors": [
    { "pointer": "/items/0/quantity", "code": "min_value", "detail": "Must be ≥ 1." },
    { "pointer": "/currency", "code": "invalid_enum", "detail": "Must be one of EUR, USD, GBP." }
  ]
}
```
```json
{
  "type": "https://api.example.com/problems/insufficient-funds",
  "title": "Insufficient funds",
  "status": 409,
  "detail": "Balance 30.00 EUR is less than charge 50.00 EUR.",
  "instance": "/v1/charges",
  "requestId": "req_01J9Z3M2"
}
```
- `type` is a stable URI clients switch on; `title` is constant per type; `detail` is human-readable for this occurrence.
- Never include stack traces, SQL, or internal hostnames.

## Pagination, filtering, sorting
Cursor pagination (default for all lists):
```
GET /v1/orders?limit=20&cursor=eyJjIjoiMjAyNS0wMy0wMVQxMjowMDowMFoiLCJpIjoib3JkXzAxSjkifQ
```
```json
{
  "data": [ { "id": "ord_01J9...", "createdAt": "..." } ],
  "pagination": { "nextCursor": "eyJ...", "hasMore": true }
}
```
- Cursor = base64url of the last row's sort key + id; treat as opaque; reject tampered cursors with 400.
- SQL: `WHERE (created_at, id) < (:c, :i) ORDER BY created_at DESC, id DESC LIMIT :limit + 1` (fetch one extra to compute `hasMore`).
- Offset pagination only for small admin tables needing page numbers; cap `offset` (e.g. 10 000).
- Avoid `totalCount` on large tables; if needed, make it opt-in (`?include=totalCount`) or approximate.
- Filtering: explicit params `?status=paid&createdAfter=2025-01-01T00:00:00Z`; multi-value `?status=paid,refunded`.
- Sorting: `?sort=-createdAt,amount` (leading `-` = descending); allow-list sortable fields, backed by indexes.
- Sparse fields/expansion (optional): `?fields=id,status`, `?expand=customer`.

## Idempotency
```
POST /v1/payments
Idempotency-Key: 6f1c2f1e-8a5b-4d4e-9b1a-0d3c7e2f9a10
```
- Client generates a UUID per logical operation and reuses it on retries.
- Server stores `(tenant_id, key) → request_hash, status, response` for 24 h.
- Same key + same hash → replay stored response (same status code). Same key + different hash → 422. Key in flight → 409.

## Rate limiting
```
RateLimit-Limit: 100
RateLimit-Remaining: 0
RateLimit-Reset: 30
Retry-After: 30
```
- Limit per API key/tenant and per IP for unauthenticated routes; separate stricter buckets for auth and expensive endpoints.
- Return 429 with a problem+json body (`type: .../rate-limited`).

## Versioning and deprecation
- Non-breaking (allowed in-version): new endpoint, new optional request field, new response field, new enum value *only if documented that clients must tolerate unknown values*.
- Breaking (needs new major version): removing/renaming fields or endpoints, changing types, making optional fields required, changing default behavior, tightening validation, changing error `type`s.
- Deprecation response headers:
  ```
  Deprecation: @1735689600
  Sunset: Wed, 31 Dec 2025 23:59:59 GMT
  Link: <https://api.example.com/docs/migrate-v2>; rel="deprecation"
  ```
- Process: announce → headers + changelog → monitor usage per client → contact remaining callers → sunset → 410 Gone.
- Run old and new versions on shared domain logic; versions are thin translation layers.

## GraphQL notes
- Schema-first SDL; nullable by default only where truly optional.
- Relay-style connections (`edges`, `node`, `pageInfo { endCursor hasNextPage }`) for lists; `first` capped at 100.
- Mutations return a payload type with `userErrors { field message code }`.
- Enforce query depth (≤ 10) and cost limits; disable introspection in production for private APIs; use DataLoader to avoid N+1.
- Deprecate with `@deprecated(reason: "...")`; never remove fields still in use (track via field usage metrics).

## OpenAPI component snippet
```yaml
openapi: 3.1.0
info: { title: Example API, version: 1.4.0 }
components:
  parameters:
    IdempotencyKey:
      name: Idempotency-Key
      in: header
      required: false
      schema: { type: string, format: uuid }
  schemas:
    Problem:
      type: object
      required: [type, title, status]
      properties:
        type: { type: string, format: uri }
        title: { type: string }
        status: { type: integer }
        detail: { type: string }
        instance: { type: string }
        requestId: { type: string }
        errors:
          type: array
          items:
            type: object
            properties:
              pointer: { type: string }
              code: { type: string }
              detail: { type: string }
    Order:
      type: object
      additionalProperties: false
      required: [id, status, total, createdAt]
      properties:
        id: { type: string, example: ord_01J9Z3K8 }
        status: { type: string, enum: [pending, paid, cancelled] }
        total: { $ref: '#/components/schemas/Money' }
        createdAt: { type: string, format: date-time }
    Money:
      type: object
      required: [amount, currency]
      properties:
        amount: { type: integer, description: Minor units }
        currency: { type: string, pattern: '^[A-Z]{3}$' }
    OrderPage:
      type: object
      required: [data, pagination]
      properties:
        data: { type: array, items: { $ref: '#/components/schemas/Order' } }
        pagination:
          type: object
          properties:
            nextCursor: { type: [string, 'null'] }
            hasMore: { type: boolean }
  responses:
    Problem:
      description: Error
      content:
        application/problem+json:
          schema: { $ref: '#/components/schemas/Problem' }
  securitySchemes:
    bearerAuth: { type: http, scheme: bearer }
security: [ { bearerAuth: [] } ]
```
