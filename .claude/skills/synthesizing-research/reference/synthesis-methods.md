# Synthesis methods

## Contents
- Data prep
- Tagging codebook
- Atomic observation format
- Affinity mapping
- Thematic analysis
- Observation, interpretation, recommendation
- Insight statements: good vs bad
- Jobs-to-be-done statements
- How Might We statements
- Prioritization scoring
- Opportunity solution tree
- Combining qualitative and quantitative sources
- Common mistakes

## Data prep
1. Collect every source in one place: transcripts, note grids, session recordings, survey open-ends, support tickets, sales call notes.
2. Pseudonymize first: replace names with P# and role ("P4 · Admin · 2,000 seats · fintech"); remove emails, company names and customer data from screenshots.
3. Build a participant table: P#, role, segment, company size, customer status, guide version, date. Synthesis uses it to count n/N per segment.
4. Note gaps: missing sessions, guide changes between versions, sessions where recording failed.
5. Read or watch each session once before tagging. Write a 5-line session summary (goals, workflow, top pains, workarounds, surprises).

## Tagging codebook
Keep 15-30 codes. Deductive codes come from the research questions; inductive codes are added as patterns appear. Review the codebook after the first 3 sessions and merge or split codes.

| Code | Definition | Include | Exclude | Example |
|---|---|---|---|---|
| Workaround | Participant uses another tool or manual step to compensate for a gap | Exports, spreadsheets, scripts, asking a colleague | Normal use of integrated tools | "I copy it into Excel to check." |
| Trust / verification | Participant checks or doubts system output | Double-checking, re-running, screenshots as proof | General dislike | "I never trust it the first time." |
| Permission friction | Access, roles or approvals block or slow work | Waiting for access, asking admin | Login failures (tag Auth) | "I had to ping IT for two days." |
| Compliance pressure | Audit, security, legal requirements shape behavior | Audit prep, evidence, retention | Generic security opinions | "Auditors want a log of every change." |

Type tags (apply one per note): Behavior, Pain, Workaround, Goal, Tool, Quote, Request, Surprise.
Tool-ready: in Dovetail, Notion or a spreadsheet, codes become tags; keep names identical across studies so the repository stays searchable.

## Atomic observation format
`[P#] · [role] · [one fact: what they said or did] · [source + timestamp] · [type] · [codes]`

- Good: "P3 · Admin · exports user list to CSV before every bulk change · Session 3, 12:40 · Workaround · Trust/verification"
- Bad: "P3 doesn't like bulk edit and wants a preview and better errors" (interpretation, three ideas, solution baked in)

## Affinity mapping
1. Put all atomic notes on the board, color-coded by role (e.g. yellow end user, blue admin, green buyer, pink IT/security).
2. Silently cluster notes that mean similar things. Ignore which question produced them.
3. Name each cluster as a first-person sentence ("I need proof the change worked before I tell my manager").
4. Group clusters into 5-8 themes; name themes as statements, not one-word labels.
5. Check color mix inside each cluster: single-color clusters are role-specific insights.
6. Park orphans in "Other observations"; revisit at the end.
7. Count unique participants per cluster (not notes); one talkative participant does not make a pattern.

## Thematic analysis
For larger or mixed datasets (20+ interviews, open-ended survey answers), use Braun and Clarke's six phases:
1. Familiarize: read everything, write session summaries.
2. Generate initial codes across the full dataset.
3. Search for themes: group codes into candidate themes.
4. Review themes: check against coded extracts and the whole dataset; merge, split or drop.
5. Define and name themes: one-paragraph definition each, with scope.
6. Write up: themes with evidence, quotes and counts.
Use two coders on at least 20% of the data when the decision is high-stakes; discuss and resolve disagreements, then update the codebook.

## Observation, interpretation, recommendation

| Layer | Question it answers | Example |
|---|---|---|
| Observation | What did we see or hear? | 7/9 admins exported data before bulk changes. |
| Interpretation | Why, and what does it mean? | Admins lack confidence the change will do what they expect. |
| Recommendation | What should we do? | Explore a preview of affected records; test with 5 admins. |

Rule: if a sentence contains "should", it is a recommendation. If it contains "because" or "means", it is interpretation. Keep them in separate columns.

## Insight statements: good vs bad
Formula: **[Who] [does/experiences what] because [why], which means [implication].** Plus n/N, quote, didn't fit, confidence.

| Bad | Problem | Good |
|---|---|---|
| Users want a dashboard. | Feature request, no who, no why | Managers rebuild the same weekly report by hand because they cannot save filters, which costs about an hour a week and delays team reviews. (Managers 5/6) |
| Onboarding is confusing. | Vague, no evidence | New end users skip workspace setup because the first screen asks for settings only admins know, so 4/7 started with an empty, unusable workspace. |
| 60% of users hate exports. | Percentage from N=10, presumed emotion | 6/10 participants exported data weekly to combine it with finance data, because there is no integration with their ERP. |

## Jobs-to-be-done statements
Job story: **When [situation], I want to [motivation], so I can [expected outcome].**
- Good: "When a new team joins mid-quarter, I want to give everyone the right access in one step, so I can avoid a week of access requests."
- Bad: "As an admin, I want a bulk-role button." (solution, no situation)

Also capture: functional job (get the task done), emotional job (feel confident, avoid blame), social job (look competent to the manager or auditor). Enterprise buyers often have an additional job: "justify the purchase to finance and security".

## How Might We statements
- Start from one insight. Keep the user and the tension.
- Not too broad ("HMW improve admin UX?"), not too narrow ("HMW add a preview button?").
- Good: "HMW help admins confirm a bulk change is safe before it applies?"
- Generate 3-5 HMWs per top insight, then pick the one that opens the most solution directions.

## Prioritization scoring
Score 1-3 on each dimension; priority = Impact x Frequency x Severity (1-27).

| Score | Impact | Frequency | Severity |
|---|---|---|---|
| 3 | Affects revenue, renewal, compliance or a key metric | Most participants, or weekly+ | Blocks the task or causes data loss/errors |
| 2 | Affects a core workflow for one segment | Several participants, or monthly | Slows the task, needs a workaround |
| 1 | Nice to improve | Few participants, rare | Annoyance, cosmetic |

Bands: 18-27 act now · 8-17 plan for next cycle · 1-7 monitor. Break ties with confidence level and effort estimate from engineering. Show the scoring table in the report so stakeholders can challenge it.

## Opportunity solution tree
Teresa Torres' structure, outcome at the top:

```
Outcome: Reduce time for admins to provision a new team (median 3 days -> 1 day)
├── Opportunity: Admins don't trust bulk changes (Insight 1, score 18)
│   ├── Solution: Preview affected users before apply
│   │   └── Assumption test: 5 admins complete bulk change with preview prototype
│   └── Solution: Undo bulk change within 24 hours
├── Opportunity: Role definitions don't match real job functions (Insight 3, score 12)
│   └── Solution: Role templates by department
└── Opportunity: Access requests arrive through email and chat (Insight 4, score 9)
```
Rules: outcomes are measurable; opportunities are user needs from insights (not features); each solution has at least one assumption test.

## Combining qualitative and quantitative sources
- Use analytics, support tickets or survey data to size a qualitative pattern ("7/9 admins export first; analytics show 68% of bulk edits are preceded by an export").
- Treat a qualitative pattern confirmed by a second source as one confidence level higher.
- Where sources disagree, report both and propose a follow-up study.

## Common mistakes
- Clustering by interview question instead of meaning.
- Counting notes instead of participants.
- Treating feature requests as insights.
- Dropping the one segment that disagrees.
- Presenting stakeholder hypotheses as findings.
- Writing themes as single words ("Trust", "Speed").
