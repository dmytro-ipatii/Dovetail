import SwiftUI
import Testing
@testable import DovetailRouter

@MainActor
@Suite("ButtonContent")
struct ButtonContentTests {
    @Test func roleDefaultsToNil() {
        let button = ButtonContent(label: "OK", action: {})
        #expect(button.label == "OK")
        #expect(button.role == nil)
    }

    @Test func storesProvidedRole() {
        let button = ButtonContent(label: "Delete", role: .destructive, action: {})
        #expect(button.role == .destructive)
    }

    @Test func actionRunsWhenInvoked() {
        var callCount = 0
        let button = ButtonContent(label: "Tap") { callCount += 1 }
        button.action()
        button.action()
        #expect(callCount == 2)
    }

    @Test func eachButtonGetsUniqueID() {
        let first = ButtonContent(label: "Same", action: {})
        let second = ButtonContent(label: "Same", action: {})
        #expect(first.id != second.id)
    }
}

@MainActor
@Suite("AlertContent")
struct AlertContentTests {
    @Test func messageDefaultsToNil() {
        let alert = AlertContent(title: "Title", actions: [])
        #expect(alert.title == "Title")
        #expect(alert.message == nil)
        #expect(alert.actions.isEmpty)
    }

    @Test func storesMessageAndActionsInOrder() {
        let alert = AlertContent(
            title: "Title",
            message: AnyView(Text("Message")),
            actions: [
                ButtonContent(label: "Cancel", role: .cancel, action: {}),
                ButtonContent(label: "Delete", role: .destructive, action: {})
            ]
        )
        #expect(alert.message != nil)
        #expect(alert.actions.map(\.label) == ["Cancel", "Delete"])
    }
}

@MainActor
@Suite("ConfirmationDialogContent")
struct ConfirmationDialogContentTests {
    @Test func messageDefaultsToNil() {
        let dialog = ConfirmationDialogContent(title: "Title", actions: [])
        #expect(dialog.title == "Title")
        #expect(dialog.message == nil)
        #expect(dialog.actions.isEmpty)
    }

    @Test func storesMessageAndActionsInOrder() {
        let dialog = ConfirmationDialogContent(
            title: "Title",
            message: AnyView(Text("Message")),
            actions: [
                ButtonContent(label: "Share", action: {}),
                ButtonContent(label: "Remove", role: .destructive, action: {})
            ]
        )
        #expect(dialog.message != nil)
        #expect(dialog.actions.map(\.label) == ["Share", "Remove"])
    }
}
