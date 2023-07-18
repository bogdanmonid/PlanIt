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
    var modelData: ModelTask? {
        didSet{
            guard let modelData = modelData else {return}
            self.titleLabel.text = modelData.titleTask
            self.descriptionLabel.text = modelData.descriptionTask
        }
    }
    
    @IBOutlet weak var checkMarkLabel: UIButton!
    @IBOutlet weak var pencilLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.layer.masksToBounds = true
            titleLabel.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.layer.masksToBounds = true
            descriptionLabel.layer.cornerRadius = 12
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
        customDelegate?.editingTask(title: titleLabel.text ?? "")
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
    
    func animate(){
        UIView.animate(withDuration: 1,
                       delay: 0.1,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {self.contentView.layoutIfNeeded()})
    }
}
