//
//  SegueOption.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

/// The way ``Router/showScreen(_:content:)`` presents a new screen.
public enum SegueOption {
    /// Pushes the screen onto the current navigation stack.
    case push
    /// Presents the screen as a sheet with its own navigation stack.
    case sheet
    /// Presents the screen as a full screen cover with its own navigation stack.
    case fullScreenCover

    /// Whether the presented screen needs its own `NavigationStack`.
    ///
    /// `false` for ``push``, which reuses the existing stack. `true` for ``sheet`` and
    /// ``fullScreenCover``, which start a new one.
    public var addRootNavigationStack: Bool {
        switch self {
        case .push:
            false
        case .sheet, .fullScreenCover:
            true
        }
    }
}
