//
//  WeightMeasurementTableView.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/29/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class WeightMeasurementTableView: UITableViewController {
    
    @IBOutlet var weightMeasurementTableView: UITableView!
    
    let weightMeasurementArray = ["Imperial", "Metric", "Stone"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let weightMeasure = UserDefaults.standard.value(forKey: "weightMeasure") as? String {
            switch weightMeasure {
            case "imperial":
                
                let index = IndexPath(row: 0, section: 0)
                weightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(weightMeasurementTableView, didSelectRowAt: index)
            case "metric":
                
                let index = IndexPath(row: 1, section: 0)
                weightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(weightMeasurementTableView, didSelectRowAt: index)
                
            case "stone":
                
                let index = IndexPath(row: 2, section: 0)
                weightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(weightMeasurementTableView, didSelectRowAt: index)
            default:
                
                let index = IndexPath(row: 0, section: 0)
                weightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(weightMeasurementTableView, didSelectRowAt: index)
            }
        } else {
            
            let index = IndexPath(row: 0, section: 0)
            weightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
            tableView(weightMeasurementTableView, didSelectRowAt: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weight Measurement"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightMeasurementArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightMeasurementCell")
        
        cell?.textLabel?.text = weightMeasurementArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.set("imperial", forKey: "weightMeasure")
        case 1:
            
            UserDefaults.standard.set("metric", forKey: "weightMeasure")
        case 2:
            
            UserDefaults.standard.set("stone", forKey: "weightMeasure")
        default:
            
            UserDefaults.standard.set("imperial", forKey: "weightMeasure")
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
