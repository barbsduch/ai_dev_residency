---
name: performance-reliability
description: Performance, scalability, and reliability standards (Core Web Vitals, caching, observability, error handling, SLOs). Use when building pages, queries, APIs, background jobs, or deploying to production.
---
# Performance & Reliability

## Targets
- Web: LCP < 2.5s, INP < 200ms, CLS < 0.1 (Core Web Vitals, measured on mid-range mobile).
- API: p95 < 300ms for reads; 99.9% uptime SLO unless stated otherwise.

## Always do
1. **Measure before optimizing**: Lighthouse, profiler, `EXPLAIN` on queries.
2. **Database**: index columns used in filters and joins; avoid N+1 queries; paginate every list.
3. **Cache** deliberately (CDN, HTTP cache headers, Redis) with a clear invalidation rule.
4. **Frontend**: code-split routes, lazy-load below-the-fold content, optimized images (AVIF/WebP, sized), minimal JS.
5. **Slow work → background jobs** with retries, exponential backoff, and idempotency keys.
6. **Timeouts on every network call**; circuit breakers for flaky dependencies.
7. **Graceful degradation**: if a non-critical service fails, the page still works.
8. **Observability**: structured logs with request IDs, metrics (latency, errors, traffic, saturation), tracing, alerts tied to SLOs.
9. **Health checks** and zero-downtime deploys; database migrations are backward-compatible.
10. **Feature flags** for risky releases; have a rollback plan.

## Output
State the metric before and after any optimization. No metric = no claim.
