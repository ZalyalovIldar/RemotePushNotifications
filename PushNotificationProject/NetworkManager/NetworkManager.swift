//
//  NetworkManager.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NetworkManagerProtocol {
    
    func obtainImage(with url: URL, completionBlock: @escaping (DownloadResult) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionBlock(.Error(error: error.localizedDescription))
            }
            else {
                completionBlock(.Success(imageData: data!))
            }
            }.resume()
    }
    
}
