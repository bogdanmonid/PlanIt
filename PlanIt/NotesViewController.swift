//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

class NotesViewController: UIViewController{
    
    var model: Model!
    var placeholder: UILabel!
    
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
        
        textViewLabel.delegate = self
        placeholder = UILabel()
        placeholder.text = "Description"
        placeholder.font = .italicSystemFont(ofSize: 20)
        placeholder.alpha = 0.25
        placeholder.sizeToFit()
        textViewLabel.addSubview(placeholder)
        placeholder.frame.origin = CGPoint(x: 5, y: (textViewLabel.font?.pointSize)! / 2)
        placeholder.textColor = .systemGray5
        placeholder.isHidden = !textViewLabel.text.isEmpty
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldLabel.layer.cornerRadius = 17
        textFieldLabel.addShadow()
        textViewLabel.addShadowForTextView()
        
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

extension UIView {
    func addShadow() {
        
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        let radius = self.frame.size.height / 2
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy: -1), cornerRadius: radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 1, height: 3)
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 2
        innerShadow.cornerRadius = self.frame.size.height / 2
        
        layer.addSublayer(innerShadow)
    }
    
    func addShadowForTextView(shadowColor: CGColor = UIColor.black.cgColor,
                              shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                              shadowOpacity: Float = 0.4,
                              shadowRadius: CGFloat = 3.0){
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}

extension NotesViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholder.isHidden = true
    }
}
