//
//  TableViewController.swift
//  HWPushN
//
//  Created by Гузель on 24/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {

    var dataManager = DataManager()
    var notifications: [NotificationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let array = dataManager.obtainNotifications() ?? []
        for arr in array {
            notifications.insert(arr, at: 0)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail", let notification = sender as? NotificationModel {
            
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.currentModel = notification
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        if let url = URL(string: notifications[indexPath.row].image) {
        
            cell.photoImageView.sd_setImage(with: url, completed: nil)
        }
        
        cell.titleLabel.text = notifications[indexPath.row].title
        cell.descriptionLabel.text = notifications[indexPath.row].descriptionInfo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: notifications[indexPath.row])
    }
}
