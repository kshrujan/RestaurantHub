//
//  ThirdViewController.swift
//  RestaurantHub
//
//  Created by Shrujan Kalidindi on 6/16/16.
//  Copyright © 2016 Shrujan Kalidindi. All rights reserved.
//

import UIKit



class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var restaurantTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let restaurantsRaw = UserDefaults.standard.data(forKey: "restaurantsarray") {
            if let restaurants = NSKeyedUnarchiver.unarchiveObject(with: restaurantsRaw) as? [Restaurant] {
                RestaurantManager.restaurants = restaurants
            }
        }
        
    }
    
    //returning to view, so it must be updated
    override func viewWillAppear(_ animated: Bool) {
        restaurantTable.reloadData()
    }
    
    //UITableViewDataSource functions that are necessary
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantManager.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
        
        let restaurant = RestaurantManager.restaurants[indexPath.row]
        cell.detailTextLabel!.numberOfLines = 3
        cell.textLabel!.text = restaurant.name
        cell.detailTextLabel!.text = "Date: " + restaurant.date! + "    " + "Total: " + "$" + restaurant.bill!
        cell.accessoryType = .disclosureIndicator
        return cell
        
        
    }
    
    // Allows user to edit the table cells
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Allows user to delete table cells, and on delete the restaurauntTable is reloaded to show the accurate data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            // You need to figure out how to delete these rows without having to save the array all over. It's too inefficient.
            RestaurantManager.restaurants.remove(at: indexPath.row)
            
            let defaults = UserDefaults.standard
            let myData = NSKeyedArchiver.archivedData(withRootObject: RestaurantManager.restaurants)
            UserDefaults.standard.set(myData, forKey: "restaurantsarray")
            defaults.synchronize()
            restaurantTable.reloadData()
        }
    }

    

}
