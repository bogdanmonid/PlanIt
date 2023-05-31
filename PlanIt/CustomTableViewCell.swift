//
//  CustomTableViewCell.swift
//  PlanIt
//
//  Created by Bogdan Monid on 29.05.23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMarkLabel: UIButton!
    @IBOutlet weak var pencilLabel: UIButton!
    @IBOutlet weak var label: UILabel!{
        didSet{
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
    }
    
}
