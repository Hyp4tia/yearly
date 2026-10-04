# Task: App Store Readiness Audit

- **ID:** TASK-001
- **Status:** Completed
- **Owner:** Hyp4tia / Antigravity
- **Area:** Core App

## Intended outcome

Audit Yearly against Apple App Store Review Guidelines (2.1, 2.3, 2.5, 4.2, 5.1), diagnose and fix build failures, add privacy manifests, and verify 100% test coverage.

## Completion criteria

- Xcode project builds cleanly for iOS Simulator and physical device.
- Apple Privacy Manifest (`PrivacyInfo.xcprivacy`) included with required reason CA92.1.
- All unit tests pass with zero failures.
- App icon meets 1024x1024 no-alpha requirement.

## Current progress

- Build failure diagnosed and resolved.
- `PrivacyInfo.xcprivacy` created in both `Yearly` and `YearlyWidget` targets.
- 18/18 tests passing.

## Next action

None (completed).

## Blockers

None.

## Sources and decisions

- Links to `DECISIONS.md#DEC-004`.
- Artifact: `APP_STORE_READINESS_AUDIT.md`.

## Deliverables

- `Yearly/PrivacyInfo.xcprivacy`
- `YearlyWidget/PrivacyInfo.xcprivacy`
- `Yearly/Assets.xcassets/AppIcon.appiconset/AppIcon.png`

## Completion evidence

- `xcodebuild -project Yearly.xcodeproj -scheme Yearly -destination "generic/platform=iOS Simulator" clean build` succeeded.
- `xcodebuild test` executed 18 tests with 0 failures on October 5, 2026.
