//
//  NavigationStackIfNeededView.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 23/10/2026.
//
import SwiftUI

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
