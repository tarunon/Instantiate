// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Instantiate",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_11)
    ],
    products: [
        .library(
            name: "Instantiate",
            targets: ["Instantiate"]
        ),
        .library(
            name: "InstantiateStandard",
            targets: ["InstantiateStandard"]
        )
    ],
    targets: [
        .target(
            name: "Instantiate"
        ),
        .target(
            name: "InstantiateStandard",
            dependencies: [
                .target(name: "Instantiate")
            ]
        ),
        .testTarget(
            name: "InstantiateTests",
            dependencies: ["Instantiate", "InstantiateStandard"]
        )
    ],
    swiftLanguageVersions: [.v4, .v5]
)
