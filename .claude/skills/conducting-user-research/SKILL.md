---
name: conducting-user-research
description: Plans, runs, and synthesizes user research for enterprise products - turns a product question into a decision-driven research plan, selects methods (interviews, usability tests, surveys, JTBD, card sorting, analytics, competitive analysis), sets recruiting criteria and sample sizes, writes non-leading interview guides, usability tasks and unbiased surveys, measures task success, time, SEQ and SUS, and synthesizes findings into evidence-backed insights, personas, and reports with consent and anonymization. Use when the user mentions user research, discovery, customer interviews, usability testing, survey design, personas, jobs to be done, research plan, synthesis, affinity mapping, SUS, or competitive analysis, or needs evidence before a product decision.
---

# Conducting User Research

Research exists to change a decision. Start from the decision, pick the cheapest method that can change it, and report only what the evidence supports.

## Choose the workflow

- **Planning a study** → follow "Plan workflow"; pick methods and sample sizes from [reference/methods.md](reference/methods.md).
- **Writing an interview guide, usability script, or survey** → use the templates in [reference/methods.md](reference/methods.md).
- **Analyzing data, writing insights, personas, or a report** → follow "Synthesis workflow" and [reference/synthesis-and-reporting.md](reference/synthesis-and-reporting.md).
- **Competitive analysis** → use the matrix in [reference/synthesis-and-reporting.md](reference/synthesis-and-reporting.md).

## Non-negotiable rules

1. **Question → decision.** Every study names the decision it informs, the owner, and the deadline. If no result would change the decision, don't run the study.
2. **Match method to question**: *why/what problems* → qualitative (interviews, contextual inquiry); *can they use it* → usability testing; *how many/how much* → surveys, analytics. Say/do gap: prefer observed behavior over stated preference.
3. **Recruit the real user**: in B2B, separate buyer, admin, and end user; screen on behavior ("exported a report in the last 30 days"), not job titles alone. Exclude employees and friends.
4. **Ask about past behavior, not hypotheticals**: "Tell me about the last time you…" - never "Would you use…?" or "Do you like…?".
5. **No leading questions**: open, neutral wording; no feature pitches before observing; let silence work.
6. **Sample sizes**: 5 per distinct user segment per usability round; 6–12 interviews per segment (stop at saturation); surveys ≥ 100 for rough proportions, ~385 for ±5% at 95% confidence on a large population.
7. **Separate observation from interpretation.** Every insight cites evidence as **n/N** participants plus a representative quote or clip; never percentages from qualitative samples under 20.
8. **Consent and privacy**: written informed consent (purpose, recording, storage, retention, withdrawal); pseudonymize participants (P1, P2…); strip names, emails, company names, and screenshots of customer data before sharing; follow customer NDAs and DPAs.
9. **Report negative and null results** and limitations (sample, bias, method) alongside findings.

## Plan workflow

Copy this checklist and track progress:

```
Research plan checklist:
- [ ] 1. Decision, owner, deadline, and what we already know
- [ ] 2. Research questions (3-5) and hypotheses/assumptions to test
- [ ] 3. Method(s) chosen from the method matrix, with rationale
- [ ] 4. Participants: segments, screener, sample size, incentive
- [ ] 5. Materials: guide / tasks / survey drafted from templates
- [ ] 6. Pilot with 1 participant; revise leading or confusing items
- [ ] 7. Consent, recording, and data-handling plan
- [ ] 8. Analysis plan and report format agreed with stakeholders
```

**Step 6 – Pilot loop.** Run the guide, tasks, or survey with one person matching the screener. Fix any question that was misunderstood, leading, or produced yes/no answers, and re-pilot if more than two items changed.

## Synthesis workflow

1. Debrief within 24 hours of each session; capture observations as atomic notes (one fact, participant ID, source).
2. Cluster notes bottom-up (affinity mapping) → name themes → write insights using the format below.
3. Count support (n/N) and look for disconfirming evidence for every insight.
4. Translate insights into recommendations tied to the original decision; rate confidence.
5. Produce the report using the template below.

## Report template

```markdown
## Research report: [study]
**Decision informed:** [decision] · **Method:** [method, N, segments, dates]

### Key insights
| # | Insight | Evidence (n/N + quote) | Confidence | Recommendation |
|---|---------|------------------------|------------|----------------|
| 1 | Admins verify bulk changes in an external spreadsheet because the app shows no preview | 7/9 admins; P4: "I export first so I can check nothing breaks." | High | Add a pre-commit preview of affected records |

**Metrics (if usability):** task success, time on task, SEQ, SUS
**Surprises / disconfirmed assumptions:** [list]
**Limitations:** [sample, recruiting bias, method]
**Next steps / open questions:** [list]
```

Confidence: **High** (consistent across segments, observed behavior, ≥ 2 methods or most participants), **Medium** (consistent but single method or segment), **Low** (few participants or stated preference only).

## Example

**Input:** "Should we build a custom-dashboard builder? Sales says customers want it."

**Output (plan summary):**
- Decision: invest one quarter in a dashboard builder vs. improving prebuilt reports. Owner: PM Analytics.
- Research questions: What do users do with current reports? What workarounds exist (exports, BI tools)? Who would build dashboards?
- Methods: 10 JTBD interviews (5 analysts, 5 managers at accounts > 200 seats) + analytics on export frequency + review of 50 tagged sales/support tickets.
- Screener: exported or scheduled a report in the last 30 days.
- Sample guide question: "Walk me through the last time you exported data from us. What happened next?"
- Success signal: ≥ 6/10 describe a recurring, painful workaround that a builder would replace.
