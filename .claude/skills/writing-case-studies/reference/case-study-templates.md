# Case study templates

## Contents
- Full portfolio template (with prompts)
- Skimmable layout (the 60-second layer)
- Visual storytelling and captions
- NDA treatment
- Portfolio review deck outline (45 minutes)
- Internal case study / retrospective template
- Filled example (enterprise, anonymized)

## Full portfolio template (with prompts)
Target 800-1,500 words, 8-15 visuals.

**1. Hero / TL;DR** (≤ 3 lines + meta row)
- Outcome-led headline. One-line TL;DR: problem → your action → result.
- Meta: role, team, timeline, platform, personas, your ownership (e.g. "Owned end-to-end UX; partnered on research").

**2. Context** (60-120 words)
- Product, company type (anonymized if needed), users, why this mattered to the business now.

**3. Problem** (100-150 words)
- Who struggles, with what, how we know (data, research), what it costs (tickets, churn risk, deal blockers, compliance risk).
- Problem statement: "[Persona] needs a way to [goal] because [insight], but today [barrier], which causes [cost]."

**4. Constraints** (bullets)
- Timeline, legacy architecture, design system rules, permissions model, compliance (WCAG 2.2 AA, audit, data residency), team capacity, competing stakeholder goals.

**5. Process and key decisions** (300-500 words, the core)
- Brief process line (not a generic double diamond) - only the activities that changed the outcome.
- 2-4 decisions, each: question → options → evidence → call → trade-off → result.
- Stakeholder moments: where you aligned or pushed back (PM, engineering, sales, legal, CS).

**6. Research evidence**
- Methods, sample (e.g. "8 admin interviews, 5 usability sessions"), 2-3 key insights with a quote each.

**7. Iterations** (before/after)
- 2-3 rounds max; what you learned each round and what changed.

**8. Solution** (100-200 words + hero visuals)
- The final design walked through the primary task; include edge states (empty, error, no-permission) to show rigor.

**9. Impact**
- 2-4 metrics with baseline, after, timeframe, and source; proxies labeled. Plus qualitative signals.

**10. Learnings / reflection** (80-150 words)
- What worked, what didn't, what you'd do differently, what you'd do next.

## Skimmable layout (the 60-second layer)
A reader who only sees bold text, headings, captions, and numbers must get the story.

```
[Headline: outcome-led]
[TL;DR line]                    [Meta: Role | Team | Timeline | Users]
[Hero image: final design, caption with insight]
[3 impact numbers as large stat tiles]
## Problem - [one bold sentence]
## Key decision 1 - [bold one-liner]   [before/after image + caption]
## Key decision 2 - [bold one-liner]   [image + caption]
## Impact - [bold one-liner]
## What I'd do differently - [bold one-liner]
```

Rules: headings are statements ("Admins didn't trust auto-approval"), not labels ("Research"); one idea per section; stat tiles show number + label + source.

## Visual storytelling and captions
- Sequence: problem evidence → messy middle (sketches, flows, test findings) → before/after → final.
- Prefer annotated screens over raw screens; 1-3 callouts per image.
- Caption formula: **[What changed] + [why / evidence] + [effect]** - "Moved approval risk to the first column because admins scanned for risk first (6 of 8 sessions); review time dropped 38% in testing."
- Diagram enterprise complexity: persona/role map, system context (IdP → product → HRIS), permission matrix, service blueprint snippet.
- Alt text for every image: what it shows + the takeaway.
- Avoid: 20 sticky-note photos, unannotated wireframe galleries, device mockups that hide the design.

## NDA treatment

| Element | Treatment |
|---|---|
| Company / client | "A Fortune 500 logistics company", "Series C HR platform" |
| Product name, logos | Remove or replace with neutral name |
| Screens | Redraw at wireframe/mid-fi fidelity, blur, or crop to the pattern; replace real data with plausible fake data |
| Metrics | Relative ("cut by about a third", "3x") instead of absolute revenue/user counts |
| People | Roles, not names; no customer quotes with identifying detail |
| Unreleased work | Exclude or describe at the problem/process level only |

When in doubt, ask the employer; offer a password-protected page or walk-through in interview only.

## Portfolio review deck outline (45 minutes)
Typical format: 30-35 min presentation + 10-15 min Q&A. 15-25 slides; 1 deep case (or 2 cases: 20 + 10 min).

| # | Slide | Time | Content |
|---|---|---|---|
| 1 | Intro | 2 min | You, your focus, what you'll show and why |
| 2 | Project hero | 1 min | Headline, TL;DR, role/team/timeline |
| 3 | Context | 2 min | Product, users, business stakes |
| 4 | Problem | 3 min | Evidence, cost, problem statement |
| 5 | Constraints & stakeholders | 2 min | Constraint list, stakeholder map |
| 6-7 | Research | 4 min | Methods, 2-3 insights with quotes |
| 8-12 | Key decisions (2-3) | 10 min | Options, evidence, call, trade-off - one decision per 1-2 slides |
| 13-14 | Iterations | 3 min | Before/after, what testing changed |
| 15-16 | Solution | 4 min | Walkthrough of primary task + one edge state |
| 17 | Impact | 2 min | 2-4 metrics, labeled proxies |
| 18 | Reflection | 2 min | What you'd change, what you learned |
| 19 | (Optional) Second project | 8 min | Compressed: problem, decision, impact |
| 20 | Q&A | 10-15 min | Backup slides ready: research detail, alt directions, metrics source |

Presenter tips: ≤ 30 words per slide; speaker notes hold the story; rehearse to 30 min to leave buffer; tailor slide 1 to the company's product and challenges.

## Internal case study / retrospective template
Audience: leadership, partner teams, design org. 1-2 pages or 10-slide readout.

```markdown
# [Project]: [outcome in one line]
**Team:** [names/roles]  **Timeline:** [start-end]  **Status:** [shipped / pilot / paused]

## Why we did this (business goal, customer problem, target metric)
## What we shipped (2-3 screenshots, one paragraph)
## Results vs. goals
| Metric | Goal | Actual | Source | Note |
## Key decisions and why
## What went well / what didn't / what we'll change
| Went well | Didn't go well | We'll change |
## Reusable assets (patterns, components, research, templates)
## Open questions and asks for leadership
```

Blameless: describe process and system causes ("requirements changed after build started because legal review came late"), not individuals.

## Filled example (enterprise, anonymized)

**Headline:** Making bulk user provisioning safe enough for IT admins to trust

**TL;DR:** IT admins at a mid-market HR platform avoided bulk import because one bad CSV could lock out hundreds of employees. As the sole product designer, I introduced a preview-and-validate step with row-level fixes, which raised bulk import adoption from 18% to 47% of new accounts in two quarters and cut provisioning tickets by about a third.

**Role:** Product designer, end-to-end (research, flows, UI, testing) · **Team:** PM, 4 engineers, CS lead · **Timeline:** 5 months · **Users:** IT admins, HR admins

**Problem:** "IT admins need to provision hundreds of users at once because onboarding comes in waves, but today errors only appear after import, which causes lockouts and 30% of onboarding tickets."

**Constraints:** SCIM roadmap uncertain; import service could only validate synchronously up to 5,000 rows; design system had no data-grid edit pattern; WCAG 2.2 AA required for enterprise contracts.

**Decision 1 - Validate before or after import?** Options: post-import error report (cheap) vs. pre-import preview (costly). Evidence: 7 of 8 admins said they'd "never risk it" without seeing changes first. Call: preview with row-level errors. Trade-off: capped preview at 5,000 rows and added async import above that, accepting a slower path for the largest 5% of customers.

**Decision 2 - Fix in product or in the CSV?** Inline fixes for the 3 most common errors (missing manager, duplicate email, invalid role); download-and-reupload for the rest. Kept scope shippable in one quarter.

**Impact:** Adoption 18% → 47% (product analytics, 2 quarters). Provisioning tickets down ~35% (support data, same-length periods). Task success in testing 3/6 → 6/6. Proxies labeled.

**What I'd do differently:** Bring CS in at kickoff, not after the first pilot - they knew the top error types and would have saved a research round.
