//
//  ButtonContent.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 25/10/2026.
//
import SwiftUI

/// A button shown in an ``AlertContent`` or a ``ConfirmationDialogContent``.
public struct ButtonContent: Identifiable {
    /// A unique identifier, generated when the button is created.
    public let id = UUID().uuidString
    /// The title of the button.
    public let label: String
    /// The role of the button, such as `.cancel` or `.destructive`, if any.
    public let role: ButtonRole?
    /// The closure to run when the button is tapped.
    public let action: () -> Void

    /// Creates a button.
    ///
    /// - Parameters:
    ///   - label: The title of the button.
    ///   - role: An optional role, such as `.cancel` or `.destructive`, that controls the button's
    ///     appearance and placement.
    ///   - action: The closure to run when the button is tapped. The alert or dialog is dismissed
    ///     automatically.
    public init(
        label: String,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.role = role
        self.action = action
    }
}

extension Array where Element == ButtonContent {
    /// Builds a SwiftUI `Button` for each element, in order.
    ///
    /// - Returns: A type-erased view containing the buttons.
    func generateButtonsView() -> AnyView {
        AnyView(ForEach(self) { action in
            Button(action.label, role: action.role, action: action.action)
        })
    }
}
