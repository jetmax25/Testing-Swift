//
//  User.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

import Foundation

class User {
    let name: String
    var projects = [Project]()
    
    init(name: String) {
        self.name = name
    }
    
    func add(project: Project) {
        projects.append(project)
    }
    
    var numTasks: Int{
        return projects.reduce(into: 0) { value, project in
            value += project.toDoItems.count
        }
    }
    
    var outstandingTasksString: String {
        return "\(numTasks) Items"
    }
}
