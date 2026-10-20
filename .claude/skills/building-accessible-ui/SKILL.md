---
name: building-accessible-ui
description: Builds and audits user interfaces to WCAG 2.2 Level AA - semantic HTML, correct ARIA, keyboard and focus management, color contrast, accessible forms and error handling, live regions, target size, reflow and zoom, reduced motion, and media captions - and tests with axe, Lighthouse, keyboard-only and screen readers (VoiceOver, NVDA), reporting issues by success criterion. Use when writing or reviewing frontend components, HTML, React/Vue/Angular UI, forms, dialogs, menus, or tables, or when the user mentions accessibility, a11y, WCAG, ADA, Section 508, EN 301 549, screen reader, keyboard navigation, ARIA, focus, or contrast.
---

# Building Accessible UI

Target WCAG 2.2 Level AA - the standard referenced by ADA case law, Section 508, EN 301 549, and most enterprise procurement (VPAT/ACR). Native HTML first; ARIA only to fill gaps.

## Choose the workflow

- **Writing new UI** → follow "Build workflow".
- **Auditing existing UI or a diff** → follow "Audit workflow".
- **Need the criterion-by-criterion checklist** → read [reference/wcag-checklist.md](reference/wcag-checklist.md).
- **Dialog, menu, tabs, combobox, toast, form errors, skip link, data table** → copy from [reference/component-patterns.md](reference/component-patterns.md).

## Non-negotiable rules

1. **Semantic HTML first**: `<button>` for actions, `<a href>` for navigation, `<label>` for inputs, `<table>` for tabular data, landmarks (`<header> <nav> <main> <footer>`), one `<h1>` and no skipped heading levels. Never `<div onClick>`.
2. **ARIA rules**: no ARIA is better than bad ARIA. Don't override native semantics; every interactive ARIA role must be keyboard operable; never `aria-hidden="true"` on focusable elements; state attributes (`aria-expanded`, `aria-selected`, `aria-checked`) must update.
3. **Keyboard**: everything operable with Tab/Shift+Tab, Enter/Space, Esc, arrows per APG pattern. No keyboard traps. DOM order = visual order. No positive `tabindex`.
4. **Visible focus**: never `outline: none` without a replacement; focus indicator ≥ 3:1 against adjacent colors and not hidden by sticky headers/footers (2.4.11). Use `:focus-visible`.
5. **Contrast**: text ≥ 4.5:1; large text (≥ 24 px, or ≥ 18.66 px bold) ≥ 3:1; UI components, icons, and focus rings ≥ 3:1. Never convey meaning by color alone.
6. **Names**: every control has an accessible name; icon-only buttons get `aria-label`; visible label text is included in the accessible name (2.5.3). Images: meaningful `alt`, decorative `alt=""`.
7. **Forms**: programmatic labels, `autocomplete` tokens on personal data, errors in text linked via `aria-describedby`, `aria-invalid="true"` on failed fields, focus moved to error summary on submit.
8. **Dynamic content**: announce status changes with live regions (`role="status"` polite, `role="alert"` only for urgent); manage focus on route change, dialog open/close, and deletion.
9. **Target size** ≥ 24×24 CSS px or 24 px spacing (2.5.8); provide single-pointer alternatives to dragging (2.5.7).
10. **Reflow & motion**: usable at 320 CSS px width and 400% zoom without 2-D scrolling (except tables/maps); text spacing overrides don't break layout; honour `prefers-reduced-motion`; nothing flashes > 3 times/second; auto-moving content > 5 s can be paused.
11. **Media**: captions for prerecorded and live video, audio description or text alternative for video, transcripts for audio.

## Build workflow

Copy this checklist and track progress:

```
Accessibility build checklist:
- [ ] 1. Choose native elements; pick the APG pattern for any custom widget
- [ ] 2. Landmarks, heading outline, page <title>, lang attribute
- [ ] 3. Accessible names, roles, states for every control
- [ ] 4. Keyboard model + focus management (open/close/route change)
- [ ] 5. Contrast and non-color cues checked against tokens
- [ ] 6. Forms: labels, autocomplete, error association, summary
- [ ] 7. Live regions for async status; reduced motion
- [ ] 8. Reflow at 320 px / 400% zoom; targets ≥ 24 px
- [ ] 9. Run automated + manual tests (Audit workflow steps 1-3); fix and re-test
```

**Step 9 – Verification loop.** Automated tools catch only ~30–40% of issues. Every change must pass the keyboard walk and a screen-reader smoke test; re-run all three after each fix until clean.

## Audit workflow

1. **Automated**: `npx @axe-core/cli <url>` or `@axe-core/playwright` / `jest-axe` in tests; Lighthouse accessibility audit. Treat any axe violation as a failure in CI.
2. **Keyboard walk**: unplug the mouse; Tab through the whole flow. Check focus visible, logical order, no traps, Esc closes overlays, focus returns to trigger, focus never hidden under sticky elements.
3. **Screen reader**: VoiceOver + Safari (macOS: Cmd+F5; rotor Ctrl+Opt+U) and NVDA + Firefox/Chrome (Windows; Elements list Insert+F7). Verify names, roles, states, headings list, landmarks, and announcements of dynamic changes.
4. **Visual**: zoom 200% and 400%, 320 px viewport, Windows High Contrast / forced-colors, text-spacing bookmarklet, grayscale.
5. Map each finding to a WCAG success criterion via [reference/wcag-checklist.md](reference/wcag-checklist.md); confirm it's reproducible.
6. Report using the template below, most severe first.

## Report template

```markdown
## Accessibility audit: [scope] - WCAG 2.2 AA

| # | Severity | WCAG SC | Location | Issue | Who is affected | Fix |
|---|----------|---------|----------|-------|-----------------|-----|
| 1 | Critical | 2.1.1 Keyboard (A) | Filters > "Apply" | `<div onClick>` not focusable or operable by keyboard | Keyboard and screen-reader users cannot apply filters | Replace with `<button type="button">` |

**Tools / AT used:** axe x.y, Lighthouse, NVDA + Chrome, VoiceOver + Safari, keyboard
**Not tested / assumptions:** [list]
```

Severity: **Critical** (blocks a task for a disability group), **High** (major difficulty or AA failure on a key flow), **Medium** (AA failure with workaround), **Low** (best practice / AAA).

## Example

**Input:** `<div class="btn" onclick="save()"><i class="icon-save"></i></div>` and `<input placeholder="Email">` with error shown only as a red border.

**Output findings:**
1. Critical – 2.1.1 Keyboard / 4.1.2 Name, Role, Value: div is not focusable and has no name → `<button type="button" aria-label="Save">`.
2. High – 1.3.1 / 3.3.2 Labels: placeholder used as label → add `<label for="email">Email</label>` and `autocomplete="email"`.
3. High – 1.4.1 Use of Color / 3.3.1 Error Identification: red border only → text error linked with `aria-describedby`, `aria-invalid="true"`, icon + text.
