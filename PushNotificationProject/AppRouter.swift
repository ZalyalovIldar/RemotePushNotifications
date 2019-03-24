//
//  AppRouter.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private let databaseManager = DatabaseManager()
    
    func openController(with payload: Payload) {
        
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: Identifiers.TabBarVC.rawValue) as! UITabBarController
        
        let notificationModel = NotificationModel()
        notificationModel.title = payload.alert
        notificationModel.text = payload.text ?? ""
        notificationModel.imageURL = payload.imageURL ?? ""
        
        databaseManager.saveObjects(objects: [notificationModel])
        
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC

        let navigationVC = tabBarVC.selectedViewController as! UINavigationController
        let notificationVC = navigationVC.viewControllers[0]
        let imageNavigationVC = tabBarVC.viewControllers![1] as! UINavigationController
        let imageVC = imageNavigationVC.viewControllers[0] as! ImageViewController
        
        imageVC.imageURLString = notificationModel.imageURL
        
        notificationVC.performSegue(withIdentifier: Identifiers.ToDetailedVC.rawValue, sender: notificationModel)
        
        UIApplication.shared.keyWindow?.makeKey()
    }
}
