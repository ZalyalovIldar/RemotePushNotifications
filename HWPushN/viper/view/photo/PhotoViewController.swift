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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let model = notificationModel {
            
            if let url = URL(string: model.image) {
                
                DispatchQueue.main.async {
                    self.photoImageView.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
