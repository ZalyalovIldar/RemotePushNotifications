//
//  RemotePushNotificationManager.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class RemotePushNotification: NSObject, UNUserNotificationCenterDelegate {
    
    var notificationCenter = UNUserNotificationCenter.current()
    
    func configureRemoteNotification() {
        
        notificationCenter.delegate = self 
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self](authorized, error) in
           
            guard authorized else { return }
            self?.getNotificationSettings()
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else {
                
                self?.checkRemoteNotificationStatus()
            }
        }
    }
    
    func checkRemoteNotificationStatus() {
        
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.alertSetting {
            case .enabled:
                  print("enabled")
                  
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            
            case .disabled:
                print("disabled")
            default: break
            }
        }
        
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
}
