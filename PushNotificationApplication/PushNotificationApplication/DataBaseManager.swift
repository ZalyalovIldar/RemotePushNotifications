//
//  DataBaseManager.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol {
    
    /// получить массив объектов из бд
    ///
    /// - Returns: массив объектов типа Notification
    func obtainModels() -> [Notification]
    
    /// сохраняет объект типа Notification
    ///
    /// - Parameter model: объект
    func save(model: Notification)
    
    /// очистить бд
    func clearAll()
    
}

class DataBaseManager: DataBaseManagerProtocol {
    
    fileprivate lazy var mainRealm: Realm = {
        
        let config = Realm.Configuration(
            
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
        return try! Realm(configuration: .defaultConfiguration)
    }()
    
    func obtainModels() -> [Notification] {
        
        let models = mainRealm.objects(Notification.self)
        return Array(models)
    }
    
    func save(model: Notification) {
        
        try! mainRealm.write {
            mainRealm.add(model)
        }
    }
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}
