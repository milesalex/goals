//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


class TodayViewController: UITableViewController/*, TableViewCellDelegate*/ {

    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedTodos = loadTodos() {
            toDoItems += savedTodos
        } else {
            // empty
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TableViewCell
        
        if indexPath.row < self.toDoItems.count {
           let todoItem = toDoItems[indexPath.row]
            cell.configure(text: todoItem.text, placeholder: "What are you doing today?")
        } else {
            cell.configure(text: "", placeholder: "What are you doing today?")
            cell.todoTextField.becomeFirstResponder()
        }
        
        
        //cell.delegate = self
        cell.viewController = self
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
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
    
}

