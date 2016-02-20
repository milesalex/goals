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
    
    
    
    public func configure(text text: String?, placeholder: String) {
        self.todoTextField.delegate = self
        
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
    }
    
    
}