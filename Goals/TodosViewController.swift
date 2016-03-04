//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

enum ToDoType{
    case Today, Year, Life
}

class TodosViewController: UITableViewController/*, TableViewCellDelegate*/ {
    
//    var type: ToDoType?
    
    var dataModel: DataModel? {
        didSet {
            if let dataModel = self.dataModel {
                self.tabBarItem.title = dataModel.tabName()
                self.title = dataModel.tabName()

                dataModel.loadTodos()
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows in the table view
        // Add one row for the entry cell
        if let dataModel = self.dataModel {
            return dataModel.toDoItems.count + 1
        } else {
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if let dataModel = self.dataModel {
            // Load todoItem data model into the table view
            // After all data is loaded, add a blank cell for entering a new todo
            if indexPath.row < dataModel.toDoItems.count {
                
                // Get todoItem from toDoItem data model by using indexPath.row
                let todoItem = dataModel.toDoItems[indexPath.row]
                
                // Populate cell with text and placeholder
                cell.configure(text: todoItem.text, placeholder: dataModel.placeholder())
                
            } else {
                
                // In empty cell, populate with only placeholder text
                cell.configure(text: "", placeholder: dataModel.placeholder())
                
                // Focus text input on empty cell
                cell.todoTextField.becomeFirstResponder()
            }
        }
        
        cell.viewController = self
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let dataModel = self.dataModel else {
            print("cant get data model")
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.tableView.beginUpdates()
            dataModel.toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            dataModel.saveTodos()
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        guard let dataModel = self.dataModel else {
            print("cant get data model")
            return false
        }
        
        if indexPath.row == dataModel.toDoItems.count {
            return false
        } else {
            return true
        }
    }
    
    func saveTaskWithTitle(title: String) {
        
        guard let dataModel = self.dataModel else {
            print("cant save task with title")
            return
        }
        
        let newIndexPath = NSIndexPath(forItem: dataModel.toDoItems.count + 1, inSection: 0)
        self.tableView.beginUpdates()
        dataModel.toDoItems.append(ToDoItem(text: title, completed: false)!)
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        dataModel.saveTodos()
    }
}
