//
//  BirthDatePickerViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 9/29/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class BirthDatePickerViewController: UIViewController {
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        print(birthDatePicker.date)
        
        UserDefaults.standard.set(birthDatePicker.date, forKey: "birthDate")
    }
}
