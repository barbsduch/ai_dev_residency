# WCAG 2.2 Level A + AA checklist

Grouped by POUR. Level in brackets. ★ = new in WCAG 2.2. (4.1.1 Parsing is obsolete in 2.2 and removed.)

## Contents
- 1 Perceivable
- 2 Operable
- 3 Understandable
- 4 Robust
- Testing tool mapping

## 1 Perceivable
- [ ] **1.1.1 Non-text Content (A)** – meaningful images/icons have text alternatives; decorative use `alt=""` or CSS; complex charts have a data table or long description.
- [ ] **1.2.1 Audio-only and Video-only (A)** – transcript or text/audio alternative.
- [ ] **1.2.2 Captions, Prerecorded (A)** – synchronized, accurate captions incl. speaker IDs and meaningful sounds.
- [ ] **1.2.3 Audio Description or Media Alternative (A)** and **1.2.5 Audio Description (AA)** – visual-only information is described.
- [ ] **1.2.4 Captions, Live (AA)** – live video (webinars, town halls) captioned.
- [ ] **1.3.1 Info and Relationships (A)** – headings, lists, tables, labels, groups (`fieldset/legend`) are in markup, not just visual.
- [ ] **1.3.2 Meaningful Sequence (A)** – DOM order matches reading order.
- [ ] **1.3.3 Sensory Characteristics (A)** – instructions don't rely on shape, position, or sound only ("click the green button on the right").
- [ ] **1.3.4 Orientation (AA)** – works in portrait and landscape.
- [ ] **1.3.5 Identify Input Purpose (AA)** – `autocomplete` tokens on user-data fields (`name`, `email`, `tel`, `street-address`).
- [ ] **1.4.1 Use of Color (A)** – color plus text/icon/pattern for status, errors, links in body text (or 3:1 + underline on hover/focus).
- [ ] **1.4.2 Audio Control (A)** – auto-playing audio > 3 s can be paused/muted.
- [ ] **1.4.3 Contrast, Minimum (AA)** – 4.5:1 text; 3:1 large text (≥ 24 px / ≥ 18.66 px bold).
- [ ] **1.4.4 Resize Text (AA)** – 200% text zoom without loss of content/function.
- [ ] **1.4.5 Images of Text (AA)** – real text, not images (logos exempt).
- [ ] **1.4.10 Reflow (AA)** – no 2-D scrolling at 320 CSS px wide (= 1280 px at 400%); tables, maps, diagrams exempt.
- [ ] **1.4.11 Non-text Contrast (AA)** – 3:1 for input borders, icons, focus indicators, chart segments, toggle states.
- [ ] **1.4.12 Text Spacing (AA)** – no loss with line-height 1.5, paragraph 2×, letter 0.12em, word 0.16em.
- [ ] **1.4.13 Content on Hover or Focus (AA)** – tooltips/popovers dismissible (Esc), hoverable, persistent.

## 2 Operable
- [ ] **2.1.1 Keyboard (A)** – all functionality by keyboard.
- [ ] **2.1.2 No Keyboard Trap (A)** – focus can always leave (except modal dialogs, which close with Esc).
- [ ] **2.1.4 Character Key Shortcuts (A)** – single-key shortcuts can be turned off, remapped, or only work on focus.
- [ ] **2.2.1 Timing Adjustable (A)** – session timeouts warn ≥ 20 s ahead and allow extending (≥ 10×), unless > 20 h.
- [ ] **2.2.2 Pause, Stop, Hide (A)** – carousels, tickers, auto-updating content > 5 s controllable.
- [ ] **2.3.1 Three Flashes or Below Threshold (A)**.
- [ ] **2.4.1 Bypass Blocks (A)** – skip link and landmarks.
- [ ] **2.4.2 Page Titled (A)** – unique `<title>`, updated on SPA route change ("Invoices – Acme Admin").
- [ ] **2.4.3 Focus Order (A)** – logical; dialogs trap and restore focus.
- [ ] **2.4.4 Link Purpose, In Context (A)** – no ambiguous "Click here" without context.
- [ ] **2.4.5 Multiple Ways (AA)** – nav + search or sitemap.
- [ ] **2.4.6 Headings and Labels (AA)** – descriptive.
- [ ] **2.4.7 Focus Visible (AA)**.
- [ ] ★ **2.4.11 Focus Not Obscured, Minimum (AA)** – focused element not entirely hidden by sticky headers, footers, cookie banners, chat widgets (use `scroll-padding`).
- [ ] **2.5.1 Pointer Gestures (A)** – multipoint/path gestures have single-pointer alternative.
- [ ] **2.5.2 Pointer Cancellation (A)** – actions fire on up-event; can abort by moving away.
- [ ] **2.5.3 Label in Name (A)** – accessible name contains visible label text (voice control).
- [ ] **2.5.4 Motion Actuation (A)** – shake/tilt has UI alternative and can be disabled.
- [ ] ★ **2.5.7 Dragging Movements (AA)** – drag-and-drop (kanban, sliders, reorder) has single-pointer alternative (buttons, "Move to…" menu).
- [ ] ★ **2.5.8 Target Size, Minimum (AA)** – targets ≥ 24×24 CSS px, or 24 px circle around target doesn't overlap others; inline text links exempt.

## 3 Understandable
- [ ] **3.1.1 Language of Page (A)** – `<html lang="en">`.
- [ ] **3.1.2 Language of Parts (AA)** – `lang` on foreign-language passages.
- [ ] **3.2.1 On Focus (A)** / **3.2.2 On Input (A)** – no unexpected context change (no auto-submit on select change).
- [ ] **3.2.3 Consistent Navigation (AA)** / **3.2.4 Consistent Identification (AA)**.
- [ ] ★ **3.2.6 Consistent Help (A)** – help mechanisms (contact, chat, FAQ link) in the same relative place across pages.
- [ ] **3.3.1 Error Identification (A)** – error described in text.
- [ ] **3.3.2 Labels or Instructions (A)** – including format hints.
- [ ] **3.3.3 Error Suggestion (AA)** – suggest the fix.
- [ ] **3.3.4 Error Prevention, Legal/Financial/Data (AA)** – reversible, checked, or confirmed.
- [ ] ★ **3.3.7 Redundant Entry (A)** – don't make users re-enter info already given in the same process (auto-fill or offer "Same as billing address").
- [ ] ★ **3.3.8 Accessible Authentication, Minimum (AA)** – no cognitive function test (memorizing, transcribing, puzzles) to log in unless alternative exists; allow paste and password managers; support passkeys/OAuth; CAPTCHA only with object-recognition or alternative.

## 4 Robust
- [ ] **4.1.2 Name, Role, Value (A)** – custom controls expose name, role, state; changes are notified.
- [ ] **4.1.3 Status Messages (AA)** – "3 results", "Saved", errors announced via live regions without moving focus.

## Testing tool mapping
| Method | Reliably catches | Misses |
|--------|------------------|--------|
| axe / Lighthouse | Missing names/labels/alt, contrast, invalid ARIA, duplicate IDs, lang | Focus order, meaningful alt, keyboard operability, announcements |
| Keyboard walk | 2.1.x, 2.4.3, 2.4.7, 2.4.11, traps, 2.5.7 alternatives | Names/roles |
| Screen reader | 1.3.1, 4.1.2, 4.1.3, alt quality, heading structure | Visual issues |
| Zoom / 320 px / text spacing | 1.4.4, 1.4.10, 1.4.12 | Semantics |
