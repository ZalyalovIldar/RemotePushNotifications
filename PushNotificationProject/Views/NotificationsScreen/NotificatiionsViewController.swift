//
//  ViewController.swift
//  PushNotificationProject
//
//  Created by Петр on 24/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    /// Cell spacing
    let cellSpacingHeight: CGFloat = 5
    
    /// Row height
    let estimatedRowHeight = 100
    
    /// Data for cells
    var items: [NotificationModel]!
    
    var databaseManager: DatabaseManagerProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        databaseManager = DatabaseManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = databaseManager.getObjects(with: NotificationModel.self)
    }

    
    // MARK: - Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cell.rawValue, for: indexPath) as! NotificationTableViewCell
        
        cell.configureCell(with: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentModel = items[indexPath.row]
        performSegue(withIdentifier: Identifiers.ToDetailedVC.rawValue, sender: currentModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == Identifiers.ToDetailedVC.rawValue, let model = sender as? NotificationModel {
            
            if let destinationVC = segue.destination as? DetailedViewController {
                destinationVC.currentModel = model
            }
        }
    }
}

