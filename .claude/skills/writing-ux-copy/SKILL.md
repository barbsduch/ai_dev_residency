---
name: writing-ux-copy
description: Writes, rewrites, and reviews UX copy and content design for enterprise B2B product UI - voice and tone by context (success, error, destructive, onboarding, empty), plain-language and sentence-case rules, button, heading, label, helper text, placeholder, tooltip, error, confirmation dialog, empty state, toast, banner, notification, email, and no-permission copy with character limits, accessible link and alt text, inclusive language, localization readiness, content testing (cloze, highlighter, comprehension, A/B), content audits, string inventories, glossaries, and string tables for developer handoff. Use when the user asks to write or fix microcopy, UX writing, content design, error messages, button labels, empty states, confirmation dialogs, tooltips, onboarding copy, notification or email copy, a voice and tone guide, a style guide, a terminology glossary, a content audit, string table, or says "make this copy clearer", "what should this button say", or "review the wording on this screen".
---

# Writing UX Copy

Every string has one job: help a specific person finish a specific task with the least reading - so write for the task, the state, and the role, not for the page.

## Choose the workflow

- **Write copy for a new screen, flow, or component** → "Write workflow" + [reference/component-copy-patterns.md](reference/component-copy-patterns.md).
- **Rewrite or review existing copy / screenshot** → "Review workflow" + [reference/component-copy-patterns.md](reference/component-copy-patterns.md).
- **Error messages only** → rule 6 + "Error messages" in [reference/component-copy-patterns.md](reference/component-copy-patterns.md).
- **Voice and tone guide, style guide, or glossary** → [reference/voice-style-and-testing.md](reference/voice-style-and-testing.md).
- **Content testing, content audit, or string inventory** → [reference/voice-style-and-testing.md](reference/voice-style-and-testing.md).
- **Developer handoff** → produce the string table in the output template below.

## Non-negotiable rules

1. **Clear, concise, useful, human** - in that order. Clarity beats brevity; brevity beats cleverness. No jokes in errors, destructive flows, or billing.
2. **Front-load** the most important words. Users scan the first 2-3 words of a line ("Export failed" not "Unfortunately, we were unable to complete your export").
3. **Plain language, grade 6-8** (Flesch-Kincaid). Sentences ≤ 20 words; one idea per sentence. Replace jargon unless it is the user's own term (admins do say "SSO", "SCIM", "role").
4. **Active voice, second person.** "You don't have access" not "Access has not been granted". The system is "we" only when it did something.
5. **Sentence case everywhere** (buttons, headings, tabs, menu items). Capitalize only proper nouns and product names.
6. **Error formula: what happened + why (if known) + how to fix.** Never blame the user, never "Invalid", "Oops", "Error 403", or a code alone. Keep reference IDs for support, after the human text.
7. **Buttons are verb + object** ("Invite users", "Delete 12 invoices"). The button that confirms a dialog repeats the action in the dialog title; never "OK"/"Yes" for consequential actions.
8. **One term per concept.** Use the glossary; never alternate "workspace / project / space" or "remove / delete" for different behaviors without defining them.
9. **Name consequences in destructive copy**: what is affected, how many, whether it can be undone, who else is impacted.
10. **Accessible content**: link text makes sense out of context ("View billing history", not "click here"); no directional-only or sensory-only instructions ("the button on the right", "the green icon"); alt text describes purpose; labels never live only in placeholders.
11. **Localization-ready**: budget 30-40% expansion (up to 200% for strings under 10 characters); no string concatenation or sentence fragments assembled in code; full-sentence keys with variables and plural forms (ICU MessageFormat); locale-formatted dates, numbers, currency.
12. **Inclusive and role-aware**: no ableist, gendered, or violent metaphors ("sanity check", "kill", "blacklist" → "quick check", "stop", "blocklist"); write for the persona's role (end user, admin, buyer, IT/security approver) and tell non-admins who can help.

## Write workflow

Copy this checklist and track progress:

```
UX copy checklist:
- [ ] 1. Frame: persona/role, task, context of use, frequency, emotional state
- [ ] 2. Pull voice, tone-for-context, and glossary terms (or draft a mini glossary)
- [ ] 3. List every string and every state (default, empty, loading, success, error, partial, no-permission, destructive)
- [ ] 4. Draft with component rules and character limits
- [ ] 5. Run accessibility, inclusive-language, and localization passes
- [ ] 6. Run the quality check; revise until every item passes
- [ ] 7. Deliver the string table (keys, states, limits, notes) + open questions
```

**Step 1 - Frame.** Ask or state assumptions: who reads this, what they are trying to do, how often (daily operator vs. once-a-year admin), and how they feel (blocked, rushed, anxious about data loss). Tone shifts with the emotional state; voice does not.

**Step 3 - Inventory states.** A table screen alone needs: column headers, filters, empty (first use), empty (no results), loading, error, partial load, no-permission, bulk-action confirmations, success toasts. Missing states are the most common copy defect.

**Step 4 - Character guidance** (English source; leave 30-40% room):

| Component | Target | Hard limit | Pattern |
|---|---|---|---|
| Button | 1-3 words | 25 chars | Verb + object |
| Page / dialog title | 2-6 words | 50 chars | Noun phrase or the action as a question |
| Field label | 1-4 words | 30 chars | Noun, no colon |
| Helper text | 1 sentence | 90 chars | Constraint or example |
| Tooltip | 1-2 sentences | 150 chars | Defines, never essential |
| Inline error | 1-2 sentences | 120 chars | What + how to fix |
| Toast | ≤ 1 sentence | 60 chars | Result + optional action |
| Banner | Title + 1-2 sentences | 200 chars | Impact + action |
| Empty state | Heading + 1-2 sentences + CTA | 150 chars body | What goes here + how to start |
| Email subject | 4-7 words | 50 chars | Front-load the event |

## Review workflow

1. Identify the persona, task, and state for each string; flag missing states.
2. Score each string against rules 1-12; note the rule number for each issue.
3. Rewrite only what fails, keeping the product's established terms.
4. Report with the review table (original → rewrite → rule → why), most user-impacting first.

## Quality check (run before delivering, revise until all pass)

- [ ] Every string is tied to a state, and no state is missing
- [ ] First 2-3 words carry the meaning; no "Please note", "In order to", "Unfortunately"
- [ ] Grade level ≤ 8 (estimate); no sentence > 20 words
- [ ] Every error has what + how to fix; none blames the user
- [ ] Every destructive confirmation names object, count, reversibility; button repeats the verb
- [ ] Terms match the glossary throughout; sentence case throughout
- [ ] Links and buttons make sense read alone; no directional-only instructions
- [ ] No concatenation; variables and plurals are explicit; within character limits with expansion room
- [ ] Non-admin and no-permission copy says who can help

## Output template

```markdown
## Copy: [screen / flow] - persona: [role], task: [task]

**Tone for this context:** [e.g. calm, direct, reassuring]  **Glossary terms used:** [terms]

| Key | Component | State | Copy (en) | Chars / limit | Notes (variables, plural, a11y, l10n) |
|-----|-----------|-------|-----------|---------------|----------------------------------------|
| users.invite.button | Button | Default | Invite users | 12 / 25 | - |

**Review (if rewriting):**
| # | Original | Rewrite | Rule | Why |
|---|----------|---------|------|-----|

**Open questions / assumptions:** [list]
```

## Example

**Input:** "Our delete dialog says: 'Are you sure? This action cannot be undone. [Cancel] [OK]'. It deletes a user group in our admin console."

**Output:**

| Key | Component | State | Copy (en) | Chars / limit | Notes |
|---|---|---|---|---|---|
| groups.delete.title | Dialog title | Destructive | Delete "{groupName}"? | ~22 / 50 | Variable in quotes |
| groups.delete.body | Dialog body | Destructive | {count, plural, one {# member loses} other {# members lose}} access to the apps assigned to this group. You can't undo this. | ~95 / 200 | ICU plural; consequence first |
| groups.delete.confirm | Button (danger) | Destructive | Delete group | 12 / 25 | Repeats title verb; not "OK" |
| groups.delete.cancel | Button | Destructive | Cancel | 6 / 25 | Default focus for keyboard users |
| groups.delete.toast | Toast | Success | "{groupName}" deleted | ~20 / 60 | Announce via polite live region |

Review: "Are you sure?" (rule 9: no consequence named) and "OK" (rule 7: verb missing) replaced.
