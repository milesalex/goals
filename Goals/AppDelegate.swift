//
//  AppDelegate.swift
//  Goals
//
//  Created by Alex Miles on 2/18/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let todayDataModel = DataModel(aType: .Today)
    let yearDataModel = DataModel(aType: .Year)
    let lifeDataModel = DataModel(aType: .Life)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nuxViewController = storyboard.instantiateViewControllerWithIdentifier("NuxStepViewController") as! NuxStepViewController
        
        nuxViewController.steps = [
            NuxStep(text: "Today", description: "test", model: todayDataModel)!,
            NuxStep(text: "Year", description: "test2", model: yearDataModel)!,
            NuxStep(text: "Life", description: "test3", model: lifeDataModel)!];

        let prefs = NSUserDefaults.standardUserDefaults()
        if (!prefs.boolForKey("hasOpened")) {
            
            // NuxStepViewController
            
            // PROTOCOL:
            // type (TODAY, YEAR, LIFE)
            // message "stuff i wanna do today/year/life")
            
            
            
            self.window?.rootViewController = nuxViewController
        } else {
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("CustomTabBarViewController") as! CustomTabBarViewController

            //let step = self.steps[0]
            
           // initialViewController.todayDataModel = todayDataModel

            self.window?.rootViewController = initialViewController
        }
        
        
        // check if user is in nux if so then load today view
        
        // else do this shit
        
        
        let tabBarController = UITabBarController()
        let todayNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        let yearNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        let lifeNavigationController = storyboard.instantiateViewControllerWithIdentifier("TodosNavigationController") as! UINavigationController
        
        
        tabBarController.viewControllers = [todayNavigationController, yearNavigationController, lifeNavigationController]
        
        //window!.rootViewController = tabBarController
        
        let todayViewController = todayNavigationController.topViewController as! TodosViewController
        let yearViewController = yearNavigationController.topViewController as! TodosViewController
        let lifeViewController = lifeNavigationController.topViewController as! TodosViewController
        
        todayViewController.dataModel = todayDataModel
        yearViewController.dataModel = yearDataModel
        lifeViewController.dataModel = lifeDataModel
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        let prefs = NSUserDefaults.standardUserDefaults()
        
        let whenUserLastClosedApp = NSDate()
        prefs.setValue(whenUserLastClosedApp, forKey: "whenUserLastClosedApp")
        prefs.synchronize()
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Reference time when the user last closed the app
        
        
        // Reset application badge number
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        self.todayDataModel.deleteAllPastTodosForCurrentDate()
        
    }
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Badge, categories: nil))
        
        let fireTime = NSDate.nextDayAtHour(8)
        
        let notification = UILocalNotification()
        notification.alertBody = "What are you doing today?"
        notification.alertAction = "Open"
        notification.fireDate = fireTime
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Alex added this from master
    
    


}

