//
//  PersistantController.swift
//  TaskManager
//
//  Created by Amir on 5/16/23.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    static var empty: PersistenceController = {
        PersistenceController(inMemory: true)
    }()
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskManager")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
