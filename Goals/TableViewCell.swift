//
//  TableViewCell.swift
//  Goals
//
//  Created by Alex Miles on 2/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

/*protocol TableViewCellDelegate {
    func tableViewCell(tableViewCell: TableViewCell, didEnterString string: String)
}*/


class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    weak var viewController: TodayViewController?
    
    func configure(text text: String?, placeholder: String) {
        self.todoTextField.delegate = self
        
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
    }
    
    
    func textFieldShouldReturn(todoTextField: UITextField) -> Bool {
        //textField code
        if todoTextField.text?.characters.count == 0 {
            return false
        }
        
        todoTextField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        viewController?.saveTaskWithTitle(self.todoTextField.text!)
//        self.todoTextField.text = ""
//        self.todoTextField.becomeFirstResponder()
        
        //delegate?.tableViewCell(self, didEnterString: self.todoTextField.text!)
        
//        toDoItems.append(ToDoItem(text: todoTextField.text!))
//        print(toDoItems)
        
        
        
        
    }
    
    
}