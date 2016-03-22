//
//  NewSettingsViewController.swift
//  Goals
//
//  Created by kevin grennan on 3/20/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

class NewSettingsViewController: UIViewController {
    
    @IBOutlet weak var didPickTime: UIDatePicker!
    @IBOutlet weak var dailySwitch: UISwitch!
    @IBOutlet weak var weekendSwitch: UISwitch!
    @IBOutlet weak var reminderTime: UIDatePicker!
    @IBOutlet weak var weekendText: UILabel!
    var dailySwitchOn :Bool!
    var weekendSwitchOn :Bool!
    var strDate :String!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var dailyReminder :Bool = true
    var weekendReminder :Bool = true
    var reminderSetTime :String = "08 00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailySwitch.addTarget(self, action: Selector("dailyStateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        //weekendSwitch.addTarget(self, action: Selector("weekendStateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            dailyReminder = NSUserDefaults.standardUserDefaults().boolForKey("dailyReminder")
            //weekendReminder = NSUserDefaults.standardUserDefaults().boolForKey("weekendReminder")
            
            if dailyReminder == true {
                dailySwitch.setOn(true, animated: false)
            } else {
                dailySwitch.setOn(false, animated: false)
                disableSubActions()
            }
            
//            if weekendReminder == true {
//                weekendSwitch.setOn(true, animated: false)
//            } else {
//                weekendSwitch.setOn(false, animated: false)
//            }
            
            if dailySwitch.on == true{
            dailySwitchOn = true
            } else {
            dailySwitchOn = false
            }
            
//            if weekendSwitch.on == true{
//                weekendSwitchOn = true
//            } else {
//                weekendSwitchOn = false
//            }
            if let reminderSetTime = NSUserDefaults.standardUserDefaults().objectForKey("reminderSetTime"){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH mm"
            if let date = dateFormatter.dateFromString(reminderSetTime as! String) {
                didPickTime.date = date
                }}

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func dailyStateChanged(switchState: UISwitch) {
        if switchState.on {
            enableSubActions()
            dailySwitchOn = true
        } else {
            disableSubActions()
            dailySwitchOn = false
        }
    }
    
//    func weekendStateChanged(switchState: UISwitch) {
//        if switchState.on {
//            weekendSwitchOn = true
//        } else {
//            weekendSwitchOn = false
//        }
//    }
    
    func disableSubActions() {
        reminderTime.alpha = 0.3
        reminderTime.userInteractionEnabled = false
//        weekendSwitch.alpha = 0.3
//        weekendSwitch.setOn(false, animated:true)
//        weekendSwitchOn = false
//        weekendSwitch.userInteractionEnabled = false
//        weekendText.alpha = 0.3
    }
    
    func enableSubActions() {
        reminderTime.alpha = 1
        reminderTime.userInteractionEnabled = true
//        weekendSwitch.alpha = 1
//        weekendSwitch.userInteractionEnabled = true
//        weekendText.alpha = 1
    
    }
    
    @IBAction func timeAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH mm"
        strDate = dateFormatter.stringFromDate(didPickTime.date)
        
    }
    @IBAction func didPressDone(sender: UIBarButtonItem) {
        if dailySwitchOn == true{
            defaults.setBool(true, forKey: "dailyReminder")
        } else {
            defaults.setBool(false, forKey: "dailyReminder")
        }
//        if weekendSwitchOn == true {
//            defaults.setBool(true, forKey: "weekendReminder")
//        } else {
//            defaults.setBool(false, forKey: "weekendReminder")
//        }
        if strDate != nil{
        defaults.setObject(strDate, forKey: "reminderSetTime")
        }
        defaults.synchronize()
        dismissViewControllerAnimated(true, completion: nil)
        AppDelegate().updateNotificationTime()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
