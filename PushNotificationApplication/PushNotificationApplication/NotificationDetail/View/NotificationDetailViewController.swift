//
//  NotificationDetailViewController.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class NotificationDetailViewController: UIViewController, NotificationDetailViewInput {
    
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var describtionImage: UILabel!

    var model: Notification?
    var presenter: NotificationDetailViewOutput!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setupDetailNotification(withModel: model!)
    }
    
    func setupPicture(dataPicture: Data) {
        
        pictureImage.image = UIImage(data: dataPicture)
    }
    
    func setupName(name: String) {
        
        nameLabel.text = name
    }
    
    func setupDescription(description: String) {
        
        describtionImage.text = description
    }
}
