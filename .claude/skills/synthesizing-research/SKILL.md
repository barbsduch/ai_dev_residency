---
name: synthesizing-research
description: Turns raw interview notes, transcripts, usability sessions, survey open-ends and support tickets into evidence-backed decisions for enterprise B2B products - tagging codebooks, atomic observations, affinity mapping, thematic analysis, insight statements with n/N evidence, quotes and confidence levels, observation vs interpretation vs recommendation, JTBD statements, evidence-based personas and archetypes (end user, admin, buyer, IT approver), opportunity solution trees, How Might We statements, impact x frequency x severity prioritization, research reports, readout decks and repository nuggets. Use when the user asks to synthesize or analyze research, interview notes or transcripts, do affinity mapping or thematic analysis, write insights or findings, build personas, write JTBD or How Might We statements, prioritize findings, write a research report or readout, tag notes for Dovetail, or says "what did we learn", "turn these notes into insights", or "what should we do with this research".
---

# Synthesizing Research

Synthesis turns many observations into a few defensible claims: every insight traces back to counted evidence, says why it matters, and points to a decision.

## Choose the workflow

- **Raw notes or transcripts to insights** → follow "Synthesis workflow" end to end; methods and codebook in [reference/synthesis-methods.md](reference/synthesis-methods.md).
- **Quick synthesis after 3-5 sessions** (top-line for the team) → Steps 1-5, then the "Top-line" variant in the output template.
- **Personas, archetypes, JTBD** → Step 6 plus the templates in [reference/reports-and-personas.md](reference/reports-and-personas.md).
- **Prioritizing findings or building an opportunity solution tree** → Steps 7-8 and [reference/synthesis-methods.md](reference/synthesis-methods.md).
- **Writing the report, readout deck, or repository nuggets** → Step 9 and [reference/reports-and-personas.md](reference/reports-and-personas.md).
- **Reviewing someone else's insights** → run "Quality check" on each insight and report failures with rewrites.

## Non-negotiable rules

1. **Atomic observations first.** One fact per note, with participant ID, source and timestamp. Never cluster paragraphs or summaries.
2. **Three layers, never blended.** Observation (what was said or done) → Interpretation (why, what it means) → Recommendation (what to do). Label each.
3. **Count everything.** Every insight states support as n/N participants, by segment. No percentages for qualitative samples under 20.
4. **Quote, don't paraphrase, as evidence.** Each insight carries at least one verbatim quote or clip reference, pseudonymized (P4, Admin, 2,000-seat fintech).
5. **Look for disconfirming evidence.** For every insight, record who did not fit and why. Report contradictions, not just patterns.
6. **Behavior beats opinion.** Observed actions and past stories outweigh stated preferences and feature requests; feature requests are reframed as needs.
7. **Segment by role.** In enterprise data, analyze end users, admins, buyers and IT/security approvers separately before combining. An insight true for one role is labeled with that role.
8. **Rate confidence explicitly.** High / Medium / Low using the criteria in "Quality check"; Low-confidence insights are framed as hypotheses to test.
9. **Personas from evidence only.** Personas and archetypes are built from behavioral patterns in the data, never from demographics or stakeholder assumptions; every attribute is traceable.
10. **Tie back to the decision.** Each recommendation names the decision it informs and an owner. Insights that inform no decision go to "Other observations".
11. **Protect participants.** Strip names, emails, company names and screenshots of customer data before sharing; follow retention rules agreed in consent.

## Synthesis workflow

Copy this checklist and track progress:

```
Synthesis checklist:
- [ ] 1. Gather sources; confirm decision, research questions, segments
- [ ] 2. Build or adapt the tagging codebook
- [ ] 3. Break data into atomic observations and tag them
- [ ] 4. Affinity map bottom-up; name clusters as themes
- [ ] 5. Write insight statements with n/N, quotes, disconfirming evidence, confidence
- [ ] 6. Derive JTBD statements and personas/archetypes if needed
- [ ] 7. Reframe insights as opportunities and How Might We statements
- [ ] 8. Prioritize with impact x frequency x severity; build opportunity solution tree
- [ ] 9. Write report, readout deck, and repository nuggets
- [ ] 10. Run quality check; revise until every insight passes
```

**Step 2 - Codebook.** Start with deductive codes from the research questions (e.g. "O2 Error detection"), then add inductive codes as patterns emerge. Each code has a name, definition, include/exclude rule and example. Keep it to 15-30 codes; merge codes used fewer than twice.

**Step 3 - Atomic observations.** Format: "P3 · Admin · exports user list to CSV before every bulk change · 12:40". Tag with type (Behavior, Pain, Workaround, Goal, Tool, Quote, Request) and codes. Expect 40-80 observations per 60-minute interview.

**Step 4 - Affinity mapping.** Cluster by similarity of meaning, not by interview question. Name each cluster with a full sentence in the participant's voice ("I don't trust bulk changes until I check them myself"), not a label ("Trust"). Group clusters into 5-8 themes. Split any cluster over ~15 notes.

**Step 5 - Insight statements.** Formula: **[Who] [does/experiences what] because [why], which means [implication for the product or business].** Add evidence n/N by segment, 1-2 quotes, who did not fit, and confidence.

**Step 7 - How Might We.** One HMW per insight: narrow enough to act on, broad enough for multiple solutions. "HMW help admins confirm a bulk change is safe before it applies?" not "HMW add a preview?" (too narrow) or "HMW improve admin experience?" (too broad).

**Step 8 - Prioritize.** Score each opportunity 1-3 on Impact (business and user value), Frequency (how many participants and how often), Severity (blocks task 3 / slows 2 / annoys 1). Priority = I x F x S (max 27). 18+ act now, 8-17 plan, under 8 monitor. Then lay out the opportunity solution tree: outcome → opportunities → solution ideas → assumption tests.

## Quality check

Before delivering, check every insight against this rubric. Revise and re-check until all pass.

| Criterion | Pass if... |
|---|---|
| Atomic evidence | traces to tagged observations with participant IDs |
| Counted | shows n/N by segment; no percentages under N=20 |
| Quoted | includes at least one verbatim, pseudonymized quote |
| Explains why | states a cause or motivation, not only a behavior |
| Implication | says what it means for the product or decision |
| Layers separated | observation, interpretation and recommendation are labeled |
| Disconfirming | names who did not fit, or states none found |
| Confidence | rated and justified |

Confidence: **High** = 6+ of 8-12 participants or most of a segment, observed behavior, consistent across segments or confirmed by a second source (analytics, tickets). **Medium** = consistent pattern but single segment, single method, or mostly stated. **Low** = 2-3 participants, stated preference only, or contradicted evidence; label as hypothesis.

## Output template

```markdown
## Research synthesis: [study] · [method], N=[n] ([segments])
**Decision informed:** [decision] · **Owner:** [name/role]

### Insights
| # | Insight (who, what, why, implication) | Evidence n/N by segment | Quote | Didn't fit | Confidence |
|---|---|---|---|---|---|
| 1 | Admins verify bulk changes in a spreadsheet because the product shows no preview, so bulk edits feel unsafe and get delayed. | Admins 7/9 · End users n/a | P4: "I export first so I can check nothing breaks." | P2 uses a sandbox workspace | High |

### Opportunities and priority
| # | How Might We | Impact | Freq | Severity | Score | Recommendation | Owner |
|---|---|---|---|---|---|---|---|

### JTBD / archetypes (if requested)
### Other observations · Contradictions · Limitations · Open questions
```

**Top-line variant (after 3-5 sessions):** 3-5 emerging patterns with n/N, all marked "Emerging - not yet confident", plus surprises and what to probe next.

## Example

**Input:** Notes: "P1 admin: 'I always export before bulk edits.' P3 admin: export to Excel, checks rows, then imports. P5 admin: once broke 200 accounts with a bulk change. P2 admin: uses sandbox. P6 end user: never does bulk edits."

**Output:**
- **Observation:** 3/4 admins export data before bulk changes to check them manually (P1, P3, P5); P5 broke 200 accounts once.
- **Interpretation:** Admins don't trust bulk changes because they can't see the effect before it applies.
- **Insight:** Admins double-check bulk changes outside the product because there is no preview, which makes bulk editing slow and risky. Evidence: Admins 3/4 · P1: "I always export before bulk edits." Didn't fit: P2 uses a sandbox. Confidence: Medium (single segment, small N; confirm with support tickets).
- **HMW:** help admins confirm a bulk change is safe before it applies? Score: I3 x F2 x S3 = 18 → act now.
- **Recommendation:** Explore a pre-commit preview of affected records; test with 5 admins. Owner: PM Admin.
