//
//  Notification.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

class Payload {
    
    /// Title of notification
    var alert: String
    
    /// Text of notification
    var text: String?
    
    /// Image URL
    var imageURL: String?
    
    init(with aps: [String: AnyObject]) {
        alert = aps["alert"] as? String ?? ""
        text = aps["text"] as? String
        imageURL = aps["imageURL"] as? String
    }
}
