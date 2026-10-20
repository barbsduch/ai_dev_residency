# Heuristic review procedure

## Contents
- Procedure
- Severity scale
- The 10 heuristics with enterprise checks
- Feedback timing reference
- Information architecture checks
- Design-token checks

## Procedure
1. **Scope**: name the screens/flow and the primary task. Review one task at a time.
2. **Two passes**: pass 1 walks the task to understand the flow; pass 2 inspects each screen against every heuristic below.
3. **Log each finding once**, against the single most relevant heuristic, with exact location (screen + element).
4. **Rate severity** using frequency × impact × persistence (scale below).
5. **Recommend a concrete fix**, not "improve clarity". Reference a pattern from reference/patterns.md when one applies.
6. **Verify**: re-read the findings list; merge duplicates; confirm each finding would actually affect the stated user.

Multiple reviewers find more issues: one evaluator finds ~35% of problems, 3–5 evaluators find ~75%. Say so when the review is single-evaluator.

## Severity scale
| Score | Label | Meaning | Action |
|-------|-------|---------|--------|
| 0 | Not a problem | Disagreement on reflection | Drop |
| 1 | Cosmetic | Fix if time allows | Backlog |
| 2 | Minor | Slows users; low priority | Next cycle |
| 3 | Major | Users struggle or err often | Fix before release |
| 4 | Catastrophic | Blocks task, loses data, or causes harmful error | Fix now |

## The 10 heuristics with enterprise checks

**H1 Visibility of system status**
- [ ] Every action has feedback within 100 ms; long jobs show progress and complete with a notification.
- [ ] Data freshness shown ("Updated 2 min ago"); saving state shown ("Saving…" → "Saved").

**H2 Match between system and the real world**
- [ ] Uses the customer's domain terms, not internal/database names (`acct_status_cd`).
- [ ] Dates, numbers, currency formatted for user locale; time zones explicit for scheduled items.

**H3 User control and freedom**
- [ ] Undo for destructive and bulk actions; Cancel on every multi-step flow; Esc closes dialogs.
- [ ] Back button and deep links work; filters persist in the URL.

**H4 Consistency and standards**
- [ ] Same component for same job (one date picker, one table); platform conventions respected.
- [ ] Button order and placement consistent across dialogs.

**H5 Error prevention**
- [ ] Constrained inputs (pickers, selects, masks) instead of free text where values are known.
- [ ] Destructive confirmation states the object and count; type-to-confirm only for irreversible high-impact actions (delete workspace).

**H6 Recognition rather than recall**
- [ ] Recent items, saved views, and autocomplete; no need to remember IDs across screens.
- [ ] Selected filters visible as chips.

**H7 Flexibility and efficiency of use**
- [ ] Keyboard shortcuts for frequent actions; bulk actions; saved filters; compact density.
- [ ] Command palette or global search for apps with > ~20 destinations.

**H8 Aesthetic and minimalist design**
- [ ] Each screen has one clear primary action; secondary info is progressively disclosed.
- [ ] No decorative content competing with data.

**H9 Help users recognize, diagnose, and recover from errors**
- [ ] Errors follow the formula in reference/patterns.md; inline, next to cause; input preserved.

**H10 Help and documentation**
- [ ] Contextual help (tooltips, "Learn more" links) at points of confusion; consistent help location.

## Feedback timing reference
| Duration | Pattern |
|----------|---------|
| < 100 ms | Direct manipulation; no indicator |
| 100 ms – 1 s | Button pressed state, inline spinner; avoid flashing loaders (delay showing by ~300 ms, then keep ≥ 500 ms) |
| 1 – 10 s | Skeleton or spinner with label ("Loading invoices…") |
| > 10 s | Determinate progress bar or step count, cancel, run in background, notify on completion |

Optimistic UI is acceptable for low-risk, high-success actions (star, rename); roll back with an error toast on failure.

## Information architecture checks
- [ ] Top-level nav ≤ 7 items grouped by user goal, not by org chart or backend service.
- [ ] Nav labels tested with card sorting or tree testing when restructuring (see conducting-user-research).
- [ ] Breadcrumbs for hierarchies deeper than 2 levels.
- [ ] Settings split into personal vs. workspace/admin.
- [ ] Every object has a canonical, shareable URL.

## Design-token checks
- [ ] Color: semantic tokens (`color.text.danger`, `color.bg.surface`) not raw palette; light and dark themes.
- [ ] Spacing: 4 px base, 8 px rhythm (4, 8, 12, 16, 24, 32, 48).
- [ ] Type: ≤ 6 sizes; body 14–16 px for dense apps; line-height 1.4–1.6.
- [ ] Motion: 100–300 ms durations, ease-out entering, honours `prefers-reduced-motion`.
- [ ] Elevation and radius come from tokens; component variants documented.
