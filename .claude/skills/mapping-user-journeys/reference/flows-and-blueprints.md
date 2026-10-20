# User flows, task flows and service blueprints

## Contents
- Flow vs. task flow vs. blueprint
- User flow notation
- Step-by-step flow template
- Path coverage checklist
- Permission branch patterns
- Filled flow example: invite users by CSV
- Service blueprint template
- Filled blueprint example: access request approval
- Common mistakes

## Flow vs. task flow vs. blueprint

| Artifact | Shows | Use when |
|---|---|---|
| Task flow | One linear path for one task, no branches | Aligning on the happy path early |
| User flow | One task with all decisions, errors and permission branches across screens | Designing or reviewing screens; handing off to engineering |
| Service blueprint | The user journey plus everything the organization does to support it | Diagnosing handoffs, ops load, SLAs, support cost |

## User flow notation

Use the same shapes in FigJam / Miro so any designer can read the flow.

| Shape | Meaning | Label style |
|---|---|---|
| Rounded rectangle (pill) | Start / end | "Start: admin opens Members" |
| Rectangle | Screen or page | "Screen: Invite members" |
| Small rectangle | User action | "Uploads CSV" |
| Diamond | Decision (user or system) | Question: "File valid?" |
| Hexagon or grey box | System process | "System: validates rows" |
| Parallelogram | Input / output (email, file) | "Email: invitation sent" |
| Red outline | Error state | "Error: 3 rows invalid" |
| Lock icon or dashed border | Permission gate | "Gate: role = Admin?" |
| Arrow label | Condition | "Yes" / "No" / "Timeout" |

Rules: read left to right or top to bottom; every diamond has 2+ labeled exits; every path ends in a terminal pill; IDs (F1, F2...) on each node so stories and tickets can reference them.

## Step-by-step flow template

Use when a table is faster than a diagram, or as the source for the diagram.

| ID | Actor | Step / screen | Action or decision | Outcomes → next | System response | Error / edge path | Permission rule | Copy needed |
|---|---|---|---|---|---|---|---|---|
| F1 | | | | | | | | |

**Header block above the table:**
- Task: · Persona + role: · Entry points (all): · Success end: · Failure ends:
- Preconditions (data, plan, feature flag): · Related journey stage:

## Path coverage checklist

```
- [ ] Happy path: shortest successful route, numbered end to end
- [ ] Alternate paths: other valid routes (import vs. manual, mobile vs. desktop, SSO vs. password)
- [ ] Validation errors: each input that can be wrong, with inline message
- [ ] System errors: timeout, server error, partial success, rate limit
- [ ] Empty data: first use, no results, deleted or archived object
- [ ] Permission branches: no access, read-only, needs approval, plan does not include feature
- [ ] Interruptions: session timeout, navigation away, browser back, duplicate submit
- [ ] Concurrency: another admin edits the same record; object changed since load
- [ ] Notifications: what email / in-app message fires at each end state
- [ ] Re-entry: how the user resumes a half-finished task
- [ ] Accessibility: keyboard-only path, focus destination after each step
```

## Permission branch patterns

| Situation | Show | Never |
|---|---|---|
| Role lacks permission | Explain what is restricted + name/link of an admin + "Request access" | Hide the entry point silently or show a 404 |
| Read-only role | Content visible, edit controls disabled with tooltip giving the reason | Enabled buttons that fail on click |
| Needs approval | "Submit for approval" replaces "Save"; show approver and expected time | Making the requester guess status |
| Plan does not include feature | Value statement + who can upgrade (often billing admin, not this user) | Upsell modal blocking the user's current task |
| Policy blocks (e.g. data residency, IP allow-list) | Name the policy and the admin who set it | Generic "Something went wrong" |

## Filled flow example: invite users by CSV

Task: Admin invites 25 people by CSV. Persona: Workspace admin (Owner or Admin role). Entry: Members page, onboarding checklist, empty-state CTA. Success end: invitations sent. Failure ends: user cancels; no permission.

| ID | Actor | Step / screen | Action or decision | Outcomes → next | System response | Error / edge path | Permission rule | Copy needed |
|---|---|---|---|---|---|---|---|---|
| F1 | Admin | Members | Clicks "Invite members" | → F2 | Opens invite dialog | – | Role ∈ {Owner, Admin}; else → F1a | Button label |
| F1a | Member | Members | Sees disabled "Invite members" | → end (request) | Tooltip + "Ask an admin" link | – | – | "Only admins can invite. Ask Dana Lee." |
| F2 | Admin | Invite dialog | Chooses "Upload CSV" or "Type emails" | CSV → F3; Type → F2b | – | – | – | Tab labels, template link |
| F3 | Admin | Invite dialog | Uploads file | → F4 | Validates format | Wrong type / > 5 MB → F3e | – | Helper text: "CSV, max 1,000 rows" |
| F3e | System | Invite dialog | – | → F3 | Inline error, file kept selectable | – | – | "This file is .xlsx. Save it as CSV and upload again." |
| F4 | System | Review step | Row validation | All valid → F5; Some invalid → F4e | Shows count valid / invalid | Duplicate, existing member, bad domain | Domain allow-list from Security settings | – |
| F4e | Admin | Review step | Fixes rows inline or skips them | → F5 | Row-level errors with reason | All rows invalid → stays on F4 | – | "Row 7: jo@gmail.com is outside allowed domains (acme.com)." |
| F5 | Admin | Review step | Sets default role, confirms "Send 25 invitations" | → F6 | – | Seats exceeded → F5e | Assigning Admin role needs Owner | Count in button label |
| F5e | System | Review step | – | Owner → buy seats; Admin → request | Shows seats left | – | Billing permission | "You have 20 seats left. Remove 5 people or ask Sam (billing owner) to add seats." |
| F6 | System | Members | – | → end | Toast + rows show "Invited"; email sent; audit log entry | Partial send failure → per-row "Resend" | – | "25 invitations sent. Undo" |

## Service blueprint template

| Lane | Step 1 | Step 2 | Step 3 | Step 4 |
|---|---|---|---|---|
| Physical / digital evidence | Email, screen, PDF, invoice | | | |
| Customer actions | | | | |
| — Line of interaction — | | | | |
| Frontstage (visible staff / UI) | | | | |
| — Line of visibility — | | | | |
| Backstage (invisible staff actions) | | | | |
| — Line of internal interaction — | | | | |
| Support processes (systems, vendors, teams) | | | | |
| Policies / rules | | | | |
| Time / SLA | | | | |
| Fail points (F) and waits (W) | | | | |
| Metrics | | | | |

Mark **fail points** with F and **excessive waits** with W directly in the cell. Each fail point gets a row in the opportunity table with owner.

## Filled blueprint example: access request approval

Scenario: Analyst requests access to a restricted dashboard; manager approves; admin provisions.

| Lane | Request | Notify approver | Approve | Provision | Confirm |
|---|---|---|---|---|---|
| Evidence | "Request access" screen | Email + Slack message | Approval page | Role change | Email: "Access granted" |
| Customer actions | Analyst writes reason, submits | – | Manager reviews, approves | – | Analyst opens dashboard |
| Frontstage | Confirmation with status link | Message with request context | One-click approve / deny with reason | – | In-app banner |
| Backstage | – | Reminder at 24 h, escalation at 72 h | Admin queue updated | Admin assigns role manually (W) | – |
| Support processes | Request service, audit log | Notification service | Policy engine (data classification) | IdP group sync via SCIM (F: sync fails silently) | Notification service |
| Policies | Reason required | Approver = direct manager from HRIS | Restricted data needs data owner too | Least privilege, 90-day expiry | – |
| Time / SLA | 1 min | 0 | Target < 1 business day | Target < 4 h; actual 1–3 days (W) | – |
| Metrics | Requests / week | Time to first view | Approval time | Provision time | Requests re-submitted |

Fail points: F1 SCIM sync fails silently → admin and requester never told; W1 manual provisioning backlog. Opportunities: auto-provision on approval; sync failure alert to admin with retry.

## Common mistakes

- Only the happy path drawn; errors "to be handled by engineering".
- Decisions without labeled exits, or paths that end nowhere.
- Permission branches missing, so the first non-admin tester hits a dead end.
- Blueprint with no backstage detail – it is just a journey map with extra headers.
- Fail points identified but not tied to an owner or metric.
