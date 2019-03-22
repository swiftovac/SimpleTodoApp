//
//  Todo.swift
//  SimpleTodoApp
//
//  Created by Stefan Milenkovic on 3/22/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import Foundation


class Todo: Codable {
    
    var title: String
    var completed: Bool
    
    
    init(title: String, completed: Bool) {
        self.title = title
        self.completed = completed
    }
    
    
}
