//
//  Restaurant.swift
//  letuseat
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import Foundation
import Alamofire
import MapKit
import Contacts

class Restaurant:NSObject, MKAnnotation {
    private var _name: String
    private var _address: String
    private var _result: String
    private var _inspectionType: String
    private var _inspectionDate: String
    private var _inspectionID: String
    private var _risk: String
    private var _violations: String?
    
    var name: String {
        return _name
    }
    var address: String {
        return _address
    }
    var result: String {
        return _result
    }
    var inspectionType: String {
        return _inspectionType
    }
    var inspectionID: String {
        return _inspectionID
    }
    var risk: UIColor {
        switch _risk {
        case "RISK 1 (HIGH)":
            return .red
        case "RISK 2 (MEDIUM)":
            return UIColor(displayP3Red:1.0, green: 215.0/255, blue: 0.0, alpha: 1.0)
        case "RISK 3 (LOW)":
            return UIColor(displayP3Red:0, green: 100.0/255, blue: 0.0, alpha: 1.0)
        default:
            return .brown
        }
    }
    var violations: String {
        if let restviolations = _violations{
            return restviolations
        }
        return ""
    }
    var inspectionDate:String {
        let dateString = _inspectionDate
        let dateFormatterFromString = DateFormatter()
        dateFormatterFromString.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let s = dateFormatterFromString.date(from:dateString)
        //CONVERT FROM NSDate to String
        let date = s!
        let dateFormatterFromDate = DateFormatter()
        dateFormatterFromDate.dateFormat = "MMMM dd, yyyy"
        return dateFormatterFromDate.string(from:date as Date)
    }
    
    // mapview variables
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return name
    }
    var subtitle: String?{
        return "result: \(result)"
    }
    var imageName: String {
        switch _risk {
        case "RISK 1 (HIGH)":
            return "high"
        case "RISK 2 (MEDIUM)":
            return "medium"
        case "RISK 3 (LOW)":
            return "low"
        default:
            return "pin"
        }
    }
    
    init(name: String, address: String, result: String, inspectionType: String, inspectionDate: String, inspectionID: String, risk: String, violation: String?, longitude: String, latitude: String ) {
        self._name = name
        self._address = address
        self._result = result
        self._inspectionType = inspectionType
        self._inspectionDate = inspectionDate
        self._inspectionID = inspectionID
        self._risk = risk
        
        if let _violation = violation {
            self._violations = _violation
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        if let restLong = Double(longitude){
            if let restLat = Double(latitude) {
                self.coordinate = CLLocationCoordinate2D(latitude: restLat, longitude: restLong)
            }
        }
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
