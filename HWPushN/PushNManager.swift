//
//  PushNManager.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class PushNManager: NSObject, UNUserNotificationCenterDelegate {
    
    
    var notificationCenter = UNUserNotificationCenter.current()
    
    /// настройка конфигураций уведомления
    func configureRemoteNotifications() {
        
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self]
            (authorized, error) in
            
            if let error = error {
                
                print("Error: \(error.localizedDescription)")
            }
            else {
                self?.checkRemoteNoficationsStatus()
                self?.configureNotification()
            }
        }
    }
    
    /// Настройка действий над уведомлением
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
    
    /// Проверка статуса настроек уведомлений
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
}
