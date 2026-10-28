//
//  DovetailRouter.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var dovetailRouter: DovetailRouter = MockRouter()
}

@MainActor
public protocol DovetailRouter {
    func showScreen<T: View>(
        _ segue: SegueOption,
        @ViewBuilder content: @escaping (DovetailRouter) -> T
    )
    func dismissScreen()
    func showModal<T: View>(
        backgroundColor: Color,
        transition: AnyTransition,
        @ViewBuilder content: @escaping () -> T
    )
    func showModal<T: View>(
        @ViewBuilder content: @escaping () -> T
    )
    func dismissModal()
    func showAlert(content: AlertContent)
    func dismissAlert()
    func showConfirmationDialog(content: ConfirmationDialogContent)
    func dismissConfirmationDialog()
}

public class MockRouter: DovetailRouter {
    public func showScreen<T>(
        _ segue: SegueOption,
        content: @escaping (any DovetailRouter) -> T
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
