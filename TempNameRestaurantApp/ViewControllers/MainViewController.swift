//
//  ViewController.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/15/23.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    let locationManager = CLLocationManager()
    let typesOfFood: [String] = ["Mexican", "American", "Asian", "Italian", "Greek", "Indian"]
    let price: [String] = ["$", "$$", "$$$", "$$$$"]
    
    let foodPickerView = PickerView(tag: 0)
    let pricePickerView = PickerView(tag: 0)
    
    let titleLabel = TitleLabel()
    let pickDinnerButton = PickDinnerButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureViews()
        
    }
    
    private func configureViewController () {
        locationManager.delegate = self
        
        foodPickerView.delegate = self
        foodPickerView.dataSource = self
        
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
    }
    
    private func configureViews () {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor)
        ])
        
        stackView.addArrangedSubview(foodPickerView)
        
        NSLayoutConstraint.activate([
            foodPickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
        
        
        view.addSubview(stackView)
    }

    
}

//MARK: - PickerView Delegate/Data Source
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return typesOfFood.count
        } else {
            return price.count
        }
    }

}

//MARK: - Location Manager Delegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            //send an alert stating that location services are disabled and how to fix that Setting > General > ...
            break
        case .authorizedWhenInUse, .authorizedAlways:
            //app will be able to function as intended
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

}
