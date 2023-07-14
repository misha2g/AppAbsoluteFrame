// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppAbsoluteFrame",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AppAbsoluteFrame",
            targets: ["AppAbsoluteFrame"]),
    ],
    targets: [
        .target(
            name: "AppAbsoluteFrame",
            dependencies: [])
    ]
)
