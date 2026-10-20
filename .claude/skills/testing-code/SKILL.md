---
name: testing-code
description: Designs test strategy and enforces quality gates for application code - unit, integration, contract, and end-to-end tests, regression tests for bugs, edge cases, deterministic tests, coverage, strict types, linting, CI pipelines, PR templates, and definition of done. Use when writing or changing code that needs tests, fixing a bug, reviewing test quality, setting up Jest, Vitest, pytest, Playwright, or GitHub Actions CI, dealing with flaky tests, or when the user mentions tests, testing, TDD, coverage, QA, regression, CI, quality gates, or "is this ready to merge".
---

# Testing Code

Tests prove behavior, not implementation. A change is done only when tests were actually run and their real output is reported.

## Choose the workflow

- **Fixing a bug** → follow "Bug-fix workflow".
- **Building a feature or changing behavior** → follow "Feature workflow".
- **Need test examples, fixtures, mocking rules** → read [reference/test-patterns.md](reference/test-patterns.md).
- **Setting up CI, PR template, review checklist, flaky tests** → read [reference/ci-quality-gates.md](reference/ci-quality-gates.md).

## Test mix (testing trophy)

| Layer | Share of effort | Scope | Speed target |
|-------|-----------------|-------|--------------|
| Static (types, lint) | Always on | Whole codebase | Seconds |
| Unit | Many | Pure logic, edge cases | < 10 ms each |
| Integration | Most value | Module + real DB/HTTP layer (containers or in-memory) | < 1 s each |
| Contract | Per service boundary | Provider/consumer schemas | Seconds |
| E2E (Playwright) | Few | Critical user journeys only: sign-up, login, checkout, core create/edit | < 5 min suite |

## Non-negotiable rules

1. **Run the tests.** Never claim tests pass without running them. Report the exact command and the real pass/fail counts; if they can't run, say why.
2. **Regression test first for bugs:** write a test that fails for the reported reason, watch it fail, then fix.
3. **Test behavior through public interfaces.** Assert on outputs, state, and side effects visible to callers, not private methods or call order. Refactors should not break tests.
4. **Deterministic only.** Fake the clock, seed randomness, no real network or third-party calls, no shared mutable state, no `sleep`. Each test sets up and cleans up its own data.
5. **Mock at the boundary** (HTTP, email, payments, time), not your own modules. Prefer fakes and real local dependencies (Testcontainers, SQLite/pg-mem) over deep mocks.
6. **One behavior per test**, Arrange-Act-Assert, named as `does X when Y`.
7. **Cover the edge-case catalogue** (below) for any non-trivial input.
8. **Coverage is a signal, not a target.** Look at uncovered lines for missing cases; don't write assertion-free tests to hit a number. Changed lines ≥ 80% is a reasonable gate.
9. **Strict static checks:** TypeScript `strict: true`, `noUncheckedIndexedAccess`; mypy/pyright strict on new code; lint and format enforced in CI.
10. **Small PRs** (< 400 changed lines) with tests in the same PR.

## Edge-case catalogue

Empty / null / undefined · zero, negative, max int, float precision · empty string, whitespace, very long string, Unicode/emoji, RTL · empty list, one item, many items, duplicates · boundaries (off-by-one at limits, page size) · invalid format / wrong type · time zones, DST, leap day, end of month · concurrency (double submit, race) · permissions (unauthenticated, other user, other tenant) · external failure (timeout, 500, malformed response) · idempotency (retry of the same request).

## Bug-fix workflow

```
Bug-fix checklist:
- [ ] 1. Reproduce: write a failing test that captures the bug
- [ ] 2. Run it and confirm it fails for the right reason
- [ ] 3. Fix the smallest root cause
- [ ] 4. Run the new test → passes; run the full suite → no regressions
- [ ] 5. Add neighbouring edge cases from the catalogue
- [ ] 6. Report results with the template below
```

## Feature workflow

```
Feature test checklist:
- [ ] 1. List behaviors and acceptance criteria
- [ ] 2. Pick the lowest layer that proves each behavior
- [ ] 3. Write tests for happy path, edge cases, errors, permissions
- [ ] 4. Implement until green
- [ ] 5. Run lint, typecheck, full test suite
- [ ] 6. If any step fails → fix → rerun all of step 5 until clean
- [ ] 7. Add/extend one E2E test only if this is a critical journey
- [ ] 8. Report results with the template below
```

## Definition of done

Acceptance criteria met · tests added at the right layer · lint, typecheck, tests, and audit green locally and in CI · no skipped/`.only` tests · no new warnings · docs/changelog updated if behavior changed · PR small and described.

## Report template

```markdown
## Test report: [change]

**Commands run:** `npm run lint && npm run typecheck && npm test`
**Result:** 142 passed, 0 failed, 1 skipped (pre-existing: [reason]) — [duration]
**New/changed tests:**
- `src/cart/total.test.ts` — applies discount at exact threshold (regression for #123)
**Coverage of changed lines:** 92%
**Not tested / risks:** [list, with reason]
```

## Example

**Input:** "Bug: `calculateTotal` charges shipping on orders of exactly $50, but free shipping should start at $50."

**Output:**
1. Adds `it('waives shipping when subtotal is exactly 50')` plus 49.99 and 50.01 cases; runs it → fails (`expected 50, received 55`).
2. Changes `subtotal > 50` to `subtotal >= 50`; uses integer cents to avoid float drift.
3. Runs `npm test` → reports "3 new tests pass; full suite 142 passed, 0 failed".
