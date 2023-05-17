//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by Amir on 5/15/23.
//

import XCTest
@testable import TaskManager

final class NewTaskTests: XCTestCase {

    func test_ensure_task_name_is_not_empty() {
        let sut = NewTaskViewModel(order: 0)
        sut.desc = "some"
        XCTAssertThrowsError(try sut.addTask()) { error in
            XCTAssertEqual(error as! ErrorTypes, ErrorTypes.name)
        }
    }
    
    func test_ensure_task_desc_is_not_empty() {
        let sut = NewTaskViewModel(order: 0)
        sut.title = "some"
        XCTAssertThrowsError(try sut.addTask()) { error in
            XCTAssertEqual(error as! ErrorTypes, ErrorTypes.desc)
        }
    }

}
