//
//  Router.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

public extension EnvironmentValues {
    /// The router of the closest enclosing ``DovetailRouterView``.
    ///
    /// Every ``DovetailRouterView`` injects itself into the environment, so any view inside it can
    /// navigate without passing the router down explicitly:
    ///
    /// ```swift
    /// struct ProfileButton: View {
    ///     @Environment(\.dovetailRouter) private var router
    ///
    ///     var body: some View {
    ///         Button("Profile") {
    ///             router.showScreen(.push) { _ in ProfileView() }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// Outside of a ``DovetailRouterView`` the value is a ``MockRouter``, which only logs each call.
    @Entry var dovetailRouter: Router = MockRouter()
}

/// An interface for presenting and dismissing screens, modals, alerts and confirmation dialogs.
///
/// ``DovetailRouterView`` is the concrete implementation used in apps. Depend on this protocol in
/// your views and view models so navigation can be replaced with a test double, such as ``MockRouter``.
///
/// Each method only changes the presentation state of the router that receives the call.
/// Screens shown with ``showScreen(_:content:)`` get their own router, passed to the `content` closure.
@MainActor
public protocol Router {
    /// Presents a new screen.
    ///
    /// The new screen is wrapped in its own ``DovetailRouterView``, so it can route further using the
    /// router passed to `content`.
    ///
    /// - Parameters:
    ///   - segue: How the screen is presented. See ``SegueOption``.
    ///   - content: A view builder that receives the new screen's router and returns its content.
    func showScreen<T: View>(
        _ segue: SegueOption,
        @ViewBuilder content: @escaping (Router) -> T
    )

    /// Dismisses the current screen.
    ///
    /// Pops a pushed screen, or dismisses a screen presented as a sheet or full screen cover.
    /// Has no effect on the root screen of the app.
    func dismissScreen()

    /// Presents a custom modal over the current screen with the given styling.
    ///
    /// Tapping the background outside the modal content dismisses it.
    ///
    /// - Parameters:
    ///   - backgroundColor: The color that fills the screen behind the modal content.
    ///   - transition: The transition used to insert and remove the modal content.
    ///   - content: A view builder that returns the modal content.
    func showModal<T: View>(
        backgroundColor: Color,
        transition: AnyTransition,
        @ViewBuilder content: @escaping () -> T
    )

    /// Presents a custom modal over the current screen with the default styling.
    ///
    /// The background is black at 25% opacity, and the content appears with a slight scale combined
    /// with a fade. Tapping the background outside the modal content dismisses it.
    ///
    /// - Parameter content: A view builder that returns the modal content.
    func showModal<T: View>(
        @ViewBuilder content: @escaping () -> T
    )

    /// Dismisses the custom modal, if one is shown.
    func dismissModal()

    /// Presents an alert.
    ///
    /// - Parameter content: The title, message and buttons of the alert.
    func showAlert(content: AlertContent)

    /// Dismisses the alert, if one is shown.
    func dismissAlert()

    /// Presents a confirmation dialog.
    ///
    /// - Parameter content: The title, message and buttons of the dialog.
    func showConfirmationDialog(content: ConfirmationDialogContent)

    /// Dismisses the confirmation dialog, if one is shown.
    func dismissConfirmationDialog()
}

/// A router that presents nothing and logs every call instead.
///
/// This is the default value of ``SwiftUICore/EnvironmentValues/dovetailRouter`` outside of a
/// ``DovetailRouterView``. It is also useful in SwiftUI previews and tests, where real navigation
/// isn't needed.
public final class MockRouter: Router {
    public func showScreen<T>(
        _ segue: SegueOption,
        content: @escaping (any Router) -> T
    ) where T: View {
        print("The Router Environment is not initialized.")
    }

    public func dismissScreen() {
        print("The Router Environment is not initialized.")
    }

    public func showModal<T: View>(
        @ViewBuilder content: @escaping () -> T
    ) {
        print("The Router Environment is not initialized.")
    }

    public func showModal<T: View>(
        backgroundColor: Color,
        transition: AnyTransition,
        @ViewBuilder content: @escaping () -> T
    ) {
        print("The Router Environment is not initialized.")
    }

    public func dismissModal() {
        print("The Router Environment is not initialized.")
    }

    public func showAlert(content: AlertContent) {
        print("The Router Environment is not initialized.")
    }

    public func dismissAlert() {
        print("The Router Environment is not initialized.")
    }

    public func showConfirmationDialog(content: ConfirmationDialogContent) {
        print("The Router Environment is not initialized.")
    }

    public func dismissConfirmationDialog() {
        print("The Router Environment is not initialized.")
    }
}
