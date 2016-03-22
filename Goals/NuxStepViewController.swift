//
//  NuxStepViewController.swift
//  Goals
//
//  Created by Nathaniel Hajian on 3/16/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


public class NuxStepViewController: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var subHead: UITextView!
    @IBOutlet weak var nuxButton: UIButton!
    
    
    var tableView = TodosViewController()
    public var steps = Array<NuxStep>()
    
    var currentStep:NuxStep? //nuxstep
    
    func advanceToNextStep() {
        if (!self.steps.isEmpty) {
            self.currentStep = self.steps[0];
            self.steps.removeFirst()
            setTextColor()
            
            if let label = self.currentStep?.titleText{
                
                
                self.header.text = label
            }

            if let label = self.currentStep?.stepDescription{
                self.subHead.text = label
            }
        }
    }
    

    func setTextColor (){
    
    
        if header.text == "Today"{
            
            header.textColor = UIColorFromRGB(0x1DA1F2)
            nuxButton.backgroundColor = UIColorFromRGB(0x1DA1F2)
            
        }
            
        else if header.text == "Year"{
            
            header.textColor = UIColorFromRGB(0xF1596B)
            nuxButton.backgroundColor = UIColorFromRGB(0xF1596B)
            
        }
            
        else {
            
            header.textColor = UIColorFromRGB(0x19CF86)
            nuxButton.backgroundColor = UIColorFromRGB(0x19CF86)
            
            
        }
        
    
    
    
    }
    
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
       nuxButton.layer.cornerRadius = 5
        
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // check nux
        if (segue.identifier == "endingNux") {
            let destinationController = segue.destinationViewController as! CustomTabBarViewController
            
            //let step = self.steps[0]
            
            //destinationController.todayDataModel = self.currentStep!.model
            
            //destinationController.dataModel = (self.currentStep?.model)!
            
        } else {
            let destinationController = segue.destinationViewController as! TodosViewController
            
            if (self.currentStep == nil) {
                self.advanceToNextStep()
            }
            destinationController.dataModel = self.currentStep?.model
            
            self.tableView = destinationController; 
        }
    }

    @IBAction func nextActionButton(sender: UIButton) {
        
        self.currentStep?.model.loadTodos()
        self.currentStep?.model.saveTodos()

        if (!self.steps.isEmpty) {
            self.advanceToNextStep()
            
            
            
            
            if (self.currentStep?.model != nil) {
                self.tableView.dataModel = self.currentStep!.model
            } else {
                "ending NUX"
            }
        } else {
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setBool(true, forKey: "hasOpened")
            
            performSegueWithIdentifier("endingNux", sender: nil)

            
            NSLog("should end nux")
        }
        
        
        
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}


