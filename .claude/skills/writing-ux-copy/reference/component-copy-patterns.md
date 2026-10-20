# Component copy patterns (good vs. bad, enterprise examples)

## Contents
- Buttons and links
- Headings and titles
- Labels, helper text, placeholders
- Tooltips
- Error messages
- Confirmation dialogs
- Empty states
- Toasts and inline success
- Banners and system status
- Onboarding
- Notifications and emails
- Permission and no-access messages
- Accessibility in content
- Localization patterns

## Buttons and links
Verb + object, sentence case, describes the result. Primary button label = the user's goal.

| Bad | Good | Why |
|---|---|---|
| Submit | Send request | Says what happens |
| OK | Save changes | Verb + object |
| Click here | View audit log | Link makes sense alone |
| Yes / No | Remove user / Keep user | Answers stand without the question |
| Learn more | Learn about SSO setup | Distinct when a screen reader lists links |
| Continue (on payment) | Pay $1,200 | Names the commitment |

- Bulk actions include the count: "Archive 24 projects".
- Keep the same verb from trigger to dialog to toast: "Deactivate" → "Deactivate user?" → "User deactivated".
- Avoid "Get started" on every screen; use the task ("Connect your IdP").

## Headings and titles
- Page titles name the object or task: "Billing", "Invite users to Acme". Not "Welcome to your billing management experience".
- Dialog titles state the action, often as a question for decisions: "Revoke API key?"
- Section headings help scanning; 2-6 words; no ending punctuation (except "?").

## Labels, helper text, placeholders
- Labels: short nouns, no colon, always visible. "Work email", not "Please enter your work email address:".
- Mark the minority: if most fields are required, mark "(optional)" ones instead of asterisks everywhere.
- Helper text: constraints and format before the user types. "Use 8+ characters. Avoid reused passwords." / "Shown to members on invoices."
- Placeholders: example values only, never the label or instructions (they disappear on focus and fail contrast). "e.g. finance-team".

| Bad | Good |
|---|---|
| Label in placeholder: "Enter domain" | Label "Company domain", helper "Users with this email domain can join automatically", placeholder "acme.com" |
| "SCIM token:" | "SCIM token" + helper "Paste this into your identity provider. It's shown once." |

## Tooltips
- Define or clarify; never hold essential instructions or errors (not discoverable on touch, often missed).
- ≤ 150 characters; no links or buttons inside (use a popover or help panel).
- Bad: tooltip on "Seats" saying "Seats". Good: "Seats are paid licenses. Viewers don't use a seat."

## Error messages
Formula: **what happened + why (if known) + how to fix.** Place next to the cause; summary at top on submit with links to fields.

| Bad | Good |
|---|---|
| Invalid input | Enter a date in the future, like 12/31/2030 |
| Error 403 | You don't have permission to export reports. Ask a workspace admin to give you the Analyst role. |
| Oops! Something went wrong :( | We couldn't save your changes because the connection dropped. Your edits are kept - try again. |
| Upload failed | "Q3_ledger.xlsx" is 42 MB. Upload files up to 25 MB, or split the file. |
| Email is wrong | This email is already in your organization. Search for the user instead. |
| SAML assertion validation error | Sign-in failed because your identity provider sent an expired certificate. Ask your IT admin to update the certificate in Okta. Ref: 8F2-91A |
| Import failed | 18 of 500 rows didn't import because the "Cost center" column is empty. Download the error report, fix the rows, and import them again. |

- System errors: say what's safe ("Your data wasn't changed"), what to do, and include a reference ID after the human text.
- Validation timing: on blur or submit, not on every keystroke. Never clear user input.
- Never "invalid", "illegal", "fatal", "abort", "you failed".

## Confirmation dialogs
Use only for destructive, irreversible, costly, or wide-impact actions; prefer undo for reversible ones.

Structure: **Title** = action + object as question. **Body** = consequence (what, how many, who is affected, reversible or not). **Buttons** = specific verb + Cancel.

| Bad | Good |
|---|---|
| "Are you sure?" [OK] [Cancel] | "Remove 3 users from Finance?" Body: "They lose access to 12 shared dashboards. Their own data isn't deleted." [Remove users] [Cancel] |
| "Warning! This will delete everything!" | "Delete workspace "Acme EU"? All 1,240 projects and their files are deleted after 30 days. You can restore it until then." [Delete workspace] |

- For very high impact (delete tenant, rotate all keys), require typing the object name: "Type Acme EU to confirm".
- Don't use double negatives ("Don't not notify users").

## Empty states
Three types, each different copy:

| Type | Pattern | Example |
|---|---|---|
| First use | What goes here + value + primary CTA | "No integrations yet. Connect Slack or Teams to get alerts where your team works." [Add integration] |
| No results | Echo the query + how to widen | "No invoices match "overdue" in Q2. Try another date range or clear filters." [Clear filters] |
| Cleared / done | Positive closure | "All access requests reviewed. New requests appear here." |
| No permission | Why + who can help | See permission section |

Bad: "No data", "Nothing to see here!", a blank table.

## Toasts and inline success
- Result in past tense, ≤ 60 chars, optional single action: "Report scheduled. [View]", "12 invoices archived. [Undo]".
- Auto-dismiss ≥ 5 s, longer (or persistent) when they contain an action; announce via a polite live region.
- Errors that need action are inline or banners, not disappearing toasts.

## Banners and system status
- Lead with impact, then action, then timing: "Exports are delayed by about 30 minutes. Your scheduled reports will still be sent. [Status page]"
- Severity words consistent: info, warning, error, success - and never color alone (include icon + text).
- Trial/billing: factual, no guilt: "Your trial ends in 5 days. Add a payment method to keep your 14 users' access." Not "Don't lose everything!"

## Onboarding
- Explain value by role: admins get setup tasks (SSO, SCIM, roles); end users get first-task guidance.
- Checklists with 3-5 steps, each verb + object, show progress ("2 of 4 done").
- Tours ≤ 3-4 steps, skippable, never block the task. Prefer contextual hints at the moment of need.

## Notifications and emails
- Subject/title front-loads the event and object: "Access request: Dana Lee → Payroll app".
- Body answers: what happened, who did it, what to do, by when. One primary CTA.
- Say why they got it and how to change it: "You're receiving this because you're an approver for Payroll. [Notification settings]".
- Security emails: never ask for passwords; name the device/location; give a clear "This wasn't me" path.

## Permission and no-access messages
Say what they can't do, why, and who can help - name the role, ideally the person, and offer a request path.

| Bad | Good |
|---|---|
| Access denied | You can view this report but can't edit it. Editors: Priya Shah, Marco Ruiz. [Request edit access] |
| 403 Forbidden | This page is for organization admins. Ask your admin to change your role, or go back to your dashboard. |
| (hidden button, no explanation) | Disabled button + adjacent text: "Only billing admins can change the plan." |

## Accessibility in content
- Link and button text unique and descriptive out of context; avoid repeated "Edit" - use "Edit billing contact" (visually or via accessible name).
- No sensory-only instructions: not "click the blue button on the right" but "select Save changes".
- Alt text: purpose not appearance; ≤ 125 chars; decorative images get empty alt. Chart alt text states the takeaway ("Ticket volume fell 32% after launch") and links a data table.
- Use "select" over "click" (works for touch, keyboard, voice).
- Error and status text must be programmatically associated and announced (work with design/engineering).
- Avoid ALL CAPS for meaning (screen readers may spell it out), and avoid emoji as the only carrier of meaning.

## Localization patterns
- Never concatenate: bad `"You have " + n + " new " + item`; good key `notifications.count` = `{n, plural, one {You have # new alert} other {You have # new alerts}}`.
- Whole sentences with named variables: `"{user} invited {count} people to {workspace}"` so translators can reorder.
- Avoid idioms ("touch base", "out of the box"), culture-bound examples, and text in images.
- Dates, times, numbers, currency via locale formatting; show time zone for scheduled jobs ("Runs daily at 09:00 CET").
- Leave 30-40% width; German, Finnish, and Russian often run longest; design for RTL mirroring.
- Provide translator notes per key: context, max length, variable meaning, tone.
