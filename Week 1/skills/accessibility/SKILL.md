---
name: accessibility
description: WCAG 2.2 AA accessibility rules for all UI code (HTML, React, mobile). Use when writing or reviewing any interface, component, color choice, form, or media.
---
# Accessibility (WCAG 2.2 AA)

## Goal
Usable by keyboard, screen reader, voice, zoom, and low-vision users. Required by law for many enterprise buyers (ADA, Section 508, European Accessibility Act).

## Always do
1. **Semantic HTML first**: `button` for actions, `a` for navigation, real `label`s, headings in order (one `h1`), landmarks (`header`, `nav`, `main`).
2. **ARIA only when HTML can't** — no ARIA beats bad ARIA.
3. **Keyboard**: every action reachable with Tab/Shift+Tab/Enter/Space/Esc; visible focus ring (≥ 3:1 contrast); logical order; no keyboard traps; focus moved into and back out of dialogs.
4. **Contrast**: text ≥ 4.5:1 (large text ≥ 3:1); UI components and icons ≥ 3:1.
5. **Never color alone** to convey meaning — add text or icons.
6. **Images**: meaningful `alt`; decorative `alt=""`.
7. **Forms**: errors linked via `aria-describedby`, announced, and in text; required fields marked in text.
8. **Dynamic content**: `aria-live="polite"` for toasts and async results.
9. **Targets ≥ 24×24px**; support 200% zoom and 400% reflow without horizontal scroll.
10. **Motion**: respect `prefers-reduced-motion`; no auto-playing media with sound.

## Verify
- Run axe / Lighthouse (0 violations is the floor, not proof).
- Tab through the whole flow with no mouse.
- Test with VoiceOver (Mac: Cmd+F5) or NVDA.

## Output
Cite the WCAG success criterion (e.g. "1.4.3 Contrast") for each issue found.
