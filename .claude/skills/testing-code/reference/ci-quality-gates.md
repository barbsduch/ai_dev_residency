# CI quality gates

## Contents
- Required gates
- GitHub Actions workflow
- Branch protection
- PR template
- Code review checklist
- Flaky-test policy

## Required gates
| Gate | Command (Node) | Command (Python) | Blocks merge |
|------|----------------|------------------|--------------|
| Format | `prettier --check .` | `ruff format --check .` | Yes |
| Lint | `eslint . --max-warnings 0` | `ruff check .` | Yes |
| Types | `tsc --noEmit` | `mypy --strict src` / `pyright` | Yes |
| Unit + integration | `vitest run --coverage` | `pytest -q --cov` | Yes |
| Dependency audit | `npm audit --audit-level=high` | `pip-audit` | Yes (High/Critical) |
| E2E critical paths | `playwright test` | `playwright test` | Yes on main-bound PRs |
| Build | `npm run build` | `python -m build` | Yes |

Target total PR pipeline < 10 minutes; parallelize jobs and cache dependencies.

## GitHub Actions workflow
```yaml
name: ci
on:
  pull_request:
  push:
    branches: [main]
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
permissions:
  contents: read

jobs:
  checks:
    runs-on: ubuntu-latest
    timeout-minutes: 15
    env:
      TZ: UTC
    services:
      postgres:
        image: postgres:16
        env: { POSTGRES_PASSWORD: postgres, POSTGRES_DB: app_test }
        ports: ['5432:5432']
        options: >-
          --health-cmd "pg_isready -U postgres" --health-interval 5s --health-retries 10
    steps:
      - uses: actions/checkout@<pinned-sha>        # pin third-party actions to a full SHA
      - uses: actions/setup-node@<pinned-sha>
        with: { node-version-file: '.nvmrc', cache: 'npm' }
      - run: npm ci
      - run: npx prettier --check .
      - run: npx eslint . --max-warnings 0
      - run: npx tsc --noEmit
      - run: npm audit --audit-level=high
      - run: npx vitest run --coverage
        env: { DATABASE_URL: postgres://postgres:postgres@localhost:5432/app_test }
      - run: npm run build

  e2e:
    needs: checks
    runs-on: ubuntu-latest
    timeout-minutes: 20
    steps:
      - uses: actions/checkout@<pinned-sha>
      - uses: actions/setup-node@<pinned-sha>
        with: { node-version-file: '.nvmrc', cache: 'npm' }
      - run: npm ci
      - run: npx playwright install --with-deps chromium
      - run: npx playwright test
      - if: failure()
        uses: actions/upload-artifact@<pinned-sha>
        with: { name: playwright-report, path: playwright-report, retention-days: 7 }
```

## Branch protection
- Require PR + at least 1 approving review (2 for auth, payments, data migrations); dismiss stale approvals on new commits.
- Require status checks `checks` and `e2e` to pass; require branch up to date.
- No direct pushes or force pushes to `main`; CODEOWNERS for sensitive paths.

## PR template
Save as `.github/pull_request_template.md`:
```markdown
## What and why
<!-- One paragraph. Link the issue. -->

## How it was tested
- [ ] Unit/integration tests added or updated
- [ ] Commands run locally and results: `npm test` → __ passed, __ failed
- [ ] Manual check (screenshots/video for UI changes)

## Risk
- [ ] Database migration (backward compatible?)
- [ ] Feature flag: ____
- [ ] Touches auth, permissions, payments, or personal data

## Checklist
- [ ] Small and focused (< 400 lines changed)
- [ ] No `.only`, `.skip`, `console.log`, or commented-out code
- [ ] Docs/changelog updated if behavior changed
```

## Code review checklist
- **Correctness:** does it do what the issue asks; are edge cases from the catalogue handled?
- **Tests:** would these tests fail if the code were wrong? Do they test behavior, not implementation?
- **Design:** simplest solution; no duplication; names reveal intent; functions do one thing.
- **Security/privacy:** input validated, authz checked per object, no secrets or PII in logs.
- **Performance:** no N+1 queries, unbounded lists, or blocking calls on hot paths.
- **Operability:** errors handled and logged with context; migrations reversible; feature flagged if risky.
- Label comments: `blocking:`, `suggestion:`, `nit:`, `question:`. Approve when only nits remain.

## Flaky-test policy
1. A test that fails then passes on retry without code change is flaky; CI retries are for detection, not a fix.
2. On first detection: open a ticket with the failure log/trace, owner = last author of the area.
3. Quarantine (move to a non-blocking `@flaky` tag/suite) within 1 working day if it blocks others; never just delete it.
4. Fix or delete within 2 weeks; track flake rate (target < 1% of runs).
5. Common causes to check: shared state between tests, real time/timezones, unawaited promises, test order, network calls, animations, non-unique test data, fixed sleeps.
