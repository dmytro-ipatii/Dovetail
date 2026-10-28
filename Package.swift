// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Dovetail",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(name: "DovetailRouter", targets: ["DovetailRouter"]),
    ],
    targets: [
        .target(name: "DovetailRouter"),
        .testTarget(name: "DovetailRouterTests", dependencies: ["DovetailRouter"]),
    ],
    swiftLanguageModes: [.v6]
)
