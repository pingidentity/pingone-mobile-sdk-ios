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
                     url: "https://github.com/pingidentity/pingone-mobile-sdk-ios/releases/tag/v1.7.0/PingOneSDK.xcframework.1.7.0.zip",
                     checksum: "223c759bb9b156a20ed7dd1bb5235edf62a8ea158a3135e8c60b13ee0ece4341
"),
    ]
)
