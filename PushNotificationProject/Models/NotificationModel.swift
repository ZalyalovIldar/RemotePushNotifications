//
//  NotificationModel.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class NotificationModel: Object {
    
    dynamic var id: String = String(describing: UUID.init())
    dynamic var title: String = String()
    dynamic var text: String = String()
    dynamic var imageURL: String = String()
    dynamic var date: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
