//
//  Persistence.swift
//  Shared
//
//  Created by Alexander Skorulis on 2/10/21.
//

import CoreData
import CloudKit

struct PersistenceController {

    let container: NSPersistentCloudKitContainer
    
    static var inMemory: PersistenceController {
        return PersistenceController(inMemory: true)
    }
    
    init() {
        self.init(inMemory: false)
    }

    private init(inMemory: Bool) {
        container = NSPersistentCloudKitContainer(name: "Goals")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let cloudPath = "iCloud.com.skorulis.goals"
            let desc = container.persistentStoreDescriptions.first!
            desc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: cloudPath)
                desc.cloudKitContainerOptions?.databaseScope = .public
            
            container.persistentStoreDescriptions = [desc]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
