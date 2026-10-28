//
//  CustomModalViewModifier.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 25/10/2026.
//
import SwiftUI

struct CustomModalView: View {

    var backgroundColor: Color
    var transition: AnyTransition

    var modalContentView: AnyView?
    var onOutsidePress: () -> Void

    var body: some View {
        ZStack {
            if let modalContentView {
                backgroundColor
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(
                                .linear
                            ),
                            removal: .opacity.animation(
                                .linear.delay(
                                    0.1
                                )
                            )
                        )
                    )
                    .zIndex(10)
                    .onTapGesture {
                        onOutsidePress()
                    }

                modalContentView
                    .transition(transition)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zIndex(20)

            }
        }
        .zIndex(999999)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.spring(
            response: 0.3,
            dampingFraction: 0.8
        ), value: modalContentView != nil)
    }
}
