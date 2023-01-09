
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
            checksum: "a5374e08af3d967455d684ef6effe7907a1bef4e9d8e603edaa0db5df856ec2e")
    ]
)
