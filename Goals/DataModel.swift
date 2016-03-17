//
//  Functions.swift
//  Goals
//
//  Created by Alex Miles on 2/23/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import Foundation

public class DataModel {
    init(aType: ToDoType) {
        self.type = aType
    }
    
    var type: ToDoType
    var toDoItems = [ToDoItem]()
    
    func loadTodos() {
        // Save data to local variable that we can use in this VC
        if let savedTodos = NSKeyedUnarchiver.unarchiveObjectWithFile(archiveURL()) as? [ToDoItem] {
            toDoItems = savedTodos
        } else {
            // empty view
        }
    }
    
    func saveTodos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: archiveURL())
        
        if !isSuccessfulSave {
            print("Failed to save todos...")
        }
    }
    
    func archiveURL() -> String {
        let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        switch self.type {
            case .Today:
                return DocumentsDirectory!.URLByAppendingPathComponent("today").path!
            case .Year:
                return DocumentsDirectory!.URLByAppendingPathComponent("year").path!
            case .Life:
                return DocumentsDirectory!.URLByAppendingPathComponent("life").path!
        }
    }
    
    func deleteAllPastTodosForCurrentDate() {

        var whenUserLastClosedApp: NSDate?
        let prefs = NSUserDefaults.standardUserDefaults()
        
        whenUserLastClosedApp = prefs.objectForKey("whenUserLastClosedApp") as? NSDate
        
        if self.type == .Today {
            if let date = whenUserLastClosedApp {
                if date.isYesterday() {
                    print("dont delete todos")
                } else {
                    toDoItems.removeAll()
                    saveTodos()
                }
            }
        }
        
    }
    
    func tabName() -> String {
        switch self.type {
            case .Today:
                return "Today"
            case .Year:
                return "Year"
            case .Life:
                return "Life"
        }
    }
    
    func placeholder() -> String {
        switch self.type {
        case .Today:
            return "What are you doing today"
        case .Year:
            return "What are you doing this year"
        case .Life:
            return "What are you doing before you die"
        }
    }
}