//
//  NotificationTableViewCell.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    func configureCell(notification: NotificationObject) {
       
        avatarImage.image = UIImage(data: notification.image)
        nameLabel.text = notification.name
        descriptionLabel.text = notification.descriprion
    }
}
