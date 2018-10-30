//
//  RestaurantListViewController.swift
//  letuseat
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import UIKit

class RestaurantListViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var chicagoRestaurantsService: ChicagoRestaurantsService!
    var restaurants = [Restaurant]()
    var filteredRestaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        fetchTableData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Restaurants"
    }
    
    func fetchTableData() {
        chicagoRestaurantsService = ChicagoRestaurantsService()
        chicagoRestaurantsService.getChicagoRestaurants{ (chicagoRestaurants) in
            guard let restaurants = chicagoRestaurants else {
                let alert = UIAlertController(title: "UIAlertController", message: "TryAgain", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "TryAgain", style: .default, handler: { _ in self.fetchTableData()}))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.restaurants = restaurants
            self.tableView.reloadData()
        }
       
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterRestaurantsForSearch(_ searchText: String, scope: String = "All") {
        filteredRestaurants = restaurants.filter({( restaurant : Restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    func searchBarIsActive() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarIsActive() ? filteredRestaurants.count : restaurants.count
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantCell {
            let restaurant = searchBarIsActive() ? filteredRestaurants[indexPath.row] : restaurants[indexPath.row]
            cell.upDateCellUI(title: restaurant.name, address: restaurant.address)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurants[indexPath.row]
        performSegue(withIdentifier: "restaurantDetails", sender: restaurant)

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if let restaurant = sender as? Restaurant {
                destination.restaurant = restaurant
                self.title = ""
            }
        }
    }
}

extension RestaurantListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterRestaurantsForSearch(searchController.searchBar.text!)
    }
}
