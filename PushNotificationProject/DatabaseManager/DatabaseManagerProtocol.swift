//
//  DatabaseManagerProtocol.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseManagerProtocol {
    
    var mainRealm: Realm { get set }
    
    /// Return objects by given type
    ///
    /// - Parameter type: type of objects
    /// - Returns: list of objects
    func getObjects<T>(with type: T.Type) -> Array<T>? where T : Object
    
    /// Return objects by given type
    ///
    /// - Parameters:
    ///   - type: type of objects
    ///   - completionBlock: completionBlock
    /// - Returns: list of objects
    func asyncGetObjects<T>(with type: T.Type, completionBlock: @escaping (Array<T>?) -> Void) where T : Object
    
    /// Save given objects in database
    ///
    /// - Parameter objects: list of objects
    func saveObjects<T>(objects: Array<T>) where T : Object
    
    /// Save given objects in database
    ///
    /// - Parameters:
    ///   - objects: list of objects
    ///   - completionBlock: completionBlock
    func asyncSaveObjects<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object
    
    /// Delete objects
    ///
    /// - Parameter objects: list of objects
    func deleteObjects<T>(objects: Array<T>) where T : Object
    
    /// /// Delete objects
    ///
    /// - Parameters:
    ///   - objects: list of objects
    ///   - completionBlock: completionBlock
    func asyncDelete<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object
    
    /// Clean database
    func clearAll()
    
    /// Perfom given transaction in "write" block
    ///
    /// - Parameter transaction: given transaction
    func performTransaction(transaction: () -> ())
}
