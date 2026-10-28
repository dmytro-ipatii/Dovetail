//
//  DovetailRouterView.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//
import SwiftUI

public struct DovetailRouterView<Content: View>: View, DovetailRouter {
    @Environment(\.dismiss) private var dismiss

    @State private var destinations: [AnyDestination] = []
    @Binding private var screenDestinations: [AnyDestination]

    @State private var sheetScreen: AnyDestination?
    @State private var fullScreenCover: AnyDestination?

    // Modal, Alerts and Dialog
    @State private var modalBackgroundColor: Color = Color.black.opacity(0.25)
    @State private var modalTransition: AnyTransition = AnyTransition.scale(scale: 0.9).combined(with: .opacity)

    @State private var customModal: AnyDestination?

    @State private var alertContent: AlertContent?
    @State private var confirmationDialogContent: ConfirmationDialogContent?

    private var addNavigationStack: Bool = true

    @ViewBuilder var content: (_ router: DovetailRouter) -> Content

    public init(
        addNavigationStack: Bool = true,
        screenDestinations: (Binding<[AnyDestination]>)? = nil,
        content: @escaping (_ router: DovetailRouter) -> Content
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
        @ViewBuilder content: @escaping (DovetailRouter) -> T
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
        backgroundColor: Color = Color.black.opacity(0.25),
        transition: AnyTransition = AnyTransition.scale(scale: 0.9).combined(with: .opacity),
        @ViewBuilder content: @escaping () -> T
    ) {
        modalBackgroundColor = backgroundColor
        modalTransition = transition
        customModal = AnyDestination(destination: content())
    }

    public func showModal<T: View>(
        @ViewBuilder content: @escaping () -> T
    ) {
        customModal = AnyDestination(destination: content())
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
