//
//  CoffeeViewController.swift
//  PlanIt
//
//  Created by Bogdan Monid on 15.06.23.
//

import UIKit

class CoffeeViewController: UIViewController {
    
    private let cancelButton = UIButton()
    private let coffeeTitle = UILabel()
    private let coffeeTitleView = UIView()
    private let coffeeCupImage = UIImageView()
    private let pickerView = UIView()
    private let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    private let informationButton = UIButton()
    private let ellipsForInfo = UIImageView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
   
    private let pickerCount = Array(0...10)
   
    private let coffeCups: [UIImage] = [UIImage(named: "cup1")!,
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
        
        collectionView.register(CoffeeViewCell.self, forCellWithReuseIdentifier: CoffeeViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.frame = view.bounds
//    }
    
//    func stackViewSetupUI(with cup: Int){
//        
//        let selectedImages = Array(coffeCups.prefix(cup))  // Создаем новый массив изображений, содержащий только выбранное количество изображений
//        
//        for arrangedSubview in stackView.arrangedSubviews{  //удаляем изображения
//            stackView.removeArrangedSubview(arrangedSubview)
//            arrangedSubview.removeFromSuperview()
//        }
//        
//        for image in selectedImages{  // добавляем изображения
//            let imageView = UIImageView(image: image)
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.contentMode = .scaleAspectFit
//            NSLayoutConstraint.activate([
//                imageView.widthAnchor.constraint(equalToConstant: 75),
//                imageView.heightAnchor.constraint(equalToConstant: 75)
//            ])
//            stackView.addArrangedSubview(imageView)
//        }
//    }
    
    func setupUI(){
        
        view.addSubview(coffeeTitleView)
        view.addSubview(coffeeTitle)
        view.addSubview(cancelButton)
        view.addSubview(pickerView)
        view.addSubview(coffeeCupImage)
        view.addSubview(picker)
        view.addSubview(ellipsForInfo)
        view.addSubview(informationButton)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2431372549, blue: 0.2862745098, alpha: 1)
        
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
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            collectionView.widthAnchor.constraint(equalToConstant: 50),
            collectionView.heightAnchor.constraint(equalToConstant: 20),
        
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
        
        let selectedImageCount = row
        //stackViewSetupUI(with: selectedImageCount)
    }
}

extension CoffeeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coffeCups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeViewCell.identifier, for: indexPath) as! CoffeeViewCell
        cell.imageView.image = coffeCups[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 5 - 10
        let height = collectionView.frame.height / 5 + 30
        return CGSize(width: width, height: height)
    }
}
