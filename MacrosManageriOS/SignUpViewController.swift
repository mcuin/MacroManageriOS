//
//  SignUpViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 11/14/18.
//  Copyright © 2018 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpFirstNameTextField: UITextField!
    @IBOutlet weak var signUpLastNameTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpConfirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpConfirmButton: UIButton!
    
    var dailyActivity: String!
    var physicalActivityLifestyle: String!
    var pounds: Double!
    var kg: Double!
    var stone: Double!
    var dietFatPercent: Double!
    var goal: String!
    var calories: Int!
    var carbs: Int!
    var fat: Int!
    var protien: Int!
    var currentCalories: Double!
    var currentCarbs: Double!
    var currentFat: Double!
    var currentProtein: Double!
    var dailyMeals: [[String: Any]]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let dailyAcitivtyLevel = UserDefaults.standard.string(forKey: "dailyActivityLevel") {
            
            self.dailyActivity = dailyAcitivtyLevel
        } else {
            
            self.dailyActivity = "moderate"
        }
        
        if let physicalActivity = UserDefaults.standard.string(forKey: "physicalActivityLifestyle") {
            
            self.physicalActivityLifestyle = physicalActivity
        } else {
            
            self.physicalActivityLifestyle = "sedentary"
        }
        
        if let checkPounds = UserDefaults.standard.double(forKey: "pounds") as? Double {
            
            self.pounds = checkPounds
        } else {
            
            self.pounds = 0.0
        }
        
        if let checkKg = UserDefaults.standard.double(forKey: "kg") as? Double {
            
            self.kg = checkKg
        } else {
            
            self.kg = 0.0
        }
        
        if let checkStone = UserDefaults.standard.double(forKey: "stone") as? Double {
            
            self.stone = checkStone
        } else {
            
            self.stone = 0.0
        }
        
        if let dietFat = UserDefaults.standard.double(forKey: "prefferedFat") as? Double {
            
            self.dietFatPercent = dietFat
        } else {
            
            self.dietFatPercent = 0.0
        }
        
        if let goalCheck = UserDefaults.standard.string(forKey: "goal") {
            
            self.goal = goalCheck
        } else {
            
            self.goal = "maintain"
        }
        
        if let caloriesCheck = UserDefaults.standard.integer(forKey: "calories") as? Int {
            
            self.calories = caloriesCheck
        } else {
            
            self.calories = 0
        }
        
        if let carbsCheck = UserDefaults.standard.integer(forKey: "carbs") as? Int {
            
            self.carbs = carbsCheck
        } else {
            
            self.carbs = 0
        }
        
        if let fatCheck = UserDefaults.standard.integer(forKey: "fat") as? Int {
            
            self.fat = fatCheck
        } else {
            
            self.fat = 0
        }
        
        if let protienCheck = UserDefaults.standard.integer(forKey: "protein") as? Int {
            
            self.protien = protienCheck
        } else {
            
            self.protien = 0
        }
        
        if let currentCaloriesCheck = UserDefaults.standard.double(forKey: "currentCalories") as? Double {
            
            self.currentCalories = currentCaloriesCheck
        } else {
            
            self.currentCalories = 0.0
        }
        
        if let currentCarbsCheck = UserDefaults.standard.double(forKey: "currentCarbs") as? Double {
            
            self.currentCarbs = currentCarbsCheck
        } else {
            
            self.currentCarbs = 0.0
        }
        
        if let currentFatCheck = UserDefaults.standard.double(forKey: "currentFat") as? Double {
            
            self.currentFat = currentFatCheck
        } else {
            
            self.currentFat = 0.0
        }
        
        if let currentProteinCheck = UserDefaults.standard.double(forKey: "currentProtien") as? Double {
            
            self.currentProtein = currentProteinCheck
        } else {
            
            self.currentProtein = 0.0
        }
        
        if let dailyMealsCheck = UserDefaults.standard.array(forKey: "dailyMeals") as? [[String : Any]] {
            
            self.dailyMeals = dailyMealsCheck
        } else {
            self.dailyMeals = []
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        if signUpFirstNameTextField.text == "" {
            
            let firstNameAlert = UIAlertController(title: "First Name Error", message: "Please enter your first name.", preferredStyle: .alert)
            firstNameAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(firstNameAlert, animated: true, completion: nil)
            }
        } else if signUpLastNameTextField.text == "" {
            
            let lastNameAlert = UIAlertController(title: "Last Name Error", message: "Please enter your last name.", preferredStyle: .alert)
            lastNameAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(lastNameAlert, animated: true, completion: nil)
            }
        } else if signUpEmailTextField.text == "" || !self.isValidEmail(testStr: signUpEmailTextField.text!){
            
            let emailAlert = UIAlertController(title: "Email Error", message: "Please enter a valid email.", preferredStyle: .alert)
            emailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(emailAlert, animated: true, completion: nil)
            }
        } else if signUpPasswordTextField.text == "" {
            
            let passwordAlert = UIAlertController(title: "Password Error", message: "Please enter a password.", preferredStyle: .alert)
            passwordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(passwordAlert, animated: true, completion: nil)
            }
        } else if signUpConfirmPasswordTextField.text == "" {
            
            let confirmPasswordAlert = UIAlertController(title: "Confirm Password Error", message: "Please confirm you password.", preferredStyle: .alert)
            confirmPasswordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(confirmPasswordAlert, animated: true, completion: nil)
            }
        } else if signUpPasswordTextField.text != signUpConfirmPasswordTextField.text {
            
            let passwordMatchAlert = UIAlertController(title: "Password Error", message: "The entered passwords do not match.", preferredStyle: .alert)
            passwordMatchAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(passwordMatchAlert, animated: true, completion: nil)
            }
        } else if signUpPasswordTextField.text!.count < 6 || signUpConfirmPasswordTextField.text!.count < 6 {
            
            let passwordLengthAlert = UIAlertController(title: "Password Error", message: "The entered password is too short. Please enter 6 characters.", preferredStyle: .alert)
            passwordLengthAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                
                self.present(passwordLengthAlert, animated: true, completion: nil)
            }
        } else {
            
            Auth.auth().createUser(withEmail: signUpEmailTextField.text!, password: signUpConfirmPasswordTextField.text!, completion: { (authResult, error) in
                if error == nil {
                    guard let user = authResult?.uid else {return}
                    print("Uid \(user)")
                    
                    let db = Firestore.firestore()
                    let settings = db.settings
                    settings.areTimestampsInSnapshotsEnabled = true
                    db.settings = settings
                    
                    print(self.signUpFirstNameTextField.text!)
                    print(self.signUpLastNameTextField.text!)
                    print(self.signUpEmailTextField.text!)
                    print(UserDefaults.standard.string(forKey: "gender")!)
                    print(UserDefaults.standard.string(forKey: "weightMeasure")!)
                    print(UserDefaults.standard.string(forKey: "heightMeasure")!)
                    print(UserDefaults.standard.value(forKey: "birthDate")!)
                    print(UserDefaults.standard.integer(forKey: "feet"))
                    print(UserDefaults.standard.double(forKey: "inches"))
                    print(UserDefaults.standard.double(forKey: "cm"))
                    
                    let userReference = db.collection("users").document("\(user)")
                    userReference.setData(["firstName": self.signUpFirstNameTextField.text!, "lastName": self.signUpLastNameTextField.text!, "email": self.signUpEmailTextField.text!, "showAds": true, "gender": UserDefaults.standard.string(forKey: "gender")!, "weightMeasurement": UserDefaults.standard.string(forKey: "weightMeasure")!, "heightMeasurement": UserDefaults.standard.string(forKey: "heightMeasure")!, "birthDate": UserDefaults.standard.value(forKey: "birthDate")!, "feet": UserDefaults.standard.integer(forKey: "feet"), "inches": UserDefaults.standard.double(forKey: "inches"), "cm": UserDefaults.standard.double(forKey: "cm"), "dailyActivity": self.dailyActivity, "physicalActivityLifestyle": self.physicalActivityLifestyle, "goal": self.goal, "calories": self.calories, "carbs": self.carbs, "fat": self.fat, "protein": self.protien, "currentCalories": self.currentCalories, "currentCarbs": self.currentCarbs, "currentFat": self.currentFat, "currentProtein": self.currentProtein, "dietFatPercent": self.dietFatPercent, "dailyMeals": self.dailyMeals]) { err in
                        
                        if let error = err {
                            
                            print(error)
                        } else {
                            
                            print("Sign up success")
                        }
                    }
                    
                    
                } else {
                    
                    print(error)
                }
                
            })
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
