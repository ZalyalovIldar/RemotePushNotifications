//
//  NotificationsListPresenter.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

class NotificationsListPresenter: NotificationsListViewOutput {
    
    var dataBaseManager: DataBaseManagerProtocol!
    weak var view: NotificationsListViewInput!
    
    func clearAll() {
        dataBaseManager.clearAll()
    }
}
