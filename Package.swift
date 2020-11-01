// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TokamakPublish",
  platforms: [.macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "TokamakPublish",
      targets: ["TokamakPublish"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/JohnSundell/Publish.git", from: "0.7.0"),
    .package(url: "https://github.com/TokamakUI/Tokamak.git", .branch("publish-support")),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "TokamakPublish",
      dependencies: ["Publish", .product(name: "TokamakStaticHTML", package: "Tokamak")]
    ),
    .testTarget(
      name: "TokamakPublishTests",
      dependencies: ["TokamakPublish"]
    ),
  ]
)
