// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "HighlightableText",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "HighlightableText",
            targets: ["HighlightableText"]
        )
    ],
    targets: [.target(name: "HighlightableText")],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault")
    ]
}

