//
//  ChicagoRestaurantsService.swift
//  letuseat
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import Foundation
import Alamofire

class ChicagoRestaurantsService{
    
    func getChicagoRestaurants(completion: @escaping ([Restaurant]?)->()){
        guard let url = URL(string: CHICAGO_RESTAURANTS_URL) else {
            completion(nil)
            return
        }
        var restaurants: [Restaurant] = []
        Alamofire.request(url).responseJSON { response in
            guard response.result.isSuccess,let responseRestaurants = response.result.value as? [Dictionary<String, AnyObject>] else {
                print( "ERROR:NO RESULTS REUTRNED");
                completion(nil)
                return
            }
            
            for responseRestaurant in responseRestaurants {
                let restaurant = self.parserestaurant(restaurant: responseRestaurant)
                restaurants.append(restaurant)
            }
            completion(restaurants)
        }
        
    }
    
    func parserestaurant(restaurant: Dictionary<String, AnyObject>) -> (Restaurant) {
        
        let name = (restaurant["dba_name"] as! String).capitalized
        let result = (restaurant["results"] as! String).uppercased()
        let inspectionType = restaurant["inspection_type"] as! String
        let inspectionDate = restaurant["inspection_date"] as! String
        let inspectionID = restaurant["inspection_id"] as! String
        var risk: String = ""
        var address: String = ""
        var violations: String?
        var longitude: String = ""
        var latitude: String = ""
        if let _risk = restaurant["risk"] as? String {
            risk = _risk.uppercased()
        }
        if let _address = (restaurant["address"] as? String)?.capitalized {
            address = _address
        }
        if let city = restaurant["city"] as? String, let state = restaurant["state"] as? String {
            address = address + "\(city.capitalized) \(state.uppercased())"
        }
        if let _violations = restaurant["violations"] as? String {
            violations = _violations
        }
        if let _longitude = restaurant["longitude"] as? String, let _latitude = restaurant["latitude"] as? String {
            longitude = _longitude
            latitude = _latitude
        }
        
        return Restaurant(name: name, address: address, result: result, inspectionType: inspectionType, inspectionDate: inspectionDate, inspectionID: inspectionID, risk: risk, violation: violations, longitude: longitude, latitude: latitude)
    }
}
