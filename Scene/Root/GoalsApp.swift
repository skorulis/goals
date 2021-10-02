//
//  GoalsApp.swift
//  Shared
//
//  Created by Alexander Skorulis on 2/10/21.
//

import SwiftUI

@main
struct GoalsApp: App {
    let persistenceController = IOC.shared.resolve(PersistenceController.self)!

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IOC.shared.container.resolve(GenericFactory.self)!)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
