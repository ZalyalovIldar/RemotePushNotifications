//
//  ApplicationRouter.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ApplicationRouter {
    
    let detailVC = "detailVC"
    let tableVC = "tableVC"
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let dataManager = DataManager()
    let aps = "aps"
    let alertId = "alert"
    let titleId = "title"
    let bodyId = "body"
    let urlImageString = "urlImageString"
    let tabbar = "tabbar"
    let toDetail = "toDetail"
    
    /// Метод, срабатывающий при нажатии на нотификацию
    ///
    /// - Parameter dict: userInfo в виде словаря
    func didPressedPushNotification(dict: NSDictionary) {
        
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: tabbar) as! UITabBarController
        
        let notificationModel = NotificationModel()
        
        if let aps = dict[aps] as? NSDictionary {
            
            if let alert = aps[alertId] as? NSDictionary {
            
                if let title = alert[titleId] as? NSString {
                    notificationModel.title = title as String
                }
                
                if let body = alert[bodyId] as? NSString {
                    notificationModel.descriptionInfo = body as String
                }
            }
        }
        
        if let img = dict[urlImageString] as? NSString {
            notificationModel.imageUrlString = (img as String)
        }
        
        notificationModel.id = getLastId() + 1
        
        dataManager.saveItem(item: notificationModel)
        
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        
        let navigationVC = tabBarVC.viewControllers![0] as! UINavigationController
        let notificationVC = navigationVC.viewControllers[0]
        let photoNavigationVC = tabBarVC.viewControllers![1] as! UINavigationController
        let photoVC = photoNavigationVC.viewControllers[0] as! PhotoViewController
        
        photoVC.notificationModel = notificationModel
        
        notificationVC.performSegue(withIdentifier: toDetail, sender: notificationModel)
        
        UIApplication.shared.keyWindow?.makeKey()
    }
    
    /// Получение последнего id моделей
    ///
    /// - Returns: Последний id
    func getLastId() -> Int {
        
        var id = 0
        
        if let notifArray = dataManager.obtainNotifications() {
            
            for notif in notifArray {
            
                if notif.id > id {
                    id = notif.id
                }
            }
        }
        
        return id
    }
}
