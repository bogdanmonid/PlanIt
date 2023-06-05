//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

class NotesViewController: UIViewController {
    
    var model: Model!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textFieldLabel: UITextField!
    @IBOutlet weak var textViewLabel: UITextView!{
        didSet{
            textViewLabel.layer.cornerRadius = 13
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        saveButton.isEnabled = true
        textFieldLabel.addTarget(self, action: #selector(saveEnabling), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldLabel.layer.cornerRadius = 17
        textFieldLabel.addShadow(to: [.top, .left, .right])
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print("blablabla")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func saveText(){
        model = Model(text: textFieldLabel.text!)
    }
}

extension NotesViewController: UITextFieldDelegate{
    
    @objc func saveEnabling(){
        if textFieldLabel.text?.isEmpty == false{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
}

extension UITextField{
    
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor){
        
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        
        for edge in edges {
            let  gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            gradientLayer.cornerRadius = 17
            gradientLayer.masksToBounds = true

            switch edge{
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
                gradientLayer.frame = CGRect(x: 0, y: 0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.frame = CGRect(x: 0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
                gradientLayer.frame = CGRect(x: 0, y: 0, width: radius, height: viewFrame.height)
            case.right:
                gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
}
