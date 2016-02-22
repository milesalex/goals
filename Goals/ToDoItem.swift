//
//  ToDoItem.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

// MARK: Types

struct PropertyKey {
    static let textKey = "text"
    static let completedKey = "completed"
}

class ToDoItem: NSObject, NSCoding {
    var text: String!
    
    var completed: Bool!
    
    init?(text: String){
        self.text = text
        self.completed = false
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: PropertyKey.textKey)
        aCoder.encodeObject(completed, forKey: PropertyKey.completedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObjectForKey(PropertyKey.textKey) as! String
        
        self.init(text: text)
    }
    
}




