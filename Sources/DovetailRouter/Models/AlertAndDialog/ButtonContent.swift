//
//  ButtonContent.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 25/10/2026.
//
import SwiftUI

public struct ButtonContent: Identifiable {
    public let id = UUID().uuidString
    let label: String
    var role: ButtonRole?
    let action: () -> Void

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

public extension Array where Element == ButtonContent {
    func generateButtonsView() -> AnyView {
        AnyView(ForEach(self) { action in
            Button(action.label, role: action.role, action: action.action)
        })
    }
}
