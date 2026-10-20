# Voice, style guide, glossary, testing, and audits

## Contents
- Voice chart template
- Tone by context
- Style guide rules
- Glossary template
- Inclusive language swaps
- Content testing methods
- Content audit and string inventory
- Content design handoff

## Voice chart template
Voice is constant; tone flexes. Define 3-4 voice attributes, each with "we are / we are not" and examples.

| Attribute | We are | We are not | Do | Don't |
|---|---|---|---|---|
| Clear | Plain, specific | Vague, jargony | "Sync runs every 15 minutes" | "Leverage near-real-time synergies" |
| Confident | Direct, decisive | Bossy, arrogant | "Connect your IdP to turn on SSO" | "You must immediately configure..." |
| Supportive | Calm, helpful | Cutesy, gushing | "Your changes are saved" | "Woohoo, you rock!" |
| Trustworthy | Honest about limits | Evasive, salesy | "We don't support SCIM for this plan" | "Coming soon!" (with no date) |

Fill-in prompts: who is our main reader? What do they need to feel? What three words should a customer use to describe how we sound? Which competitor tone do we want to avoid?

## Tone by context

| Context | User state | Tone | Pattern | Example |
|---|---|---|---|---|
| Success | Relieved, moving on | Brief, neutral | Past tense + next step | "Policy published. Members see it next time they sign in." |
| Error (user-fixable) | Frustrated | Calm, specific | What + how to fix | "Enter a cost center to save this request." |
| Error (system) | Anxious | Reassuring, honest | What's safe + what to do + ref ID | "We couldn't load invoices. Your data is safe. Try again in a few minutes. Ref: 4C1-0B7" |
| Destructive | Cautious | Serious, explicit | Object + count + consequence | "Delete 8 API keys? Apps using them stop working immediately." |
| Onboarding | Curious, unsure | Encouraging, concrete | Value + first action | "Invite your team so approvals don't wait on you." |
| Empty | Neutral | Helpful | What goes here + how to start | "No reports yet. Create one from a template." |
| Billing / legal | Wary | Precise, factual | Amounts, dates, consequences | "You'll be charged $480 on Nov 1 for 4 added seats." |
| Security | Alert | Direct, non-alarming | Event + device + action | "New sign-in from Chrome on Windows, Berlin. Wasn't you? Reset your password." |

## Style guide rules
- **Case:** sentence case for all UI text; title case only for product names.
- **Numbers:** numerals for all numbers in UI ("3 users"); thousands separators by locale; ranges with en dash or "to".
- **Dates and times:** locale-formatted; relative for recent ("5 min ago"), absolute on hover or after 7 days; always show time zone for scheduled actions.
- **Punctuation:** no periods on buttons, labels, titles, or single-sentence toasts; periods on full sentences in body and helper text; no exclamation marks except rare celebrations; avoid ampersands in body copy.
- **Contractions:** use common ones (can't, you'll, don't) for a human voice; avoid stacked ones (wouldn't've).
- **Pronouns:** "you/your" for the user; avoid "my" in navigation ("Your profile"); "we" only for the company's actions.
- **Verbs:** "select" not "click"; "sign in / sign out" (not log in/login mixed); "set up" (verb) vs "setup" (noun).
- **Abbreviations:** spell out on first use unless the persona uses it daily (SSO, API for admins).
- **Formatting:** bold only for UI element names in help text; no underline except links; avoid ALL CAPS.
- **Readability targets:** grade 6-8; sentences ≤ 20 words; paragraphs ≤ 3 sentences in UI.

## Glossary template
One term per concept, shared with PM, engineering, docs, support, sales, and localization.

| Term | Definition | Use | Don't use | Notes / owner |
|---|---|---|---|---|
| Workspace | Container for projects owned by one organization | "Switch workspace" | Space, account, tenant (in UI) | "Tenant" OK in API docs |
| Member | Person with access to a workspace | "Invite members" | User (in end-user UI), seat | "Seat" only in billing |
| Remove | Takes access away; data kept | "Remove from group" | Delete | Reversible |
| Delete | Permanently erases, after 30-day restore window | "Delete project" | Remove, trash | Requires confirmation |
| Deactivate | Blocks sign-in; keeps history and ownership | "Deactivate user" | Suspend, disable | SCIM deprovision maps here |

Review the glossary when a feature introduces a new noun; add translator notes and do-not-translate terms (product names, feature names if decided).

## Inclusive language swaps

| Avoid | Use |
|---|---|
| Whitelist / blacklist | Allowlist / blocklist |
| Master / slave | Primary / replica, main |
| Sanity check | Quick check, confidence check |
| Kill, abort, execute (people-facing) | Stop, cancel, run |
| Crazy, insane, lame, blind spot | Unexpected, wild, weak, gap |
| Guys | Everyone, team, folks |
| He/she (generic) | They, or the role ("the approver") |
| Simply, just, easy, obviously | (Delete - it's not easy for everyone) |

Also: gender-inclusive name and title fields, don't require "first/last name" split globally, avoid assuming age, ability, or region.

## Content testing methods

| Method | Answers | How | Sample / threshold |
|---|---|---|---|
| Cloze test | Is text understandable? | Delete every 5th-6th word; participants fill blanks | ≥ 60% correct = comprehensible; 15-25 participants |
| Highlighter test | Which phrases help or confuse? | Green = clear/confident, red/yellow = confusing or worrying | 5-8 participants; look for clusters |
| Comprehension questions | Do people understand the consequence? | Show copy, ask "What happens if you select Delete group?" | ≥ 80% correct answers before shipping destructive copy |
| 5-second test | Does the headline land? | Show for 5 s, ask what it was about | 20+ participants (unmoderated) |
| First-click / task test | Do labels guide action? | "Where would you go to add a seat?" | 70%+ correct first click; 15-30 participants |
| Preference test | Which variant reads better? | Side by side, ask why | Directional only; 20+ |
| A/B test | Which drives behavior in production? | Split traffic on one string change | Predefine metric, minimum detectable effect, and run to sample size; don't stop early |
| Readability score | Is it grade 6-8? | Flesch-Kincaid / Hemingway-style check | Sanity check, not a substitute for testing |

Test with the real persona (admins for admin consoles). Report: method, participants, success rate, quotes, recommended change.

## Content audit and string inventory
Use for redesigns, migrations to a design system, localization, or terminology cleanup.

1. **Inventory**: export all strings (from code resource files, Figma text layers, or manual capture per screen).
2. **Tag**: component type, state, feature, persona, owner.
3. **Score** each string against criteria: clarity, accuracy, terminology, voice, accessibility, localization risk (1-3).
4. **Decide**: keep / rewrite / merge / delete.
5. **Prioritize** by traffic and risk (errors, billing, destructive, security first).

Audit template:

| Key / location | Component | State | Current copy | Issues (rule #) | Score | Action | Proposed copy | Owner |
|---|---|---|---|---|---|---|---|---|
| billing.plan.error | Inline error | Error | "Error: plan invalid" | Vague, no fix (6) | 1 | Rewrite | "Choose a plan with at least 14 seats - you have 14 members." | Billing squad |

Summarize: total strings, % failing per criterion, top 10 rewrites, glossary conflicts found, duplicates to consolidate.

## Content design handoff
Deliver a string table, not screenshots with redlines.

- **Key** naming: `feature.screen.element.state` (e.g. `sso.setup.save.error`). Stable keys; never reuse a key for new meaning.
- Columns: key, component, state, copy, character limit, variables and their meaning, plural forms, accessible name if different from visible text, translator note, screenshot/frame link, status (draft/approved).
- Include every state, including loading, partial, and no-permission.
- Flag strings needing legal or security review (consent, data deletion, billing).
- Agree with engineering on where strings live (resource files), and that copy changes don't need design file edits to ship.
