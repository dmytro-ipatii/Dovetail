//
//  View+RouterView.swift
//  Dovetail
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

/// Presentation modifiers used by ``DovetailRouterView``. Each one presents while its binding is
/// non-`nil` and resets the binding to `nil` when dismissed.
extension View {
    func sheetViewModifier(screen: Binding<AnyDestination?>) -> some View {
        sheet(item: screen) { screen in
            ZStack {
                screen.destination
            }
        }
    }

    func fullScreenCoverViewModifier(screen: Binding<AnyDestination?>) -> some View {
        fullScreenCover(item: screen) { screen in
            ZStack {
                screen.destination
            }
        }
    }

    /// Overlays a ``CustomModalView`` that shows `screen` and calls `onOutsidePress` when the
    /// background is tapped.
    func customModalViewModifier(
        backgroundColor: Color,
        transition: AnyTransition,
        screen: Binding<AnyDestination?>,
        onOutsidePress: @escaping () -> Void
    ) -> some View {
        overlay {
            ZStack {
                CustomModalView(
                    backgroundColor: backgroundColor,
                    transition: transition,
                    modalContentView: screen.wrappedValue?.destination,
                    onOutsidePress: onOutsidePress
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
    }

    // The `isPresented:presenting:` variants are used instead of the newer `item:` ones,
    // which only exist in the Xcode 27 SDK.

    /// Shows an alert for `content`, with a single OK button when it has no actions.
    func alertViewModifier(content: Binding<AlertContent?>) -> some View {
        alert(
            content.wrappedValue?.title ?? "",
            isPresented: content.isPresented,
            presenting: content.wrappedValue,
            actions: { item in
                if !item.actions.isEmpty {
                    item.actions.generateButtonsView()
                } else {
                    DefaultDismissButton()
                }
            },
            message: { item in
                item.message
            })
    }

    /// Shows a confirmation dialog for `content`, with a single OK button when it has no actions.
    func confirmationDialogViewModifier(content: Binding<ConfirmationDialogContent?>) -> some View {
        confirmationDialog(
            content.wrappedValue?.title ?? "",
            isPresented: content.isPresented,
            presenting: content.wrappedValue,
            actions: { item in
                if !item.actions.isEmpty {
                    item.actions.generateButtonsView()
                } else {
                    DefaultDismissButton()
                }
            },
            message: { item in
                item.message
            }
        )
    }

}

/// The OK button shown when an alert or dialog has no actions.
private struct DefaultDismissButton: View {
    var body: some View {
        // `ButtonRole.close` is only in the iOS 26 SDK, which ships with Swift 6.2.
        #if compiler(>=6.2)
        if #available(iOS 26.0, *) {
            Button("OK", role: .close, action: {})
        } else {
            Button("OK", action: {})
        }
        #else
        Button("OK", action: {})
        #endif
    }
}

extension Optional {
    /// `true` while the value is non-`nil`. Setting it to `false` clears the value.
    ///
    /// Lets a `Binding<Value?>` drive an `isPresented:` binding, as `binding.isPresented`.
    var isPresented: Bool {
        get { self != nil }
        set { if !newValue { self = nil } }
    }
}
