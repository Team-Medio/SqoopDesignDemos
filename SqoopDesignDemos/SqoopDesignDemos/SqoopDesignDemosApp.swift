//
//  SqoopDesignDemosApp.swift
//  SqoopDesignDemos
//
//  Created by Greem on 10/31/24.
//

import SwiftUI
import SqoopDesignSystem
@main
struct SqoopDesignDemosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .loadSqoopFontSystem()
                .colorScheme(.dark)
        }
    }
}
