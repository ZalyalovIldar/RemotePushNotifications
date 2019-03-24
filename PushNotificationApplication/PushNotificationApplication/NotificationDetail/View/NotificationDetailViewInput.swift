//
//  NotificationDetailViewInput.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокл исполняемый вью
protocol NotificationDetailViewInput: AnyObject {
    
    /// установить кратинку
    ///
    /// - Parameter dataPicture: дата по которой устанавливается картинка
    func setupPicture(dataPicture: Data)
    
    /// установить имя
    ///
    /// - Parameter name: имя
    func setupName(name: String)
    
    /// устанвоить описание
    ///
    /// - Parameter description: описание
    func setupDescription(description: String)
}
