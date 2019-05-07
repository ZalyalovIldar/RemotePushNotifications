//
//  NotificationModel.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class NotificationModel: Object {
    
    dynamic var id = 0
    dynamic var title = String()
    dynamic var imageUrlString = String()
    dynamic var descriptionInfo = String()
    
    override static func primaryKey() -> String? {
        return #keyPath(id)
    }
}
