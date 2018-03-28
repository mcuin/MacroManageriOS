//
//  ViewController.swift
//  MacrosManageriOS
//
//  Created by Mykal Cuin on 8/26/17.
//  Copyright © 2017 Mykal Cuin. All rights reserved.
//

import UIKit

class DailyIntakeViewController: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dailyIntakeCollectionView: UICollectionView!
    @IBOutlet weak var dailyFoodTableView: UITableView!
    @IBOutlet weak var dailyIntakeTabBar: UITabBar!
    let macros = ["Calories", "Carbohydrates", "Fats", "Protein"]
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
        
        dailyIntakeTabBar.delegate = self
        dailyIntakeCollectionView.delegate = self
        dailyIntakeCollectionView.dataSource = self
        dailyFoodTableView.delegate = self
        dailyFoodTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
}

