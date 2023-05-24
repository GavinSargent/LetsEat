//
//  ResultViewController.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/23/23.
//

import UIKit

class ResultViewController: UIViewController {
    var restaurantName = ""
    var restaurantNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
//        restaurantName = (MainViewController.locationManager.randomRestaurant?.name)!
        
        configureResultView()
    }
    
    func configureResultView(){
        
        let nameLabel = ResultInfoLabel(name: restaurantName)
        let phoneLabel = ResultInfoLabel(number: restaurantNumber)
        let takeMeThereButton = TakeMeThereButton()
        
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(takeMeThereButton)
        
        NSLayoutConstraint.activate([
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: phoneLabel.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            takeMeThereButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: -15),
            takeMeThereButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            takeMeThereButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
}

