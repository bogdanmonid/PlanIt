//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

protocol NotesViewControllerDelegate {
    func completedCreateTask(data: ModelTask, isEdit: Bool)
}


class NotesViewController: UIViewController{
    
    var isEdit = false
    var delegate: NotesViewControllerDelegate?
    var savedTextInTitleTextField: String = ""
    var savedTextInDescriptionTextView: String = ""
    
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
        
        titleTextField.text = savedTextInTitleTextField
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.delegate = self
        titleTextField.text = " Name..."
        titleTextField.textColor = UIColor.systemGray5
        titleTextField.font = .italicSystemFont(ofSize: 17)
        titleTextField.alpha = 0.75
        titleTextField.frame.origin = CGPoint(x: 3, y: (titleTextField.font?.pointSize)! / 2)
        titleTextField.addTarget(self, action: #selector(saveEnabling), for: .editingChanged)
        titleTextField.layer.cornerRadius = 17
        titleTextField.autocapitalizationType = .words
        titleTextField.addShadow()
        
        descriptionTextView.text = savedTextInDescriptionTextView
        descriptionTextView.delegate = self
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.systemGray5
        descriptionTextView.font = .italicSystemFont(ofSize: 20)
        descriptionTextView.sizeToFit()
        descriptionTextView.alpha = 0.75
        descriptionTextView.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        descriptionTextView.addShadowForTextView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        descriptionTextView.contentInset = UIEdgeInsets.zero
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if let textName = titleTextField.text, let textDescription = descriptionTextView.text{
            let task = ModelTask(id: 0, titleTask: textName, descriptionTask: textDescription)
            delegate?.completedCreateTask(data: task, isEdit: isEdit)
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
            titleTextField.alpha = 0.75
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if titleTextField.text == "" {
            titleTextField.alpha = 0.75
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
        
        savedTextInDescriptionTextView = descriptionTextView.text ?? ""
        
        if descriptionTextView.textColor == UIColor.systemGray5{
            descriptionTextView.text = ""
            descriptionTextView.alpha = 0.75
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        //savedTextInDescriptionTextView == descriptionTextView.text
        
        if descriptionTextView.text == ""{
            descriptionTextView.alpha = 0.75
            descriptionTextView.text = "Description"
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {return}  // Получаем размер клавиатуры
        
        descriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)   // Устанавливаем отступы для текстового поля, чтобы оно не                                                                                                                                     перекрывалось клавиатурой
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        descriptionTextView.contentInset = UIEdgeInsets.zero
    }
}

