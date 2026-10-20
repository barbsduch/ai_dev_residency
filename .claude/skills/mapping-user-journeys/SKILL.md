---
name: mapping-user-journeys
description: Creates and reviews journey maps (current-state and future-state), experience maps, service blueprints with frontstage, backstage, support processes and line of visibility, user flows and task flows with happy, alternate, error and permission paths, and story maps for enterprise B2B products. Scopes each map to one persona, one scenario and a clear start and end, ties every step to evidence, plots an emotion curve and moments of truth, covers multi-actor journeys (requester, approver, admin) and cross-channel handoffs (sales, onboarding, support), and turns pain points into prioritized opportunities laid out as FigJam- or Miro-ready tables. Use when the user asks for a journey map, customer journey, experience map, service blueprint, user flow, task flow, flow diagram, story map, end-to-end experience, onboarding journey, pain points, moments of truth, touchpoints, handoffs, "map the process", "where do users drop off", or "how does this work today vs. tomorrow".
---

# Mapping User Journeys

A map is a decision tool, not a poster: one actor, one scenario, real evidence, and pains that end as owned, prioritized opportunities.

## Choose the workflow

- **"What is the experience like today / should it be?"** → Journey map (current-state or future-state). Templates and a filled enterprise example in [reference/journey-templates.md](reference/journey-templates.md).
- **Broad, product-agnostic view of a whole domain** (e.g. "how IT teams buy software") → Experience map, same reference.
- **"Why does this break behind the scenes?" / ops, support, CS handoffs** → Service blueprint in [reference/flows-and-blueprints.md](reference/flows-and-blueprints.md).
- **Screen-level steps, decisions, errors, permission branches** → User flow / task flow in [reference/flows-and-blueprints.md](reference/flows-and-blueprints.md).
- **Planning a release from user activities** → Story map (section below); hand stories to the `writing-user-stories` skill.
- **No evidence yet** → Mark the map "assumption-based", then plan validation with the `conducting-user-research` skill.

| Map type | Answers | Scope | Typical lanes |
|---|---|---|---|
| Journey map | How does persona X experience scenario Y? | 1 persona, 1 scenario | Stages, actions, touchpoints, thoughts, emotions, pains, opportunities |
| Experience map | How do people experience domain Z, regardless of product? | Generalized actors | Stages, needs, actions, emotions, ecosystem |
| Service blueprint | What must the organization do to deliver this? | 1 scenario, all actors and systems | Evidence, customer actions, frontstage, backstage, support, policies |
| User flow / task flow | Which steps, screens and decisions complete the task? | 1 task, 1 entry point | Steps, decisions, system responses, errors, permissions |
| Story map | What do we build first? | 1 product area | Backbone activities, steps, stories in release slices |

## Non-negotiable rules

1. **Scope before drawing**: one persona (role + permission level), one scenario, an explicit trigger (start) and outcome (end). "All users, all of onboarding" is not a scope.
2. **Evidence on every row**: tag each step and pain with its source (interview ID, ticket count, analytics event, session recording, CS notes). Unsourced items are labeled **Assumption**.
3. **Current-state before future-state.** Never redesign a journey nobody has documented; future-state steps must trace to a current-state pain or a new goal.
4. **Use the user's words** in the thoughts lane ("Why do I need IT for this?"), not team jargon.
5. **Emotion is plotted on a fixed scale**: -2 (very negative) to +2 (very positive), one score per stage, with the quote that justifies it.
6. **Mark 2–4 moments of truth**: points where the user decides to continue, escalate, abandon or trust the product. Name what success looks like at each.
7. **Enterprise journeys show every actor**: requester, approver, admin, IT/security, buyer. Waiting time between actors is a step, with duration.
8. **Every handoff is explicit**: channel change (sales → onboarding → support, app → email → ticket), who owns it, what context is passed and what gets lost.
9. **Flows include unhappy paths**: every decision has all outcomes; every system step has an error branch; every gated action has a no-permission branch.
10. **Pains become opportunities, opportunities get priority**: score impact x reach x confidence / effort and assign an owner. A map with no owners is not done.
11. **Output as tables** (one row per lane, one column per stage) so it pastes into FigJam, Miro, Notion or a slide without redrawing.
12. **Accessibility and compliance are lanes, not footnotes**: note where assistive-tech users, consent, audit or data-residency rules change the journey.

## Workflow

Copy this checklist and track progress:

```
Journey mapping checklist:
- [ ] 1. Write the scope card (persona, scenario, trigger, end, map type, current/future)
- [ ] 2. List evidence sources and gaps; mark assumptions
- [ ] 3. Define 4-7 stages in the user's language
- [ ] 4. Fill lanes per stage: actions, touchpoints, thoughts, emotion score, pains
- [ ] 5. Add actors, waits and channel handoffs (enterprise lane set)
- [ ] 6. Plot the emotion curve; mark moments of truth
- [ ] 7. Convert pains to opportunities; score and assign owners
- [ ] 8. Add metrics per stage (baseline + target)
- [ ] 9. Run the quality check; revise until it passes
```

**Step 1 – Scope card.** Example: *Persona: Workspace admin (Owner role) at a 300-person company. Scenario: Onboard a new 25-person team after contract signature. Starts: welcome email received. Ends: 80% of the team active in week 2.*

**Step 3 – Stages.** Name stages from the user's perspective ("Get access", "Invite team"), not internal funnels ("MQL", "Activation"). 4–7 stages; if more, split into two maps.

**Step 7 – Prioritize.** Score each opportunity: Impact (1–3), Reach (% of users at that stage), Confidence (0.5 assumption / 0.8 some evidence / 1.0 strong), Effort (S=1, M=2, L=3). Priority = Impact x Reach x Confidence / Effort. Group into Now / Next / Later.

**Step 8 – Metrics.** Each stage gets one measurable signal: completion rate, time to complete, drop-off, support tickets per 100 accounts, SEQ score, or CSAT.

## Story map (quick format)

Backbone = user activities left to right (from the journey stages). Under each, user steps; under each step, stories stacked by priority. Draw horizontal release lines: **Release 1 = thinnest end-to-end slice that delivers the outcome** (walking skeleton), not "all of stage 1".

| Activity → | Set up workspace | Invite team | Configure access | Monitor adoption |
|---|---|---|---|---|
| Release 1 | Connect SSO (SAML) | Bulk invite via CSV | Assign default role | See invited vs. active count |
| Release 2 | Domain verification | SCIM provisioning | Custom roles | Weekly adoption email |
| Later | Multi-region data | Invite from Slack | Approval workflow for roles | Usage by team export |

## Quality check (run before delivering, revise until every box passes)

```
- [ ] Scope card has one persona, one scenario, a trigger and an end state
- [ ] Every step and pain cites a source or is marked Assumption
- [ ] Stages use user language; 4-7 per map
- [ ] Emotion scores on -2..+2 with a quote per stage
- [ ] 2-4 moments of truth named with a success definition
- [ ] All actors and waits shown; every handoff has owner + context passed
- [ ] Flows: every decision has all outcomes, errors and no-permission branches
- [ ] Each opportunity traces to a pain, has a score, priority bucket and owner
- [ ] Each stage has a metric with baseline (or "unknown - measure") and target
- [ ] Tables paste cleanly (no merged cells, one idea per cell)
```

## Output template

```markdown
## [Map type]: [Scenario] – [Current | Future] state

**Persona:** [role, permission level, company size] · **Scenario:** [...]
**Starts:** [trigger] · **Ends:** [outcome] · **Evidence:** [sources, n] · **Confidence:** [High/Med/Low]

| Lane | Stage 1: [name] | Stage 2: [name] | Stage 3: [name] | Stage 4: [name] |
|---|---|---|---|---|
| Actor(s) | | | | |
| User actions | | | | |
| Touchpoints / channel | | | | |
| Thoughts (quotes) | | | | |
| Emotion (-2..+2) | | | | |
| Pain points [source] | | | | |
| Handoff / wait | | | | |
| Metric (baseline → target) | | | | |
| Opportunities | | | | |

**Emotion curve:** S1 [+1] → S2 [-2] ★ → S3 [0] → S4 [+1]   (★ = moment of truth)

**Moments of truth:** 1. [stage] – [what the user decides] – success = [...]

| # | Opportunity | From pain | Impact | Reach | Conf. | Effort | Priority | Bucket | Owner |
|---|---|---|---|---|---|---|---|---|---|

**Assumptions to validate:** [...] · **Out of scope:** [...]
```

## Example

**Input:** "Map how admins onboard a new team to our SaaS tool today. We have 8 admin interviews and Zendesk data."

**Output (excerpt):** Scope card (Owner-role admin, 25-person team, from welcome email to 80% active in week 2). Five stages: Receive access → Set up SSO → Invite team → Assign roles → Confirm adoption. "Set up SSO" scores -2 with quote "I had to open a ticket with our IT and wait four days" (6/8 interviews; 140 tickets/quarter tagged "SSO"), marked ★ moment of truth. Handoff row shows sales → onboarding CSM losing the agreed seat count. Top opportunity: "Guided SAML setup with test connection and shareable IT instructions" – Impact 3 x Reach 0.9 x Conf 1.0 / Effort 2 = 1.35, Now, owner: Identity squad PM. Full worked example in [reference/journey-templates.md](reference/journey-templates.md).
