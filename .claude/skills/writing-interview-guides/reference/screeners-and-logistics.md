# Screeners and logistics

## Contents
- Screener rules
- Screener template
- Enterprise roles and quotas
- Recruiting channels and incentives
- Consent script
- Session intro script
- Note-taking grid
- Pilot interview procedure
- Dry-run checklist
- Guide versioning

## Screener rules
- Screen on recent behavior with a timeframe ("in the last 30 days"), not job title or self-described expertise.
- Use multiple-choice answers with distractors so the correct answer is not obvious. Never show which answer qualifies.
- Put disqualifiers first to save participants' time.
- Ask frequency as ranges ("Never / 1-2 times / 3-5 times / 6+ times"), not yes/no.
- Include one open articulation question ("Briefly describe the last time you did X") to filter out professional testers and low-effort answers.
- Keep it under 10 questions and about 3 minutes.
- Define quotas per segment before recruiting and track them in a recruit tracker.

## Screener template

```markdown
## Screener: [study] · target [n] per segment + 20% over-recruit

Q1. Do you or does anyone in your household work in any of these? (Select all)
    [ ] Market research or UX  -> DISQUALIFY
    [ ] [Our company] or a direct competitor  -> DISQUALIFY
    [ ] Software sales  [ ] Healthcare  [ ] Finance  [ ] None of these
Q2. Which best describes your company size?
    [ ] 1-49  -> DISQUALIFY (if enterprise study)  [ ] 50-499  [ ] 500-4,999  [ ] 5,000+
Q3. In the last 30 days, which of these have you done? (Select all)
    [ ] [Target behavior]  -> REQUIRED
    [ ] [Distractor behavior]  [ ] [Distractor behavior]  [ ] None
Q4. How many times in the last 30 days did you [target behavior]?
    [ ] 0 -> DISQUALIFY  [ ] 1-2  [ ] 3-5  [ ] 6+   (quota: at least half 3+)
Q5. Which best describes your involvement with [product category]?
    [ ] I use it day to day  -> End user quota
    [ ] I configure it or manage access for others  -> Admin quota
    [ ] I decide or approve what we buy  -> Buyer quota
    [ ] I review tools for security or compliance  -> IT/security quota
Q6. Have you taken part in a research study in the last 6 months?
    [ ] Yes -> DISQUALIFY if more than 2  [ ] No
Q7. (Open) Briefly describe the last time you [target behavior].
    -> DISQUALIFY if vague, off-topic, or under ~15 words
Q8. Are you comfortable sharing your screen on a video call? (Recording consent is collected separately.)
    [ ] Yes  [ ] No -> DISQUALIFY if screen share is required
```

## Enterprise roles and quotas

| Role | Screen on | Typical quota (per round) | Notes |
|---|---|---|---|
| End user | Did the core task in last 30 days | 6-8 | Mix of light (1-2x) and heavy (6+) users |
| Admin | Changed settings or permissions in last 90 days | 5-6 | Include at least 2 from accounts with SSO |
| Buyer / decision maker | Approved or evaluated a purchase in last 12 months | 4-6 | Often hardest to recruit; allow 30 min |
| IT / security approver | Reviewed a vendor in last 12 months | 3-5 | Ask about questionnaires, SOC 2, DPA |

Also set quotas for: company size, industry (regulated vs not), customer vs non-customer vs churned, region. Cap participants from any single account at 2 so one customer does not dominate.

## Recruiting channels and incentives
- **Existing customers:** via CS or account managers; get account owner sign-off; avoid accounts in renewal negotiation or with open escalations.
- **Prospects and non-customers:** panel vendors with B2B targeting, LinkedIn outreach, communities.
- **Churned customers:** high value for "why did you leave"; recruit through a neutral email, not sales.
- **Incentives:** pay fairly for professional time; senior roles need higher amounts or a charity donation option. Some enterprise customers and public-sector participants cannot accept gifts - offer a donation instead and check policy.
- No-show rate: plan for 15-20% in B2B; confirm 24 hours before with the link and agenda.

## Consent script
Read aloud before recording starts; also send the written version in advance.

```
Thanks for joining. Before we start, a few things:
- I'm [name], a researcher at [company]. [Name] is here to take notes.
- We're learning how people [topic] so we can improve [product area].
  There are no right or wrong answers, and I didn't build what we'll
  talk about, so you won't hurt my feelings.
- This session is about [45] minutes.
- With your permission, we'll record audio, video and screen. Recordings
  are used only by our product team, stored in [location], and deleted
  after [retention period]. Quotes will be anonymized; your name and
  company will not be shared outside the research team.
- Please don't show customer data or personal information on screen.
  If that happens, I'll pause the recording.
- You can skip any question, pause, or stop at any time, and you can ask
  us to delete your data later by contacting [email].
- Do I have your permission to record? [Wait for a clear "yes" -> start
  recording -> ask them to confirm consent again on the recording.]
```

## Session intro script
After consent: "I'll mostly ask about what you've actually done recently. Please think out loud and be as specific as you can - real examples are the most helpful. If a question doesn't make sense, tell me; that's my fault, not yours."

## Note-taking grid
One row per observation. Use participant IDs only.

| Time | P# | Objective | Q# | Observation (what they said or did) | Quote (verbatim) | Type | Follow-up |
|---|---|---|---|---|---|---|---|
| 12:40 | P3 | O2 | 5 | Exports user list to CSV before every bulk change | "I never trust it the first time." | Workaround | Ask to see the CSV |

Type tags: Behavior, Pain, Workaround, Goal, Tool, Quote, Feature request, Surprise.
Rules: write what happened, not your interpretation; mark interpretations with "[I]"; capture exact quotes in quotation marks; note timestamps for clips.

**Debrief (within 1 hour, 10 minutes):** top 3 surprises · what confirmed or contradicted assumptions · questions that didn't land · what to change for the next session.

## Pilot interview procedure
1. Recruit one person who matches the screener (a colleague in a similar role is acceptable only if no participant is available; note the limitation).
2. Run the full guide at real length with recording, a note-taker and the real tools.
3. After the session, ask the pilot participant: Which questions were confusing? Where did you feel steered? What did you expect us to ask that we didn't?
4. Mark each question: worked / misunderstood / yes-no answer / leading / ran long / redundant.
5. Compare actual section times with the time budget; cut nice-to-haves until must-asks fit in 70% of the session.
6. Revise, re-run the bias audit on changed questions, and bump the guide version. If more than two questions changed, pilot again.

## Dry-run checklist

```
Dry run (day before first session):
- [ ] Guide final version shared with moderator, note-taker and observers
- [ ] Consent form sent and signed; recording consent script printed
- [ ] Video link tested; recording and transcription on; storage location set
- [ ] Screen share works for the participant's likely setup (browser, VPN)
- [ ] Test or demo account ready if showing artifacts (no real customer data)
- [ ] Note-taking grid set up with participant ID and objectives
- [ ] Observer channel created; observer rules sent (muted, camera off)
- [ ] Incentive process ready; participant confirmed with time zone
- [ ] Backup plan: phone dial-in, second moderator, spare time slot
```

## Guide versioning
Name files "[study]-guide-v1", "v2"... Keep a change log line per version ("v2: split Q4, cut Q9, moved budget questions to end"). Note which participants saw which version so synthesis can account for changes.
