//
//  SettingsViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/28/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//
import GoogleMobileAds
import Foundation
import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var birthdayDisplayLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var settingsBannerView: GADBannerView!
    @IBOutlet weak var settingsTableBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsTabbar: UITabBar!
    
    var feetTextField: UITextField!
    var feetTextView: UITextView!
    var inchesTextField: UITextField!
    var inchesTextView: UITextView!
    var cmTextField: UITextField!
    var cmTextView: UITextView!
    var showAds = false
    
    let settingsArray = ["Birthdate", "Gender", "Weight Measurement", "Height Measurement"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let heightMeasurement = UserDefaults.standard.value(forKey: "heightMeasure") as? String {
            
            switch heightMeasurement {
            case "imperial":
                
                feetTextField = UITextField(frame: CGRect(x: 20, y: Int(settingsTableView.frame.maxY) + 8, width: 50, height: 50))
                feetTextView = UITextView(frame: CGRect(x: feetTextField.frame.maxX + 8, y: settingsTableView.frame.maxY + 8, width: 50, height: 50))
                feetTextView.textAlignment = .center
                inchesTextField = UITextField(frame: CGRect(x: feetTextView.frame.maxX + 8, y: settingsTableView.frame.maxY + 8, width: 50, height: 50))
                inchesTextView = UITextView(frame: CGRect(x: inchesTextField.frame.maxX + 8, y: settingsTableView.frame.maxY + 8, width: 50, height: 50))
                inchesTextView.textAlignment = .center
                let saveButtonImperial = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 70, y: feetTextView.frame.maxY + 8, width: 50, height: 50))
                saveButtonImperial.setTitle("Save", for: .normal)
                saveButtonImperial.setTitleColor(.blue, for: .normal)
                saveButtonImperial.tag = 0
                saveButtonImperial.addTarget(self, action: #selector(SettingsViewController.saveSettingsAction(_:)), for: .touchUpInside)
                
                if let feet = UserDefaults.standard.value(forKey: "feet") {
                    
                    feetTextField.text = feet as? String
                    inchesTextField.text = UserDefaults.standard.value(forKey: "inches") as? String
                } else {
                    
                    feetTextField.placeholder = "Feet"
                    inchesTextField.placeholder = "Inches"
                }
                
                feetTextView.text = "ft"
                inchesTextView.text = "in"
                
                if (cmTextField != nil) {
                    if (cmTextField.isDescendant(of: self.view)) {
                        
                        cmTextField.removeFromSuperview()
                        cmTextView.removeFromSuperview()
                    }
                }
               
                self.view.addSubview(feetTextField)
                self.view.addSubview(feetTextView)
                self.view.addSubview(inchesTextField)
                self.view.addSubview(inchesTextView)
                self.view.addSubview(saveButtonImperial)
            case "metric":
                
                cmTextField = UITextField(frame: CGRect(x: 20, y: Int(settingsTableView.frame.maxY) + 8, width: 100, height: 50))
                cmTextView = UITextView(frame: CGRect(x: cmTextField.bounds.maxX + 8, y: settingsTableView.frame.maxY + 8, width: 50, height: 50))
                cmTextView.textAlignment = .center
                cmTextView.sizeToFit()
                let saveButtonMetric = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 70, y: cmTextView.bounds.maxY + 8, width: 50, height: 50))
                saveButtonMetric.tag = 1
                saveButtonMetric.addTarget(self, action: #selector(SettingsViewController.saveSettingsAction(_:)), for: .touchUpInside)
                
                if let cm = UserDefaults.standard.value(forKey: "cm") {
                    
                    cmTextField.text = cm as? String
                } else {
                    
                    cmTextField.placeholder = "Centimeter"
                }
                
                if (feetTextField != nil) {
                    if (feetTextField.isDescendant(of: self.view)) {
                        
                        feetTextField.removeFromSuperview()
                        feetTextView.removeFromSuperview()
                        inchesTextView.removeFromSuperview()
                        inchesTextField.removeFromSuperview()
                    }
                }
                
                cmTextView.text = "cm"
                self.view.addSubview(cmTextField)
                self.view.addSubview(cmTextView)
                self.view.addSubview(saveButtonMetric)
            default:
                
                break
            }
        }
        
        if (showAds) {
            let request = GADRequest()
            request.testDevices = ["kGADSimulatorID"]
            settingsBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            settingsBannerView.rootViewController = self
            settingsBannerView.load(request)
        } else {
            
            /*self.view.removeConstraint(settingsTableBottomConstraint)
            settingsTableBottomConstraint = NSLayoutConstraint(item: settingsTableView, attribute: .bottom, relatedBy: .equal, toItem: settingsTabbar, attribute: .top, multiplier: 1.0, constant: 0)
            self.view.addConstraint(settingsTableBottomConstraint)*/
        }
        
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
            self.performSegue(withIdentifier: "goto_birthDateMeasure", sender: self)
        case 1:
            self.performSegue(withIdentifier: "goto_genderMeasure", sender: self)
        case 2:
            self.performSegue(withIdentifier: "goto_weightMeasure", sender: self)
        case 3:
            self.performSegue(withIdentifier: "goto_heightMeasure", sender: self)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Measurements"
    }
    
    @objc func saveSettingsAction(_ button: UIButton) {
        
        print(UserDefaults.standard.value(forKey: "birthDate"))
        print(UserDefaults.standard.value(forKey: "gender"))
        print(UserDefaults.standard.value(forKey: "heightMeasure"))
        print(UserDefaults.standard.value(forKey: "weightMeasure"))
        print(UserDefaults.standard.value(forKey: "feet"))
        print(UserDefaults.standard.value(forKey: "inches"))
        print(UserDefaults.standard.value(forKey: "cm"))
        
        switch button.tag {
        case 0:
            
            if (feetTextField.text == "" || inchesTextField.text == "" || UserDefaults.standard.value(forKey: "gender") == nil || UserDefaults.standard.value(forKey: "weightMeasure") == nil || UserDefaults.standard.value(forKey: "heightMeasure") == nil) {
                
                let settingsAlert = UIAlertController(title: "Complete Settings", message: "Please complete all settings.", preferredStyle: .alert)
                
                settingsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                    
                    settingsAlert.dismiss(animated: true, completion: nil)
                }))
                
                    DispatchQueue.main.async {
                        
                        self.present(settingsAlert, animated: true, completion: nil)
                }
            } else {
                
                UserDefaults.standard.set(Int(feetTextField.text!), forKey: "feet")
                UserDefaults.standard.set(Double(inchesTextField.text!), forKey: "inches")
                let cm: Double = (UserDefaults.standard.value(forKey: "feet") as! Double * 30.48) + (UserDefaults.standard.value(forKey: "inches") as! Double * 2.54)
                UserDefaults.standard.set(cm, forKey: "cm")
                self.navigationController?.popViewController(animated: true)
                
            }
        case 1:
            
            if (cmTextView.text == "" || UserDefaults.standard.value(forKey: "gender") == nil || UserDefaults.standard.value(forKey: "weightMeasure") == nil || UserDefaults.standard.value(forKey: "heightMeasure") == nil) {
                
                let settingsAlert = UIAlertController(title: "Complete Settings", message: "Please complete all settings.", preferredStyle: .alert)
                
                settingsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                    
                    settingsAlert.dismiss(animated: true, completion: nil)
                }))
                
                DispatchQueue.main.async {
                    
                    self.present(settingsAlert, animated: true, completion: nil)
                }
            } else {
                
                UserDefaults.standard.set(Double(cmTextField.text!), forKey: "cm")
                let feetConversion = UserDefaults.standard.value(forKey: "cm") as! Double / 30.48
                let feetRemainder = feetConversion.truncatingRemainder(dividingBy: 1)
                let feet = feetConversion - feetRemainder
                let inches = Double(cmTextField.text!)! / 2.54 - (feet * 12) + feetRemainder
                
                UserDefaults.standard.set(feet, forKey: "feet")
                UserDefaults.standard.set(inches, forKey: "inches")
                self.navigationController?.popViewController(animated: true)
            }
        default:
            
            break
        }
        
        self.performSegue(withIdentifier: "goto_signUp", sender: self)
    }
}
