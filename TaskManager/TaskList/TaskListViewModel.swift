//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    
    private var dbmanager = DBManager()
    @Published public var model: [TaskViewModel]
    private var dbModel: [Task] {
        didSet {
            model = dbModel.map({TaskViewModel(model: $0)})
        }
    }
    var showCompeleted = false
    
    init() {
        dbModel = dbmanager.retrieveAll(Task.self, sortDescriptor: [.init(key: "order", ascending: true)])
        model = dbModel.map({TaskViewModel(model: $0)})
    }
    
    public func refreshModel() {
        fetchAllData()
    }
    
    private func fetchAllData() {
        var predicate: NSPredicate? = nil
        if showCompeleted {
            predicate = NSPredicate(format: "has_done == %@", "1")
        }
        dbModel = dbmanager.retrieveAll(Task.self, predicate: predicate, sortDescriptor: [.init(key: "order", ascending: true)])
    }
    
    public func move(from source: IndexSet, to destination: Int) {
            dbModel.move(fromOffsets: source, toOffset: destination )

            // update the userOrder attribute in dbModel to
            // persist the new order. This is done in reverse order
            // to minimize changes to the indices.
            for reverseIndex in stride( from: dbModel.count - 1,
                                        through: 0,
                                        by: -1 )
            {
                dbModel[reverseIndex].order =
                    Int16(reverseIndex)
            }
        dbmanager.saveContext()
        fetchAllData()
    }
    
}
