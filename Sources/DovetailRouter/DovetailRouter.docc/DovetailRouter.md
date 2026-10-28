# ``DovetailRouter``

Imperative navigation for SwiftUI: push screens, present sheets, full screen covers, custom modals, alerts and confirmation dialogs from anywhere in your view hierarchy.

## Overview

Wrap the root of your app in a ``DovetailRouterView``. It owns a `NavigationStack` and every presentation state, and hands a router to its content:

```swift
import DovetailRouter

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            DovetailRouterView { router in
                HomeView(router: router)
            }
        }
    }
}
```

Use the router to navigate. Each new screen receives its own router, so it can keep routing:

```swift
router.showScreen(.push) { router in
    DetailView(router: router)
}

router.showScreen(.sheet) { router in
    SettingsView(router: router)
}

router.showAlert(content: AlertContent(
    title: "Saved",
    message: "Your changes are saved.",
    actions: []
))
```

Views that don't receive the router directly can read it from the environment with ``SwiftUICore/EnvironmentValues/dovetailRouter``.

## Topics

### Routing

- ``DovetailRouterView``
- ``Router``
- ``SegueOption``
- ``MockRouter``

### Alerts and dialogs

- ``AlertContent``
- ``ConfirmationDialogContent``
- ``ButtonContent``

### Supporting types

- ``AnyDestination``
