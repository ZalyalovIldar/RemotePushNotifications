//
//  DataManagerProtocol.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataManagerProtocol: AnyObject {
    
    func saveData(model: Object)
}
