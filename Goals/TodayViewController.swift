//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


class TodayViewController: UITableViewController {

    var toDoItems = [ToDoItem]()
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Create 1 row as an example
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TableViewCell
        
        cell.configure(text: "", placeholder: "What are you doing today?")
        return cell
        
    }
    
    
    func textFieldShouldReturn(todoTextField: UITextField) -> Bool {
        
        //textField code
        
        todoTextField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        
        toDoItems.append(ToDoItem(text: todoTextField.text!))
        print(toDoItems)
        
        
        self.tableView.insertRowsAtIndexPaths(NSIndexPath(item: self.toDoItems.count, section: 0), withRowAnimation: UITableViewRowAnimation)
        
    }

    
}

//class TodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    @IBOutlet weak var tableView: UITableView!
//    var toDoItems = [ToDoItem]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        tableView.separatorStyle = .None
//        tableView.rowHeight = 50
//        
//        if toDoItems.count > 0 {
//            return
//        }
//        
//        toDoItems.append(ToDoItem(text: "feed the cat"))
//        toDoItems.append(ToDoItem(text: "buy eggs"))
//        toDoItems.append(ToDoItem(text: "watch WWDC videos"))
//        toDoItems.append(ToDoItem(text: "rule the Web"))
//        toDoItems.append(ToDoItem(text: "buy a new iPhone"))
//        toDoItems.append(ToDoItem(text: "darn holes in socks"))
//        toDoItems.append(ToDoItem(text: "write this tutorial"))
//        toDoItems.append(ToDoItem(text: "master Swift"))
//        toDoItems.append(ToDoItem(text: "learn to draw"))
//        toDoItems.append(ToDoItem(text: "get more exercise"))
//        toDoItems.append(ToDoItem(text: "catch up with Mom"))
//        toDoItems.append(ToDoItem(text: "get a hair cut"))
//        toDoItems.append(ToDoItem(text: "feed the cat"))
//        toDoItems.append(ToDoItem(text: "buy eggs"))
//        toDoItems.append(ToDoItem(text: "watch WWDC videos"))
//        toDoItems.append(ToDoItem(text: "rule the Web"))
//        toDoItems.append(ToDoItem(text: "buy a new iPhone"))
//        toDoItems.append(ToDoItem(text: "darn holes in socks"))
//        toDoItems.append(ToDoItem(text: "write this tutorial"))
//        toDoItems.append(ToDoItem(text: "master Swift"))
//        toDoItems.append(ToDoItem(text: "learn to draw"))
//        toDoItems.append(ToDoItem(text: "get more exercise"))
//        toDoItems.append(ToDoItem(text: "catch up with Mom"))
//        toDoItems.append(ToDoItem(text: "get a hair cut"))
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return toDoItems.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
//        let item = toDoItems[indexPath.row]
//        
////        print(cell.textInputMode)
//        cell.textLabel?.text = item.text
//        return cell
//    }
//
//}
