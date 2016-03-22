//
//  TodayViewController.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit
import AVFoundation

enum ToDoType{
    case Today, Year, Life
}

class TodosViewController: UITableViewController/*, TableViewCellDelegate*/ {
    
//    var type: ToDoType?
    var whichTab: String!
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.title == "Today"{
            whichTab = "Today"
        } else if self.title == "Year"{
            whichTab = "Year"
        } else if self.title == "Life"{
            whichTab = "Life"
        }
    }
    
    var beepPlayer:AVAudioPlayer = AVAudioPlayer()
    func playUncheckMySound(){
        let beepSoundURL =  NSBundle.mainBundle().URLForResource("Flick", withExtension: "wav")!
        beepPlayer = try! AVAudioPlayer(contentsOfURL: beepSoundURL)
        beepPlayer.prepareToPlay()
        beepPlayer.play()
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
        cell.tabTitle = whichTab
        if let dataModel = self.dataModel {
            // Load todoItem data model into the table view
            // After all data is loaded, add a blank cell for entering a new todo
            if indexPath.row < dataModel.toDoItems.count {
                
                // Get todoItem from toDoItem data model by using indexPath.row
                let todoItem = dataModel.toDoItems[indexPath.row]
                
                // Populate cell with text and placeholder
                cell.configure(text: todoItem.text, placeholder: dataModel.placeholder(), completed: todoItem.completed)
                cell.todoCheckBox.enabled = true

                
            } else {
                
                // In empty cell, populate with only placeholder text
                cell.configure(text: "", placeholder: dataModel.placeholder(), completed: false)
                
                // Focus text input on empty cell
                cell.todoTextField.becomeFirstResponder()
                cell.todoCheckBox.enabled = false
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
        playUncheckMySound()
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
    
    func updateTask(title: String, completed: Bool, cell: TableViewCell) {
        guard let dataModel = self.dataModel else {
            print("can't save tasks")
            return
        }
        
        guard let indexPath = self.tableView.indexPathForCell(cell) else {
            print("dont have index path")
            return
        }
        
        self.tableView.beginUpdates()
        let task = dataModel.toDoItems[indexPath.row]
        task.completed = completed
        task.text = title
        dataModel.toDoItems[indexPath.row] = task
        self.tableView.endUpdates()
        dataModel.saveTodos()
        
        
        
    }
}
