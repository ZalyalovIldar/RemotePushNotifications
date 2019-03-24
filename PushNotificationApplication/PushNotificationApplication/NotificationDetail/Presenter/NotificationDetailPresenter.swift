//
//  NotificationDetailPresenter.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

class NotificationDetailPresenter: NotificationDetailViewOutput {
    
    weak var view: NotificationDetailViewInput!
    
    func setupDetailNotification(withModel: Notification) {
        
        view.setupName(name: withModel.name)
        view.setupPicture(dataPicture: withModel.image)
        view.setupDescription(description: withModel.descriprion)
    }
}
