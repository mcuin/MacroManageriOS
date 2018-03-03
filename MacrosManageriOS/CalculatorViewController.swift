//
//  CalculatorViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 9/29/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calculatorScrollView: UIScrollView!
    @IBOutlet weak var navTabBar: UITabBar!
    
    var previousView: UIView!
    var weightTextView: UITextView!
    var poundsTextField: UITextField!
    var poundsTextView: UITextView!
    var kilogramsTextField: UITextField!
    var kilogramsTextView: UITextView!
    var stoneTextField: UITextField!
    var stoneTextView: UITextView!
    var weightMeasure = ""
    let prefferedFatTextField = UITextField()
    let caloriesTextView = UITextView()
    let carbsTextView = UITextView()
    let fatsTextView = UITextView()
    let proteinTextView = UITextView()
    
    let actvityFactrosArray = ["Daily Activity Level", "Physical Activity Lifestyle", "Fitness Goal"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let birthDate = UserDefaults.standard.value(forKey: "birthDate"), let gender = UserDefaults.standard.value(forKey: "gender"), let weightMeasure = UserDefaults.standard.value(forKey: "weightMeasure"), let feet = UserDefaults.standard.value(forKey: "feet"), let inches = UserDefaults.standard.value(forKey: "inches"), let cm = UserDefaults.standard.value(forKey: "cm") {
            
            self.weightMeasure = weightMeasure as! String
            weightTextView = UITextView(frame: CGRect(x: 16, y: 16, width: 75, height: 25))
            weightTextView.text = "Weight"
            weightTextView.textColor = .black
            calculatorScrollView.addSubview(weightTextView)
            
            switch(weightMeasure as! String) {
                
            case "imperial":
                
                poundsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.frame.maxY + 16, width: 1, height: 1))
                poundsTextField.placeholder = "Pounds"
                poundsTextField.sizeToFit()
                previousView = poundsTextField
                calculatorScrollView.addSubview(poundsTextField)
                if let pounds = UserDefaults.standard.value(forKey: "pounds") {
                    poundsTextField.text! = "\(pounds)"
                }
            case "metric":
                
                kilogramsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.frame.maxY + 16, width: 1, height: 1))
                kilogramsTextField.placeholder = "Kilograms"
                kilogramsTextField.sizeToFit()
                calculatorScrollView.addSubview(kilogramsTextField)
                previousView = kilogramsTextField
                if let kilograms = UserDefaults.standard.value(forKey: "kilograms") {
                    kilogramsTextField.text! = "\(kilograms)"
                }
            case "stone":
                
                stoneTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.frame.maxY + 16, width: 1, height: 1))
                stoneTextField.placeholder = "Stones"
                stoneTextField.sizeToFit()
                calculatorScrollView.addSubview(stoneTextField)
                previousView = stoneTextField
                if let stone = UserDefaults.standard.value(forKey: "stone") {
                    stoneTextField.text! = "\(stone)"
                }
            default:
                
                poundsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.frame.maxY + 16, width: 1, height: 1))
                poundsTextField.placeholder = "Pounds"
                poundsTextField.sizeToFit()
                calculatorScrollView.addSubview(poundsTextField)
                previousView = poundsTextField
                if let pounds = UserDefaults.standard.value(forKey: "pounds") {
                    poundsTextField.text! = "\(pounds)"
                }
            }
            
            let actvityFactorsTableView = UITableView()
            actvityFactorsTableView.isScrollEnabled = false
            actvityFactorsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "activityFactorCell")
            actvityFactorsTableView.delegate = self
            actvityFactorsTableView.dataSource = self
            
            actvityFactorsTableView.frame = CGRect(x: 0, y: self.previousView.frame.maxY + 16, width: UIScreen.main.bounds.width, height: 135)
            calculatorScrollView.addSubview(actvityFactorsTableView)
            
            let prefferedFatTextView = UITextView()
            prefferedFatTextView.text = "Preffered Percent of Fat in Diet"
            prefferedFatTextView.sizeToFit()
            prefferedFatTextView.frame = CGRect(x: 16, y: actvityFactorsTableView.frame.maxY + 16, width: prefferedFatTextView.contentSize.width, height: prefferedFatTextView.contentSize.height)
            
            calculatorScrollView.addSubview(prefferedFatTextView)
            
            prefferedFatTextField.placeholder = "Percent"
            prefferedFatTextField.keyboardType = .decimalPad
            prefferedFatTextField.frame = CGRect(x: 16, y: prefferedFatTextView.frame.maxY + 4, width: 75, height: 50)
            if let prefferedFat = UserDefaults.standard.value(forKey: "prefferedFat") {
                prefferedFatTextField.text = prefferedFat as? String
            }
            
            calculatorScrollView.addSubview(prefferedFatTextField)
            
            let calculateButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 91, y: prefferedFatTextField.frame.maxY + 16, width: 1, height: 1))
            calculateButton.setTitle("Calculate", for: .normal)
            calculateButton.setTitleColor(.blue, for: .normal)
            calculateButton.sizeToFit()
            calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
            //calculateButton.frame =
            
            calculatorScrollView.addSubview(calculateButton)
            
            caloriesTextView.frame = CGRect(x: 16, y: prefferedFatTextField.frame.maxY + 16, width: (UIScreen.main.bounds.width - calculateButton.bounds.width) / 3, height: 50)
            calculatorScrollView.addSubview(caloriesTextView)
            carbsTextView.frame = CGRect(x: caloriesTextView.frame.maxX + 8, y: prefferedFatTextField.frame.maxY + 16, width: (UIScreen.main.bounds.width - calculateButton.bounds.width) / 3, height: 50)
            calculatorScrollView.addSubview(carbsTextView)
            fatsTextView.frame = CGRect(x: 16, y: caloriesTextView.frame.maxY + 16, width: (UIScreen.main.bounds.width - calculateButton.bounds.width) / 3, height: 50)
            calculatorScrollView.addSubview(fatsTextView)
            proteinTextView.frame = CGRect(x: fatsTextView.frame.maxX + 8, y: caloriesTextView.frame.maxY + 16, width: (UIScreen.main.bounds.width - calculateButton.bounds.width) / 3, height: 50)
            calculatorScrollView.addSubview(proteinTextView)
            
            if let calcedCalories = UserDefaults.standard.value(forKey: "calories"), let calcedCarbs = UserDefaults.standard.value(forKey: "carbs"), let calcedFats = UserDefaults.standard.value(forKey: "fat"), let calcedProtein = UserDefaults.standard.value(forKey: "protein"){
                
                caloriesTextView.text! = "Calories: \(calcedCalories)"
                carbsTextView.text! = "Carbs: \(calcedCarbs)g"
                fatsTextView.text! = "Fats: \(calcedFats)g"
                proteinTextView.text! = "Protein: \(calcedProtein)g"
            } else {
                caloriesTextView.text = "Calories: 0"
                carbsTextView.text = "Carbs: 0g"
                fatsTextView.text = "Fats: 0g"
                proteinTextView.text = "Protein: 0g"
            }
        } else {
            
            let calculatorAlertController = UIAlertController(title: "Missing Data", message: "Please fill out your data in the settings screen.", preferredStyle: .alert)
            
            let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default, handler: { (action) in
                
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "goto_settings", sender: self)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
                
                calculatorAlertController.dismiss(animated: true, completion: nil)
                if let navController = self.navigationController {
                    
                    navController.popViewController(animated: true)
                }
            })
            
            calculatorAlertController.addAction(goToSettingsAction)
            calculatorAlertController.addAction(cancelAction)
            
            DispatchQueue.main.async {
                
                self.present(calculatorAlertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return actvityFactrosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityFactorCell")
        cell?.textLabel?.text = actvityFactrosArray[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch indexPath.row {
        case 0:
            
            performSegue(withIdentifier: "goto_dailyActivityLevel", sender: self)
        case 1:
            
            performSegue(withIdentifier: "goto_physicalActivityLevel", sender: self)
            
        case 2:
            
            performSegue(withIdentifier: "goto_goal", sender: self)
        default:
            
            break
        }
    }
    
    @objc func calculate() {
        
        if prefferedFatTextField.text != nil {
            
            UserDefaults.standard.set(prefferedFatTextField.text, forKey: "prefferedFat")
            var bmr: Double!
            var tdee: Double!
            var calories: Double!
            var protein: Double!
            var proteinCalories: Double!
            var fat: Double!
            var fatCalories: Double!
            var carbs: Double!
            var carbsCalories: Double!
            let calendar = NSCalendar.current
            let currentDate = NSDate()
            let birthDate = UserDefaults.standard.value(forKey: "birthDate") as! NSDate
            let components = Calendar.current.dateComponents([.year], from: birthDate as Date, to: Date())
            let age = components.year
            
            switch weightMeasure {
            case "imperial":
                
                let pounds = Double(poundsTextField.text!)
                let kg = pounds! * 0.454
                let stone = (pounds! / 14)
                
                UserDefaults.standard.set(pounds, forKey: "pounds")
                UserDefaults.standard.set(kg, forKey: "kilograms")
                UserDefaults.standard.set(stone, forKey: "stone")
                
            case "metric":
                
                let kg = Double(kilogramsTextField.text!)
                let pounds = kg! / 0.454
                let stone = kg! * 0.157
                
                UserDefaults.standard.set(kg, forKey: "kilograms")
                UserDefaults.standard.set(pounds, forKey: "pounds")
                UserDefaults.standard.set(stone, forKey: "stone")
                
            case "stone":
                
                let stone = Double(stoneTextField.text!)
                let pounds = stone! * 14
                let kg = stone! * 6.35
                
                UserDefaults.standard.set(stone, forKey: "stone")
                UserDefaults.standard.set(pounds, forKey: "kilograms")
                UserDefaults.standard.set(kg, forKey: "kilograms")
            default:
                
                let weightMeasureAlert = UIAlertController(title: "Weight Error", message: "There's was an error with your weight entry. Please try again.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (void) in
                    weightMeasureAlert.dismiss(animated: true, completion: nil)
                })
                
                weightMeasureAlert.addAction(okAction)
                
                self.present(weightMeasureAlert, animated: true, completion: nil)
            }
            
            if let kg = UserDefaults.standard.value(forKey: "kilograms") as? Double, let cm = UserDefaults.standard.value(forKey: "cm") as? Double {
                
                if let gender = UserDefaults.standard.value(forKey: "gender") {
                    
                    switch(gender as! String) {
                        
                    case "male":
                        
                        let weightCalc = (10 * kg)
                        let heightCalc = (6.25 * cm)
                        let ageCalc = Double(5 * age!)
                        bmr = weightCalc + heightCalc - ageCalc + 5
                        
                    case "female":
                        
                        let weightCalc = (10 * kg)
                        let heightCalc = (6.25 * cm)
                        let ageCalc = Double(5 * age!)
                        bmr = weightCalc + heightCalc - ageCalc - 161
                        print(bmr)
                    default:
                        break
                    }
                }
                
                if bmr != nil {
                    
                    if let dailyActivity = UserDefaults.standard.value(forKey: "dailyActivityLevel") as? String {
                        
                        switch(dailyActivity) {
                            
                        case "veryLight":
                            
                            tdee = bmr * 1.20
                        case "light":
                            
                            tdee = bmr * 1.45
                        case "moderate":
                            
                            tdee = bmr * 1.55
                        case "heavy":
                            
                            tdee = bmr * 1.75
                        case "veryHeavy":
                            
                            tdee = bmr * 2.00
                        default:
                            
                            tdee = bmr * 1.20
                        }
                    }
                    
                    print(tdee)
                }
                
                if tdee != nil {
                    
                    if let goal = UserDefaults.standard.value(forKey: "goal") as? String {
                        
                        switch(goal) {
                            
                        case "maintain":
                            
                            calories = tdee
                        case "burnFatSuggested":
                            
                            calories = tdee - (tdee * 0.15)
                        case "burnFatAggressive":
                            
                            calories = tdee - (tdee * 0.20)
                            
                        case "burnFatReckless":
                            
                            calories = tdee - (tdee * 0.25)
                        case "buildMuscleSuggested":
                            
                            calories = tdee + (tdee * 0.05)
                        case "buildMuscleAggressive":
                            
                            calories = tdee + (tdee * 0.10)
                        case "buildMuscleReckless":
                            
                            calories = tdee + (tdee * 0.15)
                        default:
                            
                            calories = tdee
                        }
                    }
                    
                    print(calories)
                    UserDefaults.standard.set(round(calories), forKey: "calories")
                }
                
                if calories != nil {
                    
                    if let physicalActivityLifestyle = UserDefaults.standard.value(forKey: "physicalAcitvityLifestyle") as? String {
                        
                        switch physicalActivityLifestyle {
                            
                        case "sedentaryAdult":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.4
                        case "adultRecreationalExerciser":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.75
                        case "adultCompetitiveAthlete":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.9
                        case "adultBuildingMuscle":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.9
                        case "dietingAthlete":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.9
                        case "teenageGrowingAthlete":
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 1.0
                        default:
                            
                            protein = (UserDefaults.standard.value(forKey: "pounds") as! Double) * 0.4
                        }
                        
                        UserDefaults.standard.set(round(protein), forKey: "protein")
                    }
                    
                    if protein != nil {
                        
                        proteinCalories = protein * 4
                        print(prefferedFatTextField.text)
                        UserDefaults.standard.set(prefferedFatTextField.text!, forKey: "prefferedFat")
                        fatCalories = calories * (Double(prefferedFatTextField.text!)! / 100)
                        fat = fatCalories / 9
                        UserDefaults.standard.set(round(fat), forKey: "fat")
                        carbsCalories = calories - (proteinCalories + fatCalories)
                        carbs = carbsCalories / 4
                        UserDefaults.standard.set(round(carbs), forKey: "carbs")
                        print(calories, protein, fat, carbs)
                        
                        caloriesTextView.text! = "Calories: \(UserDefaults.standard.value(forKey: "calories")!)"
                        carbsTextView.text! = "Carbs: \(UserDefaults.standard.value(forKey: "carbs")!)g"
                        fatsTextView.text! = "Fats: \(UserDefaults.standard.value(forKey: "fat")!)g"
                        proteinTextView.text! = "Protein: \(UserDefaults.standard.value(forKey: "protein")!)g"
                    }
                }
            }
        }
    }
}
