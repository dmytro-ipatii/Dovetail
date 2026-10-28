//
//  DovetailRouterView.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//
import SwiftUI

/// A container view that owns the navigation state of a screen and routes from it.
///
/// Wrap the root of your app, or of any independent flow, in a `DovetailRouterView`. It provides a
/// `NavigationStack` and presents sheets, full screen covers, custom modals, alerts and confirmation
/// dialogs on behalf of its content.
///
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             DovetailRouterView { router in
///                 HomeView(router: router)
///             }
///         }
///     }
/// }
/// ```
///
/// The router is passed to `content` and also injected as
/// ``SwiftUICore/EnvironmentValues/dovetailRouter``, so nested views can read it from the environment.
public struct DovetailRouterView<Content: View>: View, Router {
    @Environment(\.dismiss) private var dismiss

    @State private var destinations: [AnyDestination] = []
    @Binding private var screenDestinations: [AnyDestination]

    @State private var sheetScreen: AnyDestination?
    @State private var fullScreenCover: AnyDestination?

    // Modal, Alerts and Dialog
    @State private var modalBackgroundColor: Color = ModalDefaults.backgroundColor
    @State private var modalTransition: AnyTransition = ModalDefaults.transition

    @State private var customModal: AnyDestination?

    @State private var alertContent: AlertContent?
    @State private var confirmationDialogContent: ConfirmationDialogContent?

    private var addNavigationStack: Bool = true

    @ViewBuilder var content: (_ router: Router) -> Content

    /// Creates a router view.
    ///
    /// For the root of a flow, use the default values and pass only `content`.
    ///
    /// - Parameters:
    ///   - addNavigationStack: Whether to wrap `content` in its own `NavigationStack`. Pass `false`
    ///     when the view is already inside a navigation stack owned by another router.
    ///   - screenDestinations: The navigation path of the enclosing stack, used when
    ///     `addNavigationStack` is `false` so pushed screens join that stack. Pass `nil` for a root router.
    ///   - content: A view builder that receives this router and returns the screen's content.
    public init(
        addNavigationStack: Bool = true,
        screenDestinations: (Binding<[AnyDestination]>)? = nil,
        content: @escaping (_ router: Router) -> Content
    ) {
        self.addNavigationStack = addNavigationStack
        self._screenDestinations = screenDestinations ?? .constant([])
        self.content = content
    }

    public var body: some View {
        NavigationStackIfNeededView(
            destinations: $destinations,
            addNavigationStack: addNavigationStack,
            content: ({
                content(self)
                    .sheetViewModifier(screen: $sheetScreen)
                    .fullScreenCoverViewModifier(screen: $fullScreenCover)
                    .alertViewModifier(content: $alertContent)
                    .confirmationDialogViewModifier(content: $confirmationDialogContent)

            })
        )
        .customModalViewModifier(
            backgroundColor: modalBackgroundColor,
            transition: modalTransition,
            screen: $customModal, onOutsidePress: dismissModal
        )
        .environment(\.dovetailRouter, self)
    }

    public func showScreen<T: View>(
        _ segue: SegueOption,
        @ViewBuilder content: @escaping (Router) -> T
    ) {
        let isRoot: Bool = screenDestinations.isEmpty

        let screen = DovetailRouterView<T>(
            addNavigationStack: segue.addRootNavigationStack,
            screenDestinations: segue.addRootNavigationStack ? nil : (isRoot ? $destinations : $screenDestinations),
            content: content
        )

        let destination = AnyDestination(destination: screen)

        switch segue {
        case .push:
            if isRoot {
                /// The destinations contains the initial screen added to the router
                destinations.append(destination)
            } else {
                /// The screenDestinations contains the secondary screens added when routing
                screenDestinations.append(destination)
            }
        case .sheet:
            sheetScreen = destination

        case .fullScreenCover:
            fullScreenCover = destination
        }
    }

    public func showModal<T: View>(
        backgroundColor: Color,
        transition: AnyTransition,
        @ViewBuilder content: @escaping () -> T
    ) {
        modalBackgroundColor = backgroundColor
        modalTransition = transition
        customModal = AnyDestination(destination: content())
    }

    public func showModal<T: View>(
        @ViewBuilder content: @escaping () -> T
    ) {
        // Reset the styling, so a previously styled modal doesn't leak into this one.
        showModal(
            backgroundColor: ModalDefaults.backgroundColor,
            transition: ModalDefaults.transition,
            content: content
        )
    }

    public func dismissModal() {
        customModal = nil
    }

    public func showAlert(content: AlertContent) {
        alertContent = content
    }

    public func dismissAlert() {
        alertContent = nil
    }

    public func showConfirmationDialog(content: ConfirmationDialogContent) {
        confirmationDialogContent = content
    }

    public func dismissConfirmationDialog() {
        confirmationDialogContent = nil
    }

    public func dismissScreen() {
        dismiss()
    }
}

/// The styling of a custom modal shown with ``Router/showModal(content:)``.
enum ModalDefaults {
    static var backgroundColor: Color { Color.black.opacity(0.25) }
    static var transition: AnyTransition { AnyTransition.scale(scale: 0.9).combined(with: .opacity) }
}
