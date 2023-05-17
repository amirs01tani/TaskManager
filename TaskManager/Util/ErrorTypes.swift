//
//  ErrorTypes.swift
//  TaskManager
//
//  Created by Amir on 5/16/23.
//

import Foundation

enum ErrorTypes : Error {
    case name
    case desc
    
    func getDescription() -> String {
        switch self {
        case .name:
            return "The name of the task is empty."
        case .desc:
            return "The description of the task should not be empty."
        }
    }
}
