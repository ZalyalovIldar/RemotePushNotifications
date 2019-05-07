//
//  AppDelegate.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var remoteNotificationManager = RemotePushNotification()
    var databaseManager = DataBaseManager()
    var applicationRouter = ApplicationRouter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        remoteNotificationManager.configureRemoteNotification()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    // MARK: - Push Notifications
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        let newPush = NotificationObject()
        let alertDict = aps["alert"] as! [String: String]
        
        newPush.name = alertDict["title"]!
        newPush.descriprion = alertDict["body"]!
        newPush.image = try! Data(contentsOf: URL(string: aps["url"] as! String)! )
        
        databaseManager.save(model: newPush)
        applicationRouter.openController(with: newPush)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.map {
            String(format: "%02.2hhx", $0) }.joined()
        print("Device Token \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print ("Error register \(error.localizedDescription)")
    }
    
    /// метод позволяет отображать пуш нофтификации внутри приложения
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       completionHandler([.alert,.badge,.sound])
   }
}

