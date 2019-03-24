//
//  PictureViewOutput.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокол определяющий действия презентера
protocol PictureViewOutput: AnyObject {
    
    /// отправить картинку
    ///
    /// - Parameter dataImage: поставить картинку
    func setupImage(dataImage: Data)
}
