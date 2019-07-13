//
//  ViewController.swift
//  PriorityList
//
//  Created by Jason Yu on 7/12/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import UIKit

class PriorityListViewController: UITableViewController {
    
    var todoList: TodoList
    
    //called when this viewController is initalized from storyboard
    required init?(coder aDecoder: NSCoder) {
        
        todoList = TodoList()
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    //called everytime a tableView needs a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell", for: indexPath)
        
        //to access a tagged cell
        if let label = cell.viewWithTag(10) as? UILabel{
            label.text = todoList.todos[indexPath.row].text
        }
        
        configureCheckmark(for: cell, at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            configureCheckmark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath){
        let isChecked = todoList.todos[indexPath.row].checked
        
        if isChecked == true{
            cell.accessoryType = .none
        }else{
            cell.accessoryType = .checkmark
        }
        todoList.todos[indexPath.row].checked = !isChecked
        
    }
}

