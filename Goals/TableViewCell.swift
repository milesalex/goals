//
//  TableViewCell.swift
//  Goals
//
//  Created by Alex Miles on 2/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit
import AVFoundation

/*protocol TableViewCellDelegate {
    func tableViewCell(tableViewCell: TableViewCell, didEnterString string: String)
}*/
var strikeThruLine: UIView!


class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var todoCheckBox: UIButton!
    
    @IBOutlet weak var todoContentHolder: UIView!
    var tabTitle: String!
    
    let todayChecked = UIImage(named: "check20") as UIImage?
    let yearChecked = UIImage(named: "bluecheck20") as UIImage?
    let lifeChecked = UIImage(named: "redcheck20") as UIImage?
    
    var beepPlayer:AVAudioPlayer = AVAudioPlayer()
    func playCheckMySound(){
        let beepSoundURL =  NSBundle.mainBundle().URLForResource("Pong", withExtension: "wav")!
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        beepPlayer = try! AVAudioPlayer(contentsOfURL: beepSoundURL)
        beepPlayer.prepareToPlay()
        beepPlayer.play()
    }
    func playUncheckMySound(){
        let beepSoundURL =  NSBundle.mainBundle().URLForResource("Flick", withExtension: "wav")!
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        beepPlayer = try! AVAudioPlayer(contentsOfURL: beepSoundURL)
        beepPlayer.prepareToPlay()
        beepPlayer.play()
    }
    
    
    weak var viewController: TodosViewController?
    
    func configure(text text: String?, placeholder: String, completed: Bool) {
        self.todoTextField.delegate = self
        
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        todoCheckBox.selected = completed
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
        
        todoTextField.autocapitalizationType = UITextAutocapitalizationType.Sentences
        
        if completed {
            setCheckboxImage(false)
        }
        
    }
    
    
    func textFieldShouldReturn(todoTextField: UITextField) -> Bool {
        //textField code
        if todoTextField.text?.characters.count == 0 {
            return false
        }
        
        todoTextField.resignFirstResponder()  //if desired
        performAction()
        return true
    }

    @IBAction func didEditTextField(sender: UITextField) {
        if todoTextField.text == ""{
        todoCheckBox.enabled = false
        }
    }
    
    @IBAction func didFocusTextField(sender: AnyObject) {
        if todoTextField.text != "" && strikeThruLine != nil {
            unDoCheckBox()
            todoCheckBox.selected = false
        }
    }
    @IBAction func didCheck(sender: UIButton) {
        if todoTextField.text != ""{
            if (sender.selected == true) {
                unDoCheckBox()
                playUncheckMySound()
                sender.selected = false
            } else {
                setCheckboxImage(true)
                sender.selected = true
                playCheckMySound()
                todoTextField.resignFirstResponder()
            }
            viewController?.updateTask(todoTextField.text!, completed: sender.selected, cell: self)
        }
    }
    
    func setCheckboxImage(animated: Bool) {
        if tabTitle == "Today" {
            if animated {
               animateTodayCheckBox()
            }
            
            todoCheckBox.setImage(todayChecked, forState: .Selected)
        } else if tabTitle == "Year" {
            if animated {
                animateYearCheckBox()
            }
            
            todoCheckBox.setImage(yearChecked, forState: .Selected)
        } else if tabTitle == "Life" {
            if animated {
                animateLifeCheckBox()
            }
            todoCheckBox.setImage(lifeChecked, forState: .Selected)
        }
    }
    
    func animateTodayCheckBox(){
        let animationImages:[UIImage]? =
        [UIImage(named: "check1")!,
            UIImage(named: "check2")!,
            UIImage(named: "check3")!,
            UIImage(named: "check4")!,
            UIImage(named: "check5")!,
            UIImage(named: "check6")!,
            UIImage(named: "check7")!,
            UIImage(named: "check8")!,
            UIImage(named: "check9")!,
            UIImage(named: "check10")!,
            UIImage(named: "check11")!,
            UIImage(named: "check12")!,
            UIImage(named: "check13")!,
            UIImage(named: "check14")!,
            UIImage(named: "check15")!,
            UIImage(named: "check16")!,
            UIImage(named: "check17")!,
            UIImage(named: "check18")!,
            UIImage(named: "check19")!,
            UIImage(named: "check20")!]
        let loadingImageView = UIImageView()
            loadingImageView.frame = todoCheckBox.frame
            loadingImageView.frame.origin.x = (todoCheckBox.frame.origin.x - 12)
            loadingImageView.frame.origin.y = (todoCheckBox.frame.origin.y - 7)
            loadingImageView.animationImages = animationImages
            loadingImageView.animationDuration = 0.8
            loadingImageView.animationRepeatCount = 1
            loadingImageView.startAnimating()
            todoCheckBox.addSubview(loadingImageView)
        
        
        let toDoString: String = todoTextField.text!
        let toDoStringChanged: NSString = toDoString as NSString
        let todoTextSize: CGSize = toDoStringChanged.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)])
        
        strikeThruLine = UIView()
        strikeThruLine.frame.size.width = 0
        strikeThruLine.frame.size.height = 1.5
        strikeThruLine.frame.origin.x = 0
        strikeThruLine.frame.origin.y = 10
        strikeThruLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        todoTextField.addSubview(strikeThruLine)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
            if strikeThruLine != nil {
                strikeThruLine.frame.size.width = todoTextSize.width
            }
            self.todoTextField.textColor = UIColor(white: 0.7, alpha: 0.7)
            }, completion: nil)
    }
    
    func animateYearCheckBox(){
        let animationImages:[UIImage]? =
        [UIImage(named: "bluecheck1")!,
            UIImage(named: "bluecheck2")!,
            UIImage(named: "bluecheck3")!,
            UIImage(named: "bluecheck4")!,
            UIImage(named: "bluecheck5")!,
            UIImage(named: "bluecheck6")!,
            UIImage(named: "bluecheck7")!,
            UIImage(named: "bluecheck8")!,
            UIImage(named: "bluecheck9")!,
            UIImage(named: "bluecheck10")!,
            UIImage(named: "bluecheck11")!,
            UIImage(named: "bluecheck12")!,
            UIImage(named: "bluecheck13")!,
            UIImage(named: "bluecheck14")!,
            UIImage(named: "bluecheck15")!,
            UIImage(named: "bluecheck16")!,
            UIImage(named: "bluecheck17")!,
            UIImage(named: "bluecheck18")!,
            UIImage(named: "bluecheck19")!,
            UIImage(named: "bluecheck20")!]
        let loadingImageView = UIImageView()
        loadingImageView.frame = todoCheckBox.frame
        loadingImageView.frame.origin.x = (todoCheckBox.frame.origin.x - 12)
        loadingImageView.frame.origin.y = (todoCheckBox.frame.origin.y - 7)
        loadingImageView.animationImages = animationImages
        loadingImageView.animationDuration = 0.8
        loadingImageView.animationRepeatCount = 1
        loadingImageView.startAnimating()
        todoCheckBox.addSubview(loadingImageView)
        
        
        let toDoString: String = todoTextField.text!
        let toDoStringChanged: NSString = toDoString as NSString
        let todoTextSize: CGSize = toDoStringChanged.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)])
        
        strikeThruLine = UIView()
        strikeThruLine.frame.size.width = 0
        strikeThruLine.frame.size.height = 1.5
        strikeThruLine.frame.origin.x = 0
        strikeThruLine.frame.origin.y = 10
        strikeThruLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        todoTextField.addSubview(strikeThruLine)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
            strikeThruLine.frame.size.width = todoTextSize.width
            self.todoTextField.textColor = UIColor(white: 0.7, alpha: 0.7)
            }, completion: nil)
    }
    
    func animateLifeCheckBox(){
        let animationImages:[UIImage]? =
        [UIImage(named: "redcheck1")!,
            UIImage(named: "redcheck2")!,
            UIImage(named: "redcheck3")!,
            UIImage(named: "redcheck4")!,
            UIImage(named: "redcheck5")!,
            UIImage(named: "redcheck6")!,
            UIImage(named: "redcheck7")!,
            UIImage(named: "redcheck8")!,
            UIImage(named: "redcheck9")!,
            UIImage(named: "redcheck10")!,
            UIImage(named: "redcheck11")!,
            UIImage(named: "redcheck12")!,
            UIImage(named: "redcheck13")!,
            UIImage(named: "redcheck14")!,
            UIImage(named: "redcheck15")!,
            UIImage(named: "redcheck16")!,
            UIImage(named: "redcheck17")!,
            UIImage(named: "redcheck18")!,
            UIImage(named: "redcheck19")!,
            UIImage(named: "redcheck20")!]
        let loadingImageView = UIImageView()
        loadingImageView.frame = todoCheckBox.frame
        loadingImageView.frame.origin.x = (todoCheckBox.frame.origin.x - 12)
        loadingImageView.frame.origin.y = (todoCheckBox.frame.origin.y - 7)
        loadingImageView.animationImages = animationImages
        loadingImageView.animationDuration = 0.8
        loadingImageView.animationRepeatCount = 1
        loadingImageView.startAnimating()
        todoCheckBox.addSubview(loadingImageView)
        
        
        let toDoString: String = todoTextField.text!
        let toDoStringChanged: NSString = toDoString as NSString
        let todoTextSize: CGSize = toDoStringChanged.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)])
        
        strikeThruLine = UIView()
        strikeThruLine.frame.size.width = 0
        strikeThruLine.frame.size.height = 1.5
        strikeThruLine.frame.origin.x = 0
        strikeThruLine.frame.origin.y = 10
        strikeThruLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        todoTextField.addSubview(strikeThruLine)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
            strikeThruLine.frame.size.width = todoTextSize.width
            self.todoTextField.textColor = UIColor(white: 0.7, alpha: 0.7)
            }, completion: nil)
    }


    
    func unDoCheckBox(){
        let animationImages:[UIImage]? =
        [UIImage(named: "uncheck1")!,
            UIImage(named: "uncheck2")!,
            UIImage(named: "uncheck3")!,
            UIImage(named: "uncheck4")!]
        let loadingImageView = UIImageView()
        loadingImageView.frame = todoCheckBox.frame
        loadingImageView.frame.origin.x = (todoCheckBox.frame.origin.x - 12)
        loadingImageView.frame.origin.y = (todoCheckBox.frame.origin.y - 7)
        loadingImageView.animationImages = animationImages
        loadingImageView.animationDuration = 0.3
        loadingImageView.animationRepeatCount = 1
        loadingImageView.startAnimating()
        todoCheckBox.addSubview(loadingImageView)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
                if strikeThruLine != nil {
                    strikeThruLine.frame.size.width = 0
                }
            }, completion: { finished in
                
                UIView.animateWithDuration(0.7, animations: {
                    self.todoTextField.textColor = UIColor(white: 0, alpha: 1)
                })
        })    }


    
    
    
    func performAction() {
        viewController?.saveTaskWithTitle(self.todoTextField.text!)
        todoCheckBox.enabled = true
//        self.todoTextField.text = ""
//        self.todoTextField.becomeFirstResponder()
        
        //delegate?.tableViewCell(self, didEnterString: self.todoTextField.text!)
        
//        toDoItems.append(ToDoItem(text: todoTextField.text!))
//        print(toDoItems)
        
        
    }
    
    
}