# Test patterns and examples

## Contents
- Structure and naming
- Fixtures and factories
- Mocking rules
- Determinism toolkit
- Jest / Vitest examples
- pytest examples
- Playwright E2E example
- Testing auth and multi-tenant access
- Contract tests

## Structure and naming
- Arrange-Act-Assert, separated by a blank line; one Act per test.
- Name: `describe('<unit>')` + `it('<does X> when <Y>')`. Python: `test_<does_x>_when_<y>`.
- Co-locate unit tests (`foo.test.ts` next to `foo.ts`); integration in `tests/integration`, E2E in `e2e/`.
- Assert the specific value (`toEqual({...})`), not truthiness. Snapshot only small, stable, reviewed output.

## Fixtures and factories
Build valid objects with overridable defaults; tests state only what matters.
```ts
// test/factories.ts
let seq = 0;
export const buildUser = (o: Partial<User> = {}): User => ({
  id: `user_${++seq}`, email: `user${seq}@example.test`, role: 'member', tenantId: 'tenant_a', ...o,
});
```
```python
# conftest.py
import pytest
@pytest.fixture
def user_factory(db):
    def make(**overrides):
        return db.users.create(**{"email": f"u{make.n}@example.test", "role": "member", **overrides})
    make.n = 0
    return make
```
Use transactions rolled back per test, or truncate between tests; never depend on test order.

## Mocking rules
| Mock | Don't mock |
|------|-----------|
| Third-party HTTP (use MSW, nock, respx, `responses`) | Your own modules/classes under test |
| Clock, randomness, UUIDs | The database in integration tests (use a real one in a container) |
| Email, SMS, payments, queues (in-memory fakes) | Framework internals |
| Feature flags (set explicitly) | Pure functions |

If a test needs more than ~3 mocks, the unit is doing too much; test it at integration level or refactor.

## Determinism toolkit
- Time: `vi.useFakeTimers(); vi.setSystemTime(new Date('2024-02-29T12:00:00Z'))` · Jest `jest.useFakeTimers()` · Python `freezegun` / `time-machine`.
- Randomness: inject a seeded RNG; `faker.seed(1)`.
- Network: MSW with `onUnhandledRequest: 'error'`; pytest `--block-network` (pytest-socket).
- Time zones: run CI with `TZ=UTC` and add explicit tests for a non-UTC zone.
- Async: await the condition (`expect.poll`, `waitFor`), never fixed sleeps.

## Jest / Vitest examples
```ts
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { applyCoupon } from './coupon';

describe('applyCoupon', () => {
  beforeEach(() => vi.setSystemTime(new Date('2025-01-15T00:00:00Z')));

  it('applies percentage discount in cents when coupon is valid', () => {
    const cart = { subtotalCents: 10_000 };
    const coupon = { type: 'percent', value: 15, expiresAt: '2025-02-01' };

    const result = applyCoupon(cart, coupon);

    expect(result.totalCents).toBe(8_500);
  });

  it('rejects coupon when expired', () => {
    expect(() => applyCoupon({ subtotalCents: 100 }, { type: 'percent', value: 10, expiresAt: '2025-01-14' }))
      .toThrow(/expired/);
  });

  it.each([[0, 0], [1, 1], [99, 84]])('rounds %i cents to %i at 15%% off', (input, expected) => {
    expect(applyCoupon({ subtotalCents: input }, { type: 'percent', value: 15, expiresAt: '2026-01-01' }).totalCents)
      .toBe(expected);
  });
});
```

## pytest examples
```python
import pytest
from app.pricing import apply_coupon, CouponExpired

@pytest.mark.parametrize("subtotal,expected", [(0, 0), (10_000, 8_500), (99, 84)])
def test_applies_percentage_discount_when_coupon_valid(subtotal, expected, frozen_now):
    assert apply_coupon(subtotal, percent=15, expires="2026-01-01") == expected

def test_rejects_coupon_when_expired(frozen_now):
    with pytest.raises(CouponExpired):
        apply_coupon(100, percent=10, expires="2025-01-14")

@pytest.fixture
def frozen_now(time_machine):
    time_machine.move_to("2025-01-15T00:00:00Z")
```

## Playwright E2E example
Critical journeys only; use role-based locators and seeded test accounts; no `waitForTimeout`.
```ts
import { test, expect } from '@playwright/test';

test.use({ storageState: 'e2e/.auth/member.json' }); // created once in global setup

test('member creates and sees an invoice', async ({ page }) => {
  await page.goto('/invoices/new');
  await page.getByLabel('Customer').fill('Acme Ltd');
  await page.getByLabel('Amount').fill('120.00');
  await page.getByRole('button', { name: 'Create invoice' }).click();

  await expect(page.getByRole('status')).toHaveText('Invoice created');
  await expect(page.getByRole('row', { name: /Acme Ltd/ })).toContainText('$120.00');
});
```
Config: `retries: process.env.CI ? 2 : 0`, `trace: 'on-first-retry'`, `fullyParallel: true`, isolated data per worker.

## Testing auth and multi-tenant access
Every protected endpoint gets this matrix (integration level):
```ts
describe('GET /api/invoices/:id', () => {
  it('returns 401 when unauthenticated', async () => {
    expect((await request(app).get(`/api/invoices/${inv.id}`)).status).toBe(401);
  });
  it('returns 404 when invoice belongs to another tenant', async () => {
    const res = await request(app).get(`/api/invoices/${otherTenantInvoice.id}`).set(authAs(userA));
    expect(res.status).toBe(404);
  });
  it('returns 403 when role lacks invoice:read', async () => {
    expect((await request(app).get(`/api/invoices/${inv.id}`).set(authAs(noAccessUser))).status).toBe(403);
  });
  it('returns the invoice for its owner tenant', async () => {
    const res = await request(app).get(`/api/invoices/${inv.id}`).set(authAs(userA));
    expect(res.status).toBe(200);
    expect(res.body).toMatchObject({ id: inv.id, tenantId: 'tenant_a' });
  });
});
```
Also test: list endpoints never include other tenants' rows; IDs in request body (`tenantId`) are ignored.

## Contract tests
- Consumer-driven (Pact) between internal services, or schema validation against OpenAPI (`openapi-response-validator`, Schemathesis) for public APIs.
- Provider CI verifies all consumer contracts before deploy; breaking changes require a new API version.
