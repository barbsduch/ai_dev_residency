# Enterprise UX patterns

## Contents
- Forms and validation
- Data tables
- Dialogs and confirmations
- Notifications
- Onboarding
- Empty states
- Error-message formula
- Microcopy examples

## Forms and validation
- Single column; labels above fields; never placeholder-as-label.
- Mark the minority: if most fields are required, mark "(optional)"; otherwise mark required.
- Validate on blur (not on every keystroke); re-validate on change once a field is in error; validate all on submit.
- On submit with errors: error summary at top listing each error as a link to its field, focus moved to the summary, input preserved.
- Field width hints expected length (ZIP short, address long).
- Group long forms into sections or steps; multi-step shows "Step 2 of 4" and allows going back without losing data.
- Disable submit only while submitting (show "Saving…"); don't disable it to signal invalid input - users can't tell why.
- Use the right input: `type="email"`, `inputmode="numeric"`, `autocomplete` tokens, date pickers that also accept typed dates.
- Server-side errors map back to the specific field when possible.

## Data tables
- **Columns**: left-align text, right-align numbers (tabular figures); default to the 5–7 most useful columns; let users show/hide and reorder; persist per user.
- **Sort**: click header toggles asc/desc; show direction icon; one default sort that matches the main task (e.g. newest first).
- **Filter**: faceted filters + search; active filters shown as removable chips; "Clear all"; state in URL.
- **Bulk actions**: header checkbox selects page, then offer "Select all 2,340 matching"; sticky bulk bar shows count and actions; confirm with count.
- **Pagination vs virtualization**: paginate (25/50/100) when users reference positions or share pages; virtualize when > ~200 rendered rows with continuous scroll; never render > 1,000 DOM rows.
- **Row actions**: primary row click opens detail; overflow menu (⋯) for secondary actions; avoid > 3 inline icon buttons.
- **Export**: CSV/XLSX of current filters and visible columns; async job with notification when > ~10k rows; include timestamp and filters in filename.
- **Density**: comfortable (48 px rows), compact (32–40 px); sticky header and first column on wide tables.
- **Loading**: skeleton rows on first load; keep stale rows with subtle indicator on refresh.

## Dialogs and confirmations
- Use a modal only when the user must decide before continuing; otherwise use inline or side panel.
- Title states the question/action ("Delete 3 projects?"); body states consequences; buttons repeat the verb ("Delete projects" / "Cancel").
- Destructive button uses danger style but is not autofocused; focus Cancel or the dialog title.
- Prefer undo over confirmation for reversible actions.
- Never stack modals; long forms go in a full page or drawer.

## Notifications
| Type | Use | Behaviour |
|------|-----|-----------|
| Inline message | Error/warning tied to a field or section | Persistent until resolved |
| Toast | Success or undoable action result | Auto-dismiss 5–10 s; pause on hover/focus; errors don't auto-dismiss |
| Banner | System-wide or page-level status (maintenance, trial ending) | Dismissible unless blocking |
| Notification center | Async results, mentions, approvals | Persistent, read/unread, deep links |
| Email | Out-of-app events | User-configurable frequency |

Never use a toast for errors that require action.

## Onboarding
- Get users to the first meaningful outcome ("aha") fast; defer configuration that isn't required.
- Checklist of 3–5 setup tasks with progress, dismissible, resumable.
- Sample data or templates to avoid blank slates; clearly labelled and removable.
- Contextual tips on first use of a feature, max one at a time; no forced multi-step tours.
- Admins and end users get different onboarding.

## Empty states
Formula: **What this is** + **why it's empty** + **primary action** (+ secondary: import, docs, sample).
- First use: "No invoices yet. Invoices you create or import appear here. [Create invoice] [Import CSV]"
- No results: "No invoices match 'acme' and Status: Overdue. [Clear filters]"
- Cleared/done: "All caught up. No approvals waiting."
- No permission: "You don't have access to Billing. Ask an Org admin (Jane Smith) to grant the Billing viewer role."

## Error-message formula
**What happened** + **why (if known)** + **how to fix**, in the user's terms, without blame.

| Bad | Good |
|-----|------|
| Invalid input | Enter a date in the format DD/MM/YYYY. |
| Error 403 | You don't have permission to edit this report. Ask the owner, Sam Lee, for edit access. |
| Upload failed | "budget.xlsx" is 32 MB. The limit is 25 MB - split the file or compress it. |
| Something went wrong | We couldn't save your changes because the connection dropped. Your edits are kept - try again. (Ref: 8F2A-91) |

## Microcopy examples
- Buttons: verb + noun - "Create project", "Send invite", "Export 120 rows".
- Confirmation: "Deactivate 12 users? They'll lose access immediately. You can reactivate them later."
- Success toast: "Invoice INV-204 sent to billing@acme.com. [Undo]"
- Loading: "Generating report… this usually takes about 30 seconds."
- Helper text: "Used on invoices and receipts. Max 60 characters."
- Sentence case for all UI text; no ALL CAPS; avoid "please", "oops", jargon, and double negatives.
