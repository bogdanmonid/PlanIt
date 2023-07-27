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
    var modelData: ModelTask? {
        didSet{
            guard let modelData = modelData else {return}
            self.titleLabel.text = modelData.titleTask
            self.descriptionTextViewLabel.text = modelData.descriptionTask
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
      
    @IBOutlet weak var descriptionTextViewLabel: UITextView!{
        didSet{
            descriptionTextViewLabel.layer.cornerRadius = 12
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//
//        checkMarkLabel.setImage(UIImage(named: "buttonImage"), for: .normal)
//        checkMarkLabel.setImage(UIImage(named: "checkMark"), for: .selected)
        checkMarkLabel.tintColor = .placeholderText
       
      
       
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        customDelegate?.editingTask(title: titleLabel.text ?? "")
    }
    
    func animate(){
        UIView.animate(withDuration: 0.5,
                       delay: 0.8,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {self.contentView.layoutIfNeeded()})
    }
}
