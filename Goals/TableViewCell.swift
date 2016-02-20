//
//  TableViewCell.swift
//  Goals
//
//  Created by Alex Miles on 2/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

public class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    var toDoItems = [ToDoItem]()
    
    public func configure(text text: String?, placeholder: String) {
        self.todoTextField.delegate = self
        
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
    }
    
    public func textFieldShouldReturn(todoTextField: UITextField) -> Bool {
        
        //textField code
        
        todoTextField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        
        toDoItems.append(ToDoItem(text: todoTextField.text!))
        print(toDoItems)
    }
}