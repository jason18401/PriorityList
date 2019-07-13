//
//  TodoList.swift
//  PriorityList
//
//  Created by Jason Yu on 7/13/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import Foundation

class TodoList {
    var todos: [CheckListItem] = []
    
    init() {
        let row0 = CheckListItem()
        let row1 = CheckListItem()
        let row2 = CheckListItem()
        let row3 = CheckListItem()
        
        row0.text = "Study IOS"
        row1.text = "Movie"
        row2.text = "Study IOS"
        row3.text = "Study IOS"
        
        todos.append(row0)
        todos.append(row1)
        todos.append(row2)
        todos.append(row3)
    }
}
