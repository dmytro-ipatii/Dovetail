//
//  AnyDestination.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

public struct AnyDestination: Hashable, Identifiable {

    var destination: AnyView

    public init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }

    public var id: String = UUID().uuidString

    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
