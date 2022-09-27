//
//  StoreContentExampleApp.swift
//  StoreContentExample
//
//  Created by Leif on 9/27/22.
//

import CacheStore
import SwiftUI

@main
struct StoreContentExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialValues: [.name: "Anonymous"],
                    actionHandler: .handler,
                    dependency: ()
                )
            )
        }
    }
}
