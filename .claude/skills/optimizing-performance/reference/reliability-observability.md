# Reliability and observability

## Contents
- SLO template
- Error budget policy
- Structured logging schema
- Metrics and tracing
- Alerting rules
- Health checks and graceful shutdown
- Deploys, feature flags, rollback
- Migration expand/contract pattern
- Runbook template
- Blameless postmortem template

## SLO template
```yaml
service: checkout-api
journey: "Customer completes checkout"
sli:
  availability: "proportion of POST /checkout requests with status < 500"
  latency: "proportion of POST /checkout requests served in < 500 ms"
slo:
  availability: 99.9%     # 30-day rolling window → 43.2 min error budget
  latency: 99%            # of requests under threshold
measurement: load balancer / gateway metrics, excluding synthetic traffic
owner: payments-team
review: quarterly
```
Common availability budgets (30 days): 99% = 7.2 h · 99.5% = 3.6 h · 99.9% = 43.2 min · 99.95% = 21.6 min · 99.99% = 4.3 min.

## Error budget policy
- Budget remaining > 0: ship normally.
- Budget exhausted in the window: freeze non-critical releases; prioritize reliability work until back within SLO.
- A single incident consuming > 20% of the budget requires a postmortem.

## Structured logging schema
One JSON object per line; consistent field names across services:
```json
{
  "timestamp": "2025-03-04T10:15:30.123Z",
  "level": "error",
  "service": "checkout-api",
  "env": "production",
  "version": "1.42.0",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "span_id": "00f067aa0ba902b7",
  "request_id": "req_8Hk2",
  "tenant_id": "t_123",
  "user_id": "u_456",
  "route": "POST /checkout",
  "status": 502,
  "duration_ms": 2034,
  "event": "payment_provider_timeout",
  "message": "Payment provider timed out after 2000 ms",
  "error": { "type": "TimeoutError", "stack": "..." }
}
```
Levels: `error` = needs action; `warn` = degraded but handled; `info` = business events and request summaries; `debug` off in production. Never log secrets, tokens, or PII values. Sample high-volume `info` logs; keep all errors.

## Metrics and tracing
- **RED per endpoint:** `http_requests_total{route,method,status}`, `http_request_duration_seconds` histogram (buckets around SLO thresholds: 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5).
- **USE per resource:** CPU, memory, DB connections in use / max, queue depth and age of oldest message, disk.
- **Business metrics:** sign-ups, checkouts, failed payments, job success rate.
- Avoid high-cardinality labels (user ID, full URL) on metrics; put them in traces/logs.
- **OpenTelemetry:** auto-instrument HTTP, DB, and queue clients; propagate W3C `traceparent` across services and into jobs; export via OTLP to the collector; tail-sample to keep all errors and slow traces.

## Alerting rules
Page only on user-facing symptoms; use multi-window burn-rate alerts (99.9% SLO):
| Severity | Burn rate | Long window | Short window | Budget consumed | Action |
|----------|-----------|-------------|--------------|-----------------|--------|
| Page | 14.4× | 1 h | 5 min | 2% | Page on-call |
| Page | 6× | 6 h | 30 min | 5% | Page on-call |
| Ticket | 1× | 3 d | 6 h | 10% | Next business day |

```yaml
# Prometheus example: fast burn
- alert: CheckoutErrorBudgetFastBurn
  expr: |
    (sum(rate(http_requests_total{service="checkout",status=~"5.."}[1h])) / sum(rate(http_requests_total{service="checkout"}[1h]))) > (14.4 * 0.001)
    and
    (sum(rate(http_requests_total{service="checkout",status=~"5.."}[5m])) / sum(rate(http_requests_total{service="checkout"}[5m]))) > (14.4 * 0.001)
  labels: { severity: page }
  annotations: { runbook: "https://runbooks/checkout/error-budget-burn" }
```
Every paging alert links a runbook. Alerts that fire without action needed get fixed or deleted.

## Health checks and graceful shutdown
- `GET /livez` → 200 if the process event loop responds; no dependency checks.
- `GET /readyz` → 200 only when DB/cache reachable and migrations applied; 503 while starting or draining.
- On SIGTERM: fail `/readyz`, stop accepting new connections, finish in-flight requests (≤ 30 s), close pools, exit.

## Deploys, feature flags, rollback
- Strategy: rolling or blue-green by default; canary (1% → 10% → 50% → 100%) for risky changes, auto-rollback if error rate or p99 regresses beyond SLO thresholds.
- Builds are immutable artifacts; the same image moves through staging → production; config via env.
- Feature flags decouple deploy from release: ship dark, enable per tenant/percentage, keep a kill switch. Remove flags within 30 days of full rollout.
- Rollback is one command and < 5 minutes; practice it. Code must work with both the previous and next schema version.

## Migration expand/contract pattern
Never rename or drop in a single deploy. Example: rename `users.name` → `users.full_name`.
1. **Expand:** add nullable `full_name`. Deploy.
2. **Dual write:** app writes both columns, reads `name`. Deploy.
3. **Backfill:** copy in batches (e.g. 1,000 rows, pause between batches) to avoid lock and replication lag.
4. **Switch reads:** app reads `full_name`. Deploy; verify.
5. **Stop old writes:** app writes only `full_name`. Deploy.
6. **Contract:** drop `name` after one full release cycle with no reads.

Safe-migration rules: set `lock_timeout` (e.g. 5 s); `CREATE INDEX CONCURRENTLY`; add `NOT NULL` via `CHECK ... NOT VALID` then `VALIDATE`; avoid table rewrites (changing column types) on large tables; every migration has a tested down path or a forward fix plan.

## Runbook template
```markdown
# Runbook: [alert name]
**Meaning:** what the alert detects and user impact
**Dashboards:** [links]   **Owner:** [team]   **Escalation:** [who, when]
## Triage (first 5 minutes)
1. Check recent deploys/flags → roll back if correlated
2. Check dependency status (DB, cache, third parties)
3. Check saturation (CPU, connections, queue depth)
## Mitigation options
- Roll back: `[command]`
- Disable feature: flag `[name]`
- Scale: `[command]`
## Verification
- Error rate back under [x]%, p99 under [y] ms for 15 min
## Communication
- Status page update template; customer notification threshold
```

## Blameless postmortem template
Required for every Sev1/Sev2 incident or > 20% error budget consumed; draft within 5 business days.
```markdown
# Postmortem: [title] — [date]
**Severity:** Sev[1-3]   **Duration:** [detect → resolve]   **Author(s):** [names]
## Summary
2–3 sentences: what happened, impact, how it was resolved.
## Impact
Users/tenants affected, requests failed, revenue/SLO budget consumed, data loss (yes/no).
## Timeline (UTC)
- HH:MM — trigger (deploy, config change, traffic spike)
- HH:MM — first alert / detection (time to detect: __)
- HH:MM — mitigation applied (time to mitigate: __)
- HH:MM — resolved
## Root cause and contributing factors
Use "5 whys"; focus on systems and processes, not individuals.
## What went well / what went poorly / where we got lucky
## Action items
| Action | Type (prevent/detect/mitigate) | Owner | Due | Ticket |
|--------|-------------------------------|-------|-----|--------|
```
