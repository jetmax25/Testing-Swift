//
//  Project.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

import Foundation

class Project {
    let name: String
    var toDoItems = [ToDoItem]()
    
    init(name: String) {
        self.name = name
    }
    
    func add(item: ToDoItem) {
        toDoItems.append(item)
    }
}
