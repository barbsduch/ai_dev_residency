---
name: testing-quality
description: Testing and code quality standards. Use when writing features, fixing bugs, refactoring, or reviewing code — defines what tests to write and what "done" means.
---
# Testing & Quality

## Definition of done
Code is done when it is tested, typed, linted, reviewed, and documented — not when it runs once on your machine.

## Always do
1. **Test pyramid**: many unit tests, some integration tests, few end-to-end tests (Playwright) covering critical paths only (signup, login, checkout, core workflow).
2. **Bug fix = regression test first**: write a failing test that reproduces the bug, then fix it.
3. **Test behavior, not implementation**: assert on outputs and user-visible results.
4. **Cover edges**: empty, null, max size, unicode, concurrent requests, permission denied, network failure.
5. **Deterministic tests**: no real time, randomness, or network — use fakes and fixed seeds.
6. **Types**: TypeScript `strict` / Python type hints; no `any` without a comment explaining why.
7. **Lint + format** in CI (ESLint/Prettier, Ruff); CI must pass before merge.
8. **Small PRs** (< 400 lines) with a description: what, why, how tested.
9. **Readable code**: clear names over comments; functions do one thing; no dead code.
10. **Run the tests** and report real results — never claim tests pass without running them.

## Output
After changes, report: tests added, command run, pass/fail counts, and anything not covered.
