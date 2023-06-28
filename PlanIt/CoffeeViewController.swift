//
//  CoffeeViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 15.06.23.
//

import UIKit

class CoffeeViewController: UIViewController {
    
    let cancelButton = UIButton()
    let coffeeTitle = UILabel()
    let coffeeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2431372549, blue: 0.2862745098, alpha: 1)
    
        setupUI()
    }
    
    func setupUI(){
        
        coffeeView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1921568627, blue: 0.2274509804, alpha: 1)
        coffeeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeeView)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(named: "Vector 1"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        coffeeTitle.text = "Coffee control"
        coffeeTitle.textColor = #colorLiteral(red: 0.6592550278, green: 0.8111829162, blue: 0.5474096537, alpha: 1)
        coffeeTitle.font = UIFont(name: "Verdana", size: 25)
        coffeeTitle.textAlignment = .center
        coffeeTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeeTitle)
        
        NSLayoutConstraint.activate([
            coffeeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coffeeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coffeeView.heightAnchor.constraint(equalToConstant: 50),
            coffeeView.topAnchor.constraint(equalTo: view.topAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -330),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
           
            coffeeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coffeeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            coffeeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            coffeeTitle.heightAnchor.constraint(equalToConstant: 20),
            coffeeTitle.widthAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
    @objc func cancel(){
        dismiss(animated: true)
    }
}
