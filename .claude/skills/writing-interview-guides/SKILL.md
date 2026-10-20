---
name: writing-interview-guides
description: Turns a research question into a field-ready interview guide for enterprise B2B products - research goals, learning objectives, behavioral screeners with disqualifiers and quotas, open past-behavior questions, funnel ordering with must-ask priorities and time budgets for 30, 45 or 60 minute sessions, TEDW and 5-whys probes, a bias audit that scores and rewrites every question, pilot and dry-run checklists, consent script, note-taking grid, and remote moderation tips. Covers user, admin, buyer and stakeholder or expert interviews. Use when the user asks to write, review or fix an interview guide, discussion guide, interview script, screener, recruiting criteria, interview questions, customer discovery questions, stakeholder interview questions, consent script or note-taking template, or says "are these questions leading", "what should I ask", "help me prep for interviews", or "make this guide fit 45 minutes".
---

# Writing Interview Guides

A guide is a plan for getting stories about real past behavior: every question earns its place by serving a learning objective, and nothing in it tells the participant what answer you want.

## Choose the workflow

- **Starting from a research question or brief** → follow "Build workflow" end to end.
- **Reviewing or fixing an existing guide** → run "Quality check" on every question, then reorder with Step 5.
- **Need questions for a topic** (workflow, pain points, tools, decisions, procurement, onboarding, admin, collaboration) → pull from [reference/question-bank.md](reference/question-bank.md).
- **Screener, recruiting, consent, note-taking grid, pilot** → use [reference/screeners-and-logistics.md](reference/screeners-and-logistics.md).
- **Stakeholder or expert interviews** (PM, sales, CS, support, legal, domain experts) → Build workflow, but use the stakeholder variant in Step 3 and the stakeholder section of the question bank.

## Non-negotiable rules

1. **Objective first.** Every question is tagged to one learning objective (O1, O2...). A question with no objective is cut.
2. **Past behavior, not prediction.** Ask what people did ("Tell me about the last time..."), never what they would do. Ban "Would you...", "Could you see yourself...", "Imagine if...".
3. **Open, not closed.** Start with How, What, Tell me, Walk me through. Questions answerable with yes/no, a number, or "it depends" are rewritten.
4. **One idea per question.** No double-barreled questions ("How do you create and share reports?" becomes two).
5. **Non-leading and neutral.** No adjectives that presume a feeling ("How frustrating is..."), no naming your feature or solution before the participant raises the topic, no "Don't you think...".
6. **Specific and concrete.** Anchor to a real instance, a timeframe, or an artifact ("the last report you exported this week"), not "in general" or "usually".
7. **Screen on behavior.** Recruit on what people have done recently ("approved a vendor in the last 6 months"), not job titles or self-rated expertise. Every screener has disqualifiers and quotas.
8. **Separate roles.** In enterprise accounts, end users, admins, buyers and IT/security approvers get separate sessions or separate guide modules; never mix their questions in one funnel.
9. **Budget time.** Must-ask questions fit in 70% of the session. Nice-to-have questions are marked and dropped first when time runs short.
10. **Consent before recording.** The consent script is read and agreed before any recording starts; participants are pseudonymized (P1, P2...) in notes.
11. **Pilot before fielding.** Run one pilot session with someone matching the screener and revise before the first real interview.

## Build workflow

Copy this checklist and track progress:

```
Interview guide checklist:
- [ ] 1. Decision, research question, and 3-5 learning objectives
- [ ] 2. Participant segments, screener, quotas, disqualifiers
- [ ] 3. Draft 3-6 candidate questions per objective
- [ ] 4. Bias audit: score every question, rewrite anything below 4/5
- [ ] 5. Order into sections, mark must-ask vs nice-to-have, set time budget
- [ ] 6. Add probes under each must-ask question
- [ ] 7. Add consent script, intro, wrap-up, and note-taking grid
- [ ] 8. Pilot, dry-run checklist, revise, version the guide
```

**Step 1 - Goals to objectives.** Write the decision ("Should we rebuild bulk user import before the enterprise launch?"), then the research question ("How do admins provision users today, and where does it break?"). Break it into 3-5 learning objectives phrased as things to learn, not features to validate: "O1 Understand the current provisioning workflow end to end", "O2 Identify where errors happen and how they are caught".

**Step 2 - Screener.** Use the template in [reference/screeners-and-logistics.md](reference/screeners-and-logistics.md). Target 6-8 interviews per segment; add 20% over-recruit for no-shows.

**Step 3 - Draft questions.** For each objective, pull candidates from [reference/question-bank.md](reference/question-bank.md) and adapt nouns to the product. Stakeholder variant: ask about their evidence ("What have you heard from customers, and from whom?"), goals, constraints and definitions of success; treat their answers as hypotheses to test, not findings.

**Step 4 - Bias audit.** Score each question on the rubric in "Quality check". Rewrite every question scoring below 4, showing original → rewrite.

**Step 5 - Sort and order.** Use the funnel: warm-up → context → broad behavior → specific deep dives → reactions to artifacts (if any) → wrap-up. Sensitive or evaluative topics (budget, competitors, complaints about colleagues) come after rapport is built. Time budgets:

| Section | 30 min | 45 min | 60 min |
|---|---|---|---|
| Intro + consent | 3 | 4 | 5 |
| Warm-up (role, team, typical week) | 3 | 4 | 5 |
| Context (tools, workflow overview) | 6 | 8 | 10 |
| Broad behavior (last time they did X) | 8 | 12 | 15 |
| Deep dives (objective-specific) | 7 | 12 | 18 |
| Wrap-up ("anything I didn't ask?") | 3 | 5 | 7 |
| **Max must-ask questions** | 6-8 | 9-12 | 12-15 |

**Step 6 - Probes.** Under every must-ask question add 2-3 probes: TEDW ("Tell me more", "Explain", "Describe", "Walk me through"), "What happened next?", "Why was that important?" (up to 5 whys, stop when you reach a goal or constraint), and "Can you show me?" for remote screen share.

**Step 8 - Pilot and dry run.** Follow the pilot procedure in [reference/screeners-and-logistics.md](reference/screeners-and-logistics.md). If more than two questions change, pilot again.

## Remote moderation

- Ask participants to share their screen and use their real environment; never ask them to show customer data or personal data - offer to pause recording or use a test account.
- Allow 5-7 seconds of silence before probing; silence produces the best stories.
- One moderator, one note-taker; observers stay muted with cameras off and send questions to the moderator in a private channel.
- Restate and confirm ("So you export it first, then check it in Excel - did I get that right?") instead of interpreting aloud.
- Do not demo, defend, or explain the product during the session. Note feature requests, then ask "What would that let you do?"

## Quality check

Score every question 0-5 (one point each) before delivering. Rewrite anything below 4 and re-score until the whole guide passes.

| Criterion | Pass if the question... |
|---|---|
| Open | cannot be answered with yes/no or a single word |
| Past behavior | asks about something that happened, not a prediction or opinion |
| Specific | anchors to a real instance, timeframe, or artifact |
| Neutral | has no presumed feeling, no solution named, no implied right answer |
| Single idea | asks exactly one thing |

Guide-level pass: every objective has at least two must-ask questions; must-ask total fits the time-budget table; probes exist under every must-ask; consent script and wrap-up present; roles not mixed in one funnel.

## Output template

```markdown
## Interview guide: [study name] · v[1] · [30/45/60] min
**Decision:** [decision] · **Research question:** [question]
**Participants:** [segment(s)], [n] per segment · **Screener:** see appendix

### Learning objectives
- O1 [learn ...]
- O2 [learn ...]

### Guide
| # | Section | Time | Question | Objective | Priority | Probes |
|---|---------|------|----------|-----------|----------|--------|
| 1 | Warm-up | 4 | Tell me about your role and what a typical week looks like. | Context | Must | Who do you work with most? |

### Bias audit (rewrites)
| Original | Score | Issue | Rewrite | Score |
|---|---|---|---|---|

### Appendix
Consent script · Screener · Note-taking grid · Pilot notes
```

## Example

**Input:** "Review my guide question: 'Would you use a bulk import feature if it showed errors before saving?'"

**Output:**
| Original | Score | Issue | Rewrite | Score |
|---|---|---|---|---|
| Would you use a bulk import feature if it showed errors before saving? | 1/5 | Hypothetical, yes/no, names the solution, not anchored | Walk me through the last time you added a large group of users. | 5/5 |

Probes: "How did you know whether it worked?" · "What did you do when something went wrong?" · "How long did the whole thing take?" Tag: O2 Identify where errors happen. Priority: Must.
