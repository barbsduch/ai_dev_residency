# Design briefs, PRDs, handoff and the acceptance-criteria library

## Contents
- Lightweight PRD / design brief template
- Filled brief example
- Success metric patterns
- Design handoff note template (per story)
- Handoff checklist
- Analytics event naming
- Acceptance-criteria library by state
- Acceptance-criteria library by component
- Accessibility AC set (WCAG 2.2 AA)

## Lightweight PRD / design brief template

Keep to 1–2 pages. If a section is unknown, write "Unknown – owner – date" instead of omitting it.

```markdown
# [Feature] – Design brief
**Owner(s):** PM · Design · Eng lead · **Status:** Draft / In review / Approved
**Stakeholders to consult:** Sales, CS, Support, Legal/Privacy, Security

## Problem
[1–3 sentences: who struggles, with what, how we know (evidence IDs), cost of not solving]

## Users and roles
| Persona / role | Permission level | Job to be done | Frequency |

## Goals
1. [User goal] 2. [Business goal]

## Success metrics
| Metric | Baseline | Target | Measured by | Guardrail |

## Scope
**In:** [...] **Non-goals:** [explicitly not doing, and why]

## Key flows and states
[Links to journey map / user flow / frames; list of states designed]

## Requirements
[Epics or top stories with priority: Must / Should / Could]

## Risks and assumptions
| Risk or assumption | Type (value, usability, feasibility, viability, compliance) | Mitigation / test |

## Open questions
| Question | Owner | Due |

## Timeline and milestones
[Discovery → design review → build → beta → GA]
```

## Filled brief example

**Problem:** Admins at new accounts take a median 4.2 days to set up SSO, and 38% of onboarding tickets are SSO-related (E1, E2). Accounts without SSO in week 1 reach 61% week-2 activation vs. 84% for those with SSO.
**Users:** Workspace admin (Owner/Admin role, sets up); IT identity engineer (configures IdP, often outside the product); end users (log in).
**Goals:** Admin completes and tests SSO in one session; reduce SSO tickets.
**Metrics:** SSO setup median 4.2 d → 1 d; SSO tickets 140 → 60 / quarter; guardrail: login failure rate does not increase.
**Non-goals:** SCIM provisioning (separate epic); custom IdP attribute mapping.
**Risks:** IT engineers won't use a shared link (usability – test with 5 IT admins); metadata variations across IdPs (feasibility – spike).

## Success metric patterns

| Goal type | Metric | Example target |
|---|---|---|
| Task efficiency | Median time on task | 4 min → 90 s |
| Task effectiveness | Task success rate (usability test or funnel) | 70% → 90% |
| Perceived ease | SEQ (1–7) after task | ≥ 5.5 |
| Overall usability | SUS | ≥ 68 (average), ≥ 80 (excellent) |
| Adoption | % of eligible accounts using feature in 30 days | 25% |
| Support load | Tickets per 100 accounts | -40% |
| Guardrail | Error rate, churn, accessibility defects | No increase |

## Design handoff note template (per story)

```markdown
### Handoff: Story [ID] – [title]
**Design links:** [Figma page / frames / prototype] · **Flow nodes:** [F3–F5e]
**Components:** [design-system components used; any new or modified component flagged]
**Specs:** tokens for spacing/type/color; density; breakpoints (320 / 768 / 1280 px)
**States designed:** default · loading · empty (first use / no results) · error · partial · no permission · read-only · offline
**Interactions:** hover, focus, pressed, disabled; keyboard order; focus after submit / close
**Copy:** [string table link] – final / pending (owner)
**Accessibility notes:** headings, landmarks, labels, ARIA live regions, alt text
**Analytics events:** `object_action` {properties}
**Edge cases:** long names (60+ chars), 1,000+ rows, localization (+30% text length), RTL if supported
**Open questions:** [question – owner – due]
**Out of scope for this story:** [...]
```

## Handoff checklist

```
- [ ] Frames named and ordered to match the flow node IDs
- [ ] Every state from the AC list has a frame
- [ ] Only design-system components, or new ones flagged with rationale
- [ ] Tokens used, no hard-coded values; redlines only where tokens don't cover it
- [ ] Responsive behavior shown for at least small and large breakpoints
- [ ] Focus order and keyboard behavior annotated
- [ ] Final copy in a string table with keys and character limits
- [ ] Analytics events and properties listed
- [ ] Permission variants shown per role
- [ ] Prototype link for any non-obvious interaction
- [ ] Walkthrough held with engineering + QA; questions logged
```

## Analytics event naming

Format `object_action` in past tense, snake_case: `members_invite_sent`, `sso_connection_tested`, `report_export_failed`. Properties: `method`, `count`, `role`, `error_type`, `plan`. Never include names, emails or free text (personal data); use IDs, and apply the `protecting-privacy` skill for consent rules.

## Acceptance-criteria library by state

| State | Checklist AC |
|---|---|
| Loading | Skeleton matching layout after 1 s; previous data stays visible on refresh; no layout shift when content loads |
| Empty – first use | Explains why it's empty + primary action ("Invite members"); optional sample or import |
| Empty – no results | Echoes query/filters; "Clear filters" action; different from first-use state |
| Error – system | What happened + what to do + reference ID; retry; user input preserved |
| Error – validation | Inline next to field on blur; summary with links on submit; focus moves to first error |
| Partial | Loaded data shown; inline notice of the part that failed; retry for that part only |
| No permission | States what is restricted and who to ask (name/link); "Request access" if supported |
| Read-only | Content visible; edit controls disabled with reason in tooltip |
| Success | Confirmation in context (toast or inline) with undo where reversible |
| Offline / stale | "Last updated {time}"; server actions disabled; queued changes indicated |

## Acceptance-criteria library by component

**Form:** required fields marked; labels always visible (no placeholder-only labels); input preserved on error and navigation; submit button never disabled to signal invalid fields; primary button label is verb + noun.

**Data table:** default sort stated; sort, filter and page synced to URL; column headers keyboard-sortable with `aria-sort`; bulk actions show selected count; > 100 rows paginated or virtualized; empty and no-results states distinct.

**Modal dialog:** focus moves into dialog on open and returns to trigger on close; Esc closes (unless destructive in progress); title describes action; destructive confirm names the object ("Delete 3 projects").

**Destructive action:** undo for 5–10 s preferred over confirmation; if irreversible, confirmation states consequences and requires the object name for high-impact deletes.

**File upload:** accepted types and max size stated before upload; progress shown > 1 s; wrong type/size error names the problem and fix; drag-and-drop has a keyboard-accessible button alternative.

**Notifications / email:** trigger and recipient roles defined; unsubscribe or preference link for non-transactional; deep link lands on the exact object; content excludes sensitive data.

**Search:** results update within 300 ms of typing stop or on Enter; query echoed; no-results suggests alternatives; recent searches respect privacy settings.

## Accessibility AC set (WCAG 2.2 AA)

```
- [ ] All interactive elements reachable and operable by keyboard; visible focus indicator (2.4.7, 2.4.11)
- [ ] Focus order follows visual order; focus moves logically after dialogs and submit
- [ ] Every input has a programmatic label; errors identified in text and linked to fields (3.3.1, 3.3.3)
- [ ] Text contrast ≥ 4.5:1 (≥ 3:1 for large text and UI components) (1.4.3, 1.4.11)
- [ ] Information not conveyed by color alone (1.4.1)
- [ ] Target size ≥ 24 x 24 CSS px (2.5.8)
- [ ] Content reflows at 320 px width without horizontal scroll (1.4.10)
- [ ] Status messages announced to screen readers (4.1.3)
- [ ] No drag-only interactions; single-pointer alternative provided (2.5.7)
```
