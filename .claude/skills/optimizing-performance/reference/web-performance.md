# Web performance techniques

## Contents
- Measurement tools
- LCP fixes
- INP fixes
- CLS fixes
- JavaScript bundle
- Images and fonts
- HTTP and CDN caching
- Database
- Application caching
- Background jobs
- Resilient outbound calls
- Load testing

## Measurement tools
- **Field (real users):** `web-vitals` library → analytics/RUM; Chrome UX Report. Decide on field data at p75.
- **Lab:** Lighthouse (mobile, throttled), WebPageTest, Chrome DevTools Performance panel.
- **Backend:** OpenTelemetry traces, `EXPLAIN (ANALYZE, BUFFERS)`, `pg_stat_statements`, language profilers (clinic.js, py-spy, pprof).
```ts
import { onLCP, onINP, onCLS } from 'web-vitals';
[onLCP, onINP, onCLS].forEach((fn) => fn((m) => navigator.sendBeacon('/rum', JSON.stringify(m))));
```

## LCP fixes (< 2.5 s)
- Server-render or statically generate the above-the-fold content; TTFB < 800 ms.
- LCP image: `fetchpriority="high"`, never `loading="lazy"`; preload if discovered late.
- Remove render-blocking CSS/JS: inline critical CSS (< 14 KB), `defer` scripts.
- Serve from a CDN edge; use HTTP/2 or HTTP/3; Brotli compression.

## INP fixes (< 200 ms)
- Keep tasks < 50 ms; break up long work (`await scheduler.yield()` or `setTimeout(0)` chunks).
- Give immediate visual feedback, then do work; debounce input handlers (150–300 ms) for search.
- Move heavy computation to Web Workers; virtualize lists > 100 rows (`@tanstack/react-virtual`).
- React: avoid re-rendering large trees (`memo`, stable props, `useTransition` for non-urgent updates).
- Audit third-party scripts (tag managers, chat widgets); load after interaction or idle.

## CLS fixes (< 0.1)
- Set `width`/`height` or `aspect-ratio` on images, video, iframes, ads.
- Reserve space for async content (skeletons with fixed height); never insert banners above existing content.
- Fonts: `font-display: optional` or `swap` with `size-adjust` fallback metrics.
- Animate only `transform` and `opacity`.

## JavaScript bundle
- Budget: < 170 KB compressed initial JS on mobile; enforce with `size-limit` or bundler budgets in CI.
- Route-level code splitting (`import()`/`React.lazy`); lazy-load modals, editors, charts.
- Replace heavy dependencies (moment → date-fns/Temporal, lodash → per-function imports); check with `source-map-explorer` / `vite-bundle-visualizer`.
- Tree-shake: ESM imports, `sideEffects: false`. Ship modern syntax to modern browsers.

## Images and fonts
- AVIF/WebP with `<picture>` fallback; responsive `srcset` + `sizes`; never ship images wider than 2× display size.
- `loading="lazy"` and `decoding="async"` below the fold.
- Self-host fonts, subset, WOFF2, preload at most 1–2 critical fonts.

## HTTP and CDN caching
```
# Fingerprinted static assets (app.3f9a1c.js)
Cache-Control: public, max-age=31536000, immutable
# HTML / API responses that can be briefly stale
Cache-Control: public, max-age=0, s-maxage=60, stale-while-revalidate=300
# Private, per-user data
Cache-Control: private, no-store
```
Use `ETag` for conditional requests; never cache responses with `Set-Cookie` at the CDN.

## Database
- **Find slow queries:** `pg_stat_statements` ordered by `total_exec_time`; log queries > 100 ms.
- **Read the plan:** `EXPLAIN (ANALYZE, BUFFERS)`. Red flags: Seq Scan on large tables, rows estimate off by 10×+, Sort spilling to disk, Nested Loop over many rows.
- **Index:** composite index columns ordered equality → range → sort, e.g. `(tenant_id, status, created_at DESC)`. Use partial indexes for hot subsets; create with `CONCURRENTLY` in production. Remove unused indexes (they slow writes).
- **N+1:** detect by query count per request (> 10 is suspicious). Fix with `JOIN`, `IN (...)` batching, DataLoader, or ORM eager loading (`include`, `select_related`/`prefetch_related`).
- **Pagination:** keyset over OFFSET for large tables:
  ```sql
  SELECT id, created_at, total FROM orders
  WHERE tenant_id = $1 AND (created_at, id) < ($2, $3)
  ORDER BY created_at DESC, id DESC
  LIMIT 50;
  ```
- **Connections:** pool size ≈ (CPU cores × 2) + effective spindles per DB node; use PgBouncer for serverless; set `statement_timeout` (e.g. 5 s for web requests).
- Read replicas for reporting; never run analytics queries on the primary during peak.

## Application caching
| Layer | Tool | TTL guidance | Invalidation |
|-------|------|--------------|--------------|
| Browser/CDN | Cache-Control | Assets 1 year; HTML seconds–minutes | Fingerprinted filenames; purge API |
| Application | Redis/Memcached | Seconds–minutes | Delete key on write (cache-aside) |
| In-process | LRU map | Seconds | Short TTL only (no cross-instance invalidation) |
| Query/ORM | Materialized views | Minutes–hours | `REFRESH MATERIALIZED VIEW CONCURRENTLY` |

Cache-aside with stampede protection:
```ts
async function getProduct(tenantId: string, id: string) {
  const key = `t:${tenantId}:product:${id}:v2`;
  const hit = await redis.get(key);
  if (hit) return JSON.parse(hit);
  const product = await db.product.findUnique({ where: { tenantId, id } });
  await redis.set(key, JSON.stringify(product), 'EX', 300 + Math.floor(Math.random() * 30)); // jittered TTL
  return product;
}
// on update: await redis.del(`t:${tenantId}:product:${id}:v2`)
```
For hot keys, add a short lock (`SET key:lock 1 NX EX 5`) or request coalescing so only one caller recomputes.

## Background jobs
- Use a durable queue (SQS, BullMQ, Sidekiq, Celery, Cloud Tasks); never fire-and-forget promises in request handlers.
- Idempotent handlers: store processed `idempotency_key`/event ID with a unique constraint; skip duplicates.
- Retry with exponential backoff + full jitter: `delay = random(0, min(cap, base × 2^attempt))`, e.g. base 1 s, cap 5 min, max 8 attempts → dead-letter queue + alert.
- Set a visibility timeout > the job's p99 duration; make jobs small and resumable.
- Outbox pattern when a DB write and a message must both happen: write the event in the same transaction, relay asynchronously.

## Resilient outbound calls
```ts
const res = await fetch(url, { signal: AbortSignal.timeout(3000) });
```
- Timeouts everywhere: HTTP clients, DB (`statement_timeout`), Redis, queues. Total request budget < upstream timeout.
- Retry only idempotent requests (GET, PUT, or POST with idempotency key), max 2–3 attempts, on 429/502/503/504/network errors; honor `Retry-After`.
- Circuit breaker (opossum, resilience4j, pybreaker): open after ~50% failures over 20+ requests in 10 s; half-open after 30 s.
- Bulkheads: separate pools/concurrency limits per dependency so one slow service can't exhaust all workers.
- Fallbacks: stale cache, default value, or feature hidden with a clear message.

## Load testing
k6 example asserting SLOs:
```js
import http from 'k6/http';
export const options = {
  stages: [{ duration: '2m', target: 200 }, { duration: '5m', target: 200 }, { duration: '1m', target: 0 }],
  thresholds: { http_req_failed: ['rate<0.001'], http_req_duration: ['p(95)<300', 'p(99)<1000'] },
};
export default () => http.get(`${__ENV.BASE_URL}/api/orders?limit=50`, { headers: { Authorization: `Bearer ${__ENV.TOKEN}` } });
```
Test at 2× expected peak against a production-like dataset; watch DB CPU, connections, and queue depth.
