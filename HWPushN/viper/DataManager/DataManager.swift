//
//  DataManager.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager: DataManagerProtocol {
    
    
    fileprivate lazy var mainRealm: Realm = try! Realm(configuration: .defaultConfiguration)
    
    func saveData(model: Object) {
        
    }
    
    func saveItem(item: Object) {
        
        try! mainRealm.write {
            mainRealm.add(item)
        }
    }
    
    func obtainNotifications() -> [NotificationModel]? {
        
        var array: [NotificationModel]?
        try! mainRealm.write {
            array = Array(mainRealm.objects(NotificationModel.self))
        }
        return array
    }
}
