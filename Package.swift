// swift-tools-version:6.3
import PackageDescription

let package = Package(
  name: "elementary-web-app",
  platforms: [.macOS(.v26)],
  dependencies: [
    .package(url: "https://github.com/elementary-swift/elementary-ui.git", from: "0.7.0"),
    .package(url: "https://github.com/swiftwasm/JavaScriptKit.git", from: "0.58.0"),
    .package(
      url: "https://github.com/sliemeobn/swift-foundation.git", branch: "experimental/new-codable"),
  ],
  targets: [
    .executableTarget(
      name: "WebApp",
      dependencies: [
        .product(name: "NewCodable", package: "swift-foundation"),
        .product(name: "ElementaryUI", package: "elementary-ui"),
        .product(name: "JavaScriptKit", package: "JavaScriptKit"),
        .product(name: "JavaScriptEventLoop", package: "JavaScriptKit"),
      ],
      swiftSettings: [
        .swiftLanguageMode(.v5),
        .enableExperimentalFeature("Extern"),
      ],
      plugins: [
        .plugin(name: "BridgeJS", package: "JavaScriptKit")
      ]
    ),
    .executableTarget(
      name: "Worker",
      dependencies: [
        .product(name: "JavaScriptKit", package: "JavaScriptKit"),
        .product(name: "JavaScriptEventLoop", package: "JavaScriptKit"),
        .product(name: "NewCodable", package: "swift-foundation"),
      ],
      swiftSettings: [
        .swiftLanguageMode(.v5),
        .enableExperimentalFeature("Extern"),
      ],
      plugins: [
        .plugin(name: "BridgeJS", package: "JavaScriptKit")
      ]
    ),
  ]
)
