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
    let coffeeTitleView = UIView()
    let coffeeCupImage = UIImageView()
    let pickerView = UIView()
    let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let informationButton = UIButton()
    let ellipsForInfo = UIImageView()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    let firstRowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    let secondRowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    let pickerCount = Array(1...10)
   
    let coffeCups: [UIImage] = [UIImage(named: "cup1")!,
                                UIImage(named: "cup2")!,
                                UIImage(named: "cup3")!,
                                UIImage(named: "cup4")!,
                                UIImage(named: "cup5")!,
                                UIImage(named: "cup6")!,
                                UIImage(named: "cup7")!,
                                UIImage(named: "cup8")!,
                                UIImage(named: "cup9")!,
                                UIImage(named: "cup10")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2431372549, blue: 0.2862745098, alpha: 1)
    
        picker.dataSource = self
        picker.delegate = self
        
        setupUI()
        stackViewSetupUI()
    }
    
    func stackViewSetupUI(){
        
        view.addSubview(stackView)
        
        for (index, coffeCup) in coffeCups.enumerated() {
            let imageView = UIImageView(image: coffeCup)
            imageView.contentMode = .scaleAspectFit
            
            if index < 5 {
                firstRowStackView.addArrangedSubview(imageView)
            } else {
                secondRowStackView.addArrangedSubview(imageView)
            }
        }
        
        stackView.addArrangedSubview(firstRowStackView)
        stackView.addArrangedSubview(secondRowStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ])
    }
    
    func setupUI(){
        
        view.addSubview(coffeeTitleView)
        view.addSubview(coffeeTitle)
        view.addSubview(cancelButton)
        view.addSubview(pickerView)
        view.addSubview(coffeeCupImage)
        view.addSubview(picker)
        view.addSubview(ellipsForInfo)
        view.addSubview(informationButton)
        view.addSubview(stackView)
        
        ellipsForInfo.translatesAutoresizingMaskIntoConstraints = false
        ellipsForInfo.image = UIImage(named: "ellipsForInfo")
        
        informationButton.setImage(UIImage(named: "information"), for: .normal)
        informationButton.translatesAutoresizingMaskIntoConstraints = false
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        coffeeCupImage.image = UIImage(named: "coffeeCup")
        coffeeCupImage.translatesAutoresizingMaskIntoConstraints = false
        
        pickerView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1921568627, blue: 0.2274509804, alpha: 1)
        pickerView.alpha = 0.90
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.layer.cornerRadius = 10
        
        coffeeTitleView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1921568627, blue: 0.2274509804, alpha: 1)
        coffeeTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(named: "Vector 1"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
       
        coffeeTitle.text = "Coffee control"
        coffeeTitle.textColor = #colorLiteral(red: 0.6592550278, green: 0.8111829162, blue: 0.5474096537, alpha: 1)
        coffeeTitle.font = UIFont(name: "Verdana", size: 25)
        coffeeTitle.textAlignment = .center
        coffeeTitle.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            
            ellipsForInfo.widthAnchor.constraint(equalToConstant: 60),
            ellipsForInfo.heightAnchor.constraint(equalToConstant: 60),
            ellipsForInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            ellipsForInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -17),
           
            informationButton.widthAnchor.constraint(equalToConstant: 100),
            informationButton.heightAnchor.constraint(equalToConstant: 100),
            informationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            informationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            picker.widthAnchor.constraint(equalToConstant: 100),
            picker.heightAnchor.constraint(equalToConstant: 100),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            picker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            picker.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -450),
            
            coffeeCupImage.widthAnchor.constraint(equalToConstant: 100),
            coffeeCupImage.heightAnchor.constraint(equalToConstant: 120),
            coffeeCupImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            coffeeCupImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            
            pickerView.widthAnchor.constraint(equalToConstant: 230),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 55),
            
            coffeeTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coffeeTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coffeeTitleView.heightAnchor.constraint(equalToConstant: 50),
            coffeeTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            
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

extension CoffeeViewController: UIPickerViewDataSource{
      
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCount.count
    }
}

extension CoffeeViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerCount[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

