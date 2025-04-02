// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "HighlightedText",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "HighlightedText",
            targets: ["HighlightedText"]
        )
    ],
    targets: [.target(name: "HighlightedText")],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault")
    ]
}

