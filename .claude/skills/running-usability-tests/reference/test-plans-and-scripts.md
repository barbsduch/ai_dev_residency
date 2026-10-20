# Test plans, tasks, and scripts

## Contents
- Test plan template
- Screener template
- Writing scenario tasks (good vs. bad)
- Success criteria per task
- Moderated script (full)
- Think-aloud and neutral probes
- Unmoderated setup (Maze, UserTesting, Lookback)
- Post-task and post-test questionnaires (SEQ, SUS, UMUX-Lite)

## Test plan template
```markdown
# Usability test plan: [feature] - Round [n]
**Decision this informs:** [ship / change / choose between] · **Owner:** [PM/designer] · **Readout:** [date]
**Background:** what we know, what changed since last round
**Research questions:** 1. Can [role] complete [task] without help? 2. Where do they hesitate or err? 3. ...
**Hypotheses:** H1 "≥ 4/5 admins find bulk role change within 2 min." H2 "Nobody confuses Remove role with Delete user."
**Method:** moderated remote think-aloud · 45-60 min · Figma prototype v[n]
**Participants:** 5 per segment: [End users] [Admins]; screener below; incentive per company policy
**Tasks:** T1-T6 with success criteria and time limits (table)
**Metrics:** success (full/partial/fail), time on task, errors, SEQ per task, SUS or UMUX-Lite at end
**Observers:** PM, engineer, CS rep - observers stay muted, post questions in a back channel
**Data handling:** consent form, recordings stored in [repo], deleted after [retention], participants as P1-Pn
**Risks:** prototype dead-ends, recruitment through customers (NDA), sales-sensitive accounts
```

## Screener template
Screen on behavior and role, not titles. Disqualify employees, competitors, and anyone tested in the last 3 months.
1. Which of these have you done at work in the last 30 days? (multi-select; must include "Approved an expense report")
2. Which best describes your role in [product]? End user / Admin who manages users and settings / Buyer / IT or security reviewer
3. How many people does your organization have? (mix sizes; enterprise studies need ≥ 2 accounts with 1,000+)
4. How often do you use [product or competitor]? Daily / Weekly / Monthly / Never
5. Do you use any assistive technology (screen reader, magnifier, voice control)? (recruit at least one when testing a release)

## Writing scenario tasks (good vs. bad)
A good task = motivation + goal + end state, in the user's words, with realistic data to use.

| Bad (instruction, leading) | Why | Good (scenario) |
|---|---|---|
| "Click Filters and filter by Overdue." | Names UI, gives the path | "Your CFO wants to know which customers owe money past the due date. Find them." |
| "Use the Export button to download the report." | Names the button | "You need this quarter's numbers in a spreadsheet for tomorrow's board pack. Get them." |
| "Go to Settings > Users and add a user." | Gives the path | "Priya joins your team on Monday. Make sure she can log in and see the Sales workspace." |
| "Do you like the new dashboard?" | Opinion, not a task | "Your manager asks how the team did last month. Using this screen, tell me." |
| "Explore the page." | No end state | "Find out whether any of your integrations stopped working this week." |
| "Find the Audit log." | Uses the on-screen label | "Someone changed the billing contact yesterday. Find out who." |

Rules: one goal per task; give values they need (names, amounts) on a task card; avoid order effects by rotating non-dependent tasks; include one task that must hit a permission boundary ("Change the company's SSO settings") to test the no-access state.

## Success criteria per task
| Task | Full success | Partial | Failure | Time limit |
|---|---|---|---|---|
| T2 Add Priya | Invited with Sales workspace + Member role | Invited, wrong or missing workspace | Not invited, gave up, or moderator helped | 4 min |

Errors to log: wrong path taken (count), data entry mistakes, misinterpretation (e.g., thought "Archive" deleted). Assists: any hint = failure for that task.

## Moderated script (full)
**Before (5 min)**
"Thanks for joining. I'm [name]; [observer names] are listening and taking notes. We're testing a design, not you - you can't do anything wrong, and honest reactions help most. I didn't design this, so you won't hurt my feelings. The design is a prototype, so some things won't work; if something doesn't respond, tell me what you expected. With your permission, we'll record the screen and audio; recordings stay internal and are deleted after [period]. You can stop at any time. Okay to start recording?"

**Warm-up (5 min)**
"Tell me about your role and what a normal week looks like in [product]." "When did you last [core task]? Walk me through it."

**Think-aloud instructions (1 min)**
"As you work, please think out loud - say what you're looking at, what you're trying to do, and what you expect will happen. I may stay quiet; that's on purpose because I want to see how you'd do it on your own."

**Tasks (30-40 min)** - for each: read the task card aloud, hand it over, start timer, observe, stop at end state or time limit, then:
- SEQ: "Overall, how difficult or easy was that task? 1 is very difficult, 7 is very easy."
- "What, if anything, was confusing or surprising?" (ask only after the task ends)

**Wrap-up (5-10 min)**
SUS or UMUX-Lite questionnaire. "If you could change one thing, what would it be?" "What worked well?" "Anything we didn't ask that we should have?" Thank them, explain the incentive, stop recording.

## Think-aloud and neutral probes
| Situation | Say | Never say |
|---|---|---|
| Silence > 10 s | "What are you thinking right now?" | "Do you see the button at the top?" |
| They ask "Should I click this?" | "What would you do if I weren't here?" | "Yes, try that." |
| They ask "Is this right?" | "What do you expect to happen?" | "Almost!" |
| They say "This is confusing" | "Tell me more about that." | "It's because..." |
| They're stuck past the limit | "Let's move on - that's useful for us." | Explaining the design |
| They praise it | "What makes it work for you?" | "Great, thanks!" and move on |

Observers note: timestamp, participant, observation (what happened), quote, and task - not interpretation.

## Unmoderated setup (Maze, UserTesting, Lookback)
- [ ] Welcome screen: purpose, length (≤ 20 min), recording consent, "testing the design, not you".
- [ ] Screener questions inside the tool; quotas per segment; 20-40 completes per segment for benchmarks.
- [ ] Each task: scenario text + explicit end state; set the success screen(s) or expected path in the prototype (Maze "missions" with expected paths; UserTesting "verbal response" or multiple-choice validation question).
- [ ] Add a validation question after tasks with no reliable end screen ("What was the total of the largest overdue invoice?").
- [ ] SEQ after every task; SUS or UMUX-Lite at end; one open "What was hardest?" question.
- [ ] Prototype: disable hotspot hints, start each task from a fixed frame, set a reasonable device frame and screen size.
- [ ] Pilot with 2-3 internal people outside the team, then a soft launch to 5 participants; check completion and misreads before full launch.
- [ ] Exclude speeders (completion < one-third of median time) and failed attention checks; report how many were excluded.

## Post-task and post-test questionnaires
**SEQ (after each task):** "Overall, how difficult or easy was this task to complete?" 1 Very difficult - 7 Very easy. Average is about 5.5; below 5 flags a problem task.

**SUS (System Usability Scale)**, 1 Strongly disagree - 5 Strongly agree:
1. I think that I would like to use this system frequently.
2. I found the system unnecessarily complex.
3. I thought the system was easy to use.
4. I think that I would need the support of a technical person to be able to use this system.
5. I found the various functions in this system were well integrated.
6. I thought there was too much inconsistency in this system.
7. I would imagine that most people would learn to use this system very quickly.
8. I found the system very cumbersome to use.
9. I felt very confident using the system.
10. I needed to learn a lot of things before I could get going with this system.

Scoring: odd items contribute (score − 1); even items contribute (5 − score); sum the 10 contributions (0-40) and multiply by 2.5 → 0-100. Average across participants. Benchmark: 68 is average (50th percentile); see reference/metrics-and-reporting.md for grades. Do not report individual item scores as percentages. "System" may be replaced with the product name.

**UMUX-Lite (shorter, for unmoderated or in-product)**, 1 Strongly disagree - 7 Strongly agree:
1. [Product]'s capabilities meet my requirements.
2. [Product] is easy to use.

Score = ((item1 − 1) + (item2 − 1)) / 12 × 100. To compare with SUS, use the regression estimate SUS ≈ 0.65 × UMUX-Lite + 22.9.
