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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = true
        textFieldLabel.addTarget(self, action: #selector(saveEnabling), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldLabel.layer.cornerRadius = 17
        addInnerShadow()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func saveText(){
        model = Model(text: textFieldLabel.text!)
    }
    
    private func addInnerShadow(){
        
        let textFieldLayer = textFieldLabel.layer
        
        // textFieldLayer.backgroundColor = UIColor.black.cgColor
        textFieldLayer.cornerRadius = textFieldLabel.frame.height / 2
        textFieldLayer.shadowColor = UIColor.black.cgColor
        textFieldLayer.shadowOffset = CGSize(width: 3, height: 3)
        textFieldLayer.shadowOpacity = 0.5
        textFieldLayer.shadowRadius = 1
        textFieldLayer.masksToBounds = false
        
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
