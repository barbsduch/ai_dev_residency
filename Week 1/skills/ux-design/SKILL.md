---
name: ux-design
description: Enterprise UX standards for any UI work — screens, components, flows, forms, empty/error/loading states, navigation, copy. Use whenever building or reviewing user-facing interfaces.
---
# UX Design

## Goal
Interfaces a busy professional can use correctly on first try, at scale, with real data.

## Always do
1. **Start from the job**: state the user, their task, and success in one line before designing.
2. **Design every state**: empty, loading (skeletons > spinners), partial, error, success, no-permission, offline.
3. **Use real data shapes**: long names, 0 / 1 / 10,000 rows, missing fields, RTL text, large numbers.
4. **One primary action per view**; destructive actions are secondary, confirmed, and undoable where possible.
5. **Forms**: labels above fields, inline validation on blur, errors say what went wrong *and* how to fix it, preserve input on failure.
6. **Consistency**: reuse the design system's tokens and components; never hardcode colors, spacing, or fonts.
7. **Tables (enterprise core)**: sort, filter, pagination or virtualization, column persistence, bulk actions, export.
8. **Feedback within 100ms**; anything > 1s shows progress; > 10s runs in background with notification.
9. **Microcopy**: plain verbs ("Save invoice", not "Submit"), no jargon, no blame.
10. **Responsive**: works at 320px width and at 1920px+ dense layouts.

## Anti-patterns
- Modals on modals; hidden critical actions in kebab menus; disabled buttons with no explanation.
- "Something went wrong" with no next step.
- Placeholder text used as labels.

## Review output
List issues as: **Severity (blocker/major/minor) – Location – Problem – Fix**. Reference Nielsen's 10 heuristics by name where relevant.
