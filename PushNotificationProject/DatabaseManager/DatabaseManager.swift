//
//  DatabaseManager.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class DatabaseManager: DatabaseManagerProtocol {
    
    internal lazy var mainRealm: Realm = try! Realm(configuration: .defaultConfiguration)
    
    // MARK: - Operation queues
    
    private lazy var getOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.name = "Get operation queue"
        
        return queue
    }()
    
    private lazy var saveOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Save operation queue"
        
        return queue
    }()
    
    private lazy var deleteOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Delete operation queue"
        
        return queue
    }()
    
    
    // MARK: - Get objects
    
    func getObjects<T>(with type: T.Type) -> Array<T>? where T : Object {
        
        return Array(mainRealm.objects(T.self))
    }
    
    func asyncGetObjects<T>(with type: T.Type, completionBlock: @escaping (Array<T>?) -> Void) where T : Object {
        
        getOperationQueue.addOperation {
            completionBlock(self.getObjects(with: T.self))
        }
    }
    
    
    // MARK: - Save objects
    
    func saveObjects<T>(objects: Array<T>) where T : Object {
        
        try! mainRealm.write {
            mainRealm.add(objects)
        }
    }
    
    func asyncSaveObjects<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object {
        
        saveOperationQueue.addOperation {
            
            self.saveObjects(objects: objects)
            completionBlock(true)
        }
    }
    
    
    // MARK: - Delete objects
    
    func deleteObjects<T>(objects: Array<T>) where T : Object {
        
        try! mainRealm.write {
            mainRealm.delete(objects, cascading: true)
        }
    }
    
    func asyncDelete<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object {
        
        DispatchQueue.main.async {
            self.deleteObjects(objects: objects)
        }
    }
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
    
    func performTransaction(transaction: () -> ()) {
        
        try! mainRealm.write {
            transaction()
        }
    }
}

protocol CascadeDeleting: class {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }
    
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}

private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }
    
    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        if let cascadingObject = element as? CascadeDeletable {
            element.objectSchema.properties.forEach {
                if cascadingObject.propertiesToCascadeDelete.contains($0.name) {
                    guard let value = element.value(forKey: $0.name) else { return }
                    if let entity = value as? RLMObjectBase {
                        toBeDeleted.insert(entity)
                    } else if let list = value as? RealmSwift.ListBase {
                        for index in 0..<list._rlmArray.count {
                            if let realmObject = list._rlmArray.object(at: index) as? RLMObjectBase {
                                toBeDeleted.insert(realmObject)
                            }
                        }
                    }
                }
            }
        }
        delete(element)
    }
}

protocol CascadeDeletable: class {
    var propertiesToCascadeDelete: [String] { get }
}

private extension Realm {
    private func cascadingDelete(_ object: Object) {
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(object)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object, !element.isInvalidated else { continue }
            resolve(element, toBeDeleted: &toBeDeleted)
            delete(element)
        }
    }
    
    private func resolve(_ element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        guard let deletable = element as? CascadeDeletable else { return }
        let propertiesToDelete = element.objectSchema.properties.filter {
            deletable.propertiesToCascadeDelete.contains($0.name)
        }
        propertiesToDelete.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let object = value as? Object {
                toBeDeleted.insert(object)
            } else if let list = value as? RealmSwift.ListBase {
                for index in 0..<list._rlmArray.count {
                    guard let object = list._rlmArray.object(at: index) as? Object else { continue }
                    toBeDeleted.insert(object)
                }
            }
        }
    }
}
