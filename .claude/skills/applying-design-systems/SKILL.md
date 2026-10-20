---
name: applying-design-systems
description: Designs enterprise B2B UI with and for a design system - tokens (semantic color, type scale, 4/8 pt spacing, elevation, radius, motion) named primitive, semantic, component; component anatomy, variants, properties and every state (default, hover, focus, active, disabled, loading, error, empty, selected, read-only); enterprise patterns (data tables, filters, bulk actions, forms, wizards, navigation, dashboards, settings, no-access states, toasts and banners, empty states, destructive confirmations, onboarding); density and responsive modes; built-in WCAG 2.2 AA; component docs; Figma libraries, variables, auto layout and component properties; contribution, governance, design QA. Use when a designer says design system, component library, UI kit, tokens, variables, Figma library, new component, component states, variants, spec or document this component, which pattern should I use, table or filter pattern, empty state, design QA, handoff, contribution request, or "does this follow our design system".
---

# Applying Design Systems

Reuse before you create: every screen is assembled from tokens, components, and patterns that already solve the problem, and every new piece earns its place by solving a repeated need for many teams.

## Choose the workflow

- **Designing a screen with an existing system** → follow "Screen workflow"; pick patterns from [reference/enterprise-patterns.md](reference/enterprise-patterns.md).
- **Creating or changing tokens, color, type, spacing, themes, density, Figma variables** → read [reference/foundations-and-tokens.md](reference/foundations-and-tokens.md).
- **Designing or specifying a new component** → follow "Component workflow" and use the state matrix below.
- **Documenting a component, contribution request, governance, or design QA before handoff** → read [reference/component-docs-and-governance.md](reference/component-docs-and-governance.md).
- **Microcopy and UX flows** → also apply `designing-ux`; **engineering accessibility specs** → `building-accessible-ui`.

## Non-negotiable rules

1. **Search the system first** (library, docs, pattern page) and reuse; then extend with a variant or property; create new only when no existing component can do the job - and log it as a contribution.
2. **Tokens only.** No raw hex, px, or font values on screens or components. Components reference semantic or component tokens, never primitives directly.
3. **Three-tier token naming**: primitive (`blue-600`) → semantic (`color.action.primary.bg`) → component (`button.primary.bg`). Names describe purpose, not appearance.
4. **Design every state** in the state matrix for every interactive component and every data view - not only default.
5. **Spacing on a 4 pt base, 8 pt rhythm** (4, 8, 12, 16, 24, 32, 48, 64); type from the scale only; radius and elevation from tokens.
6. **Accessibility is built into the component**, not added per screen: 4.5:1 text, 3:1 UI and focus, 24 × 24 px minimum targets, visible focus, label + text error, never color alone (WCAG 2.2 AA).
7. **Density modes** (comfortable, compact) change spacing and row height through tokens, never by redrawing components; compact still meets target-size rules.
8. **Responsive by rule**: define breakpoints and behavior (reflow, collapse, priority columns) per component; usable at 320 px width.
9. **One pattern per job.** Same problem → same pattern across products (one table, one date picker, one toast). Deviations need a documented reason.
10. **Figma structure mirrors code**: component names, property names, and variant values match the coded component API; variables mirror code tokens.
11. **Content is part of the component**: label rules, character limits, truncation, and localization expansion (+30-40%) are specified.
12. **No handoff without design QA**: the checklist in the reference passes, and deviations from the system are annotated.

## Component state matrix

| State | Visual rule | Notes |
|---|---|---|
| Default | Base tokens | Resting appearance |
| Hover | Background or border one step darker/lighter | Pointer only; never the only affordance |
| Focus | 2 px outline, ≥ 3:1, 2 px offset, never removed | Keyboard (`focus-visible`); not obscured by sticky elements |
| Active / pressed | Darker than hover, optional inset | Brief feedback |
| Disabled | Reduced emphasis, no hover; explain why nearby or via tooltip on a focusable wrapper | Prefer hiding or read-only when action is never available to this role |
| Loading | Spinner or skeleton in place, width preserved, label "Saving…" | Prevent double submit |
| Error | Danger border + icon + text message below | Color not alone; input preserved |
| Empty | Message + primary action (data components) | Distinguish first-use vs. no results |
| Selected | Fill/check + text or icon change | Not color alone; selected + hover + focus combined |
| Read-only | Value as text, no input chrome, still focusable and copyable | Not the same as disabled |

## Screen workflow

Copy this checklist and track progress:

```
Design-system screen checklist:
- [ ] 1. Task frame: persona, role/permissions, primary task, density need
- [ ] 2. Pick page template and patterns (table, form, wizard, dashboard, settings)
- [ ] 3. Assemble from library components; note any gap
- [ ] 4. Apply tokens only (color, type, spacing, radius, elevation)
- [ ] 5. Design states: empty, loading, error, partial, no-permission, read-only
- [ ] 6. Responsive and density variants (desktop, tablet, 320 px; compact)
- [ ] 7. Content: labels, errors, truncation, localization
- [ ] 8. Accessibility annotations: focus order, names, headings, announcements
- [ ] 9. Design QA checklist; annotate deviations; file contributions
```

## Component workflow

1. **Justify**: list 3+ real use cases from 2+ teams; confirm no existing component or variant covers them.
2. **Anatomy**: name every part (container, label, icon, helper text, counter...) and mark required vs. optional.
3. **API**: variants (hierarchy, size), boolean and text properties, instance swaps; names match the coded component.
4. **States**: every row of the state matrix, including combinations (selected + focus, error + disabled → not allowed).
5. **Tokens**: map each part to component tokens that alias semantic tokens; light, dark, and high-contrast themes.
6. **Behavior**: keyboard model, responsive rules, density, truncation, motion (100-300 ms, reduced-motion).
7. **Document** with the component doc template; review with engineering and accessibility; publish with a changelog.

## Quality check before delivering

Run this rubric on your own output; revise until every line passes:

- [ ] Every element maps to an existing component, token, or pattern - or is flagged as a proposed contribution.
- [ ] No raw values; token names follow primitive → semantic → component.
- [ ] All relevant states shown; disabled vs. read-only vs. hidden chosen deliberately per role.
- [ ] Contrast, focus, target size, labels, and color-not-alone checks pass and cite WCAG where failing.
- [ ] Density and responsive behavior specified.
- [ ] Content rules (labels, limits, truncation) included.
- [ ] Output follows the template below.

## Output template

```markdown
## Design-system spec: [screen or component]
**Persona / task:** [role] needs to [job] · **Patterns used:** [table, filters, bulk actions]
### Components and tokens
| Element | Component (variant, props) | Tokens | Notes |
|---|---|---|---|
| Primary action | Button (primary, md, icon-left) | button.primary.bg, space.inset.md | Label "Invite users" |
### States
| State | What shows | Copy |
|---|---|---|
### Responsive and density
[breakpoint behavior; compact row height]
### Accessibility
[focus order, accessible names, contrast, target size, announcements]
### Gaps and contributions
[missing component/variant, proposed solution, owner]
### Design QA
[pass/fail per checklist section; deviations annotated]
```

## Example

**Input:** "I need a 'Status' chip for invoices: Paid, Overdue, Draft, Void. Is there something in the system?"

**Output (summary):**
- Reuse the existing Badge component with a `tone` property (neutral, info, success, warning, danger) - no new component.
- Mapping: Paid → success, Overdue → danger, Draft → neutral, Void → neutral with strikethrough-free text "Void".
- Tokens: `badge.success.bg` → `color.feedback.success.subtle` → `green-100`; text `color.feedback.success.text` (≥ 4.5:1 on its background).
- Rules: always text label (color is never the only signal), optional leading icon for Overdue, max 16 characters, no wrapping, sentence case.
- States: badges are non-interactive; if used as a filter, switch to the Filter chip component with selected and focus states.
- Accessibility: inside tables, the text is read with the cell; no tooltip-only meaning.
