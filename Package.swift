// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Dovetail",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // One library product per module, e.g.
        // .library(name: "AppRouter", targets: ["AppRouter"]),
    ],
    targets: [
        // One target (and matching test target) per module, e.g.
        // .target(name: "AppRouter"),
        // .testTarget(name: "AppRouterTests", dependencies: ["AppRouter"]),
    ]
)
