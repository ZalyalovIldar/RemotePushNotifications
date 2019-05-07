//
//  ApplicationRouter.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

class ApplicationRouter {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var dataBaseManager: DataBaseManagerProtocol = DataBaseManager()
    
    func obtainImage(completion: @escaping ((UIImage?) -> Void)) {
        URLSession.shared.dataTask(with: URL(string: "http://www.lipetskmedia.ru/images/news_/034/269.jpg")!) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else  {
                
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()
    }
   
    func openController(with model: NotificationObject) {
        
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "pushed")
        let tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        let detail = detailViewController as! NotificationDetailViewController
       
        detail.model = model
       
        UIApplication.shared.keyWindow?.rootViewController = tabBarViewController
        
        let mainNavigation = tabBarViewController.selectedViewController as! UINavigationController
        let pictureNavigation = tabBarViewController.viewControllers![1] as! UINavigationController
        
        let table = mainNavigation.viewControllers[0]
        let picture = pictureNavigation.viewControllers[0] as! PictureViewController
        
        picture.notificationPicture = model.image
        table.performSegue(withIdentifier: "detail", sender: model)
        
        UIApplication.shared.keyWindow?.makeKey()
     }
}
