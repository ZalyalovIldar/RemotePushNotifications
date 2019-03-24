//
//  PictureViewController.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, PictureViewInput {
    
    @IBOutlet weak var mainPicture: UIImageView!
    
    var notificationPicture: Data?
    var presenter: PictureViewOutput!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.setupImage(dataImage: notificationPicture!)
    }
   
    func setupPicture(pictureData: Data) {
        
        mainPicture.image = UIImage(data: pictureData)
    }
}
