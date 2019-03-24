//
//  ImageViewController.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    /// Notification's image container
    @IBOutlet weak var notificationImageView: UIImageView!
    
    var networkManager: NetworkManagerProtocol!
    
    var imageURLString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let imageURLString = imageURLString else { return }
        
        if let imageURL = URL(string: imageURLString) {
            
            networkManager.obtainImage(with: imageURL) { [weak self] (result) in
                
                switch result {
                    
                case .Success(let data):
                    DispatchQueue.main.async {
                        self?.notificationImageView.image = UIImage(data: data)
                    }
                    
                case .Error(let error):
                    print(error.localizedCapitalized)
                    
                }
            }
        }
    }

}
