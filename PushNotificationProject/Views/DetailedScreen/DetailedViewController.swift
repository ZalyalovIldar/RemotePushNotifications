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
        
        guard  let model = currentModel else { return }
        titleLabel.text = model.title
        textLabel.text = model.text
            
        guard let imageURL = URL(string: model.imageURL) else { return }

        setImage(with: imageURL)
    }
    
    private func setImage(with url: URL) {
        
        networkManager.obtainImage(with: url) { [weak self] (result) in
            
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
                
            case .error(let error):
                print(error.localizedCapitalized)
                
            }
        }
    }

}
