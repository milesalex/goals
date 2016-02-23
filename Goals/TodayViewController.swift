//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


class TodayViewController: UITableViewController/*, TableViewCellDelegate*/ {
    
    // Data model
    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Save data to local variable that we can use in this VC
        if let savedTodos = loadTodos() {
            toDoItems += savedTodos
        } else {
            // empty view
        }
        
        deleteTodos()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows in the table view
        // Add one row for the entry cell
        return self.toDoItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TableViewCell
        
        // Load todoItem data model into the table view
        // After all data is loaded, add a blank cell for entering a new todo
        if indexPath.row < self.toDoItems.count {
           
            // Get todoItem from toDoItem data model by using indexPath.row
            let todoItem = toDoItems[indexPath.row]
            
            // Populate cell with text and placeholder
            cell.configure(text: todoItem.text, placeholder: "What are you doing today?")
            
        } else {
            
            // In empty cell, populate with only placeholder text
            cell.configure(text: "", placeholder: "What are you doing today?")
            
            // Focus text input on empty cell
            cell.todoTextField.becomeFirstResponder()
            
        }
        
        cell.viewController = self
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.tableView.beginUpdates()
            toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.endUpdates()
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == toDoItems.count {
            return false
        } else {
            return true
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -150 {
            print("close")
            view.endEditing(true)
        }
    }
    
    func saveTaskWithTitle(title: String) {
        let newIndexPath = NSIndexPath(forItem: self.toDoItems.count + 1, inSection: 0)
        self.tableView.beginUpdates()
        toDoItems.append(ToDoItem(text: title, completed: false)!)
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        saveTodos()
    }
    
    func saveTodos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save todos...")
        }
    }
    
    func loadTodos() -> [ToDoItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ToDoItem.ArchiveURL.path!) as? [ToDoItem]
    }
    
    func deleteTodos() {
//        let date = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
//        let hour = components.hour
//        let minutes = components.minute
//        print(components)
    }
    
}

