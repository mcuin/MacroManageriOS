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
        
        if let name = foodName, let serving = foodServing, let cals = foodCals, let carbs = foodCarbs, let fats = foodFats, let protein = foodProtein {
            food = ["foodName": name, "foodServings": serving, "foodCalories": cals, "foodCarbs": carbs, "foodFats": fats, "foodProtein": protein]
            if var dailyFoods = UserDefaults.standard.value(forKey: "dailyFoods") as? Array<Dictionary<String, Any>> {
                dailyFoods.append(food)
                
                UserDefaults.standard.set(dailyFoods, forKey: "dailyFoods")
            } else {
                let dailyFoods = [food]
                
                UserDefaults.standard.set(dailyFoods, forKey: "dailyFoods")
            }
            
            if var dailyCurrentCals = UserDefaults.standard.value(forKey: "dailyCurrentCals") as? Double {
                dailyCurrentCals = (cals * serving) + Double(dailyCurrentCals)
                UserDefaults.standard.set(dailyCurrentCals, forKey: "dailyCurrentCals")
            } else {
                UserDefaults.standard.set((cals * serving), forKey: "dailyCurrentCals")
            }
            
            if var dailyCurrentCarbs = UserDefaults.standard.value(forKey: "dailyCurrentCarbs") as? Double {
                dailyCurrentCarbs = (carbs * serving) + dailyCurrentCarbs
                UserDefaults.standard.set(dailyCurrentCarbs, forKey: "dailyCurrentCarbs")
            } else {
                UserDefaults.standard.set((carbs * serving), forKey: "dailyCurrentCarbs")
            }
            
            if var dailyCurrentFats = UserDefaults.standard.value(forKey: "dailyCurrentFats") as? Double {
                dailyCurrentFats = (fats * serving) + dailyCurrentFats
                UserDefaults.standard.set(dailyCurrentFats, forKey: "dailyCurrentFats")
            } else {
                UserDefaults.standard.set((fats * serving), forKey: "dailyCurrentFats")
            }
            
            if var dailyCurrentProtein = UserDefaults.standard.value(forKey: "dailyCurrentProtein") as? Double {
                dailyCurrentProtein = (protein * serving) + dailyCurrentProtein
                UserDefaults.standard.set(dailyCurrentProtein, forKey: "dailyCurrentProtein")
            } else {
                UserDefaults.standard.set((protein * serving), forKey: "dailyCurrentProtein")
            }
            
        } else {
            
            let foodSaveAlert = UIAlertController(title: "Unable to Add Food", message: "There was an issue adding your food. Please try again.", preferredStyle: .alert)
            foodSaveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                self.present(foodSaveAlert, animated: true, completion: nil)
            }
        }
    }
}
