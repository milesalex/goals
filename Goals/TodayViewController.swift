//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


class TodayViewController: UITableViewController/*, TableViewCellDelegate*/ {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows in the table view
        // Add one row for the entry cell
        return toDoItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Load todoItem data model into the table view
        // After all data is loaded, add a blank cell for entering a new todo
        if indexPath.row < toDoItems.count {
           
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
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            saveTodos()
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == toDoItems.count {
            return false
        } else {
            return true
        }
    }
    
    func saveTaskWithTitle(title: String) {
        let newIndexPath = NSIndexPath(forItem: toDoItems.count + 1, inSection: 0)
        self.tableView.beginUpdates()
        toDoItems.append(ToDoItem(text: title, completed: false)!)
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        saveTodos()
    }
    
}

