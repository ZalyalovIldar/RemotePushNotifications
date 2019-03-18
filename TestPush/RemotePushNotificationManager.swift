//
//  RemotePushNotificationManager.swift
//  TestPush
//
//  Created by Ильдар Залялов on 18/03/2019.
//  Copyright © 2019 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class RemotePushNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    var notificationCenter = UNUserNotificationCenter.current()
    var applicationRouter = ApplicationRouter()
    
    func configureRemoteNotifications() {
        
        notificationCenter.delegate = self 
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (authorized, error) in
            
            if let error = error {
                
                print("Error: \(error.localizedDescription)")
            }
            else {
                self?.checkRemoteNoficationsStatus()
                self?.configureNotification()
            }
        }
    }
    
    func checkRemoteNoficationsStatus() {
        
        notificationCenter.getNotificationSettings { (settings) in
            
            switch settings.alertSetting {
            case .enabled:
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            case .disabled:
                print("DisEnabled")
                
            default: break
            }
        }
    }
    
    func configureNotification() {
        
        let categoryId = "myActions"
        
        let okAction = UNNotificationAction(identifier: "okAction",
                                            title: "OK",
                                            options: .foreground)
        let remove = UNNotificationAction(identifier: "removeAction",
                                          title: "Remove",
                                          options: .destructive)
        
        let category = UNNotificationCategory(
            identifier: categoryId,
            actions: [okAction,remove],
            intentIdentifiers: [],
            options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    //MARK: - UNUserNotificationCenterDelegate
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "okAction" {
            applicationRouter.openController(with: .red)
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
}
