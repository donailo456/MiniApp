// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "WeatherSDK",
            targets: ["WeatherSDK"]
        )
    ],
    targets: [
        .target(
            name: "WeatherSDK"
        ),
    ]
)
