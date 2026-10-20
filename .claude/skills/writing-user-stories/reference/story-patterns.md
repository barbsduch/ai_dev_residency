# Story patterns, splitting and enterprise examples

## Contents
- Good vs. bad stories
- INVEST check with failure fixes
- Acceptance criteria: good vs. bad
- Splitting worked examples
- Enterprise role and permission stories
- Role/permission matrix template
- Epic → story → task breakdown
- Job stories
- Common mistakes

## Good vs. bad stories

| Bad | Why it fails | Good |
|---|---|---|
| As a user, I want a dashboard. | Vague role, no outcome, solution-first | As a support team lead, I want to see open tickets by agent, so that I can rebalance work before SLAs are breached. |
| As an admin, I want a button to export users so that I can export users. | Circular "so that" | As a workspace admin, I want to export the member list with roles, so that I can complete our quarterly access review. |
| As a developer, I want to build the permissions API. | Technical task, no user value | As a workspace owner, I want to give a contractor view-only access, so that they can review reports without changing data. |
| As a user, I want SSO, MFA, audit logs and SCIM. | Four stories in one | Split into four, each with its own outcome |
| As a manager, I want the approval page to be intuitive. | Untestable | As a manager, I want to approve an access request from the email, so that requesters aren't blocked while I'm away from my desk. |
| As a buyer, I want a red banner on the billing page. | Prescribes UI without a decided design | As a billing owner, I want to know before my seat limit is reached, so that I can add seats before new hires are blocked. |
| As an auditor, I want everything logged. | Unbounded | As a compliance auditor, I want to filter the audit log by user and date range, so that I can answer an auditor request in one session. |

## INVEST check with failure fixes

| Letter | Question | If it fails |
|---|---|---|
| Independent | Can it ship without another story in this sprint? | Merge tightly coupled stories or reorder; stub the dependency |
| Negotiable | Is the "how" still open for discussion? | Remove UI prescriptions from the goal; move them to design notes |
| Valuable | Would a real role notice and care if it shipped alone? | Re-slice vertically; layer work becomes tasks |
| Estimable | Can the team size it? | Add a time-boxed spike story for the unknown |
| Small | Fits in half a sprint; ≤ 8 ACs? | Split with SPIDR / workflow / role |
| Testable | Can QA write a pass/fail test from the ACs? | Replace vague words with numbers, states and exact copy |

## Acceptance criteria: good vs. bad

| Bad | Good |
|---|---|
| The page loads fast. | Given 500 members, when the Members page opens, then the first 50 rows render within 1 s and a skeleton shows until then. |
| Show an error if something goes wrong. | Given the upload fails on the server, when the admin submits, then the dialog shows "We couldn't upload the file. Try again, or contact support with ID {ref}." and the selected file stays attached. |
| Admins can manage users. | Given I am a Member, when I open Members, then "Invite members" is disabled with the tooltip "Only admins can invite. Ask {admin_name}." |
| It should be accessible. | All controls are reachable by Tab in visual order; focus moves to the first invalid field on submit; each input has a visible label; text contrast ≥ 4.5:1. |
| Works on mobile. | At ≤ 640 px the table becomes a stacked list; the primary action stays visible without horizontal scrolling. |
| Handle empty state. | Given no members other than me, when I open Members, then I see "Invite your team to start collaborating" and a "Invite members" button. |

**Given/When/Then rules:** Given = state and role; When = one user or system action; Then = observable result (screen, message, data, email, event). One rule per scenario. Use concrete data ("3 invalid rows"), not "some".

## Splitting worked examples

**Epic: Approval workflow for access requests**

| Slice | Technique | Story |
|---|---|---|
| 1 | Path (happy) | As an analyst, I want to request access to a restricted dashboard with a reason, so that my manager can approve it without a separate email. |
| 2 | Workflow step | As a manager, I want to approve or deny a request with one click from the notification, so that my team isn't blocked waiting for me. |
| 3 | Path (unhappy) | As an analyst, I want to see why a request was denied, so that I can ask for the right level of access. |
| 4 | Rules | As a data owner, I want requests for Confidential dashboards to need my approval too, so that sensitive data access is controlled. |
| 5 | Rules (time) | As an analyst, I want requests unanswered for 72 h to escalate to the admin, so that I'm not blocked by an absent manager. |
| 6 | Interface | As a manager, I want to approve requests in Slack, so that I don't need to switch tools. |
| – | Spike | Spike (2 days): confirm HRIS provides reliable manager mapping for approver routing. |

**Epic: Export reports**

| Technique | Slice 1 (ship first) | Later slices |
|---|---|---|
| Data | CSV of the current view, ≤ 10,000 rows | > 10,000 rows emailed as a background job; XLSX |
| Interface | Web | Scheduled exports; API |
| Rules | Export what the user can see | Mask PII columns for non-admin roles; watermark |
| Path | Success | Export failed → retry; export expired link |

**Split smells:** "and" in the goal; more than one role in the "As a"; ACs that test different screens; a story that only a later story makes valuable.

## Enterprise role and permission stories

- As a **workspace owner**, I want to transfer ownership to another admin, so that the workspace isn't locked when I leave the company.
- As an **IT administrator**, I want users provisioned and deprovisioned from our identity provider, so that leavers lose access the same day.
- As a **security reviewer**, I want to see which integrations have access to workspace data, so that I can approve or revoke them during vendor review.
- As a **billing owner**, I want to approve seat increases requested by admins, so that spend stays within the purchase order.
- As a **read-only auditor**, I want to view and export the audit log without edit rights, so that I can collect evidence without risking changes.
- As a **team lead (no admin rights)**, I want to request a new member for my team, so that I don't have to chase an admin by email.
- As a **guest collaborator**, I want to see only the projects I was invited to, so that I'm confident I'm not viewing other clients' data.

## Role/permission matrix template

| Capability | Owner | Admin | Member | Guest | Denied experience |
|---|---|---|---|---|---|
| View members | ✓ | ✓ | ✓ (names only) | ✗ | Nav item hidden for Guest; direct URL shows "You don't have access to Members. Ask {owner}." |
| Invite members | ✓ | ✓ | ✗ | ✗ | Disabled button + tooltip naming an admin |
| Assign Admin role | ✓ | ✗ | ✗ | ✗ | Role option shown disabled: "Only owners can assign Admin." |
| Remove member | ✓ | ✓ (not Owners) | ✗ | ✗ | Action absent from row menu |
| Export member list | ✓ | ✓ | ✗ | ✗ | – |

Every ✗ needs a denied experience. "Hidden" is acceptable only when the capability's existence is itself sensitive.

## Epic → story → task breakdown

| Level | Owner | Size | Example |
|---|---|---|---|
| Epic | PM + design lead | Multiple sprints, outcome + metric | Admins bring their team into the workspace (activation 61% → 80%) |
| Story | Team | ≤ half a sprint, user-visible | Fix invalid CSV rows before sending |
| Task | Individual | Hours to 2 days, not user-visible | Design row-error states; write error strings; build validation endpoint; add `members_invite_sent` event; QA keyboard path |

Design tasks (explore, spec states, copy, a11y annotations, usability check) live under the story they serve, not in a separate "design story".

## Job stories

Use when situation and motivation matter more than persona, or several roles share the trigger.

| User story | Job story |
|---|---|
| As an admin, I want alerts for failed syncs, so that users have access. | When the IdP sync fails overnight, I want to be told which users were affected before they log in, so I can fix access before tickets arrive. |
| As a finance lead, I want an invoice export. | When month-end close starts, I want all invoices for the period in one file, so I can reconcile without asking each team. |

## Common mistakes

- "As a user" everywhere - hides the admin vs. end-user difference that drives most enterprise UX.
- Only happy-path ACs; states and permissions discovered in QA.
- Design and build split into separate stories, so design is "done" before anything ships.
- ACs that copy the mockup ("matches Figma") instead of stating behavior.
- Stories written after the sprint started, with copy and open questions unresolved.
