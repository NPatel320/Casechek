//
//  ViewController.swift
//  letuseat
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let locationManager = CLLocationManager()
    var restaurant: Restaurant!
    var restaurantInfo: [String:String] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = restaurant.name
        
        // tableview set up
        prepareRestaurantForTable(restaurant: restaurant)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let twoLabelNib = UINib(nibName: "TwoLabelCell", bundle: nil)
        tableView.register(twoLabelNib, forCellReuseIdentifier: "twoLabelCell")
        
        // mapview set up
        mapView.delegate = self
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(restaurant.coordinate,1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.register(RestaurantMarkerView.self,forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.addAnnotation(restaurant)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func prepareRestaurantForTable(restaurant: Restaurant){
        if !restaurant.address.isEmpty {
            restaurantInfo["Address"] = restaurant.address
        }
        if !restaurant.result.isEmpty {
            restaurantInfo["Results"] = restaurant.result
        }
        if !restaurant.inspectionType.isEmpty {
            restaurantInfo["Inspection Type"] = restaurant.inspectionType
        }
        if !restaurant.inspectionDate.isEmpty {
            restaurantInfo["Inspection Date"] = restaurant.inspectionDate
        }
        if !restaurant.inspectionID.isEmpty {
            restaurantInfo["Inspection ID"] = restaurant.inspectionID
        }
        if !restaurant.violations.isEmpty {
            restaurantInfo["Violations"] = restaurant.violations
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "twoLabelCell", for: indexPath) as? TwoLabelCell{
            let restaurantInfo = Array(self.restaurantInfo).sorted(by: { $0.0 < $1.0 })
            cell.topLabel.text = restaurantInfo[indexPath.row].key + ":"
            cell.bottomLabel.text = restaurantInfo[indexPath.row].value
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantInfo.count
    }
}

extension DetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Restaurant
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}


