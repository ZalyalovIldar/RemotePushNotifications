//
//  NotificationDetailModuleConfigurator.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//


import Foundation
import UIKit

class NotificationDetailModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        configureModule()
    }
    
    /// сконфигурировать контроллер
    func configureModule() {
        
        guard let view = viewController as? NotificationDetailViewController else { fatalError() }
        
        let presenter = NotificationDetailPresenter()
        
        view.presenter = presenter
      
        presenter.view = view
    }
}
