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
    let disabledId = "Disabled"
    let errorId = "Error: "
    let categoryId = "myActions"
    let okId = "okAction"
    let ok = "OK"
    let removeId = "removeAction"
    let remove = "Remove"
    
    /// настройка конфигураций уведомления
    func configureRemoteNotifications() {
        
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self]
            (authorized, error) in
            
            if let error = error {
                
                print(self!.errorId + error.localizedDescription)
            }
            else {
                self?.checkRemoteNoficationsStatus()
                self?.configureNotification()
            }
        }
    }
    
    /// Настройка действий над уведомлением
    func configureNotification() {
        
        let okAction = UNNotificationAction(identifier: self.okId,
                                            title: self.ok,
                                            options: .foreground)
        let remove = UNNotificationAction(identifier: self.removeId,
                                          title: self.remove,
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
                print(self.disabledId)
                
            default: break
            }
        }
    }
}
