# Contributing to Dovetail

Thanks for helping improve Dovetail! Bug reports, fixes and new modules are all welcome.

## Workflow
1. Open an issue first for new modules or larger changes, so we can agree on scope.
2. Fork the repo and create a branch from `main`.
3. Make your change, with tests and DocC comments for public API.
4. Add an entry under `[Unreleased]` in `CHANGELOG.md`.
5. Open a pull request. CI must pass.

## Adding a module
Each module is independent and exposed as its own library product:
- `Sources/<Module>/` for the code and a `<Module>.docc` catalog
- `Tests/<Module>Tests/` for tests (Swift Testing)
- A `.library` product and `.target`/`.testTarget` entries in `Package.swift`
- The module added to `documentation_targets` in `.spi.yml` and to the modules table in `README.md`

Modules should not depend on each other unless there is a strong reason; prefer no third-party dependencies.

## Requirements
Swift 6.0 toolchain (Xcode 16+), iOS 18+. CI builds with both the oldest and the newest supported Xcode, so avoid SDK APIs newer than Xcode 16 unless they're behind `#if compiler(...)` and `#available` checks.

## Conduct
Participation is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).
