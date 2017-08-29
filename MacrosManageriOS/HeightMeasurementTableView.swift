//
//  HeightMeasurementTableView.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/29/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class HeightMeasurementTableView: UITableViewController {
    
    @IBOutlet var heightMeasurementTableView: UITableView!
    
    let heightMeasurementArray = ["Imperial", "Metric"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let heightMeasurement = UserDefaults.standard.value(forKey: "heightMeasurement") as? String {
            
            switch heightMeasurement {
            case "imperial":
                
                let index = IndexPath(row: 0, section: 0)
                heightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(heightMeasurementTableView, didSelectRowAt: index)
            case "metric":
                
                let index = IndexPath(row: 1, section: 0)
                heightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(heightMeasurementTableView, didSelectRowAt: index)
            default:
                
                let index = IndexPath(row: 0, section: 0)
                heightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
                tableView(heightMeasurementTableView, didSelectRowAt: index)
            }
        } else {
            
            let index = IndexPath(row: 0, section: 0)
            heightMeasurementTableView.selectRow(at: index, animated: true, scrollPosition: .none)
            tableView(heightMeasurementTableView, didSelectRowAt: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heightMeasurementArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "heightMeasurementCell")
        
        cell?.textLabel?.text = heightMeasurementArray[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            UserDefaults.standard.set("imperial", forKey: "heightMeasurement")
        case 1:
            UserDefaults.standard.set("metric", forKey: "heightMeasurement")
        default:
            UserDefaults.standard.set("imperial", forKey: "heightMeasurement")
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
