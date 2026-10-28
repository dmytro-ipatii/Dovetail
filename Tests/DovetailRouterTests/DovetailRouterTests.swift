import SwiftUI
import Testing
@testable import DovetailRouter

@MainActor
@Suite("DovetailRouter environment", .tags(.router))
struct DovetailRouterTests {
    @Test func defaultEnvironmentRouterIsMockRouter() {
        let router = EnvironmentValues().dovetailRouter
        #expect(router is MockRouter)
    }

    @Test func environmentRouterCanBeReplaced() {
        var environment = EnvironmentValues()
        let router = MockRouter()
        environment.dovetailRouter = router
        #expect((environment.dovetailRouter as? MockRouter) === router)
    }

    @Test func mockRouterHandlesEveryCallWithoutPresenting() {
        let router: Router = MockRouter()
        let alert = AlertContent(title: "Alert", actions: [])
        let dialog = ConfirmationDialogContent(title: "Dialog", actions: [])

        for segue in [SegueOption.push, .sheet, .fullScreenCover] {
            router.showScreen(segue) { _ in EmptyView() }
        }
        router.dismissScreen()
        router.showModal { EmptyView() }
        router.showModal(backgroundColor: .red, transition: .opacity) { EmptyView() }
        router.dismissModal()
        router.showAlert(content: alert)
        router.dismissAlert()
        router.showConfirmationDialog(content: dialog)
        router.dismissConfirmationDialog()
    }
}
