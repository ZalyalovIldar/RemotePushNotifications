//
//  DetailedViewController.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    /// Title of notification
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Image of notification
    @IBOutlet weak var imageView: UIImageView!
    
    /// Text of notification
    @IBOutlet weak var textLabel: UILabel!
    
    var networkManager: NetworkManagerProtocol!
    
    var currentModel: NotificationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager = NetworkManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let model = currentModel {
            titleLabel.text = model.title
            textLabel.text = model.text
            
            if let imageURL = URL(string: model.imageURL) {
                
                networkManager.obtainImage(with: imageURL) { [weak self] (result) in
                    
                    switch result {
                        
                    case .Success(let data):
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }

                    case .Error(let error):
                        print(error.localizedCapitalized)
                        
                    }
                }
            }
        }
    }

}
