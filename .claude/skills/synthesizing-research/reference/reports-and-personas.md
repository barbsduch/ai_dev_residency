# Reports, readouts, personas and repository

## Contents
- Research report template
- Readout deck outline
- Insight card template
- Persona vs archetype
- Archetype template
- Enterprise role set
- Research repository nuggets
- Worked example

## Research report template

```markdown
# [Study name] - research report
**Decision informed:** [decision] · **Owner:** [role] · **Researcher:** [name]
**Method:** [method], N=[n] ([segments with counts]) · **Guide version(s):** [v1, v2]

## TL;DR (3-5 bullets)
- [Most important insight + recommendation]

## Background and research questions
- Why we ran this; what we already knew; RQ1-RQ3

## Who we talked to
| Segment | n | Company size | Customer status |
|---|---|---|---|

## Key insights
For each insight: statement (who, what, why, implication) · evidence n/N by segment
· 1-2 quotes · didn't fit · confidence · recommendation · owner

## Opportunities and priority
| HMW | Impact | Freq | Severity | Score | Recommendation |
|---|---|---|---|---|---|

## Personas / archetypes / JTBD (if in scope)

## Surprises and disconfirmed assumptions
## Limitations (sample, recruiting bias, method, guide changes)
## Open questions and next steps
## Appendix: participant table, codebook, guide, raw data location
```

Length guide: TL;DR readable in 1 minute; full report under 10 pages; anything longer goes in the appendix or repository.

## Readout deck outline
Target 10-14 slides, 30 minutes: 15 minutes presenting, 15 minutes discussing decisions.

1. Title: study, timeframe, researcher
2. The decision we need to make (one sentence)
3. TL;DR: 3 headline insights and the recommendation
4. Who we talked to (segment table, no names)
5-9. One insight per slide: headline as a full sentence, n/N, one quote or 30-second clip, implication
10. What surprised us / what we were wrong about
11. Opportunities ranked by score (table)
12. Recommendations with owners and next steps
13. Limitations and open questions
14. Discussion: decisions to make today

Slide rules: headline states the finding, not the topic ("Admins check bulk changes in Excel because there's no preview", not "Bulk editing"). One idea per slide. Quotes attributed as "Admin, 2,000-seat fintech", never by name. Invite PM, engineering, design, CS, sales and support; send the deck 24 hours ahead to decision makers.

## Insight card template
For FigJam, Notion, Dovetail or a wall.

```
INSIGHT #[n] · [Theme]
[Who] [does/experiences what] because [why], which means [implication].
Evidence: [segment] [n/N] · [segment] [n/N]
Quote: "[verbatim]" - P[#], [role]
Didn't fit: [who and why]
Confidence: High / Medium / Low - [reason]
HMW: [question]
Priority: I[x] F[x] S[x] = [score]
Source: [study], [sessions], [repository link]
```

## Persona vs archetype
- **Archetype:** a behavioral pattern (goals, behaviors, pain points, context) with no fictional biography. Preferred for enterprise work; easier to keep honest and to reuse across accounts.
- **Persona:** an archetype with a name, photo and story. Use only when the team needs empathy anchors, and only when every attribute is backed by data.
- Build from behavioral variables, not demographics: plot each participant on 4-8 behavioral spectrums (e.g. "configures once vs. changes weekly", "works alone vs. coordinates many teams"), then look for participants who cluster together. Each cluster with 3+ participants is a candidate archetype.
- Minimum evidence: 8-12 interviews per role for a first version; mark as provisional below that.
- Review yearly or when the product or market shifts.

## Archetype template

```markdown
## [Archetype name: a behavior, e.g. "The Cautious Bulk Admin"]
**Role:** Admin · **Seen in:** 6/9 admins (P1, P3, P4, P5, P7, P9) · **Confidence:** High

**Context:** Manages access for 500-5,000 users; reports to IT; audited yearly.
**Goals:** Make changes without breaking anyone's access; prove changes to auditors.
**Key behaviors:** Exports before every bulk change; keeps a personal change log in a spreadsheet; schedules changes for Friday evenings.
**Pain points:** No preview of bulk changes; audit log lacks "before" values.
**Jobs to be done:** When a reorg happens, I want to move hundreds of users between roles safely, so I can avoid support tickets on Monday.
**Tools:** [product], Excel, Okta, ServiceNow
**Quote:** "I never trust it the first time."
**What would change their behavior:** Visible preview and undo.
**Design implications:** Previews and reversible actions in admin flows; exportable audit evidence.
**Evidence source:** [study, repository link]
```

## Enterprise role set
Check every synthesis against the four core roles; note when a role was not studied.

| Role | Typical goals | Typical evidence sources |
|---|---|---|
| End user | Get daily work done fast, avoid errors | Interviews, usability tests, analytics |
| Admin | Control access, keep things safe, reduce tickets | Admin interviews, support tickets, audit logs |
| Buyer / decision maker | Prove ROI, reduce risk, adoption across teams | Sales call notes, win/loss interviews |
| IT / security approver | Compliance, SSO, data protection, vendor risk | Security questionnaires, procurement interviews |

## Research repository nuggets
A nugget is the smallest reusable unit: one observation or insight with evidence, tagged for search.

```
Title: Admins export data before bulk changes to check them
Type: Insight | Observation | Quote | Clip
Study: [name] · Timeframe: [range] · Method: Interviews N=12
Roles: Admin · Segment: 1,000+ seats · Product area: User management
Tags: Workaround, Trust/verification, Bulk edit
Evidence: 7/9 admins · Clip: Session 4, 12:40-13:15
Confidence: High
Status: Active | Superseded by [link] | Archived
Linked decisions: [Jira epic or decision record]
```
Rules: use the same tag names as the codebook; one nugget per insight; link to raw data, never paste personal data; mark superseded nuggets instead of deleting them; delete raw recordings on the retention schedule agreed in consent.

## Worked example
**Study:** Bulk user management, 12 interviews (9 admins, 3 end users), 45 min each.

**Atomic notes (sample):** "P1 · Admin · exports to CSV before every bulk change · S1 08:12" · "P5 · Admin · broke 200 accounts with one bulk role change last quarter · S5 21:30" · "P2 · Admin · tests changes in a sandbox workspace first · S2 15:05" · "P10 · End user · lost access for 2 days after reorg · S10 06:40".

**Cluster:** "I don't trust a bulk change until I've checked it myself" (P1, P3, P4, P5, P7, P9, P11 - 7 participants, all admins except P11).

**Insight:** Admins verify bulk changes outside the product because there's no preview of who will be affected, which makes reorgs slow and leaves end users without access. Evidence: Admins 6/9 · End users 1/3 (lost access). Quote: "I export first so I can check nothing breaks." - P4, Admin. Didn't fit: P2 uses a sandbox. Confidence: High (observed screen-share behavior, matches 23 support tickets on bulk role errors last quarter).

**JTBD:** When a reorg happens, I want to move hundreds of users between roles safely, so I can avoid Monday morning access tickets.

**HMW:** help admins confirm a bulk change is safe before it applies? Score I3 x F3 x S3 = 27 → act now.

**Opportunity solution tree branch:** Outcome "reduce bulk-change support tickets by 50%" → opportunity "admins can't predict the effect of bulk changes" → solutions "preview affected users", "undo within 24 hours" → test "5 admins complete a reorg task with preview prototype; success rate and SEQ".

**Recommendation:** Prototype preview and undo for bulk role changes; usability test with 5 admins. Owner: PM User Management. Decision: include in next quarter's admin roadmap.
