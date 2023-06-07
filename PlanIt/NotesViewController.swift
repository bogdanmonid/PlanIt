//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

protocol NotesViewControllerDelegate {
    
    func completedCreateTask(data: ModelTask)
}

class NotesViewController: UIViewController{
    
    var delegate: NotesViewControllerDelegate?
    var placeholder: UILabel!
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.layer.cornerRadius = 13
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        nameTextField.delegate = self
        nameTextField.text = "    Name..."
        nameTextField.textColor = UIColor.systemGray5
        nameTextField.font = .italicSystemFont(ofSize: 17)
        nameTextField.alpha = 0.25
        nameTextField.frame.origin = CGPoint(x: 3, y: (nameTextField.font?.pointSize)! / 2)
        nameTextField.addTarget(self, action: #selector(saveEnabling), for: .editingChanged)
        nameTextField.layer.cornerRadius = 17
        nameTextField.addShadow()
        nameTextField.becomeFirstResponder()
        
        //        placeholder = UILabel()
        //        placeholder.text = "Description"
        //        placeholder.font = .italicSystemFont(ofSize: 20)
        //        placeholder.alpha = 0.25
        //        placeholder.sizeToFit()
        //        placeholder.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        //        placeholder.textColor = .systemGray5
        //        placeholder.isHidden = !descriptionTextView.text.isEmpty
        // descriptionTextView.addSubview(placeholder)
        
        
        
        descriptionTextView.delegate = self
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.systemGray5
        descriptionTextView.font = .italicSystemFont(ofSize: 20)
        descriptionTextView.sizeToFit()
        descriptionTextView.alpha = 0.25
        descriptionTextView.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        descriptionTextView.addShadowForTextView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if let textName = nameTextField.text, let textDescription = descriptionTextView.text{
            let task = ModelTask(nameTask: textName, descriptionTask: textDescription)
            delegate?.completedCreateTask(data: task)
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension NotesViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.becomeFirstResponder()
        
        if nameTextField.textColor == UIColor.systemGray5{
            nameTextField.text = ""
            nameTextField.textColor = UIColor.white
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if nameTextField.text == "" {
            nameTextField.text = "    Name..."
            nameTextField.textColor = UIColor.systemGray5
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    @objc func saveEnabling(){
        if nameTextField.text?.isEmpty == false{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
}

extension NotesViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if descriptionTextView.textColor == UIColor.systemGray5{
            descriptionTextView.text = ""
            descriptionTextView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if descriptionTextView.text == "" {
            descriptionTextView.text = "Description"
            descriptionTextView.textColor = UIColor.systemGray5
        }
    }
}

