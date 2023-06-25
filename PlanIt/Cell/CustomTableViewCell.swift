//
//  CustomTableViewCell.swift
//  PlanIt
//
//  Created by Bogdan Monid on 29.05.23.
//

import UIKit

protocol CustomTableViewCellDelegate {
    func editingTask(title: String)
}

class CustomTableViewCell: UITableViewCell {
    
    var customDelegate: CustomTableViewCellDelegate?
    
    @IBOutlet weak var checkMarkLabel: UIButton!
    @IBOutlet weak var pencilLabel: UIButton!
    @IBOutlet weak var label: UILabel!{
        didSet{
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkMarkLabel.setImage(UIImage(named: "buttonImage"), for: .normal)
        checkMarkLabel.setImage(UIImage(named: "checkMark"), for: .selected)
        checkMarkLabel.tintColor = .clear
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        customDelegate?.editingTask(title: label.text ?? "")
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        checkMarkLabel.isSelected = !checkMarkLabel.isSelected
    }
}
