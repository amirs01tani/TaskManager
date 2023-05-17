//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject, Identifiable {
    
    let title: String
    let desc: String
    @Published var hasDone: Bool
    var order: Int16
    var model: Task
    let dbManager = DBManager()
    
    init(model: Task) {
        self.model = model
        self.title = model.title ?? ""
        self.desc = model.desc ?? ""
        self.hasDone = model.has_done == 0 ? false : true
        self.order = model.order
    }
    
    func toggleHasDone() {
        hasDone.toggle()
        (model as NSManagedObject).setValue(1 - model.has_done, forKey: "has_done")
        dbManager.write()
    }

}
