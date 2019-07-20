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
    
    func newTodo() -> CheckListItem{
        let item = CheckListItem()
        item.text = randomTitle()
        item.checked = true
        todos.append(item)
        
        return item
    }
    
    func move(item: CheckListItem, to index: Int){
        guard let currentIndex = todos.firstIndex(of: item) else { return }
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }
    
    func remove(items: [CheckListItem]){
        for item in items{
            if let index = todos.firstIndex(of: item){
                todos.remove(at: index)
            }
        }
    }
    
    private func randomTitle() -> String {
        var titles = ["New todo", "Generic", "fill me out", "wot"]
        let randomNumber = Int.random(in: 0...titles.count-1)
        return titles[randomNumber]
    }
}
