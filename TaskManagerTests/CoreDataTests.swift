//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by Amir on 5/15/23.
//

import XCTest
import CoreData
@testable import TaskManager

final class CoreDataTests: XCTestCase {
    
    func test_add_item() {
        let controller = PersistenceController.empty
        let context = controller.container.viewContext
        let task = Task(context: context)
        
        XCTAssertNil(task.title, "title shoud be nil")
        XCTAssertNil(task.desc, "description shoud be nil")
    }
    
    func test_fetch_data_when_DB_is_empty() {
        let controller = PersistenceController.empty
        let context = controller.container.viewContext
        let reqest = Task.fetchRequest()
        let items = try? context.fetch(reqest)
        
        XCTAssertTrue(items?.count ?? 0 == 0, "there should be no item")
    }
    
    func test_fetch_data_when_an_item_added() {
        let controller = PersistenceController.empty
        let context = controller.container.viewContext
        let task = Task(context: context)
        let reqest = Task.fetchRequest()
        let items = try? context.fetch(reqest)
        
        XCTAssertTrue(items?.count ?? 0 > 0, "items were not fetched")
    }
    
    
}


