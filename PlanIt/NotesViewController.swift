//
//  NotesViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 30.05.23.
//

import UIKit

class NotesViewController: UIViewController {
    
    var shadowLayer: CALayer?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textFieldLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeTextField()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = textFieldLabel.frame.size
        let layer: CALayer = CALayer()
        
        textFieldLabel.layer.backgroundColor = UIColor.lightGray.cgColor
        textFieldLabel.layer.position = CGPointMake(size.width, size.height)
        textFieldLabel.layer.bounds = CGRectMake(0, 0, size.width, size.height)
        textFieldLabel.layer.shadowColor = UIColor.darkGray.cgColor
        textFieldLabel.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        textFieldLabel.layer.shadowOpacity = 0.8
        textFieldLabel.layer.shadowRadius = 5
      //  self.shadowLayer = layer
        self.shadowLayer?.addSublayer(layer)
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //    private func addShadowToTextField(){
    //        if nil == self.shadowLayer{
    //            let size = textFieldLabel.frame.size
    //            self.textFieldLabel.clipsToBounds = true
    //            let layer: CALayer = CALayer()
    //            layer.backgroundColor = UIColor.lightGray.cgColor
    //            layer.position = CGPointMake(size.width / 2,  -size.height / 2 + 0.5)
    //            layer.bounds = CGRectMake(0, 0, size.width, size.height)
    //            layer.shadowColor = UIColor.darkGray.cgColor
    //            layer.shadowOffset = CGSizeMake(0.5, 0.5)
    //            layer.shadowOpacity = 0.8
    //            layer.shadowRadius = 5
    //            self.shadowLayer = layer
    //
    //        }
    //    }
}

private extension NotesViewController{
    
    func changeTextField(){
        
        textFieldLabel.layer.masksToBounds = true
        textFieldLabel.layer.cornerRadius = 17
        
        
    }
}
