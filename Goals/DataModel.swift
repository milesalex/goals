//
//  Functions.swift
//  Goals
//
//  Created by Alex Miles on 2/23/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import Foundation

var toDoItems = [ToDoItem]()

func loadTodos() {
    // Save data to local variable that we can use in this VC
    if let savedTodos = NSKeyedUnarchiver.unarchiveObjectWithFile(ToDoItem.ArchiveURL.path!) as? [ToDoItem] {
        toDoItems = savedTodos
    } else {
        // empty view
    }
}

func saveTodos() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path!)
    
    if !isSuccessfulSave {
        print("Failed to save todos...")
    }
}