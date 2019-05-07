//
//  PhotoViewController.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var notificationModel: NotificationModel!
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let model = notificationModel {
            
            if let url = URL(string: model.imageUrlString) {
                
                self.photoImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
