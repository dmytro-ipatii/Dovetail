//
//  AnyDestination.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

/// A type-erased screen that can be stored in a navigation path or presented as a sheet.
///
/// Each destination gets a unique ``id`` when it's created. Two destinations are equal only if they
/// share that identifier, even when they wrap the same view.
public struct AnyDestination: Hashable, Identifiable {

    var destination: AnyView

    /// Creates a destination that wraps the given view.
    ///
    /// - Parameter destination: The view to show when the destination is presented.
    public init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }

    /// A unique identifier, generated when the destination is created.
    public let id: String = UUID().uuidString

    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
