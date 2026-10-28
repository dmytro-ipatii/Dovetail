//
//  NavigationStackIfNeededView.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//
import SwiftUI

/// Wraps `content` in a `NavigationStack` bound to `destinations`, or shows it as is when the
/// view is already inside a stack.
struct NavigationStackIfNeededView<Content: View>: View {
    @Binding var destinations: [AnyDestination]
    var addNavigationStack: Bool

    @ViewBuilder var content: Content

    var body: some View {
        if addNavigationStack {
            NavigationStack(
                path: $destinations,
                root: ({
                    content
                        .navigationDestination(for: AnyDestination.self, destination: ({ destination in
                            destination.destination
                        }))
                })
            )
        } else {
            content
        }
    }
}
