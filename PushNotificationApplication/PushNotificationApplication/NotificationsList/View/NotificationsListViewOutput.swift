//
//  NotificationsListViewOutput.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокло действий, которые исполняет пресентера
protocol NotificationsListViewOutput: AnyObject {
    
    /// очистить базу данных
    func clearAll()
}
