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
    
    func setupDetailNotification(with model: NotificationObject) {
        
        view.setupName(name: model.name)
        view.setupPicture(dataPicture: model.image)
        view.setupDescription(description: model.descriprion)
    }
}
