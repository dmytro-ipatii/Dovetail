//
//  AlertContent.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 25/10/2026.
//

import SwiftUI

public struct AlertContent {
    let title: String
    var message: AnyView?
    var actions: [ButtonContent] = []

    public init(
        title: String,
        message: AnyView? = nil,
        actions: [ButtonContent]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}
