# Synthesis and reporting

## Contents
- Synthesis procedure
- Insight format and quality bar
- Prioritizing findings
- Usability findings table
- Report template (full)
- Persona template
- Competitive analysis matrix
- Anonymization checklist

## Synthesis procedure
1. **Capture**: within 24 h, turn notes/transcripts into atomic observations - one fact per note, tagged with participant ID (P3), segment, and source (timestamp).
   - Observation: "P3 exports the user list to Excel before every bulk role change (12:40)."
   - Not: "Users don't trust bulk edit." (that's an interpretation)
2. **Cluster (affinity mapping)**: group bottom-up by similarity, not by pre-set categories or your guide's sections. Split clusters with > ~15 notes; merge near-duplicates.
3. **Name themes** as full sentences describing user behavior or need, not labels ("Admins verify changes outside the product" not "Trust").
4. **Write insights** (format below): theme + why it matters + evidence.
5. **Count and challenge**: tally n/N per insight and per segment; actively search for disconfirming notes; downgrade confidence if found.
6. **Recommend**: link each insight to the original decision; separate "what we learned" from "what we suggest".
7. **Review**: a second person checks that every insight traces to observations (peer debrief). Fix any claim without evidence.

## Insight format and quality bar
```
Insight: [Who] [does/needs/struggles with what] because [underlying reason],
         which means [consequence for them / the business].
Evidence: n/N participants ([segments]); "[representative quote]" - P#; [clip/timestamp]
Counter-evidence: [what didn't fit]
Confidence: High / Medium / Low
Implication: [decision or design direction]
```
Quality bar - an insight is:
- **Grounded**: traceable to multiple observations.
- **Non-obvious**: explains *why*, not just *what*.
- **Actionable**: suggests a direction for the decision at hand.
- **Scoped**: names which segment it applies to.

Never report qualitative counts as percentages (say "7 of 9", not "78%").

## Prioritizing findings
Score each finding: **Frequency** (n/N) × **Impact** (blocks task / causes error / annoyance) × **Business reach** (segment size or revenue). Use the same 0–4 severity scale as heuristic reviews for usability issues:
- 4 – blocks task or causes data loss, any participant
- 3 – significant delay or error for most participants
- 2 – minor delay, recovered without help
- 1 – cosmetic / preference

## Usability findings table
| # | Severity | Task | Finding | n/N | Evidence | Recommendation |
|---|----------|------|---------|-----|----------|----------------|
| 1 | 4 | T2 Create filter | Users don't find "Add filter" hidden under ⋯ menu | 4/5 failed | P2: "I'd expect it by the search." | Show "Filters" button next to search |

Task metrics summary: success rate per task with n/N, median time, mean SEQ; overall SUS with 90% confidence interval when N ≥ 20.

## Report template (full)
```markdown
# [Study name] - research report
**Date:** · **Researchers:** · **Decision informed:** · **Owner:**

## TL;DR (≤ 5 bullets)
- Top insight + recommendation
- ...

## Background and research questions
## Method
- Method, N, segments, recruiting source, dates, moderated/unmoderated
- Screener criteria; incentive
## Key insights (most important first)
[insight blocks using the insight format]
## Usability findings (if applicable)
[findings table + task metrics]
## Recommendations
| Recommendation | Insight(s) | Effort | Owner |
## What we didn't learn / limitations
## Appendix: guide, tasks, screener, participant table (pseudonymized), raw data link
```
Keep the TL;DR readable in 1 minute; link a 2–3 minute highlight reel of clips (with consent).

## Persona template
Build personas only from research data (≥ 2 studies or ≥ 12 participants); cluster on behaviors and goals, not demographics. Prefer a role name over a fake human name for B2B.
```markdown
## [Role-based name, e.g. "The Compliance Admin"]
**Based on:** [studies, N participants, segments] · **Share of users:** [from analytics/survey]
**Context:** company size, team, tools used alongside ours, frequency of use
**Goals / jobs:** When…, I want to…, so I can… (2–3)
**Key behaviors:** [observed, with n/N]
**Pain points:** [observed, with representative quote]
**Decision role:** buyer / admin / end user / influencer
**What success looks like:** [measurable outcome]
**Design implications:** [3 bullets]
```
Review personas yearly or when the customer base shifts; mark assumptions explicitly.

## Competitive analysis matrix
Compare against 3–6 alternatives, including the non-product alternative (spreadsheets, email, doing nothing).

| Dimension | Us | Competitor A | Competitor B | Spreadsheet/manual |
|-----------|----|--------------|--------------|--------------------|
| Target segment / job | | | | |
| Core task flow (steps to complete [task]) | 7 steps | 4 steps | | |
| Key differentiating features | | | | |
| Enterprise needs (SSO, roles, audit log, API) | | | | |
| Pricing model / entry price | | | | |
| Onboarding (time to first value) | | | | |
| UX strengths | | | | |
| UX weaknesses | | | | |
| Evidence source | trial, docs, reviews, interviews | | | |

Procedure: define the job and 3–5 key tasks → do a hands-on walkthrough of each competitor (screenshots, step counts) → mine public reviews (G2, Capterra) for recurring themes → summarize opportunities as "Where we can win" and "Table stakes we're missing". Cite sources; avoid claims not verified hands-on.

## Anonymization checklist
- [ ] Participant IDs (P1…) replace names; key file stored separately with restricted access.
- [ ] Remove/blur names, emails, phone numbers, company names, customer data in screenshots and clips.
- [ ] Quotes edited only to remove identifiers ("[company]"); meaning unchanged.
- [ ] Small-segment combinations that could re-identify someone (e.g. "only CFO at a 50-person fintech") generalized.
- [ ] Recordings deleted per the consent retention period; access logged.
- [ ] Raw data not shared outside the research team without consent and legal review.
