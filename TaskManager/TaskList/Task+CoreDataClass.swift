//
//  Task+CoreDataClass.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    func setHasDone(value: Int16) {
        self.has_done = value
    }
}

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var order: Int16
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var has_done: Int16

}

extension Task : Identifiable {
    
}
