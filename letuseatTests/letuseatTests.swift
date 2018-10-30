//
//  letuseatTests.swift
//  letuseatTests
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import XCTest
import Alamofire
import MapKit
@testable import letuseat

class letuseatTests: XCTestCase {
    
    var chicagoRestaurantsService: ChicagoRestaurantsService!
    var testRestaurantDict: [String: String] = [:]

    override func setUp() {
        chicagoRestaurantsService = ChicagoRestaurantsService()
        testRestaurantDict = [":@computed_region_43wa_7qmu": "23",
        ":@computed_region_6mkv_f3dw": "21572",
        ":@computed_region_awaf_s7ux": "11",
        ":@computed_region_bdys_3d7i": "176",
        ":@computed_region_vrxf_vc4k": "28",
        "address": "3400 W LAKE ST ",
        "aka_name": "SHAM MARKET",
        "city": "CHICAGO",
        "dba_name": "SHAM MARKET",
        "facility_type": "Grocery Store",
        "inspection_date": "2018-10-25T00:00:00.000",
        "inspection_id": "2232253",
        "inspection_type": "License",
        "latitude": "41.88475367639503",
        "license_": "2630976",
        "longitude": "-87.71122978859283",
        "results": "Pass w/ Conditions",
        "risk": "Risk 3 (Low)",
        "state": "IL",
        "violations": "3. MANAGEMENT, FOOD EMPLOYEE AND CONDITIONAL EMPLOYEE; KNOWLEDGE, RESPONSIBILITIES AND REPORTING - Comments: - OBSERVED NO EMPLOYEE HEALTH POLICY/TRAINING ON SITE. INSTRUCTED FACILITY TO ESTABLISH AN APPROPRIATE EMPLOYEE HEALTH POLICY/TRAINING SYSTEM AND MAINTAIN WITH VERIFIABLE DOCUMENTS ON SITE. PRIORITY FOUNDATION VIOLATION #7-38-010. NO CITATION ISSUED | 5. PROCEDURES FOR RESPONDING TO VOMITING AND DIARRHEAL EVENTS - Comments: - OBSERVED NO PROCEDURE/PLAN FOR RESPONDING TO VOMITING AND DIARRHEAL EVENTS. INSTRUCTED FACILITY TO DEVELOP AND MAINTAIN A PROCEDURE/PLAN AND TO MAINTAIN ANY APPROPRIATE SUPPLIES ON SITE. PRIORITY FOUNDATION VIOLATION #7-38-005. NO CITATION ISSUED.??? | 47. FOOD & NON-FOOD CONTACT SURFACES CLEANABLE, PROPERLY DESIGNED, CONSTRUCTED & USED - Comments: - OBSERVED RAW WOOD SURFACES USED AS PANELS AND FIXTURES FOR THE WINDOW COUNTER. INSTRUCTED TO SEAL TO PROVIDE A SMOOTH AND EASILY CLEANABLE SURFACE FOR BOTH THE ENTIRE COUNTER AREA AND IN THE REGISTER AREA. | 47. FOOD & NON-FOOD CONTACT SURFACES CLEANABLE, PROPERLY DESIGNED, CONSTRUCTED & USED - Comments: - OBSERVED CRATES USED TO ELEVATE NON FOOD ITEMS IN THE FRONT OF THE STORE. INSTRUCTED TO REMOVE AND PROVIDE PROPER SHELVING UNITS THAT IS ELEVATED TO AT LEAST 6 INCHES FROM THE GROUND. | 51. PLUMBING INSTALLED; PROPER BACKFLOW DEVICES - Comments: - OBSERVED PREMISES WITHOUT A UTILITY (MOP) SINK. INSTRUCTED TO CONSULT WITH PLUMBER AND PROVIDE SINK. | 55. PHYSICAL FACILITIES INSTALLED, MAINTAINED & CLEAN - Comments: - OBSERVED BUILDUP DIRT ON THE FLOORS OTHER SURFACES THROUGHOUT THE FACILITY. INSTRUCTED TO DETAIL CLEAN UNDER AND AROUND ALL SHELVING UNITS, STORAGE AREAS AND FURNACE ROOM. MUST MAINTAIN AT ALL TIMES. | 55. PHYSICAL FACILITIES INSTALLED, MAINTAINED & CLEAN - Comments: - OBSERVED EXCESS CLUTTER AND UNNECESSARY ARTICLES STORED IN THE BASEMENT. MUST REMOVE ALL UNNECESSARY ARTICLES, CLEAN ALL CLUTTER, ORGANIZE, AND MAINTAIN AREAS AT ALL TIMES | 55. PHYSICAL FACILITIES INSTALLED, MAINTAINED & CLEAN - Comments: - OBSERVED MISSING FLOOR TILES BEHIND THE FRONT COUNTER OF THE STORE. INSTRUCTED TO EITHER REPLACE MISSING TILES TO CREATE A SMOOTH AND EASILY CLEANABLE SURFACE. | 55. PHYSICAL FACILITIES INSTALLED, MAINTAINED & CLEAN - Comments: - OBSERVED MOP IN A POSITION THAT DOES NOT ALLOW TO DRY PROPERLY AND PREVENT PEST HARBORAGE. MUST STORE MOP AFTER USE IN A POSITION THAT ALLOWS FOR AIR-DRYING WITHOUT SOILING AND PEST HARBORAGING. | 56. ADEQUATE VENTILATION & LIGHTING; DESIGNATED AREAS USED - Comments: - OBSERVED A MISSING LIGHT SHIELD IN THE WASHROOM CEILING LIGHT. INSTRUCTED TO PROVIDE AND MAINTAIN AT ALL TIMES. | 56. ADEQUATE VENTILATION & LIGHTING; DESIGNATED AREAS USED - Comments: - OBSERVED BURNED OUT LIGHT IN THE 2-DOOR REFRIGERATOR UNIT. INSTRUCTED TO REPLACE LIGHT BULB.",
        "zip": "60624"]
        
        super.setUp()
        
    }
    
    override func tearDown() {
        testRestaurantDict = [:]
        super.tearDown()
    }
    func testparserestaurant(){
        let restaurant = chicagoRestaurantsService.parserestaurant(restaurant: testRestaurantDict as Dictionary<String, AnyObject>)
        var address = testRestaurantDict["address"]?.capitalized
        address = address! + "\(testRestaurantDict["city"]!.capitalized) \(testRestaurantDict["state"]!.uppercased())"
        XCTAssertEqual(restaurant.name, testRestaurantDict["dba_name"]?.capitalized)
        XCTAssertEqual(restaurant.result, testRestaurantDict["results"]?.uppercased())
        XCTAssertEqual(restaurant.inspectionType, testRestaurantDict["inspection_type"])
        XCTAssertEqual(restaurant.inspectionID, testRestaurantDict["inspection_id"])
        XCTAssertEqual(restaurant.risk, UIColor(displayP3Red:0, green: 100.0/255, blue: 0.0, alpha: 1.0))
        XCTAssertEqual(restaurant.address, address)
        XCTAssertEqual(restaurant.violations, testRestaurantDict["violations"])
    }
}
