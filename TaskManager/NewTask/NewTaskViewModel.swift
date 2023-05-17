//
//  NewTaskViewModel.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import Foundation

class NewTaskViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var desc: String = ""
    var order: Int16
    let dbmanager = DBManager()
    
    init(order: Int) {
        self.order = Int16(order)
    }
    
    public func addTask() throws {
        guard !title.isEmpty else {
            throw ErrorTypes.name
        }
        
        guard !desc.isEmpty else {
            throw ErrorTypes.desc
        }
        
        let newTask = Task(context: dbmanager.context)
        newTask.title = title
        newTask.desc = desc
        newTask.has_done = 0
        newTask.order = order
        dbmanager.saveContext()
    }
}
