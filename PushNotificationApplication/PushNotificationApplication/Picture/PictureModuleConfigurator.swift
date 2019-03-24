//
//  PictureModuleConfigurator.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class PictureModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        configureModule()
    }
    
    /// сконфигурировать контроллер
    func configureModule() {
        
        guard let view = viewController as? PictureViewController else { fatalError() }
        
        let presenter = PicturePresenter()
        
        view.presenter = presenter
        
        presenter.view = view
    }
}
