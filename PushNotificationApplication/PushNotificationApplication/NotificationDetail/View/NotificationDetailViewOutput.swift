//
//  NotificationDetailViewOutput.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокл исполняемый презентером
protocol NotificationDetailViewOutput: AnyObject {
    
    /// сконфигурировать ячейку
    ///
    /// - Parameter withModel: ячейку
    func setupDetailNotification(withModel: Notification)
}
