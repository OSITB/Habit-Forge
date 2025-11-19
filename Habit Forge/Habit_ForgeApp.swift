//
//  Habit_ForgeApp.swift
//  Habit Forge
//
//  Created by Илья Быков on 19.11.2025.
//

import SwiftUI
import CoreData

@main
struct Habit_ForgeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
