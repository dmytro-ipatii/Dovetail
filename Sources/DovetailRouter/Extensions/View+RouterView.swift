//
//  View+RouterView.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

import SwiftUI

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

    func alertViewModifier(content: Binding<AlertContent?>) -> some View {
        alert(
            content.wrappedValue?.title ?? "",
            item: content,
            actions: { item in
                if !item.actions.isEmpty {
                    item.actions.generateButtonsView()
                } else {
                    if #available(iOS 26.0, *) {
                        Button("OK", role: .close, action: {})
                    } else {
                        // Fallback on earlier versions
                        Button("OK", action: {})
                    }
                }
            },
            message: { item in
                item.message
            })
    }

    func confirmationDialogViewModifier(content: Binding<ConfirmationDialogContent?>) -> some View {
        confirmationDialog(
            content.wrappedValue?.title ?? "",
            item: content,
            actions: { item in
                if !item.actions.isEmpty {
                    item.actions.generateButtonsView()
                } else {
                    if #available(iOS 26.0, *) {
                        Button("OK", role: .close, action: {})
                    } else {
                        // Fallback on earlier versions
                        Button("OK", action: {})
                    }
                }
            },
            message: { item in
                item.message
            }
        )
    }

}
