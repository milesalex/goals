//
//  CustomTabBarViewController.swift
//  Goals
//
//  Created by kevin grennan on 3/7/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var customTabBar: UIView!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    var todayTab: UIViewController!
    var yearTab: UIViewController!
    var lifeTab: UIViewController!
    var tabs: [UIViewController]!
    var selectedIndex: Int = 0
    var keyboardShowing: Bool! = true
    
    let todayDataModel = DataModel(aType: .Today)
    let yearDataModel = DataModel(aType: .Year)
    let lifeDataModel = DataModel(aType: .Life)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let todayNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        let yearNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        let lifeNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        
        let todayViewController = todayNavigationController.topViewController as! TodosViewController
        let yearViewController = yearNavigationController.topViewController as! TodosViewController
        let lifeViewController = lifeNavigationController.topViewController as! TodosViewController
        
        tabs = [todayViewController, yearViewController, lifeViewController]
        
        todayViewController.dataModel = todayDataModel
        yearViewController.dataModel = yearDataModel
        lifeViewController.dataModel = lifeDataModel
        
        buttons[selectedIndex].selected = true
        didPressTab(buttons[selectedIndex])
        
        //Check if keyboard is visible
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardVisible:", name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressTab(sender: UIButton) {
        let previousIndex = selectedIndex
        
        selectedIndex = sender.tag
        buttons[previousIndex].selected = false
        
        let previousVC = tabs[previousIndex]
        previousVC.willMoveToParentViewController(nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.selected = true
        
        let vc = tabs[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        
        contentView.addSubview(vc.view)
        vc.didMoveToParentViewController(self)
        

//        if keyboardShowing == true{
//            //keyboard should still be visible
//            print("keyboard is visible")
//        }else{
//            //keyboard should not be visible
//            print("keyboard is not visible")
//        }
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
//    }
//    
//        func keyboardWillChangeFrame(notification: NSNotification) {
//            var info = notification.userInfo!
//            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.customTabBar.frame.origin.y = keyboardFrame.origin.y-50
//                })
//            print(keyboardFrame.origin.y)
            }

//    func keyboardVisible(notification: NSNotification) {
//        keyboardShowing = true
//        var info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.customTabBar.frame.origin.y = keyboardFrame.origin.y-50
//        })
//        print("eee", keyboardFrame.origin.y)
//    }
//    
//    func keyboardHidden(notification: NSNotification) {
//        keyboardShowing = false
//        var info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.customTabBar.frame.origin.y = keyboardFrame.origin.y-50
//        })
//        print("oooo", keyboardFrame.origin.y)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
