// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "EyeTwenty",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "EyeTwenty", targets: ["EyeTwenty"])
    ],
    targets: [
        .executableTarget(
            name: "EyeTwenty",
            dependencies: [],
            path: "Sources/EyeTwenty"
        )
    ]
)
