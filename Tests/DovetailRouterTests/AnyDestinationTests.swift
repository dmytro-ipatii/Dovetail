import SwiftUI
import Testing
@testable import DovetailRouter

@MainActor
@Suite("AnyDestination")
struct AnyDestinationTests {
    @Test func eachDestinationGetsUniqueID() {
        let first = AnyDestination(destination: Text("First"))
        let second = AnyDestination(destination: Text("First"))
        #expect(first.id != second.id)
    }

    @Test func destinationsWithSameContentAreNotEqual() {
        let first = AnyDestination(destination: EmptyView())
        let second = AnyDestination(destination: EmptyView())
        #expect(first != second)
    }

    @Test func copiesAreEqualAndHashIdentically() {
        let destination = AnyDestination(destination: EmptyView())
        let copy = destination
        #expect(destination == copy)
        #expect(destination.hashValue == copy.hashValue)
    }

    @Test func destinationsDeduplicateInSetByID() {
        let destination = AnyDestination(destination: EmptyView())
        let other = AnyDestination(destination: EmptyView())
        let set: Set<AnyDestination> = [destination, destination, other]
        #expect(set.count == 2)
    }
}
