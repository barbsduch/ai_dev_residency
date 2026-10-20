# Journey and experience map templates

## Contents
- Scope card template
- Evidence log template
- Lane definitions
- Current-state journey map template
- Future-state journey map template
- Experience map template
- Multi-actor enterprise lane set
- Cross-channel handoff table
- Filled example: admin onboards a new team to a SaaS tool
- Common mistakes

## Scope card template

| Field | Value |
|---|---|
| Map type | Journey map / Experience map / Service blueprint / Flow / Story map |
| State | Current / Future |
| Persona | Role, permission level, company size, experience with product |
| Scenario | One sentence: what the persona is trying to achieve |
| Trigger (start) | The event that starts the journey |
| End state | Observable outcome that ends it (ideally measurable) |
| Decision it supports | What the team will decide using this map |
| Out of scope | Adjacent journeys explicitly excluded |

## Evidence log template

| ID | Source type | Detail | n / volume | Stages covered | Quality |
|---|---|---|---|---|---|
| E1 | Interviews | Admin interviews, mid-market | 8 | All | High |
| E2 | Support tickets | Tagged "SSO", "invite" | 140 / quarter | 2–3 | High |
| E3 | Product analytics | Invite → first login funnel | 1,200 accounts | 3–5 | High |
| E4 | CS call notes | Onboarding calls | 15 | 1, 4 | Medium |
| E5 | Team workshop | PM, CS, sales estimates | – | All | Low (assumption) |

Confidence rating for the whole map: **High** = 2+ independent sources per stage; **Medium** = 1 source per stage; **Low** = mostly workshop assumptions.

## Lane definitions

| Lane | What goes in it | Good | Bad |
|---|---|---|---|
| Stages | 4–7 phases in user language | "Invite my team" | "Activation funnel" |
| Actor(s) | Who acts in this stage | "Admin, IT security reviewer" | "User" |
| User actions | Verbs the user performs | "Uploads CSV of 25 emails" | "Onboarding" |
| Touchpoints | Channel + artifact | "Email: welcome; App: Settings > SSO" | "Product" |
| Thoughts | Verbatim or close quote | "Which role gives view-only?" | "Confused" |
| Emotion | -2..+2 score + driver | "-2: blocked by IT for 4 days" | A smiley with no reason |
| Pain points | Specific, sourced | "SAML metadata field rejects XML upload [E2: 38 tickets]" | "SSO is hard" |
| Handoff / wait | Owner change, duration | "Waits 3–5 days for IT" | (missing) |
| Metric | Signal, baseline, target | "SSO setup median 4.2 days → 1 day" | "Improve SSO" |
| Opportunities | How might we / concept | "Shareable IT setup link with test button" | "Fix SSO" |
| Owner | Team or person | "Identity squad PM" | "Product" |

## Current-state journey map template

```markdown
## Journey map: [scenario] – Current state
**Persona:** · **Trigger:** · **End:** · **Evidence:** E1–E4 · **Confidence:**

| Lane | 1. [stage] | 2. [stage] | 3. [stage] | 4. [stage] | 5. [stage] |
|---|---|---|---|---|---|
| Actor(s) | | | | | |
| User actions | | | | | |
| Touchpoints / channel | | | | | |
| Thoughts | | | | | |
| Emotion (-2..+2) | | | | | |
| Pain points [source] | | | | | |
| Handoff / wait | | | | | |
| Metric (baseline) | | | | | |
| Opportunities | | | | | |
```

## Future-state journey map template

Same lanes, plus two rows that keep the future honest:

| Lane | Stage... |
|---|---|
| Changed from current | Which current pain this removes (cite pain ID) |
| Target metric | Baseline → target, and how it is measured |
| Dependencies | Teams, systems, policies needed (e.g. "Legal approves auto-provisioning") |
| Risk / assumption | What must be true for this to work |

Rule: every future-state step either removes a sourced pain, serves a new stated goal, or is cut.

## Experience map template

Use when the question is about a domain, not a product (e.g. "how procurement teams evaluate software").

| Lane | Discover | Evaluate | Approve | Adopt | Renew |
|---|---|---|---|---|---|
| Needs / goals | | | | | |
| Actors involved | | | | | |
| Actions | | | | | |
| Tools used (any vendor) | | | | | |
| Emotion (-2..+2) | | | | | |
| Ecosystem pains | | | | | |
| Opportunity areas | | | | | |

## Multi-actor enterprise lane set

Replace the single actions lane with one lane per actor and add a wait lane:

| Lane | Request | Review | Approve | Provision | Use |
|---|---|---|---|---|---|
| Requester (end user) | Requests access to Reports | Waits | Waits | Gets email | Opens report |
| Approver (manager) | – | Gets Slack + email | Approves in app | – | – |
| Admin | – | – | – | Assigns "Analyst" role | – |
| IT / security | – | Checks data classification | – | – | – |
| System | Creates request | Sends reminders at 24 h | Logs to audit trail | Applies role | – |
| Wait time | 0 | median 1.5 days | 0.5 days | 1 day | – |
| Pain | No status visible | Approver lacks context | – | Admin unaware of request | – |

Totals: show **end-to-end elapsed time** vs. **hands-on time** (e.g. 3 days elapsed, 6 minutes hands-on). The gap is usually the biggest opportunity.

## Cross-channel handoff table

| # | From → To | Channel | Owner | Context passed | Context lost | Pain [source] | Fix |
|---|---|---|---|---|---|---|---|
| H1 | Sales AE → Onboarding CSM | CRM note | CS lead | Contract, seats | Use case, champion name | CSM re-asks discovery questions [E4] | Structured handoff form in CRM |
| H2 | App → Support | In-app chat → ticket | Support | URL | Error ID, account plan | Customer repeats steps [E2] | Auto-attach error ID + account |
| H3 | Support → Engineering | Ticket escalation | Support lead | Steps to reproduce | Customer impact | Slow priority triage | Add affected-seat count field |

## Filled example: admin onboards a new team to a SaaS tool

**Persona:** Dana, IT-savvy workspace admin (Owner role), 300-person company, first time using the product.
**Scenario:** Onboard a newly purchased 25-seat team after contract signature.
**Trigger:** Welcome email after contract signature. **End:** ≥ 80% of the 25 users active in week 2.
**Evidence:** E1 (8 interviews), E2 (Zendesk, 140 SSO/invite tickets per quarter), E3 (funnel, 1,200 accounts), E4 (15 CSM calls). **Confidence:** High.

| Lane | 1. Get access | 2. Set up SSO | 3. Invite team | 4. Assign roles | 5. Confirm adoption |
|---|---|---|---|---|---|
| Actor(s) | Admin, CSM | Admin, IT security | Admin | Admin, team leads | Admin, team leads |
| User actions | Opens welcome email, books kickoff | Finds SSO settings, requests IdP config from IT | Uploads CSV, edits failed rows | Chooses roles per user | Checks who logged in, nudges |
| Touchpoints | Email, kickoff call | Settings > Security, IT ticket | Settings > Members, invite email | Members table | Admin dashboard, email digest |
| Thoughts | "Who is my contact here?" | "Why do I need IT for this?" | "Which rows failed and why?" | "What can 'Editor' actually do?" | "Did they even get the email?" |
| Emotion | +1 | -2 ★ | -1 | -1 | 0 ★ |
| Pain points | Kickoff scheduled 6 days out [E4] | SAML metadata upload rejects XML; 4.2-day median wait for IT [E1 6/8, E2 38 tickets] | CSV errors shown only as "3 rows failed" [E2 41 tickets] | Role names unclear; no permission preview [E1 5/8] | 22% of invites never opened (spam filters) [E3] |
| Handoff / wait | Sales → CSM loses use case [H1] | Admin → IT, 3–5 days | – | Admin → team leads by Slack | – |
| Metric (baseline) | Time to kickoff 6 days | SSO setup median 4.2 days | Invite success 87% | Role changes in week 1: 31% | Week-2 active 61% |
| Opportunities | Self-serve kickoff checklist | Guided SAML setup + shareable IT link + test connection | Row-level CSV errors with fix suggestions | Permission preview per role | Invite resend + delivery status |

**Emotion curve:** +1 → -2 ★ → -1 → -1 → 0 ★. Moments of truth: **Set up SSO** (admin decides to push through or pause rollout; success = SSO tested in one session) and **Confirm adoption** (admin decides the purchase was worth it; success = ≥ 80% active).

| # | Opportunity | Pain | Impact | Reach | Conf. | Effort | Priority | Bucket | Owner |
|---|---|---|---|---|---|---|---|---|---|
| O1 | Guided SAML setup + IT share link | SSO wait | 3 | 0.9 | 1.0 | 2 | 1.35 | Now | Identity PM |
| O2 | Row-level CSV errors | Invite failures | 2 | 0.6 | 1.0 | 1 | 1.20 | Now | Admin squad |
| O3 | Invite delivery status + resend | Unopened invites | 2 | 0.5 | 0.8 | 1 | 0.80 | Next | Growth PM |
| O4 | Permission preview per role | Role confusion | 2 | 0.7 | 0.8 | 2 | 0.56 | Next | Admin squad |
| O5 | Structured sales → CS handoff | Lost context | 1 | 1.0 | 0.8 | 2 | 0.40 | Later | CS Ops |

## Common mistakes

- Mapping the ideal flow from the product spec and calling it current-state.
- Mixing personas in one map (admin and end user) without separate lanes.
- Emotion lane filled with emoji but no driver or quote.
- Ignoring waiting time between actors – often 90%+ of elapsed time in enterprise journeys.
- Opportunities written as solutions with no link to a pain ("Add AI assistant").
- 12+ stages crammed into one map; split it.
- No owners, so the map is admired once and never used.
