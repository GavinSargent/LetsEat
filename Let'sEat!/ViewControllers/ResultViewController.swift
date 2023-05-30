//
//  ResultViewController.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/23/23.
//

import UIKit
import MapKit

class ResultViewController: UIViewController {
    var restaurantName = ""
    var restaurantNumber = ""
    var selectedRestaurant: MKMapItem? = nil
    
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
            phoneLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            phoneLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            nameLabel.bottomAnchor.constraint(equalTo: phoneLabel.topAnchor, constant: -15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            takeMeThereButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 60),
            takeMeThereButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takeMeThereButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        nameLabel.sizeToFit()
        phoneLabel.sizeToFit()
        takeMeThereButton.addTarget(self, action: #selector(takeMeThere), for: .touchUpInside)
    }
    
    @objc func takeMeThere () {
        selectedRestaurant?.openInMaps()
    }
}

