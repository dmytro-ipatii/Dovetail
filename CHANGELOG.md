# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-10-28

### Added
- `DovetailRouter` module, a router for SwiftUI navigation:
  - `DovetailRouterView`, a container that owns a `NavigationStack` and presents screens on behalf of its content.
  - The `Router` protocol, to push screens and present sheets, full screen covers, custom modals, alerts and confirmation dialogs.
  - `AlertContent`, `ConfirmationDialogContent` and `ButtonContent` to describe alerts and dialogs, with a `message: String` convenience initializer.
  - The `dovetailRouter` environment value, so nested views can route without passing the router down.
  - `MockRouter`, a no-op router for previews and tests.
  - DocC documentation.

[Unreleased]: https://github.com/dmytro-ipatii/Dovetail/compare/0.1.0...HEAD
[0.1.0]: https://github.com/dmytro-ipatii/Dovetail/releases/tag/0.1.0
