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
    ),
    Target(
        name: "InstantiateTestsResource",
        dependencies: [
            .Target(name: "Instantiate"),
            .Target(name: "InstantiateStandard")
        ]
    ),
]

let package = Package(
    name: "Instantiate",
    targets: libralies
)
