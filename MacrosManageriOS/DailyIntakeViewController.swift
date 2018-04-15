//
//  ViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/26/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import UIKit

import GoogleMobileAds

class DailyIntakeViewController: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dailyIntakeCollectionView: UICollectionView!
    @IBOutlet weak var dailyFoodTableView: UITableView!
    @IBOutlet weak var dailyIntakeTabBar: UITabBar!
    @IBOutlet weak var dailyIntakeAdBannerView: GADBannerView!
    @IBOutlet weak var dailyIntakeTableViewBottomConstraint: NSLayoutConstraint!
    
    let macros = ["Calories", "Carbohydrates", "Fats", "Protein"]
    var adsActive = false
    var goalCalories: String!
    var goalCarbs: String!
    var goalFats: String!
    var goalProtein: String!
    var dailyCalories: String!
    var dailyCarbs: String!
    var dailyFats: String!
    var dailyProtein: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearCurrentDaily), name: .NSCalendarDayChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if (adsActive) {
            let request = GADRequest()
            request.testDevices = ["kGADSimulatorID"]
            dailyIntakeAdBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            dailyIntakeAdBannerView.rootViewController = self
            dailyIntakeAdBannerView.load(request)
        } else {
            
            self.view.removeConstraint(dailyIntakeTableViewBottomConstraint)
            let tableBottomConstraint = NSLayoutConstraint(item: dailyFoodTableView, attribute: .bottom, relatedBy: .equal, toItem: dailyIntakeTabBar, attribute: .top, multiplier: 1.0, constant: 0)
            self.view.addConstraint(tableBottomConstraint)
        }
        
        dailyIntakeTabBar.delegate = self
        dailyIntakeCollectionView.delegate = self
        dailyIntakeCollectionView.dataSource = self
        dailyFoodTableView.delegate = self
        dailyFoodTableView.dataSource = self
        
        if let calories = UserDefaults.standard.value(forKey: "calories") {
            goalCalories = "\(calories)"
        } else {
            goalCalories = "0"
        }
        
        if let carbs = UserDefaults.standard.value(forKey: "carbs") {
            goalCarbs = "\(carbs)g"
        } else {
            goalCarbs = "0g"
        }
        
        if let fats = UserDefaults.standard.value(forKey: "fat") {
            goalFats = "\(fats)g"
        } else {
            goalFats = "0g"
        }
        
        if let protein = UserDefaults.standard.value(forKey: "protein") {
            goalProtein = "\(protein)g"
        } else {
            goalProtein = "0g"
        }
        
        if let currentDailyCals = UserDefaults.standard.value(forKey: "dailyCurrentCals") {
            dailyCalories = "\(currentDailyCals)"
        } else {
            dailyCalories = "0"
        }
        
        if let currentDailyCarbs = UserDefaults.standard.value(forKey: "dailyCurrentCarbs") {
            dailyCarbs = "\(currentDailyCarbs)g"
        } else {
            dailyCarbs = "0g"
        }
        
        if let currentDailyFats = UserDefaults.standard.value(forKey: "dailyCurrentFats") {
            dailyFats = "\(currentDailyFats)g"
        } else {
            dailyFats = "0g"
        }
        
        if let currentDailyProtein = UserDefaults.standard.value(forKey: "dailyCurrentProtein") {
            dailyProtein = "\(currentDailyProtein)g"
        } else {
            dailyProtein = "0g"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return macros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyIntakeCollectionCell", for: indexPath) as! DailyIntakeCollectionCell
        cell.dailyIntakeCellTitle.text = macros[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.dailyIntakeGoal.text = goalCalories
            cell.dailyIntakeCurrent.text = dailyCalories
        case 1:
            cell.dailyIntakeGoal.text = goalCarbs
            cell.dailyIntakeCurrent.text = dailyCarbs
        case 2:
            cell.dailyIntakeGoal.text = goalFats
            cell.dailyIntakeCurrent.text = dailyFats
        case 3:
            cell.dailyIntakeGoal.text = goalProtein
            cell.dailyIntakeCurrent.text = dailyProtein
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int!
        if let foods = UserDefaults.standard.value(forKey: "dailyFoods") as? Array<Any> {
            count = foods.count
        } else {
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyFoodTableCell") as! DailyFoodTableViewCell
        if let foods = UserDefaults.standard.value(forKey: "dailyFoods") as? Array<Dictionary<String, Any>> {
            
            cell.foodNameLabel.text! = (foods[indexPath.row])["foodName"]! as! String
            cell.foodCaloriesLabel.text! = "Calories \((foods[indexPath.row])["foodCalories"] as! NSNumber)"
            cell.foodServingLabel.text! = "Servings \((foods[indexPath.row])["foodServings"] as! NSNumber)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goto_editFood", sender: self)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch item {
            
        case (tabBar.items![1]):
            
            self.performSegue(withIdentifier: "goto_calculator", sender: self)
        case (tabBar.items![2]):
            
            self.performSegue(withIdentifier: "goto_settings", sender: self)
        default:
            
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goto_addFood") {
            let destinationViewController = segue.destination as? AddFoodViewController
            destinationViewController?.foodTableView = self.dailyFoodTableView
            destinationViewController?.macrosCollectionView = self.dailyIntakeCollectionView
        }
        if (segue.identifier == "goto_editFood") {
            let destinationViewController = segue.destination as? AddFoodViewController
            destinationViewController?.editFoodIndex = self.dailyFoodTableView.indexPathForSelectedRow?.row
            destinationViewController?.foodTableView = self.dailyFoodTableView
            destinationViewController?.macrosCollectionView = self.dailyIntakeCollectionView
        }
    }
    
    @objc func clearCurrentDaily(_ notification: Notification) {
        if var dailyCurrentCals = UserDefaults.standard.value(forKey: "dailyCurrentCals") as? Double {
            dailyCurrentCals = 0
            UserDefaults.standard.set(dailyCurrentCals, forKey: "dailyCurrentCals")
        }
        
        if var dailyCurrentCarbs = UserDefaults.standard.value(forKey: "dailyCurrentCarbs") as? Double {
            dailyCurrentCarbs = 0
            UserDefaults.standard.set(dailyCurrentCarbs, forKey: "dailyCurrentCarbs")
        }
        
        if var dailyCurrentFats = UserDefaults.standard.value(forKey: "dailyCurrentFats") as? Double {
            dailyCurrentFats = 0
            UserDefaults.standard.set(dailyCurrentFats, forKey: "dailyCurrentFats")
        }
        
        if var dailyCurrentProtein = UserDefaults.standard.value(forKey: "dailyCurrentProtein") as? Double {
            dailyCurrentProtein = 0
            UserDefaults.standard.set(dailyCurrentProtein, forKey: "dailyCurrentProtein")
        }
        
        if var food = UserDefaults.standard.value(forKey: "dailyFoods") as? Array<Dictionary<String, Any>> {
            food = []
            UserDefaults.standard.set(food, forKey: "dailyFoods")
        }
        
        dailyIntakeCollectionView.reloadData()
        dailyFoodTableView.reloadData()
    }
}

