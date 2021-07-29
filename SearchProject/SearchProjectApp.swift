//
//  SearchProjectApp.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI

@main
struct SearchProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
