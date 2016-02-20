//
//  ToDoItem.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var text: String!
    
    var completed: Bool!
    
    init(text: String){
        self.text = text
        self.completed = false
    }

}
