// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PingOneSDK",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "PingOneSDK",
            targets: ["PingOneSDK"]
        ),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "PingOneSDK",
                     url: "https://github.com/pingidentity/pingone-mobile-sdk-ios/releases/tag/v1.7.1/PingOneSDK.xcframework.1.7.1.zip",
                     checksum: "de027118b5096812289455d7efd7075c05db7e0839f97f9dc68daa8d5824489f
"),
    ]
)
