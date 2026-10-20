---
name: writing-user-stories
description: Turns research findings, journey maps, flows and designs into backlog-ready work for enterprise B2B products - user stories with specific roles, INVEST checks, SPIDR splitting (spike, path, interface, data, rules) plus splitting by workflow step and role, acceptance criteria in Given/When/Then and checklist style including UX criteria (every UI state, error messages, WCAG 2.2 AA, responsive, permissions, empty data, copy), job stories, epics to stories to tasks, design definition of ready and done, per-story design handoff notes (links, specs, states, analytics events, open questions), and lightweight PRDs or design briefs (problem, users, goals, success metrics, scope, non-goals, risks). Use when the user asks to write user stories, acceptance criteria, Jira tickets, epics, a backlog, a PRD, a design brief, a one-pager, handoff notes, definition of ready or done, or says "break this design into stories", "is this story too big", "split this epic", "what are the ACs", or "get this ready for sprint planning".
---

# Writing User Stories

A story is a promise of a conversation, made testable: a specific role, a real outcome, and acceptance criteria that cover every state the design team drew - and the ones they forgot.

## Choose the workflow

- **Design, flow or research → backlog** → follow "Story workflow". Good/bad examples, splitting and enterprise permission stories in [reference/story-patterns.md](reference/story-patterns.md).
- **Story too big / epic needs breaking down** → "Splitting" section, then worked examples in [reference/story-patterns.md](reference/story-patterns.md).
- **Writing or reviewing acceptance criteria** → AC rules below + the per-component library in [reference/briefs-and-handoff.md](reference/briefs-and-handoff.md).
- **Kicking off a feature (PRD, design brief, one-pager)** → brief template in [reference/briefs-and-handoff.md](reference/briefs-and-handoff.md).
- **Handing designs to engineering** → handoff note template and checklist in [reference/briefs-and-handoff.md](reference/briefs-and-handoff.md).
- **No flow exists yet** → build one first with the `mapping-user-journeys` skill; for state and copy detail use `designing-ux` and `building-accessible-ui`.

## Non-negotiable rules

1. **Format**: "As a <specific role>, I want <goal>, so that <outcome>." Role names a real persona and permission level ("workspace admin", "billing owner", "read-only auditor") - never "user" or "I as a developer".
2. **The "so that" is a user or business outcome**, not a restatement of the goal ("so that I can click export" fails).
3. **No solution in the goal unless the design is decided.** Write "share the report with my manager", not "a share button in the top-right".
4. **Every story passes INVEST** (Independent, Negotiable, Valuable, Estimable, Small, Testable). Small = fits in half a sprint; more than ~8 ACs or 2+ "and"s in the goal means split.
5. **Split vertically** (thin end-to-end slice of value), never horizontally by layer ("build API", "build UI", "design screen" are tasks, not stories).
6. **3–8 acceptance criteria per story**, each observable and pass/fail. Ban "fast", "intuitive", "user-friendly", "etc." - replace with a number or a behavior.
7. **UX criteria are mandatory**: loading, empty, error, partial and no-permission states; exact error copy; WCAG 2.2 AA (keyboard, focus, labels, contrast 4.5:1); responsive behavior at ≤ 640 px; and analytics events.
8. **Permissions are explicit per role**: one AC (or a role matrix) states what each role sees and can do, including the denied experience.
9. **Every story links to evidence and design**: research insight or journey pain ID, and the exact frame or flow node (e.g. F4e).
10. **Copy is final or flagged**: real strings in ACs, or "Copy TBD - owner: UX writer" as an open question that blocks Ready.
11. **Definition of Ready before sprint, Definition of Done before closing** (checklists below). Open questions block Ready.
12. **Success is measurable**: each epic names a metric with baseline and target (task success, time on task, adoption, support tickets).

## Story workflow

Copy this checklist and track progress:

```
Story writing checklist:
- [ ] 1. Gather inputs: problem, personas/roles, flow or designs, research evidence
- [ ] 2. Write the epic: outcome, metric (baseline → target), in/out of scope
- [ ] 3. Map flow steps / journey stages to candidate stories (one slice each)
- [ ] 4. Write each story in format; run INVEST; split where needed
- [ ] 5. Write ACs: Given/When/Then for behavior + UX checklist for states
- [ ] 6. Add role/permission matrix and analytics events
- [ ] 7. Attach handoff notes (links, specs, states, open questions)
- [ ] 8. Check Definition of Ready; run the quality check; revise until it passes
```

**Step 3 – Slice from the flow.** Each happy-path step becomes a candidate story; each error, edge or permission branch is either an AC on that story or its own story if it carries real effort.

**Step 5 – Two AC styles together.** Use **Given/When/Then** for behavior and business rules; use a **checklist** for UI states, accessibility and copy. One scenario per rule; no "and then also" chains of more than 3 clauses.

## Splitting (SPIDR + workflow + role)

| Technique | Split by | Example (epic: "Admins manage team members") |
|---|---|---|
| **S**pike | Unknowns first, time-boxed | Spike: can we read groups from the customer's IdP via SCIM? |
| **P**ath | Happy vs. alternate / unhappy paths | Invite by email → invite by CSV → handle invalid rows |
| **I**nterface | Channel or device | Web admin first → mobile read-only list later |
| **D**ata | Data variations or volume | Up to 50 users → up to 1,000 with background processing |
| **R**ules | Business rules, deferred | Invite anyone → enforce allowed domains → require approval |
| Workflow step | Steps in the flow | Invite → accept → assign role → deactivate |
| Role | Who does it | Owner can assign Admin → Admin can assign Member only |

Pick the split that leaves the **first slice independently shippable and valuable**.

## Job story (alternative)

Use when the role is less important than the situation (cross-role triggers, notifications, automation):
"When <situation>, I want to <motivation>, so I can <expected outcome>."
Example: "When a contract renewal is 30 days away, I want to see which seats were never used, so I can reduce the order before procurement signs."

## Definition of Ready (design) and Done (design)

```
Ready:                                          Done:
- [ ] Role, goal, outcome specific              - [ ] Built UI matches specs (spacing, tokens, type)
- [ ] Linked to evidence + design frames        - [ ] All states implemented and reviewed
- [ ] All UI states designed                     - [ ] Copy matches final strings
- [ ] Copy final or owner + date set            - [ ] Keyboard, focus, screen-reader check passed (WCAG 2.2 AA)
- [ ] Permission matrix complete                 - [ ] Responsive check at 320, 768, 1280 px
- [ ] Analytics events named                     - [ ] Analytics events fire with correct properties
- [ ] ACs testable; no open questions blocking   - [ ] Designer sign-off recorded; follow-ups ticketed
```

## Quality check (run before delivering, revise until every box passes)

```
- [ ] Every role is specific (no "user"); every "so that" is an outcome
- [ ] Every story passes INVEST; none is a horizontal layer
- [ ] 3-8 ACs each, observable, no vague words
- [ ] Loading, empty, error, partial, no-permission states covered
- [ ] Error copy written (what happened + how to fix) or flagged
- [ ] Accessibility, responsive and analytics ACs present
- [ ] Permission matrix covers every role incl. denied experience
- [ ] Each story links evidence + design frame; open questions have owners
- [ ] Epic has metric with baseline and target
```

## Output template

```markdown
## Epic: [name]
**Outcome:** [...] · **Metric:** [baseline → target] · **Evidence:** [insight / pain IDs]
**In scope:** [...] · **Out of scope:** [...]

### Story [ID]: [short title]
As a [specific role], I want [goal], so that [outcome].
**Design:** [frame / flow node links] · **Evidence:** [ID] · **Size:** [S/M/L]

**Acceptance criteria**
1. Given [context], when [action], then [observable result].
2. ...
**UX criteria**
- [ ] Loading: ... - [ ] Empty: ... - [ ] Error: "[exact copy]" - [ ] No permission: ...
- [ ] Keyboard + focus: ... - [ ] Responsive ≤ 640 px: ... - [ ] Analytics: `event_name` {props}

| Role | Sees | Can do | Denied experience |
|---|---|---|---|

**Open questions:** [question – owner – due]  · **INVEST:** I✓ N✓ V✓ E✓ S✓ T✓
```

## Example

**Input:** "Break our 'bulk invite by CSV' design into stories. Admins and Owners can invite; Members can't."

**Output (excerpt):** Epic "Admins bring their team into the workspace", metric week-2 activation 61% → 80%. Stories split by path and data: (1) Invite up to 50 people by CSV, (2) Fix invalid rows inline, (3) Handle seat limit, (4) Process up to 1,000 rows in the background. Story 2: "As a workspace admin, I want to see and fix each invalid row before sending, so that everyone on my list gets an invitation." AC: "Given a CSV with 3 rows outside allowed domains, when the file is validated, then those rows show 'jo@gmail.com is outside allowed domains (acme.com)' and the button reads 'Send 22 invitations'." Role matrix: Owner/Admin can invite; Member sees disabled button with "Only admins can invite. Ask Dana Lee." Event `members_invite_sent {count, method: csv, invalid_count}`. Open question: max rows per file - owner: eng lead.
