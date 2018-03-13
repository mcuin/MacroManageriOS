//
//  AddFoodViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 3/13/18.
//  Copyright © 2018 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class AddFoodViewController: UIViewController {
    
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodServingSizeTextField: UITextField!
    @IBOutlet weak var foodCaloriesTextField: UITextField!
    @IBOutlet weak var foodCarbsTextField: UITextField!
    @IBOutlet weak var foodFatsTextField: UITextField!
    @IBOutlet weak var foodProteinTextField: UITextField!
    @IBOutlet weak var foodSaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
