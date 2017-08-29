//
//  GenderTableViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/29/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class GenderTableViewController: UITableViewController {
    
    @IBOutlet var genderTableView: UITableView!
    
    var genders = ["Female", "Male"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        switch UserDefaults.standard.value(forKey: "gender") as! String {
        case "female":
            
            let index = IndexPath(row: 0, section: 0)
            genderTableView.selectRow(at: index, animated: true, scrollPosition: .none)
            tableView(genderTableView, didSelectRowAt: index)
        case "male":
            
            let index = IndexPath(row: 1, section: 0)
            genderTableView.selectRow(at: index, animated: true, scrollPosition: .none)
            tableView(genderTableView, didSelectRowAt: index)
        default:
            
            let index = IndexPath(row: 0, section: 0)
            genderTableView.selectRow(at: index, animated: true, scrollPosition: .none)
            tableView(genderTableView, didSelectRowAt: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Gender"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "genderCell")
        
        cell?.textLabel?.text = genders[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            UserDefaults.standard.set("female", forKey: "gender")
        case 1:
            UserDefaults.standard.set("male", forKey: "gender")
        default:
            break
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
