//
//  ConfirmationDialogContent.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 25/10/2026.
//
import SwiftUI

/// The content of a confirmation dialog presented with
/// ``Router/showConfirmationDialog(content:)``.
///
/// ```swift
/// router.showConfirmationDialog(content: ConfirmationDialogContent(
///     title: "Photo",
///     actions: [
///         ButtonContent(label: "Share") { share() },
///         ButtonContent(label: "Remove", role: .destructive) { remove() }
///     ]
/// ))
/// ```
public struct ConfirmationDialogContent {
    /// The title of the dialog.
    public let title: String
    /// An optional view shown below the title.
    public let message: AnyView?
    /// The buttons of the dialog, in display order.
    public let actions: [ButtonContent]

    /// Creates the content of a confirmation dialog with a custom message view.
    ///
    /// - Parameters:
    ///   - title: The title of the dialog.
    ///   - message: An optional view shown below the title.
    ///   - actions: The buttons of the dialog, in display order. When empty, a single OK button is shown.
    public init(
        title: String,
        message: AnyView? = nil,
        actions: [ButtonContent]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }

    /// Creates the content of a confirmation dialog with a text message.
    ///
    /// - Parameters:
    ///   - title: The title of the dialog.
    ///   - message: The text shown below the title.
    ///   - actions: The buttons of the dialog, in display order. When empty, a single OK button is shown.
    public init(
        title: String,
        message: String,
        actions: [ButtonContent]
    ) {
        self.init(title: title, message: AnyView(Text(message)), actions: actions)
    }
}
