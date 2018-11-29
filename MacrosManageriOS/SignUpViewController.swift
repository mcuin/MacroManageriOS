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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
