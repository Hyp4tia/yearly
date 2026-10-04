# Project status: Yearly

This is a short overview of Yearly's current milestone and readiness. Detailed tasks live in `work/`.

## Current state

- **Development Phase:** Feature complete & App Store ready.
- **Test Suite:** 18/18 unit tests passing (`xcodebuild test`).
- **Build Status:** Verified clean build for iOS Simulator and physical device (`** BUILD SUCCEEDED **`).
- **Privacy Policy:** Published and live at `https://hyp4tia.github.io/yearly/`.
- **Blocker:** Awaiting purchase of Apple Developer Program license ($99/year) to sign with distribution certificates and submit to App Store Connect.

## Work overview

| State | Task record or existing work-system link | Short summary |
| --- | --- | --- |
| Completed | `work/completed/TASK-001-app-store-audit.md` | Full App Store readiness audit, build diagnosis, and privacy manifest declaration. |
| Completed | `work/completed/TASK-002-oled-dark-mode.md` | Pure OLED `#000000` dark mode, system theme tracking, and appearance toggle. |
| Completed | `work/completed/TASK-003-widgets-and-privacy.md` | Home/Lock Screen widgets with midnight reload, and GitHub Pages privacy policy. |
| Queued | `work/queued/TASK-004-app-store-submission.md` | Assign Team ID, configure App Store Connect listing, archive, and upload build. |

## Blockers and next action

- **Blocker:** Developer enrollment required for official code signing.
- **Next Action:** Purchase Apple Developer Program membership, configure Team ID in `Yearly.xcodeproj`, and upload archive to App Store Connect.

## Evidence and last review

- Verified by automated build and test runs on October 5, 2026.
