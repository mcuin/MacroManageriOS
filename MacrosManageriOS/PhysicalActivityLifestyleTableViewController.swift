//
//  PhysicalActivityLifestyleTableViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 10/17/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class PhysicalActivityLifestyleTableViewController: UITableViewController {
    
    let physicalActivityLifestyleArray = ["Sedentary Adult", "Adult Recreational Exerciser", "Adult Competitive Athlete", "Adult Building Muscle", "Dieting Athlete", "Teenage Growing Athelete"]
    
    @IBOutlet var physicalActivityLifestyleTableView: UITableView!
    
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
        
        return physicalActivityLifestyleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "physicalActivityLiftstyleCell")
        
        cell?.textLabel?.text = physicalActivityLifestyleArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.set("sedentaryAdult", forKey: "physicalAcitvityLifestyle")
        case 1:
            
            UserDefaults.standard.set("adultRecreationalExerciser", forKey: "physicalAcitvityLifestyle")

        case 2:
            
            UserDefaults.standard.set("adultCompetitiveAthlete", forKey: "physicalAcitvityLifestyle")

        case 3:
            
            UserDefaults.standard.set("adultBuildingMuscle", forKey: "physicalAcitvityLifestyle")
        case 4:
            
            UserDefaults.standard.set("dietingAthlete", forKey: "physicalAcitvityLifestyle")
        case 5:
            
            UserDefaults.standard.set("teenageGrowingAthlete", forKey: "physicalAcitvityLifestyle")
        default:
            
            UserDefaults.standard.set("sedentary", forKey: "physicalAcitvityLifestyle")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
