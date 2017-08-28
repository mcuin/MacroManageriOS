//
//  SettingsViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/28/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var birthdayDisplayLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    let settingsArray = ["Gender", "Weight Measurement", "Height Measurement"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsCell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell")
        
        settingsCell?.textLabel?.text = settingsArray[indexPath.row]
        
        return settingsCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "goto_genderMeasure", sender: self)
        case 1:
            self.performSegue(withIdentifier: "goto_weightMeasure", sender: self)
        case 2:
            self.performSegue(withIdentifier: "goto_heightMeasure", sender: self)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Measurements"
    }
}
