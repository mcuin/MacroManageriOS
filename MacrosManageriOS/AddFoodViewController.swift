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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        foodSaveButton.addTarget(self, action: #selector(saveFood(_sender:)), for: .touchUpInside)
    }
    
    @objc func saveFood(_sender: UIButton) {
        
        var foodName: String!
        var foodServing: Double!
        var foodCals: Double!
        var foodCarbs: Double!
        var foodFats: Double!
        var foodProtein: Double!
        var food: Dictionary<String, Any>!
        
        if foodNameTextField.text != "" {
            foodName = foodNameTextField.text!
        } else {
            let foodNameAlert = UIAlertController(title: "Unable to Add Food", message: "Please enter a name for your food.", preferredStyle: .alert)
            foodNameAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodNameAlert, animated: true, completion: nil)
            }
        }
        
        if foodServingSizeTextField.text != "" {
            foodServing = Double(foodServingSizeTextField.text!)
        } else {
            let foodServingAlert = UIAlertController(title: "Unable to Add Food", message: "Please enter a serving size for your food.", preferredStyle: .alert)
            foodServingAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodServingAlert, animated: true, completion: nil)
            }
        }
        
        if foodCaloriesTextField.text != "" {
            foodCals = Double(foodCaloriesTextField.text!)
        } else {
            let foodCalsAlert = UIAlertController(title: "Unable to Add Food", message: "Please enter the calories of your food.", preferredStyle: .alert)
            foodCalsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodCalsAlert, animated: true, completion: nil)
            }
        }
        
        if foodCarbsTextField.text != "" {
            foodCarbs = Double(foodCarbsTextField.text!)
        } else {
            let foodCarbsAlert = UIAlertController(title: "Unable to Add Food", message: "Please enter the carbohydrates of your food.", preferredStyle: .alert)
            foodCarbsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodCarbsAlert, animated: true, completion: nil)
            }
        }
        
        if foodFatsTextField.text != "" {
            foodFats = Double(foodFatsTextField.text!)
        } else {
            let foodFatsAlert = UIAlertController(title: "Unable to Add Food", message: "Please eneter the fats of your food.", preferredStyle: .alert)
            foodFatsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodFatsAlert, animated: true, completion: nil)
            }
        }
        
        if foodProteinTextField.text != "" {
            foodProtein = Double(foodProteinTextField.text!)
        } else {
            let foodProteinAlert = UIAlertController(title: "Unable to Add Food", message: "Please enter the protien of your food.", preferredStyle: .alert)
            foodProteinAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodProteinAlert, animated: true, completion: nil)
            }
        }
        
        
    }
}
