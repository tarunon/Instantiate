// swift-tools-version:3.1

import PackageDescription
import Foundation

let libralies = [
    Target(
        name: "Instantiate"
    ),
    Target(
        name: "InstantiateStandard",
        dependencies: [
            .Target(name: "Instantiate")
        ]
    )
]

let package = Package(
    name: "Instantiate",
    targets: libralies,
    swiftLanguageVersions: [3, 4]
)
