//
//  RestaurantCell.swift
//  letuseat
//
//  Created by Nirali Patel on 10/26/18.
//  Copyright © 2018 Nirali Patel. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func upDateCellUI(title: String, address: String) {
        titleLabel.text = title
        addressLabel.text = address
    }
}
