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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let calories = UserDefaults.standard.value(forKey: "calories") {
            goalCalories = "\(calories)"
        } else {
            goalCalories = "0"
        }
        
        if let carbs = UserDefaults.standard.value(forKey: "carbs") {
            goalCarbs = "\(carbs)"
        } else {
            goalCarbs = "0"
        }
        
        if let fats = UserDefaults.standard.value(forKey: "fat") {
            goalFats = "\(fats)"
        } else {
            goalFats = "0"
        }
        
        if let protein = UserDefaults.standard.value(forKey: "protein") {
            goalProtein = "\(protein)"
        } else {
            goalProtein = "0"
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
        case 1:
            cell.dailyIntakeGoal.text = goalCarbs
        case 2:
            cell.dailyIntakeGoal.text = goalFats
        case 3:
            cell.dailyIntakeGoal.text = goalProtein
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyFoodTableCell") as! DailyFoodTableViewCell
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

