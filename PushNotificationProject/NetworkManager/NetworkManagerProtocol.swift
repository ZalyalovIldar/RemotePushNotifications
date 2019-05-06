//
//  NetworkManagerProtocol.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

enum DownloadResult {
    case success(imageData: Data)
    case error(error: String)
}

protocol NetworkManagerProtocol {
    
    /// Obtains image with given url
    ///
    /// - Parameters:
    ///   - url: image url
    ///   - completionBlock: to return result
    func obtainImage(with url: URL, completionBlock: @escaping (DownloadResult) -> Void)
}
