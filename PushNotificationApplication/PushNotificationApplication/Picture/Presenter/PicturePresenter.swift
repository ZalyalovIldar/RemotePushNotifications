//
//  PicturePresenter.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

class PicturePresenter: PictureViewOutput {
    
    weak var view: PictureViewInput!
    
    func setupImage(dataImage: Data) {
        view.setupPicture(pictureData: dataImage)
    }
    
}
