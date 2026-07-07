
// swift-tools-version:5.6
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
    dependencies: [
        .package(url: "https://github.com/airsidemobile/JOSESwift.git", exact: "3.0.0"),
        .package(url: "https://github.com/ashleymills/Reachability.swift", exact: "5.2.4"),
        .package(url: "https://github.com/lachlanbell/SwiftOTP.git", exact: "3.0.2"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", exact: "0.9.19")
    ],
    targets: [
        .binaryTarget(
            name: "PingOneSDK",
            url: "https://assets.pingone.com/pingonemobile/ios-sdk/release/PingOneSDK.xcframework.2.3.2.zip",
            checksum: "a7fb70f26a3dedca8fa75227b4bff36f1275cc75f27e4bcb00fc1272fb7a37f2")
    ]
)