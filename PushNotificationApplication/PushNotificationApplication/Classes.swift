//
//  Classes.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Notification: Object {
    
    dynamic var name = String()
    dynamic var image = Data()
    dynamic var descriprion = String()
}
