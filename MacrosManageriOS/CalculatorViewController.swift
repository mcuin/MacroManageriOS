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
    
    let actvityFactrosArray = ["Daily Activity Level", "Physical Activity Lifestyle", "Fitness Goal"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let birthDate = UserDefaults.standard.value(forKey: "birthDate"), let gender = UserDefaults.standard.value(forKey: "gender"), let weightMeasure = UserDefaults.standard.value(forKey: "weightMeasure"), let feet = UserDefaults.standard.value(forKey: "feet"), let inches = UserDefaults.standard.value(forKey: "inches"), let cm = UserDefaults.standard.value(forKey: "cm") {
            
            weightTextView = UITextView(frame: CGRect(x: 16, y: 16, width: 75, height: 25))
            weightTextView.text = "Weight"
            weightTextView.textColor = .black
            calculatorScrollView.addSubview(weightTextView)
            
            switch(weightMeasure as! String) {
                
            case "imperial":
            
                poundsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.bounds.height + 16, width: 1, height: 1))
                poundsTextField.placeholder = "Pounds"
                poundsTextField.sizeToFit()
                previousView = poundsTextField
                calculatorScrollView.addSubview(poundsTextField)
            case "metric":
                
                kilogramsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.bounds.height + 16, width: 1, height: 1))
                kilogramsTextField.placeholder = "Kilograms"
                kilogramsTextField.sizeToFit()
                calculatorScrollView.addSubview(kilogramsTextField)
                previousView = kilogramsTextField
            case "stone":
                
                stoneTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.bounds.height + 16, width: 1, height: 1))
                stoneTextField.placeholder = "Stones"
                stoneTextField.sizeToFit()
                calculatorScrollView.addSubview(stoneTextField)
                previousView = stoneTextField
            default:
                
                poundsTextField = UITextField(frame: CGRect(x: 16, y: weightTextView.bounds.height + 16, width: 1, height: 1))
                poundsTextField.placeholder = "Pounds"
                poundsTextField.sizeToFit()
                calculatorScrollView.addSubview(poundsTextField)
                previousView = poundsTextField
            }
            
            print(previousView.bounds.height)
            
            let actvityFactorsTableView = UITableView()
            actvityFactorsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "activityFactorCell")
            actvityFactorsTableView.delegate = self
            actvityFactorsTableView.dataSource = self
            
            actvityFactorsTableView.frame = CGRect(x: 0, y: self.previousView.bounds.height, width: UIScreen.main.bounds.width, height: 200)
            calculatorScrollView.addSubview(actvityFactorsTableView)
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
}
