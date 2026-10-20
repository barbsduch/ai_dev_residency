# Accessible component patterns (WAI-ARIA APG)

Prefer a vetted headless library (Radix UI, React Aria, Headless UI, Angular CDK) over hand-rolling. If you must build, follow these patterns.

## Contents
- Skip link
- Dialog (modal)
- Menu button
- Tabs
- Combobox (autocomplete)
- Toast / status messages
- Form errors
- Data table (sortable)

## Skip link
```html
<a class="skip-link" href="#main">Skip to main content</a>
<main id="main" tabindex="-1">…</main>
```
```css
.skip-link { position:absolute; left:-9999px; }
.skip-link:focus { left:1rem; top:1rem; z-index:1000; }
```

## Dialog (modal)
Prefer native `<dialog>` with `showModal()` - it provides inertness and Esc handling.
```html
<dialog id="del" aria-labelledby="del-title" aria-describedby="del-desc">
  <h2 id="del-title">Delete 3 projects?</h2>
  <p id="del-desc">This can't be undone.</p>
  <button type="button" autofocus>Cancel</button>
  <button type="button" class="danger">Delete projects</button>
</dialog>
```
Keyboard: Tab/Shift+Tab cycle inside; Esc closes. On open focus first safe control (or title for long content); on close **return focus to the trigger**. Custom builds need `role="dialog" aria-modal="true"`, a focus trap, and `inert` on the background.

## Menu button
Use only for app-style action menus; for site navigation use a list of links with a disclosure button.
```html
<button aria-haspopup="menu" aria-expanded="false" aria-controls="m1">Actions</button>
<ul role="menu" id="m1" hidden>
  <li role="menuitem" tabindex="-1">Duplicate</li>
  <li role="menuitem" tabindex="-1">Archive</li>
</ul>
```
Keyboard: Enter/Space/↓ opens and focuses first item; ↑/↓ move (roving tabindex); Home/End; Esc closes and returns focus to button; Tab closes menu. Update `aria-expanded`.

## Tabs
```html
<div role="tablist" aria-label="Account settings">
  <button role="tab" id="t1" aria-selected="true"  aria-controls="p1">Profile</button>
  <button role="tab" id="t2" aria-selected="false" aria-controls="p2" tabindex="-1">Security</button>
</div>
<div role="tabpanel" id="p1" aria-labelledby="t1" tabindex="0">…</div>
<div role="tabpanel" id="p2" aria-labelledby="t2" hidden>…</div>
```
Keyboard: only the active tab is in the Tab sequence; ←/→ move between tabs (automatic activation if panels load instantly, manual with Enter/Space otherwise); Home/End.

## Combobox (autocomplete)
```html
<label for="cb">Assignee</label>
<input id="cb" role="combobox" aria-autocomplete="list"
       aria-expanded="true" aria-controls="lb" aria-activedescendant="opt-2">
<ul role="listbox" id="lb">
  <li role="option" id="opt-1">Ana Ruiz</li>
  <li role="option" id="opt-2" aria-selected="true">Ben Ito</li>
</ul>
<div role="status" class="visually-hidden">2 results available</div>
```
Keyboard: DOM focus stays on input; ↓/↑ move `aria-activedescendant`; Enter selects; Esc closes (second Esc clears). Announce result count via the status region (debounced ~500 ms).

## Toast / status messages
```html
<!-- Render once on page load, then inject text -->
<div role="status" aria-live="polite" class="toast-region"></div>
<div role="alert" class="alert-region"></div>
```
- Live region must exist in the DOM **before** content is inserted.
- Success/info → `role="status"`; urgent errors → `role="alert"` (sparingly).
- Don't move focus to toasts; toasts with actions (Undo) must be reachable by keyboard (e.g. F6 or a landmark) and stay ≥ 10 s, pausing on hover/focus. Errors needing action don't auto-dismiss.

## Form errors
```html
<div id="summary" role="alert" tabindex="-1">
  <h2>2 errors</h2>
  <ul><li><a href="#email">Enter an email address in the format name@example.com</a></li></ul>
</div>
<label for="email">Work email</label>
<input id="email" type="email" autocomplete="email"
       aria-invalid="true" aria-describedby="email-hint email-err">
<p id="email-hint">We'll send the invite here.</p>
<p id="email-err" class="error"><svg aria-hidden="true">…</svg> Enter an email address in the format name@example.com</p>
```
On submit: render summary, `summary.focus()`. Group radios/checkboxes in `<fieldset><legend>`. Required: native `required` (plus visible "(required)" text).

## Data table (sortable)
```html
<table>
  <caption>Invoices <span class="visually-hidden">, sorted by due date ascending</span></caption>
  <thead><tr>
    <th scope="col" aria-sort="ascending">
      <button type="button">Due date <svg aria-hidden="true">…</svg></button>
    </th>
    <th scope="col"><button type="button">Amount</button></th>
  </tr></thead>
  <tbody><tr><th scope="row">INV-204</th><td>€1,200</td></tr></tbody>
</table>
```
- `aria-sort` only on the currently sorted column; sort control is a `<button>` inside `<th>`.
- Row selection checkboxes labelled per row ("Select INV-204"); bulk-select count announced via `role="status"`.
- Use `role="grid"` only when cells are interactive and need 2-D arrow-key navigation; otherwise keep a plain table.
- Virtualized tables: set `aria-rowcount` on the table and `aria-rowindex` on rows.

## Utility
```css
.visually-hidden { position:absolute; width:1px; height:1px; overflow:hidden;
  clip:rect(0 0 0 0); clip-path:inset(50%); white-space:nowrap; }
@media (prefers-reduced-motion: reduce) { *{ animation-duration:.01ms !important; transition-duration:.01ms !important; } }
```
