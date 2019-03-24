//
//  NotificationsListViewController.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class NotificationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotificationsListViewInput {
    
    var dataBaseManager: DataBaseManagerProtocol!
    var presenter: NotificationsListViewOutput!
   
    @IBOutlet weak var tableView: UITableView!
    
    lazy var cashedDataSource: NSCache<AnyObject, Notification> = {
    
        let cashe = NSCache<AnyObject, Notification>()
        
        return cashe
    }()
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func clearAllBarButtonItem(_ sender: Any) {
        
        presenter.clearAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let models: [Notification]  = dataBaseManager.obtainModels()
        return models.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let models: [Notification]  = dataBaseManager.obtainModels()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTableViewCell
        
        if let newCell = cashedDataSource.object(forKey: indexPath.row as AnyObject) {
            
            cell.configureCell(notification: newCell)
        } else {
            
            let newCell = Notification()
            
            newCell.image = models[indexPath.row].image
            newCell.name = models[indexPath.row].name
            newCell.descriprion = models[indexPath.row].descriprion
            
            cell.configureCell(notification: newCell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let models: [Notification]  = dataBaseManager.obtainModels()
        let cell = models[indexPath.row]
        performSegue(withIdentifier: "detail", sender: cell)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail", let model = sender as? Notification {
            let destinationController = segue.destination as! NotificationDetailViewController
            destinationController.model = model
        }
    }
}
