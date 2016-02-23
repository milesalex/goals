//
//  ToDoItem.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

// MARK: Types



class ToDoItem: NSObject, NSCoding {

    // MARK: Properties
    var text: String!
    var completed: Bool?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    static let ArchiveURL = DocumentsDirectory?.URLByAppendingPathComponent("todoitems")
    
    // MARK: Types
    struct PropertyKey {
        static let textKey = "text"
        static let completedKey = "completed"
    }
    
    // MARK: Initialization
    init?(text: String){
        self.text = text
        self.completed = false
        
        super.init()
        
        if text.isEmpty {
            return nil
        }
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




