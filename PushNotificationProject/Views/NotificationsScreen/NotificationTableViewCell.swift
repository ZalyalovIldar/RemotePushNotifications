//
//  NotificationTableViewCell.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    /// Image of notification
    @IBOutlet weak var iconImageView: UIImageView!
    
    /// Title of notification
    @IBOutlet weak var titleLabel: UILabel!
    
    var networkManager: NetworkManagerProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        networkManager = NetworkManager()
    }

    func configureCell(with notification: NotificationModel) {
        
        titleLabel.text = notification.title
        
        if let imageURL = URL(string: notification.imageURL) {
            
            networkManager.obtainImage(with: imageURL) { [weak self] (result) in
                
                switch result {
                    
                case .Success(let data):
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(data: data)
                    }

                case .Error(let error):
                    print(error.localizedCapitalized)
                    
                }
            }
        }
    }

}
