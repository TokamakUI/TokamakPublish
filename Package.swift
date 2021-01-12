// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "TokamakPublish",
  platforms: [.macOS(.v11)],
  products: [
    .library(
      name: "TokamakPublish",
      targets: ["TokamakPublish"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/JohnSundell/Publish.git", from: "0.7.0"),
    .package(url: "https://github.com/TokamakUI/Tokamak.git", .branch("main")),
  ],
  targets: [
    .target(
      name: "TokamakPublish",
      dependencies: [
        .product(
          name: "Publish",
          package: "Publish"
        ),
        .product(
          name: "TokamakStaticHTML",
          package: "Tokamak"
        )
      ]
    ),
    .testTarget(
      name: "TokamakPublishTests",
      dependencies: [.target(name: "TokamakPublish")]
    ),
  ]
)
