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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dailyIntakeTabBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        dailyIntakeCollectionView.delegate = self
        dailyIntakeCollectionView.dataSource = self
        
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

