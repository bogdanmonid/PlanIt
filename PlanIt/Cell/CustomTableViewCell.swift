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
            let maskPath = UIBezierPath(roundedRect: titleLabel.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12, height: 12))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            titleLabel.layer.mask = maskLayer
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            let maskPath = UIBezierPath(roundedRect: descriptionLabel.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12, height: 12))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            descriptionLabel.layer.mask = maskLayer
        }
    }
      
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkMarkLabel.setImage(UIImage(named: "buttonImage"), for: .normal)
        checkMarkLabel.setImage(UIImage(named: "checkMark"), for: .selected)
        checkMarkLabel.tintColor = .placeholderText
        checkMarkSelected = UserDefaults.standard.bool(forKey: "UserDefaults")
        updateButtonState()
        //descriptionLabel.isHidden = true
        
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
                       delay: 1,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {self.contentView.layoutIfNeeded()})
    }
}
