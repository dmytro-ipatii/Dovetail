//
//  AlertContent.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 25/10/2026.
//

import SwiftUI

/// The content of an alert presented with ``Router/showAlert(content:)``.
///
/// ```swift
/// router.showAlert(content: AlertContent(
///     title: "Delete item?",
///     message: "This can't be undone.",
///     actions: [
///         ButtonContent(label: "Cancel", role: .cancel) {},
///         ButtonContent(label: "Delete", role: .destructive) { deleteItem() }
///     ]
/// ))
/// ```
public struct AlertContent {
    /// The title of the alert.
    public let title: String
    /// An optional view shown below the title.
    public let message: AnyView?
    /// The buttons of the alert, in display order.
    public let actions: [ButtonContent]

    /// Creates the content of an alert with a custom message view.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: An optional view shown below the title.
    ///   - actions: The buttons of the alert, in display order. When empty, a single OK button is shown.
    public init(
        title: String,
        message: AnyView? = nil,
        actions: [ButtonContent]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }

    /// Creates the content of an alert with a text message.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The text shown below the title.
    ///   - actions: The buttons of the alert, in display order. When empty, a single OK button is shown.
    public init(
        title: String,
        message: String,
        actions: [ButtonContent]
    ) {
        self.init(title: title, message: AnyView(Text(message)), actions: actions)
    }
}
