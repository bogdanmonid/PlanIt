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

struct Keys{
    static let name = "name"
    static let description = "description"
}

class NotesViewController: UIViewController{
    
    var delegate: NotesViewControllerDelegate?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.layer.cornerRadius = 13
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextField.frame.height))
        
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.delegate = self
        titleTextField.text = " Name..."
        titleTextField.textColor = UIColor.systemGray5
        titleTextField.font = .italicSystemFont(ofSize: 17)
        titleTextField.alpha = 0.25
        titleTextField.frame.origin = CGPoint(x: 3, y: (titleTextField.font?.pointSize)! / 2)
        titleTextField.addTarget(self, action: #selector(saveEnabling), for: .editingChanged)
        titleTextField.layer.cornerRadius = 17
        titleTextField.autocapitalizationType = .words
        titleTextField.addShadow()
        
        descriptionTextView.delegate = self
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.systemGray5
        descriptionTextView.font = .italicSystemFont(ofSize: 20)
        descriptionTextView.sizeToFit()
        descriptionTextView.alpha = 0.25
        descriptionTextView.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        descriptionTextView.addShadowForTextView()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if let textName = titleTextField.text, let textDescription = descriptionTextView.text{
            let task = ModelTask(id: 0, titleTask: textName, descriptionTask: textDescription)
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
        
        titleTextField.becomeFirstResponder()
        
        if titleTextField.textColor == UIColor.systemGray5{
            titleTextField.text = ""
            titleTextField.alpha = 0.6
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if titleTextField.text == "" {
            titleTextField.alpha = 0.25
            titleTextField.text = " Name..."
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc func saveEnabling(){
        if titleTextField.text?.isEmpty == false{
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
            descriptionTextView.alpha = 0.6
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if descriptionTextView.text == ""{
            descriptionTextView.alpha = 0.25
            descriptionTextView.text = "Description"
        }
    }
}

