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
        
        return 0
    }
}
