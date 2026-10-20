---
name: optimizing-performance
description: Measures and improves web performance and production reliability - Core Web Vitals (LCP, INP, CLS), bundle size, images, rendering, database queries, indexing, N+1, pagination, caching, background jobs, retries, timeouts, circuit breakers, observability with structured logs, metrics, tracing and OpenTelemetry, SLOs and error budgets, health checks, zero-downtime deploys, backward-compatible migrations, feature flags, rollback, and incident postmortems. Use when code is slow, pages load slowly, queries time out, the user mentions performance, latency, speed, Lighthouse, scaling, load, caching, reliability, uptime, monitoring, alerts, outages, incidents, deploys, or migrations, or before launching to production.
---

# Optimizing Performance

Measure first, fix the biggest bottleneck, measure again. Design every dependency call to be slow or fail, and every deploy to be reversible.

## Choose the workflow

- **Something is slow** → follow "Optimization workflow".
- **Preparing for production, deploys, migrations, incidents** → follow "Reliability workflow".
- **Frontend or backend techniques with numbers and code** → read [reference/web-performance.md](reference/web-performance.md).
- **SLOs, logging schema, alerts, runbooks, postmortems, migration pattern** → read [reference/reliability-observability.md](reference/reliability-observability.md).

## Targets (p75 for web vitals, p95/p99 for servers)

| Metric | Good | Investigate |
|--------|------|-------------|
| LCP | < 2.5 s | > 4.0 s poor |
| INP | < 200 ms | > 500 ms poor |
| CLS | < 0.1 | > 0.25 poor |
| TTFB | < 800 ms | > 1.8 s |
| API latency | p95 < 300 ms, p99 < 1 s | p99 > 2 s |
| DB query | < 50 ms typical | > 100 ms → log as slow |
| Initial JS (compressed) | < 170 KB | > 300 KB |
| Availability SLO | 99.9% (43 min/month budget) | Budget burn > 2%/hour |

## Non-negotiable rules

1. **Measure before and after** with the same tool and conditions (Lighthouse/WebPageTest on throttled mobile, RUM field data, `EXPLAIN ANALYZE`, profiler, load test). No optimization without a number.
2. **Database first:** index columns in `WHERE`/`JOIN`/`ORDER BY`; eliminate N+1 with joins or batching; paginate every list (cursor/keyset for large tables); select only needed columns.
3. **Cache with an invalidation plan:** every cache states key, TTL, and what invalidates it. Include `tenant_id`/user in keys for private data.
4. **Every network call has a timeout** (connect ≤ 1 s, total ≤ 2–5 s for user-facing paths), bounded retries with exponential backoff + jitter for idempotent operations only, and a circuit breaker for flaky dependencies.
5. **Move slow work off the request path** into background jobs that are idempotent (idempotency key), retried with backoff, and dead-lettered after N attempts.
6. **Degrade gracefully:** if a non-critical dependency fails, serve stale cache or a reduced feature, not a 500.
7. **Observability by default:** structured JSON logs with request/trace ID, RED metrics (Rate, Errors, Duration) per endpoint, USE metrics (Utilization, Saturation, Errors) per resource, distributed tracing via OpenTelemetry.
8. **Health checks:** `/livez` (process alive, no dependencies) and `/readyz` (can serve: DB/cache reachable). Never restart on dependency failure via liveness.
9. **Zero-downtime changes:** rolling/blue-green/canary deploys; database migrations use expand → migrate → contract; risky features behind flags; rollback in < 5 minutes.
10. **Alert on symptoms, not causes:** page on SLO burn rate; everything else is a ticket or dashboard.

## Optimization workflow

```
Optimization checklist:
- [ ] 1. Define the metric and target (e.g. checkout API p95 < 300 ms)
- [ ] 2. Measure baseline in realistic conditions; record numbers
- [ ] 3. Profile to find the top bottleneck (trace, flame graph, EXPLAIN, Lighthouse)
- [ ] 4. Apply one change targeting that bottleneck
- [ ] 5. Re-measure; keep change only if it moved the metric
- [ ] 6. Repeat 3–5 until target met; add a regression guard (budget, test, alert)
- [ ] 7. Report with the template below
```

## Reliability workflow

```
Production readiness checklist:
- [ ] 1. SLOs defined for key user journeys; alerts on burn rate
- [ ] 2. Timeouts, retries, circuit breakers on every outbound call
- [ ] 3. Structured logs + RED metrics + tracing wired up
- [ ] 4. /livez and /readyz implemented; graceful shutdown drains requests
- [ ] 5. Migrations backward compatible; rollback tested
- [ ] 6. Risky change behind a feature flag with kill switch
- [ ] 7. Runbook for each paging alert
- [ ] 8. Load test at 2× expected peak; verify no errors and SLOs hold
```

## Report template

```markdown
## Performance report: [scope]

| # | Metric | Before | After | Change | Fix | Evidence |
|---|--------|--------|-------|--------|-----|----------|
| 1 | GET /orders p95 | 1,840 ms | 120 ms | -93% | Index `(tenant_id, created_at)` + removed N+1 | EXPLAIN: Seq Scan → Index Scan |

**Method:** [tool, environment, dataset size, runs]
**Regression guard:** [budget / alert / test added]
**Remaining bottlenecks / risks:** [list]
```

## Example

**Input:** "The /orders page takes 4 seconds to load."

**Output:**
1. Measures: trace shows 1 query for orders + 50 queries for customers (N+1), 3.1 s total; LCP 4.2 s.
2. `EXPLAIN ANALYZE` shows Seq Scan on 2M rows → adds `CREATE INDEX CONCURRENTLY ON orders (tenant_id, created_at DESC)`; replaces per-row customer lookups with one `JOIN`; adds keyset pagination, 50 per page.
3. Re-measures: API p95 120 ms, LCP 1.9 s; adds slow-query alert at > 100 ms and reports the before/after table.
