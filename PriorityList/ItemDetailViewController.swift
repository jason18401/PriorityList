//
//  AddItemTableViewController.swift
//  PriorityList
//
//  Created by Jason Yu on 7/14/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem)
}

class ItemDetailViewController: UITableViewController {
    
    weak var delegateAddItemVC: ItemDetailViewControllerDelegate?

    weak var todoList: TodoList?
    weak var itemToEdit: CheckListItem?
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func Cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegateAddItemVC?.ItemDetailViewControllerDidCancel(self)  //protocol
    }
    
    @IBAction func Done(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegateAddItemVC?.ItemDetailViewController(self, didFinishEditing: item)
        }else{
            if let item = todoList?.newTodo(){
                if let textFieldText = textField.text{
                    item.text = textFieldText
                    doneBarButton.isEnabled = true
                }
                item.checked = false
                delegateAddItemVC?.ItemDetailViewController(self, didFinishAdding: item)    //protocol

            }
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit{
            title = "Edit Item"
            textField.text = item.text
        }
        
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()    //keyboard pops up automatically
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil  //doesn't allow the gray area to come after click
    }

}

extension ItemDetailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //When user taps a key on the keyboard this method is called
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let stringRange = Range(range, in: currentText) else { return false }
        
        let newText = currentText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
}
