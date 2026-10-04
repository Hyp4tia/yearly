# Yearly

A minimalist year-progress tracker for iOS, representing every day of your year as a single point of progress on an adaptive Canvas dot lattice.

## Features

- **Responsive Dot Matrix:** Fits all 365 (or 366 in leap years) days on screen without scrolling.
- **OLED Pure Black:** Built for OLED screens with true pitch black (`#000000`) dark mode.
- **Home & Lock Screen Widgets:** Glanceable days remaining and percentage completion with automated 12:00 AM daily refresh.
- **100% Offline & Private:** Zero network requests, zero trackers, and zero data collection.

## Getting Started

1. Open `Yearly.xcodeproj` in Xcode 16+.
2. Select an iOS Simulator (iOS 17.0+) or connected iPhone.
3. Press `Cmd + R` to run or `Cmd + U` to execute unit tests.

## Project Structure

- `Yearly/`: Main iOS application source code and views.
- `YearlyWidget/`: WidgetKit extension source code.
- `YearlyTests/`: Automated unit test suite.
- `work/`: Task tracking and completed milestone records.
- `index.html`: Web-hosted Privacy Policy for GitHub Pages (`https://hyp4tia.github.io/yearly/`).
