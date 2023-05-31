//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textFieldLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldLabel.layer.shadowColor = UIColor.black.cgColor
        textFieldLabel.layer.shadowRadius = 10
        textFieldLabel.layer.shadowOpacity = 1
        textFieldLabel.layer.shadowOffset = CGSize(width: 15, height: 15)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

private extension NotesViewController{
    
    func changeTextField(){
        
        textFieldLabel.layer.masksToBounds = true
        textFieldLabel.layer.cornerRadius = 17
        
    }
}
