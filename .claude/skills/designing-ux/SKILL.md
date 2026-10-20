---
name: designing-ux
description: Designs and reviews enterprise product UX - task flows, screens, forms and validation, data tables, navigation and information architecture, design-system tokens, every UI state (empty, loading, error, partial, no-permission, offline), feedback timing, microcopy, and dense or responsive layouts - and runs Nielsen heuristic reviews with severity ratings. Use when designing or building a screen, flow, form, table, dashboard, settings page, dialog, or onboarding, when reviewing a UI or mockup, or when the user mentions UX, usability, UI design, user flow, wireframe, empty state, error message, microcopy, or design system.
---

# Designing UX

Enterprise users are trying to finish a job, often under time pressure, at scale, with partial permissions. Design for the task, every state, and the 1,000th use - not the demo.

## Choose the workflow

- **Designing a new screen, flow, or component** → follow "Design workflow".
- **Reviewing an existing UI, mockup, or screenshot** → follow "Review workflow" and read [reference/heuristics-review.md](reference/heuristics-review.md).
- **Forms, tables, dialogs, notifications, onboarding, empty states, error copy** → read [reference/patterns.md](reference/patterns.md).
- **Accessibility requirements** → apply the `building-accessible-ui` skill alongside this one.

## Non-negotiable rules

1. **Frame the task first**: who (role + permission level), what job, how often, what "done" looks like. No screen without a primary task.
2. **One primary action per view.** Secondary actions are visually subordinate; destructive actions are never the default button.
3. **Design all seven states** for every data view: ideal, empty, loading, error, partial, no-permission, offline/stale. See the state matrix below.
4. **Feedback timing**: < 100 ms feels instant (no indicator); 100 ms–1 s show a subtle inline cue; 1–10 s show a spinner or skeleton; > 10 s show determinate progress, allow backgrounding, and notify on completion.
5. **Prevent errors before reporting them**: constrained inputs, sensible defaults, confirmation only for irreversible actions, and **undo** preferred over "Are you sure?".
6. **Error messages** say what happened, why (if known), and how to fix it - in plain language, next to the cause. Never "Error 500" or "Invalid input" alone.
7. **Use design-system tokens** for color, spacing (4/8 px scale), type, radius, elevation, motion. No hard-coded hex or pixel values in components.
8. **Preserve user work**: never lose form input on error, navigation, or session timeout; autosave long forms; keep filters/sort/pagination in the URL.
9. **Consistent terminology**: one name per concept across nav, headings, buttons, and docs. Buttons are verb + noun ("Create invoice"), not "OK"/"Submit".
10. **Density and responsiveness**: support compact density for power users (row height 32–40 px), and reflow to a single column at ≤ 640 px without hiding critical actions.

## UI state matrix

| State | Show | Never |
|-------|------|-------|
| Empty (first use) | Why it's empty + primary action to fill it + optional sample/import | A blank table with headers only |
| Empty (no results) | Echo the query/filters + "Clear filters" | The first-use empty state |
| Loading | Skeleton matching final layout (> 1 s); keep previous data visible on refresh | Full-page spinner that shifts layout |
| Error | Plain-language cause + retry + support reference ID | Stack traces, raw codes only |
| Partial | Loaded data + inline notice of what failed + retry for that part | Failing the whole page |
| No permission | What it is, that access is restricted, who to ask (admin name/link) | Hiding the nav item with no explanation, or a 404 |
| Offline / stale | "Last updated 5 min ago", queued changes indicator, disabled server actions | Silent failures |

## Design workflow

Copy this checklist and track progress:

```
UX design checklist:
- [ ] 1. Task frame: role, permissions, job, frequency, success criteria
- [ ] 2. Flow: entry points, happy path, branches, exit/completion
- [ ] 3. Information architecture: where this lives in nav, naming
- [ ] 4. Layout: primary action, hierarchy, density, breakpoints
- [ ] 5. All seven states designed (state matrix)
- [ ] 6. Forms/tables/dialogs follow reference/patterns.md
- [ ] 7. Microcopy: labels, buttons, errors, empty states, confirmations
- [ ] 8. Tokens only; accessibility pass (building-accessible-ui)
- [ ] 9. Self-review with the 10 heuristics; fix every severity ≥ 3
```

**Step 9 – Verification loop.** Walk the happy path and two failure paths as a first-time user and as a power user. If any step needs explanation that isn't on screen, fix the design and re-walk.

## Review workflow

1. Identify the user's primary task and walk it end to end.
2. Evaluate against the 10 Nielsen heuristics using [reference/heuristics-review.md](reference/heuristics-review.md).
3. Check the state matrix and feedback-timing rule for every data view.
4. Rate each finding 0–4 severity; drop cosmetic nitpicks unless asked.
5. Report using the template below, most severe first.

## Report template

```markdown
## UX review: [screen/flow]
**Primary task:** [role] wants to [job] so that [outcome].

| # | Severity | Heuristic | Location | Issue | User impact | Recommendation |
|---|----------|-----------|----------|-------|-------------|----------------|
| 1 | 4 Catastrophic | H5 Error prevention | Bulk delete | No confirmation or undo for deleting 500 rows | Irreversible data loss | Undo toast for 10 s + soft delete; confirm only when > 100 items |

**Missing states:** [list]
**Strengths to keep:** [list]
**Assumptions / not reviewed:** [list]
```

## Example

**Input:** "Design the user list page for our admin console."

**Output (summary):**
- Task frame: IT admin, finds and manages users weekly, bulk-deactivates leavers monthly; success = correct users changed with audit trail.
- Layout: page title "Users" + primary "Invite users"; search + filters (status, role, last active) synced to URL; table with sortable Name, Email, Role, Status, Last active; row checkbox → bulk bar ("Deactivate 12 users", "Change role", "Export CSV").
- States: first-use empty ("No users yet. Invite your team or connect SCIM."), no-results ("No users match 'jdoe' + Status: Suspended. Clear filters"), skeleton rows, partial ("Last active unavailable - retry"), no-permission ("Only Org admins can manage users. Contact Jane Smith.").
- Deactivate: confirm dialog stating count and consequences, button "Deactivate 12 users", then undo toast.
