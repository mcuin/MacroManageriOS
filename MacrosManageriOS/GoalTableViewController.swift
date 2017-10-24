//
//  GoalTableViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 10/17/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class GoalTableViewController: UITableViewController {
    
    let goalsArray = ["Burn Fat Suggested (-15%)", "Burn Fat Aggressive (-20%)", "Burn Fat Reckless (-25%)", "Maintain (+/-0%)", "Build Muscle Suggested (+5%)", "Build Muscle Aggressive (+10%)", "Build Muscle Reckless (+15%)"]
    
    @IBOutlet var goalTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goalsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell")
        
        cell?.textLabel?.text = goalsArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.set("burnFatSuggested", forKey: "goal")
        case 1:
            
            UserDefaults.standard.set("burnFatAggressive", forKey: "goal")
        case 2:
            
            UserDefaults.standard.set("burnFatReckless", forKey: "goal")
        case 3:
            
            UserDefaults.standard.set("maintain", forKey: "goal")
        case 4:
            
            UserDefaults.standard.set("buildMuscleSuggested", forKey: "goal")
        case 5:
            
            UserDefaults.standard.set("buildMuscleAggressive", forKey: "goal")
        case 6:
            
            UserDefaults.standard.set("buildMuscleReckless", forKey: "goal")
        default:
            
            UserDefaults.standard.set("maintain", forKey: "goal")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
