// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AssetPluginLibrary",
    platforms: [
        .iOS(.v13), .macOS(.v12)],
    products: [
        .plugin(name: "AssetResourcePlugin", targets: ["Generate Asset Resources"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .plugin(
            name: "Generate Asset Resources",
            capability: .command(
                intent: .custom(verb: "Generates Assets Resource", description: "Generates assets resource constants"),
                permissions: [.writeToPackageDirectory(reason: "Creates a constant files")]
            ),
            path: "Plugins/AssetResourcePlugin"
        )
    ]
)
