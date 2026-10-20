# Research methods, sample sizes, and scripts

## Contents
- Method selection matrix
- Sample size guide
- Recruiting and screener
- Consent template
- Interview guide (template)
- Jobs to be done (switch interview)
- Usability test script and metrics
- Survey design rules
- Question rewrites (leading → neutral)

## Method selection matrix
| Question type | Method | Data | Typical N | Stage |
|---------------|--------|------|-----------|-------|
| What problems/needs exist? Why? | Generative interviews, contextual inquiry | Qual, attitudinal + observed | 6–12 per segment | Discovery |
| What job is the product hired for? | JTBD switch interviews | Qual | 8–12 | Discovery |
| Can users complete key tasks? | Moderated usability test | Qual + light quant | 5 per segment per round | Design/iterate |
| How does usability compare / benchmark? | Unmoderated usability benchmark | Quant (success, time, SUS) | 20–40 per segment | Pre/post release |
| How should content be organized? | Open/closed card sort; tree test | Quant + qual | 15–30 (card sort), 50+ (tree test) | IA |
| How many users have X / prefer Y? | Survey | Quant attitudinal | 100+; ~385 for ±5% | Validate/size |
| What do users actually do? | Product analytics, funnels, session replay | Quant behavioral | All users | Any |
| Which design performs better? | A/B test | Quant behavioral | Power analysis | Optimize |
| How do we compare to alternatives? | Competitive analysis / teardown | Qual | 3–6 competitors | Strategy |
| What's breaking day to day? | Support ticket / sales-note analysis | Qual + counts | 50–200 tickets | Any |

Rule of thumb: qualitative tells you *why*; quantitative tells you *how many*. Pair one of each for high-stakes decisions (triangulation).

## Sample size guide
- **Usability (find problems)**: 5 users find ~85% of problems affecting ≥ 31% of users; run 3 rounds of 5 rather than 1 of 15.
- **Interviews**: stop at saturation (2–3 consecutive sessions with no new themes); typically 6–12 per segment.
- **Benchmark metrics**: ≥ 20 per segment for meaningful confidence intervals; report intervals, not just means.
- **Surveys**: margin of error ≈ 1/√N (N=100 → ±10%, N=400 → ±5%, N=1,000 → ±3%) at 95% confidence; plan for 10–30% B2B response rates.

## Recruiting and screener
- Sources: in-app intercept, customer success contacts, user panels, recruiting agencies for non-customers.
- Segment B2B participants by role (buyer, admin, end user), company size, plan, tenure, and usage frequency.
- Screener questions are behavioral and non-revealing (don't tell them which answer qualifies):
  - "In the last 30 days, which of these have you done? (select all)" - include the target action among distractors.
  - "How many people at your company use [category] tools?" - ranges.
- Over-recruit by 20% for no-shows. Incentive: market rate for role seniority; check customer gift policies (some forbid cash incentives).
- Exclude: employees, people researched in the last 6 months, competitors' staff.

## Consent template
```
Purpose: help [Company] improve [product area]. Session length: [45] min.
Recording: [audio/video/screen] used only by the research team; stored in [location];
deleted after [12 months]. Quotes may be shared internally without your name or company.
Participation is voluntary; you can skip questions, stop at any time, and ask us to delete your data.
Incentive: [amount] regardless of what you say or whether you finish.
[ ] I agree to take part   [ ] I agree to be recorded   Name / date
```
Ask participants to close confidential data before screen sharing; pause recording if it appears.

## Interview guide (template)
```
Intro (5 min): thanks, purpose, no right answers, we're testing ideas not you, consent check, recording on.
Warm-up (5 min): "Tell me about your role and a typical week." "Where does [domain] fit in?"
Core - past behavior (25 min):
  "Tell me about the last time you [did the task]. Walk me through it from the start."
  "What happened just before that?" "What did you do next?" "Who else was involved?"
  "What was the hardest part?" "Why was that difficult?" "How did you work around it?"
  "Show me (screen share) how you did that." "What tools/spreadsheets did you use?"
  "What did that cost you - time, errors, escalations?"
Probes: "Tell me more about that." "Why?" "Can you give an example?" "What do you mean by …?"
        Echo their last words. Wait 5+ seconds of silence.
Wrap-up (5 min): "If you could change one thing about how you do this, what would it be?"
                 "Anything I should have asked?" Thank, incentive, next steps.
```
Interviewer rules: one question at a time; don't pitch or defend the product; note exact words; capture artifacts (screenshots of workarounds, with permission).

## Jobs to be done (switch interview)
Timeline the most recent switch or purchase: **first thought → passive looking → active looking → deciding → first use → ongoing use**. Probe the four forces:
- **Push** of the current situation ("What was going wrong?")
- **Pull** of the new solution ("What did you hope would be different?")
- **Anxiety** of the new ("What almost stopped you?")
- **Habit** of the present ("What did you keep doing the old way?")

Job statement: *When [situation], I want to [motivation], so I can [expected outcome].*
Example: "When quarter-end closes, I want to reconcile invoices against payments in one place, so I can sign off without chasing three teams."

## Usability test script and metrics
```
Setup: realistic test account with seeded data; prototype or staging; tasks in random order where possible.
Intro: "We're testing the product, not you. Please think aloud - say what you're looking for and thinking."
Task card format: scenario + goal, no UI words.
  BAD:  "Click Reports and create a filter."
  GOOD: "Your manager wants to know which customers had overdue invoices last month. Find that out."
After each task: SEQ - "Overall, how difficult or easy was this task?" 1 (very difficult) – 7 (very easy).
Neutral prompts: "What are you thinking?" "What would you do next?" Answer questions with "What would you expect?"
End: SUS questionnaire; "What was most frustrating?" "What, if anything, stood out positively?"
```
| Metric | Definition | Benchmark |
|--------|-----------|-----------|
| Task success | Completed without assistance (binary or 0/0.5/1 partial) | ~78% average across studies |
| Time on task | Successful attempts only; report median/geometric mean | Compare against expert time or prior version |
| Errors | Wrong paths, slips, recoveries | Count + describe |
| SEQ | Single 7-point ease question per task | Average ≈ 5.5 |
| SUS | 10 items, 5-point; score 0–100 | 68 = average; ≥ 80 good; < 50 poor |

SUS scoring: odd items (score − 1), even items (5 − score); sum × 2.5.

## Survey design rules
- Every question maps to a research question; target ≤ 10 minutes (≈ 15–20 questions).
- One concept per question (no double-barreled "fast and reliable").
- Balanced scales with labelled endpoints and a neutral midpoint; same direction throughout; add "Not applicable" / "Don't know".
- Avoid leading/loaded wording, absolutes ("always/never"), and jargon.
- Randomize option order (except ordinal scales); put demographics and sensitive items last.
- Mutually exclusive, exhaustive ranges (0, 1–5, 6–20, 21+).
- Ask behavior frequency, not intent ("In the last month how often did you…").
- Include an attention check for panels; pilot with 3–5 people; report response rate and who didn't respond (non-response bias).
- NPS: report distribution and the follow-up "why", not just the score.

## Question rewrites (leading → neutral)
| Leading | Neutral |
|---------|---------|
| Would you use a dashboard builder? | Tell me about the last time you needed a view the reports didn't give you. |
| How much do you love the new editor? | How would you describe your experience with the editor? |
| Don't you think exports are slow? | Tell me about the last time you exported data. |
| Was it easy to find settings? | What was that like? (then SEQ) |
| Which features would you pay more for? | What have you done when the product couldn't do something you needed? |
