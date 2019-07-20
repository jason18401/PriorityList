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
    var tableData: [[CheckListItem?]?]!

    //called when this viewController is initalized from storyboard
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo() // just creating it to increase size of list
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows{
            var items = [CheckListItem]()   //checklist items that will be deleted
            for indexPath in selectedRows{
                items.append(todoList.todos[indexPath.row])
            }
            todoList.remove(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem   //this gives the edit button
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //to use sections
        let sectionTitleCount = UILocalizedIndexedCollation.current().sectionTitles.count
        var allSections = [[CheckListItem?]?](repeating: nil, count: sectionTitleCount)
        var sectionNumber = 0
        let collation = UILocalizedIndexedCollation.current()
        for item in todoList.todos{
            sectionNumber = collation.section(for: item, collationStringSelector: #selector(getter:CheckListItem.text))
            if allSections[sectionNumber] == nil{
                allSections[sectionNumber] = [CheckListItem?]()
            }
            allSections[sectionNumber]!.append(item)
        }
        tableData = allSections
    }
    
    //edit button
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todoList.move(item: todoList.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        tableView.reloadData()
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
        if tableView.isEditing{
            return
        }
        if let cell = tableView.cellForRow(at: indexPath){
            let item = todoList.todos[indexPath.row]
            item.toggleChecked()    //todoList.todos[indexPath.row].checked = !todoList.todos[indexPath.row].checked
            configureCheckmark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    //to delete rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic) //delete from tableView
        //tableView.reloadData() //can use either this or tableView.deleteRows()
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath){
        
        guard let checkmark = cell as? TableViewCell else { return }
        let isChecked = todoList.todos[indexPath.row].checked
        
        if isChecked == true{
            checkmark.checkmarkLabel.text = "✔"
        }else{
            checkmark.checkmarkLabel.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue"{
            if let ItemDetailViewController = segue.destination as? ItemDetailViewController{ //segue.destination returns a UIViewController, so you need to cast
                ItemDetailViewController.delegateAddItemVC = self
                ItemDetailViewController.todoList = todoList   //model object
            }
            
            //Edit Segue
        } else if segue.identifier == "EditItemSegue"{
            if let ItemDetailViewController = segue.destination as? ItemDetailViewController{
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
                    let item = todoList.todos[indexPath.row]
                    ItemDetailViewController.itemToEdit = item
                    ItemDetailViewController.delegateAddItemVC = self
                }
            }
        }
    }
}

extension PriorityListViewController: ItemDetailViewControllerDelegate{
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1//total amount for new position
        
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    //for editing
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem) {
        if let index = todoList.todos.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                if let tableViewCell = cell as? TableViewCell{
                    tableViewCell.todoTextLabel.text = item.text
                    
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}

