//
//  AssetResourcePlugin.swift
//  
//
//  Created by Ratnesh Jain on 07/08/23.
//

import Foundation
import PackagePlugin

@available(macOS 13.0, *)
@main
struct AssetResourcePlugin: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        print("Executing AssetResourcePlugin")
        //let targetPath = context.package.directory.appending(subpath: "Sources/\(arguments[1])")
        
        guard let target = try context.package.targets(named: ["\(arguments[1])"]).first(where: {$0 is SourceModuleTarget}) as? SourceModuleTarget else { return }
        
        let files = target.sourceFiles(withSuffix: "xcassets")
        
        let arguments: [(String, Path, Path)] = files.map { assetCatalogFile in
            let base = assetCatalogFile.path.stem
            let input = assetCatalogFile.path
            let output = assetCatalogFile.path.removingLastComponent().appending(subpath: "AssetResource.swift")
            return (base, input, output)
        }
        
        for argument in arguments {
            try Executor.run(input: argument.1.string, output: argument.2.string)
        }
    }
}
