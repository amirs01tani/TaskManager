//
//  DBManager.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import Foundation
import CoreData

class DBManager {
    
    var context = PersistenceController.shared.viewContext

    func saveContext () {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }

    /// Create and Update an entity
    func write() {
        saveContext()
    }

    /// Get all values from an entity
    func retrieveAll<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = sortDescriptor
        do {
            let values = try context.fetch(request)
            return values
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    /// Delete object from db
    func deleteObject<T: NSManagedObject>(_ object: T) {
        context.performAndWait {
            context.delete(object)
            saveContext()
        }
    }

    /// Purge Entity
    func purge<T: NSManagedObject>(entity: T.Type) {
        context.performAndWait {
            do {
                let request = T.fetchRequest() as! NSFetchRequest<T>
                let objects = try context.fetch(request)
                objects.forEach {
                    context.delete($0)
                }
                saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func purge(entityName: String, predicate: NSPredicate? = nil) {
        context.performAndWait {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                request.predicate = predicate
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                try context.execute(batchDeleteRequest)
                
                saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
