
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PingOneSDK",
    products: [
        .library(
            name: "PingOneSDK",
            targets: ["PingOneSDK"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "PingOneSDK",
            url: "https://assets.pingone.com/pingonemobile/ios-sdk/release/PingOneSDK.xcframework.1.8.1.zip",
            checksum: "7940e78277c7bb7f81663f454af8b1c7c02b36d7e518b92bed8fdffc52802954")
    ]
)
