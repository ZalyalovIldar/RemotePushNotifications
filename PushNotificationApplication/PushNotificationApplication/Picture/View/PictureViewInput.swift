//
//  PictureViewInput.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокол определяющий действия вьюхи
protocol PictureViewInput: AnyObject {
    
    /// устанвоить картинку на экран
    ///
    /// - Parameter pictureData: картинка
    func setupPicture(pictureData: Data)
}
