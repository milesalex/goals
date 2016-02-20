//
//  TableViewCell.swift
//  Goals
//
//  Created by Alex Miles on 2/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

public class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    public func configure(text text: String?, placeholder: String) {
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
    }
}