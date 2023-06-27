//
//  CoffeeViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 15.06.23.
//

import UIKit

class CoffeeViewController: UIViewController {
    
    
    //var item = UINavigationItem(title: "Coffe control").titleView?.tintColor = #colorLiteral(red: 0.6592550278, green: 0.8111829162, blue: 0.5474096537, alpha: 1)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2068116367, green: 0.2519083023, blue: 0.2926495671, alpha: 1)
        
        let navItem = UINavigationItem(title: "Coffee control")
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        
        navBar.setItems([navItem], animated: false)
        navItem.rightBarButtonItem = closeButton
        
        
    }
    
    @objc func close(){
        dismiss(animated: true)
    }
    
   
}
