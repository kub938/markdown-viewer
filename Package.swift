// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SimpleMarkdown",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SimpleMarkdown", targets: ["SimpleMarkdown"])],
    targets: [
        .executableTarget(name: "SimpleMarkdown")
    ]
)
