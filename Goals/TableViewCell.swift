//
//  TableViewCell.swift
//  Goals
//
//  Created by Alex Miles on 2/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

/*protocol TableViewCellDelegate {
    func tableViewCell(tableViewCell: TableViewCell, didEnterString string: String)
}*/


class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var todoCheckBox: UIButton!
    
    @IBOutlet weak var todoContentHolder: UIView!
    
    var strikeThruLine: UIView!
    weak var viewController: TodosViewController?
    
    func configure(text text: String?, placeholder: String) {
        self.todoTextField.delegate = self
        
        todoTextField.text = text
        todoTextField.placeholder = placeholder
        
        todoTextField.accessibilityValue = text
        todoTextField.accessibilityLabel = placeholder
        
        todoTextField.autocapitalizationType = UITextAutocapitalizationType.Sentences
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
    
    
    @IBAction func didCheck(sender: UIButton) {
        if todoTextField.text != ""{
        if (sender.selected == true)
        {
            unDoCheckBox()
            sender.selected = false
        }else{
            animateCheckBox()
            sender.selected = true
            
            }}
    
    }
    
    func animateCheckBox(){
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
        strikeThruLine.frame.origin.y = 15
        strikeThruLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        todoTextField.addSubview(strikeThruLine)
        todoTextField.textColor = UIColor(white: 0.7, alpha: 0.7)
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
            self.strikeThruLine.frame.size.width = todoTextSize.width
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
            self.strikeThruLine.frame.size.width = 0
            }, completion: { finished in
                self.todoTextField.textColor = UIColor(white: 0, alpha: 1)
        })    }


    
    func performAction() {
        viewController?.saveTaskWithTitle(self.todoTextField.text!)
//        self.todoTextField.text = ""
//        self.todoTextField.becomeFirstResponder()
        
        //delegate?.tableViewCell(self, didEnterString: self.todoTextField.text!)
        
//        toDoItems.append(ToDoItem(text: todoTextField.text!))
//        print(toDoItems)
        
        
        
        
    }
    
    
}