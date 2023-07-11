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
    var checkMarkSelected: Bool = false
   
    
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
        checkMarkLabel.tintColor = .placeholderText
        checkMarkSelected = UserDefaults.standard.bool(forKey: "UserDefaults")
        updateButtonState()
        
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        customDelegate?.editingTask(title: label.text ?? "")
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        checkMarkSelected = !checkMarkSelected
        UserDefaults.standard.set(checkMarkSelected, forKey: "UserDefaults")
        updateButtonState()
    }
    
    func updateButtonState(){
        if checkMarkSelected{
            checkMarkLabel.isSelected = true
        }else{
            checkMarkLabel.isSelected = false
        }
    }
}
