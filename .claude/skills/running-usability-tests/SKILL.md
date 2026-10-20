---
name: running-usability-tests
description: Plans, runs, and reports usability tests of designs and prototypes for enterprise B2B products - chooses the method (moderated or unmoderated, remote or in-person, first-click, five-second, tree test, card sort, preference test, heuristic evaluation, cognitive walkthrough, designer accessibility check), writes test plans with hypotheses, participants and metrics, realistic scenario tasks, moderator scripts with think-aloud, and scores task success, time on task, errors, SEQ, SUS and UMUX-Lite with confidence intervals, then rates severity and writes findings reports with quotes and clips. Use when a designer says test my prototype, usability test, user testing, UI testing, validate the design, test plan, write tasks, moderator script, Maze or UserTesting study, first-click test, tree test, SUS score, heuristic evaluation, expert review, cognitive walkthrough, accessibility check of mockups, severity rating, or usability findings report.
---

# Running Usability Tests

Watch real users attempt real tasks on the design, measure what they do (not what they say), and turn every observed problem into a rated, evidence-backed fix.

## Choose the workflow

- **"Which method should I use?"** → use the method table below.
- **Planning a study, writing tasks, moderator script, unmoderated setup (Maze, UserTesting, Lookback), SUS questionnaire** → follow "Test workflow" and read [reference/test-plans-and-scripts.md](reference/test-plans-and-scripts.md).
- **Scoring results, severity, writing the findings report** → read [reference/metrics-and-reporting.md](reference/metrics-and-reporting.md).
- **Heuristic evaluation, cognitive walkthrough, or accessibility review of mockups (no users)** → follow "Expert review workflow" and read [reference/heuristics-and-accessibility-review.md](reference/heuristics-and-accessibility-review.md).
- **Discovery questions (why, what problems, what to build)** → use the `conducting-user-research` skill instead; usability tests answer "can they use it".

## Method selection

| Question | Method | Sample | Stage |
|---|---|---|---|
| Can users complete the key tasks? Why do they fail? | Moderated think-aloud (remote or in-person) | 5 per segment per round | Wireframe → hi-fi |
| How usable is it, in numbers? Did the redesign improve? | Unmoderated benchmark | 20–40 per segment | Hi-fi, live, pre/post |
| Where would users click first? | First-click test | 30+ | Any static screen |
| Does the page communicate its purpose? | Five-second test | 20–50 | Landing, dashboard, empty state |
| Can users find items in our navigation? | Tree test (text only, no UI) | 50+ per tree | IA restructure |
| How do users group our content? | Card sort (open → closed) | 15–20 open; 30+ closed | Before IA design |
| Which visual direction is preferred? | Preference test - caveats below | 30+ | Visual exploration only |
| Fast check before users, or no access to users | Heuristic evaluation, cognitive walkthrough | 3–5 evaluators | Any |
| Will it pass WCAG 2.2 AA at design stage? | Designer accessibility review | 1 reviewer + checklist | Before handoff |

**Preference-test caveats:** preference ≠ performance; people pick the familiar or prettier option. Always pair with a task (first-click or success), ask "why", randomize order, and never use it to choose between flows.

**Enterprise specifics:** test each role separately (end user, admin, approver); seed the prototype with realistic dense data (200+ rows, long names, mixed statuses); include a no-permission path; recruit through CS/account managers with the customer's agreement.

## Non-negotiable rules

1. **Start from a decision and hypotheses.** Each study states what will change if a hypothesis holds or fails ("If ≥ 2/5 admins miss bulk edit, we move it into the toolbar").
2. **Five per segment per round, then iterate.** Five users surface ~85% of problems that affect ≥ 31% of users. Three rounds of five beat one round of fifteen. Benchmarks need 20+.
3. **Tasks are scenarios, not instructions.** A goal, a motivation, and a clear end state - never UI words ("click", "Filters", "Export button") or the labels on screen.
4. **Define success criteria before the first session** - what counts as success, partial, and failure, and the time limit.
5. **Moderator stays neutral.** No leading, no helping, no explaining the design; answer questions with questions; let silence work 5–10 s.
6. **Measure behavior first, opinion second**: task success, time, errors, then SEQ after each task and SUS or UMUX-Lite at the end.
7. **Report small-sample numbers honestly**: n/N plus an adjusted-Wald 95% confidence interval; no bare percentages under 20 participants.
8. **Rate every finding 0–4 severity** using frequency × impact × persistence; fix 3s and 4s before release.
9. **Every finding has evidence**: participants affected (n/N), a quote or clip timestamp, and the screen/element.
10. **Recommend, don't redesign in the report.** One concrete fix per finding, linked to the design-system pattern where one exists.
11. **Consent and privacy**: consent for recording; pseudonymize (P1, P2); blur customer data in clips; never use real customer records in prototypes.
12. **Accessibility is part of usability**: run the designer accessibility review on every tested design and, at least once per release, include a participant who uses assistive technology.

## Test workflow

Copy this checklist and track progress:

```
Usability test checklist:
- [ ] 1. Decision, research questions, hypotheses, success thresholds
- [ ] 2. Method, format (moderated/unmoderated, remote/in-person), sample per segment
- [ ] 3. Screener on behavior + role; recruit 6 per segment (1 no-show buffer)
- [ ] 4. Prototype seeded with realistic enterprise data and all paths tasks need
- [ ] 5. 5-8 scenario tasks with end states and success criteria
- [ ] 6. Script (moderated) or study build (unmoderated) + SEQ, SUS/UMUX-Lite
- [ ] 7. Pilot with 1 person; fix tasks, prototype dead-ends, timing
- [ ] 8. Run sessions; debrief and log observations within 24 h
- [ ] 9. Score metrics, rate severity, pick clips and quotes
- [ ] 10. Findings report + readout; log 3s and 4s as tickets
```

**Step 5 – Task writing.** Use the good/bad examples in [reference/test-plans-and-scripts.md](reference/test-plans-and-scripts.md). Order tasks as a user would, put the riskiest task 2nd or 3rd (after a warm-up), and cap a moderated session at 60 minutes.

**Step 7 – Pilot loop.** If the pilot participant misreads a task, hits a prototype dead-end, or the session overruns, fix it and pilot again. Do not start real sessions with a known broken path.

## Expert review workflow

1. Name the persona and 2–4 primary tasks; walk each task once to learn the flow.
2. **Heuristic evaluation**: inspect every screen against Nielsen's 10 heuristics; log each issue once, under the best-fitting heuristic.
3. **Cognitive walkthrough** (for first-time or infrequent tasks): at each step ask the four questions - will the user try to achieve the right effect, notice the correct action, connect it to their goal, and see progress after acting?
4. **Accessibility review**: run the designer checklist (contrast, focus order, target size, labels, color, states).
5. Rate severity, merge duplicates across evaluators, and state "single evaluator" when applicable (~35% of issues found by one evaluator, ~75% by five).

## Quality check before delivering

Run this rubric on your own output; revise until every line passes:

- [ ] Every task is a scenario with an end state and no UI words or on-screen labels.
- [ ] Hypotheses map to tasks and to a decision; success criteria defined per task.
- [ ] Sample size matches the method table and segments are separate.
- [ ] Metrics reported as n/N with confidence interval; SUS computed with the correct formula.
- [ ] Each finding has severity, n/N, evidence (quote/clip), location, and one concrete recommendation.
- [ ] Positive findings and limitations are included; nothing claimed beyond the evidence.
- [ ] Accessibility findings cite the WCAG criterion.

## Output template

```markdown
## Usability test: [design/flow] - Round [n]
**Decision:** [what this informs] · **Method:** [moderated remote think-aloud] · **Participants:** [N per segment, roles] · **Prototype:** [link/version]

### Results by task
| Task | Success (full/partial/fail) | Success rate (95% CI) | Median time | Avg SEQ | Hypothesis |
|---|---|---|---|---|---|
| T1 Find overdue invoices | 3/1/1 | 70% (29–93%) | 1:40 | 5.2 | Supported |

**SUS:** [score] (benchmark 68) · **UMUX-Lite:** [score]

### Findings (most severe first)
| # | Severity | Finding | n/N | Evidence | Location | Recommendation |
|---|---|---|---|---|---|---|
| 1 | 4 Catastrophic | Admins think "Remove" deletes the user, not their role | 4/5 | P2 06:12 "Wait, will this delete her account?" | Role panel | Rename to "Remove role"; show consequence text |

**What worked:** [list] · **Accessibility:** [WCAG issues] · **Limitations:** [list] · **Next round:** [what to retest]
```

## Example

**Input:** "Test my new approval flow prototype for expense reports."

**Output (plan summary):**
- Decision: ship the inline approval panel or keep the separate approval page. Hypothesis: managers approve a compliant report in < 60 s without opening the detail page.
- Method: moderated remote think-aloud, 5 approving managers + 5 finance admins, 45 min, Figma prototype with 40 seeded reports (3 over policy limit).
- Task T2: "A teammate says you're holding up her trip reimbursement. Make sure she gets paid if the report follows company policy." End state: report approved or returned with a reason.
- Success: approved the compliant report, returned the over-limit one with a reason; partial = right decision without a reason.
- Metrics: success with adjusted-Wald CI, time on task, SEQ per task, SUS at end; severity 0–4 per finding.
