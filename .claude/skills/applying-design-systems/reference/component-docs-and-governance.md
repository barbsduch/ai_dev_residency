# Component documentation, governance, and design QA

## Contents
- Component documentation template
- Worked example: Button (summary)
- Accessibility section requirements
- Contribution workflow
- Contribution request template
- Governance model and decision rules
- Versioning, deprecation, and changelog
- Measuring adoption
- Design QA checklist before handoff
- Handoff package

## Component documentation template
```markdown
# [Component name]
Status: [Draft / Beta / Stable / Deprecated] · Owner: [team] · Figma: [link] · Code: [link]

## Overview
One sentence: what it is and the problem it solves.

## When to use
- [situations]
## When not to use
- [situations] → use [alternative component] instead

## Anatomy
Numbered diagram: 1 Container · 2 Label · 3 Leading icon (optional) · 4 Helper text (optional) ...

## Variants and properties
| Property | Values | Default | Notes |
|---|---|---|---|
| hierarchy | primary, secondary, tertiary, danger | secondary | One primary per view |
| size | sm, md, lg | md | sm only in dense toolbars, still ≥ 24 px target |

## States
Default, hover, focus, active, disabled, loading, error, empty, selected, read-only - show each, plus combinations.

## Behavior
Interaction, keyboard model, responsive rules, density, truncation and wrapping, motion.

## Specs
Tokens per part and state (component token → semantic token), min/max widths, spacing, icon size.

## Accessibility
Role, accessible name, keyboard, focus, announcements, contrast, target size (see requirements below).

## Content guidelines
Label rules, character limits, tone, examples. Localization: allow +30-40% text expansion.

## Do / Don't
| Do | Don't |
|---|---|
| "Export invoices" | "Click here" |

## Related components and patterns
## Changelog
```

## Worked example: Button (summary)
- **Use when** triggering an action. **Not when** navigating to another page → Link.
- **Anatomy:** container, label, optional leading/trailing icon, optional loading spinner.
- **Properties:** hierarchy (primary, secondary, tertiary, danger), size (sm 32, md 40, lg 48 px height), iconOnly (requires accessible name and tooltip).
- **States:** hover darkens one ramp step; focus 2 px outline at 2 px offset ≥ 3:1; pressed one more step; disabled uses `color.action.disabled.*` and has no hover; loading keeps width, shows spinner and "Saving…" for screen readers, blocks repeat clicks.
- **Content:** verb + noun, sentence case, ≤ 3 words where possible ("Create invoice"); never "OK", "Submit", "Click here".
- **Do:** one primary per view; danger only for destructive actions. **Don't:** two primaries side by side; disabled primary as the only explanation that a form is incomplete.

## Accessibility section requirements
Every component doc states:
- Role and native element (button, link, checkbox, combobox...) and the matching WAI-ARIA Authoring Practices pattern for custom widgets.
- Accessible name source (visible label, aria-label for icon-only) and that visible text is part of the name.
- Keyboard model (Tab, Enter/Space, arrows, Esc, Home/End) and focus behavior (trap/return for overlays).
- Visible focus spec (≥ 3:1, not obscured), contrast for every state and theme, target ≥ 24 × 24 px.
- What is announced (status vs. alert) and when; error association with fields.
- Reduced-motion behavior; zoom 200% and 320 px reflow behavior.
- Known limitations and tested screen reader/browser combinations (filled in by engineering).

## Contribution workflow
1. **Check**: search library and docs; ask in the design-system channel; review open requests.
2. **Propose**: file a contribution request (template below) with 3+ use cases from 2+ teams, screenshots, and the gap.
3. **Triage** (system team, weekly): decide - use existing, add variant, new shared component, or keep local (product-specific "snowflake").
4. **Design**: contributor and system designer co-design anatomy, API, states, tokens; accessibility review.
5. **Review**: design critique + engineering feasibility + accessibility sign-off + content review.
6. **Build and document**: coded component, Figma component, docs, Code Connect or equivalent mapping.
7. **Release**: version bump, changelog, announcement with migration notes; pilot in the requesting product first.

## Contribution request template
```markdown
## Contribution request: [name]
Requester / team: · Type: new component / new variant / pattern / token / bug
Problem: what users or designers can't do today
Use cases (3+ from 2+ products): [links/screenshots]
Existing options considered and why they don't fit:
Proposed solution: anatomy sketch, properties, states
Accessibility considerations:
Urgency and deadline · Willing to contribute design/code: yes/no
```

## Governance model and decision rules
- **Model:** a central system team owns Core; federated contributors from product teams; a design-system council (design, engineering, accessibility, content) decides on breaking changes.
- **Decision rules:** add to Core only if used by 2+ products or 3+ places; keep product-specific components in product libraries labelled as such; any deviation on a shipped screen gets an annotation and a ticket.
- **Service levels:** triage within one week; bugs in stable components prioritized by severity.
- **Office hours** and a single intake channel; decisions logged publicly.

## Versioning, deprecation, and changelog
- Semantic versioning: patch (visual fix), minor (new variant/property, backward compatible), major (breaking: renamed property, removed variant).
- Deprecation: mark "Deprecated" in Figma and docs with the replacement, keep for at least one major cycle, provide a migration guide, track remaining usage.
- Changelog entry: what changed, why, who is affected, action required.

## Measuring adoption
- Library insights: instances of Core vs. detached or local components per file/team.
- Code: share of UI built from system components; number of overridden styles.
- Outcomes: design and build time for new features, UI consistency issues found in QA, accessibility defects, and support tickets about UI confusion.

## Design QA checklist before handoff
**System use**
- [ ] All components are library instances (no detached instances); local components flagged as contributions.
- [ ] All fills, text, spacing, radius, and effects use variables/styles; no raw values.
- [ ] Correct variants and properties; names match code.
**States and content**
- [ ] Every interactive element shows default, hover, focus, active, disabled, loading, error, selected, read-only as relevant.
- [ ] Data views show first-use empty, no results, loading, error, partial, no-permission, stale.
- [ ] Long text, truncation, 40% longer translations, large numbers, and many-row cases tested.
- [ ] Copy is final, sentence case, verb + noun buttons, error messages say how to fix.
**Layout**
- [ ] Auto layout throughout; spacing on the 4/8 scale; grid followed.
- [ ] Breakpoints designed (desktop, tablet, 320 px) and compact density where relevant.
**Accessibility**
- [ ] Text 4.5:1, large text 3:1, UI/focus 3:1 in all themes and states.
- [ ] Targets ≥ 24 × 24 px; focus order and accessible names annotated; headings and landmarks marked.
- [ ] Color never the only signal; motion has a reduced-motion alternative.
**Roles and edge cases**
- [ ] Each role's view designed (viewer, editor, admin); plan-locked and permission states included.
- [ ] Destructive actions follow the confirmation pattern; undo where possible.
**Handoff**
- [ ] Deviations from the system annotated with reason; tickets created for gaps.

## Handoff package
Ready-for-dev page with: flows and screens per breakpoint, state frames, redlines only where the system doesn't define spacing, accessibility annotations, content/string list, prototype link, open questions, and links to component docs. Mark frames "Ready for dev" and keep exploration on separate pages.
