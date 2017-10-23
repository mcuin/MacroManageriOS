//
//  DailyActivityTableViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 10/17/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class DailyActivityTableViewController: UITableViewController {
    
    @IBOutlet var dailyActivityLevelTableView: UITableView!
    
    let dailyActivityArray = ["Very Light", "Light", "Moderate", "Heavy", "Very Heavy"]
    let dailyActivityDescriptionArray = ["Very Light: Sitting, little walking, little other activities in a day", "Light: Typing, lab work, some walking in a day", "Moderate: Light manual labor job with 1-2 hours weight training or other training", "Heavy: Heavy manual labor job with 2-4 hours weight training or sports", "Very Heavy: Moderate or heavy for 8 hours or more a day plus 2-4 hours intense training"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        dailyActivityLevelTableView.delegate = self
        dailyActivityLevelTableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dailyActivityArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyActivityLevelCell")
        
        cell?.textLabel?.text = dailyActivityArray[indexPath.row]
        cell?.detailTextLabel?.text = dailyActivityDescriptionArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.set("veryLight", forKey: "dailyActivity")
        case 1:
            
            UserDefaults.standard.set("light", forKey: "dailyActivity")
        case 2:
            
            UserDefaults.standard.set("moderate", forKey: "dailyActivity")
        case 3:
            
            UserDefaults.standard.set("heavy", forKey: "dailyActivity")
        case 4:
            
            UserDefaults.standard.set("veryHeavy", forKey: "dailyActivity")
        default:
            
            UserDefaults.standard.set("veryLight", forKey: "dailyActivity")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
