import Testing
@testable import DovetailRouter

@Suite("SegueOption")
struct SegueOptionTests {
    @Test func pushReusesExistingNavigationStack() {
        #expect(SegueOption.push.addRootNavigationStack == false)
    }

    @Test func sheetAddsRootNavigationStack() {
        #expect(SegueOption.sheet.addRootNavigationStack)
    }

    @Test func fullScreenCoverAddsRootNavigationStack() {
        #expect(SegueOption.fullScreenCover.addRootNavigationStack)
    }
}
