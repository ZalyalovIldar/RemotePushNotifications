//
//  ApplicationRouter.swift
//  TestPush
//
//  Created by Ильдар Залялов on 18/03/2019.
//  Copyright © 2019 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit

class ApplicationRouter {
    
    
    func openController(with color: UIColor) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        
        controller?.view.backgroundColor = color
        
        UIApplication.shared.keyWindow?.rootViewController = controller
        UIApplication.shared.keyWindow?.makeKey()
    }
}
