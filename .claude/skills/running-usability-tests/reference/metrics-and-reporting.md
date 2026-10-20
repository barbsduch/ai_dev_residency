# Metrics, severity, and findings reports

## Contents
- Metric definitions
- Task success and confidence intervals
- Time on task
- Errors and assists
- SEQ, SUS, and UMUX-Lite interpretation
- Comparing rounds or designs
- Severity rating scale
- Observation log and synthesis
- Findings report (full template)
- Clips, quotes, and readouts
- Common mistakes

## Metric definitions
| Metric | Definition | Report as |
|---|---|---|
| Task success | Reached the defined end state without assistance | n/N full, partial, fail + rate with 95% CI |
| Time on task | Start of task reading → end state, successful attempts only | Median (n < 20) or geometric mean; range |
| Errors | Wrong paths, slips, misinterpretations per task | Count per participant; list the error types |
| Assists | Any moderator hint | Counts as failure for that task |
| SEQ | 7-point ease rating after each task | Mean per task |
| SUS | 10-item questionnaire at end | Mean score 0-100, CI if N ≥ 10 |
| UMUX-Lite | 2-item questionnaire at end | Mean score 0-100 |
| Confidence (optional) | "How confident are you that you completed the task correctly?" 1-7 | Flag high confidence + failure = dangerous misunderstanding |

## Task success and confidence intervals
Scoring: full = 1, partial = 0.5 (only if partial criteria were defined in advance), failure = 0. Report full/partial/fail counts as well as the rate.

Small samples need the **adjusted-Wald interval** (95%): adjusted p = (x + 1.92) / (n + 3.84); margin = 1.96 × √(p(1 − p) / (n + 3.84)); interval = p ± margin, clipped to 0-100%.

| Result | Adjusted-Wald 95% CI (approx.) | How to say it |
|---|---|---|
| 5/5 | 51-100% | "All 5 succeeded; the true rate is likely above 51%." |
| 4/5 | 36-98% | "4 of 5 succeeded." |
| 3/5 | 23-88% | "Mixed - more data needed for a benchmark." |
| 1/5 | 2-64% | "Most failed - a real problem." |
| 18/20 | 69-98% | Benchmark-quality estimate |

With 5 participants, the goal is finding problems, not proving rates. Use 20+ for benchmarks and comparisons. Industry average task completion is about 78%.

## Time on task
- Time successful attempts only; report failures separately.
- Task-time data is skewed: use the median or geometric mean for n < 25, never the arithmetic mean alone.
- Compare to an expert baseline (designer or power user completing the task) - a ratio > 2-3× expert time signals friction.
- Think-aloud slows people down; don't compare moderated times to unmoderated times.

## Errors and assists
Classify each error: **slip** (knew what to do, mis-clicked), **mistake** (wrong mental model), **misinterpretation** (wrong reading of a label or state). Mistakes and misinterpretations drive redesign; slips drive target size and spacing.

## SEQ, SUS, and UMUX-Lite interpretation
**SEQ:** mean ≈ 5.5 across many studies. < 5 = harder than average; < 4 = problem task. Low SEQ + success = friction; high SEQ + failure = users don't know they failed (often severity 4).

**SUS grades** (Sauro-Lewis curved scale, approximate):
| SUS | Percentile | Grade | Adjective |
|---|---|---|---|
| ≥ 84.1 | 96-100 | A+ | Best imaginable |
| 80.3 | ~90 | A | Excellent |
| 74-78 | ~70-80 | B | Good |
| 68 | 50 | C | Average |
| 51-62 | ~15-35 | D | OK / poor |
| < 51 | < 15 | F | Poor |

Enterprise software typically scores below consumer apps; set targets against your own previous rounds and competitors, e.g., "raise SUS from 62 to ≥ 70". Need N ≥ 10 for a stable SUS; with 5 participants report the score as indicative only.

**UMUX-Lite:** same 0-100 range; convert to SUS-equivalent with 0.65 × score + 22.9 for comparison.

## Comparing rounds or designs
- Same tasks, same success criteria, same segments, same prototype fidelity.
- Within-subjects (everyone tries both designs, counterbalanced order) needs fewer participants than between-subjects.
- For success-rate differences use an N-1 two-proportion test; for times, a t-test on log times. Don't claim "improved" from 5 vs. 5 unless the difference is dramatic and consistent; say "directionally better".

## Severity rating scale
Rate each problem on frequency (how many hit it), impact (how badly it blocks), and persistence (does it recur after learning).

| Score | Label | Typical evidence | Action |
|---|---|---|---|
| 0 | Not a problem | Single opinion, no behavior impact | Drop |
| 1 | Cosmetic | Noticed, no slowdown | Backlog |
| 2 | Minor | Hesitation or detour; recovered quickly | Next cycle |
| 3 | Major | Task failure or long delay for some, or frequent errors | Fix before release |
| 4 | Catastrophic | Most fail, data loss, wrong action without knowing, security/compliance risk, WCAG A/AA blocker | Fix now |

Quick heuristic: 1 user and low impact → 1-2; ≥ 2/5 users with failure → 3; blocks most users, irreversible harm, or silent failure → 4. Rate independently with 2+ team members, then discuss gaps of ≥ 2 points.

## Observation log and synthesis
Log one observation per row during/after each session:

| Session | Task | Time | Observation (what happened) | Quote | Tag |
|---|---|---|---|---|---|
| P3 | T2 | 12:40 | Opened Settings > Billing looking for users | "Users must be under billing?" | navigation, IA |

Synthesis: group by task, then by problem; count participants per problem (n/N); merge duplicates; write each finding as "[who] [does what] because [likely cause]". Debrief with observers within 24 h.

## Findings report (full template)
```markdown
# Usability findings: [feature] - Round [n]
## Summary (one screen)
- Top 3 problems with severity and n/N
- Hypotheses: H1 supported / not supported (evidence)
- Recommendation: ship / fix 3s and 4s then ship / redesign and retest
## Study details
Method, dates, participants (N per segment, roles, company sizes), prototype version, tasks
## Task results
Table: task, full/partial/fail, rate (95% CI), median time, SEQ, notes
SUS / UMUX-Lite with benchmark and previous round
## Findings (most severe first)
For each: severity, title, n/N, what happened, why (likely cause), evidence (quote + clip link + timestamp), screen, recommendation, owner/ticket
## What worked well (keep these)
## Accessibility findings (WCAG criterion)
## Limitations and open questions
## Next steps / next round
```

## Clips, quotes, and readouts
- One 15-45 s clip per severity 3-4 finding; show the struggle, not the explanation afterwards.
- Quote verbatim, attributed to P-number and role ("P4, finance admin"); remove names, company names, and customer data; blur screens showing real records.
- Readout: 30 min, top findings + clips first, then recommendations; invite engineering and CS. End with decisions and owners, logged as tickets with severity labels.

## Common mistakes
- Reporting "80% success" from 4/5 participants without an interval.
- Treating "I like it" as evidence of usability.
- Fixing only what the loudest participant said rather than what most did.
- Counting moderator-assisted completions as success.
- Mixing roles in one sample of five, then concluding about all roles.
- Changing the prototype mid-round without noting which participants saw which version.
