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
    let pricePickerView = PickerView(tag: 1)
    
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
        
        let mainTitleLabel = TitleLabel()
        
        
//        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
 
        stackView.addArrangedSubview(mainTitleLabel)
        stackView.addArrangedSubview(foodPickerView)
        stackView.addArrangedSubview(pricePickerView)
        
        configureSitOrGoButtonViews()
        configureDinnerButtonView()
    }
    
    func configureDinnerButtonView () {
        
        let pickDinnerButton = PickDinnerButton()
        let buttonView = UIView()
        
        stackView.addArrangedSubview(buttonView)

        buttonView.addSubview(pickDinnerButton)
        
        NSLayoutConstraint.activate([
            pickDinnerButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            pickDinnerButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
        ])
    }
    
    func configureSitOrGoButtonViews (){
        let buttonStackView = UIStackView()
        
        buttonStackView.distribution = .fillEqually
        
        let restaurantButton = RestaurantOrFastFood(title: "Restaurant")
        let fastFoodButton = RestaurantOrFastFood(title: "Fast Food")
        
        buttonStackView.addArrangedSubview(fastFoodButton)
        buttonStackView.addArrangedSubview(restaurantButton)
        
        stackView.addArrangedSubview(buttonStackView)

    }

    
}

//MARK: - PickerView Delegate/Data Source
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return typesOfFood[row]
        } else{
            return price[row]
        }
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
