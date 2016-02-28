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
    var whenUserLastClosedApp: NSDate!
    
    var prefs = NSUserDefaults.standardUserDefaults()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadTodos()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        whenUserLastClosedApp = NSDate()
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
        whenUserLastClosedApp = prefs.objectForKey("whenUserLastClosedApp") as? NSDate
        
        // Get current time
        let now = NSDate()
        
        // For testing purposes
         let yesterday = NSDate().dateByAddingTimeInterval(60 * 60 * 24 * -1)
        
        print(toDoItems)
        
        if whenUserLastClosedApp != nil {
            if whenUserLastClosedApp.numberOfDaysUntilDateTime(now) < 0 {
                toDoItems.removeAll()
                saveTodos()
                
                print("app delegate")
            } else {
                print("dont delete todos")
            }
        }
    }
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Badge, categories: nil))
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        components.hour = 8
        components.minute = 00
        
        let fireTime = calendar.dateFromComponents(components)
        
        let notification = UILocalNotification()
        notification.alertBody = "What are you doing today?"
        notification.alertAction = "Open"
        notification.fireDate = fireTime
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

