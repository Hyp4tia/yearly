# Agent Instructions: Yearly

These instructions govern all AI agent work within the Yearly codebase.

## Scope & Preservation

- **Zero Unintended Modification:** Never edit, reformat, or delete existing code files outside the explicit task scope.
- **OLED Dark Mode Rule:** Dark mode must always resolve to pitch OLED pure black (`#000000`). Never use UIKit default gray `#1C1C1E` for app backgrounds.
- **Theme Synchronization:** Use `WindowStyleModifier` and `SharedStorage` for appearance management. Do not reintroduce `.preferredColorScheme(nil)`.
- **Privacy & Offline Integrity:** Yearly is strictly 100% offline. Never introduce network calls, analytics, trackers, or external dependencies.

## Verification Requirements

- Always run `xcodebuild -project Yearly.xcodeproj -scheme Yearly -destination "generic/platform=iOS Simulator" build` after modifying Swift files.
- Always run `xcodebuild test` and confirm all 18 tests pass before marking tasks complete.
- Verify both light and dark mode appearance on device or simulator when adjusting visuals.

## Work System & Records

- Document new work in `work/active/` using `work/TASK-TEMPLATE.md`.
- Completed work moves to `work/completed/` with deliverables linked in `outputs/` or the codebase.
