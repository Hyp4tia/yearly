# Task: Apple Developer Account Assignment & App Store Submission

- **ID:** TASK-004
- **Status:** Queued
- **Owner:** Hyp4tia
- **Area:** Release / Distribution

## Intended outcome

Assign paid Apple Developer Program Team ID to Yearly targets, create App Store Connect app entry, create signed release archive, and upload build for App Store review.

## Completion criteria

- Apple Developer Program license active ($99/year).
- Official Developer Team assigned in `Yearly.xcodeproj` under Signing & Capabilities.
- App record created on App Store Connect (`com.hyp4tia.Yearly`).
- Xcode archive built with `Any iOS Device (arm64)` destination and uploaded to App Store Connect.
- Build passes automated App Store Connect ingestion with zero issues.

## Current progress

- Codebase 100% audited and compliant with all guidelines.
- 18/18 tests passing.
- Privacy policy live at `https://hyp4tia.github.io/yearly/`.

## Next action

Purchase Apple Developer Program license and select Developer Team in Xcode.

## Blockers

Awaiting purchase of Apple Developer Program license.

## Sources and decisions

- Links to `PROJECT.md#Constraints and stakeholders`.
- Deployment Guide: `APP_STORE_READINESS_AUDIT.md`.

## Deliverables

- Signed iOS Archive (`.xcarchive`).
- App Store Connect release build.
