//
//  RestaurantMarkerView.swift
//  letuseat
//
//  Created by Nirali Patel on 10/28/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import Foundation
import MapKit

class RestaurantMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let restaurant = newValue as? Restaurant else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            markerTintColor = restaurant.risk
            glyphImage = UIImage(named: restaurant.imageName)
            let mapButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                            size: CGSize(width: 30, height: 30)))
            mapButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapButton
        }
    }
}
