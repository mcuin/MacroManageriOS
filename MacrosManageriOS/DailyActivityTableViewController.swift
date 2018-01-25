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
        
        if let selection = UserDefaults.standard.value(forKey: "dailyActivityLevel") as? String {
            print(selection)
            switch selection {
                
            case "veryLight":
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            case "light":
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
            case "moderate":
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: .none)
            case "heavy":
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 3, section: 0), animated: false, scrollPosition: .none)
            case "veryHeavy":
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 4, section: 0), animated: false, scrollPosition: .none)
            default:
                
                dailyActivityLevelTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            }
        } else {
            
            
        }
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
        
        if (cell!.isSelected) {
            
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.setValue("veryLight", forKey: "dailyActivityLevel")
        case 1:
            
            UserDefaults.standard.setValue("light", forKey: "dailyActivityLevel")
        case 2:
            
            UserDefaults.standard.setValue("moderate", forKey: "dailyActivityLevel")
        case 3:
            
            UserDefaults.standard.setValue("heavy", forKey: "dailyActivityLevel")
        case 4:
            
            UserDefaults.standard.setValue("veryHeavy", forKey: "dailyActivityLevel")
        default:
            
            UserDefaults.standard.setValue("veryLight", forKey: "dailyActivityLevel")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
