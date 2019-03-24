//
//  RemoteNotificationManager.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

final class RemoteNotificationManager: NSObject {
    
    private var notificationCenter = UNUserNotificationCenter.current()
    
    func configure() {
        notificationCenter.requestAuthorization(
            options: [.alert, .badge, .sound]) { [weak self] (authorized, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                else {
                    self?.checkNotificationsStatus()
                }
        }
    }
    
    private func checkNotificationsStatus() {
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.alertSetting {
            case .enabled:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .disabled:
                print("Disabled")
            case.notSupported:
                break
            }
        }
    }
}
