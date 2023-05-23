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
    let distance: [String] = ["5 miles", "10 miles", "25 miles"]
    
    let foodPickerView = PickerView(tag: 0)
    let distancePickerView = PickerView(tag: 1)
    
    let stackView = UIStackView()
    
    var currentLocation: CLLocation? = nil
    var selectedDistance: Int = 5
    var selectedDistanceMeters = 0
    var selectedFood = "Mexican"
    
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
        
        distancePickerView.delegate = self
        distancePickerView.dataSource = self
    }
    
    @objc func pickMeal () {
        switch selectedDistance {
        case 5:
            selectedDistanceMeters = 8046
        case 10:
            selectedDistanceMeters = 16093
        case 25:
            selectedDistanceMeters = 40233
        default:
            selectedDistanceMeters = 8046
        }

        
    }
    
}

//MARK: - PickerView Delegate/Data Source
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 && pickerView.tag == 1 {
            return "Within:"
        } else {
            if pickerView.tag == 0 {
                return typesOfFood[row]
            } else {
                return distance[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 && pickerView.tag == 1 {
            return 1
        } else {
            if pickerView.tag == 0 {
                return typesOfFood.count
            } else {
                return distance.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if component == 1 {
                switch row {
                case 0:
                    selectedDistance = 5
                case 1:
                    selectedDistance = 10
                case 2:
                    selectedDistance = 25
                default:
                    return
                }
            }
        } else if pickerView.tag == 0 {
            switch row {
            case 0:
                selectedFood = "Mexican"
            case 1:
                selectedFood = "American"
            case 2:
                selectedFood = "Asian"
            case 3:
                selectedFood = "Italian"
            case 4:
                selectedFood = "Greek"
            case 5:
                selectedFood = "Indian"
            default:
                return
            }
        }
    }
    
}

//MARK: - Location Manager Delegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            createAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
//
//    func requestAllowLocationOnce () {
//        locationManager.requestLocation()
//    }
    
    func createAlert () {
        let alert = UIAlertController(title: "Location Services Not Allowed", message: "Location services have been blocked for this app. To allow location service go to Settings>TempRestaurantAppName>Location> While Using the App ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Configuring Views

extension MainViewController {
    
    private func configureViews () {
        
        let mainTitleLabel = TitleLabel()
        
        
        //        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        stackView.addArrangedSubview(mainTitleLabel)
        stackView.addArrangedSubview(foodPickerView)
//        configureDistanceCategoryLabelView()
        stackView.addArrangedSubview(distancePickerView)
        configureSitOrGoSegControlView()
        configureDinnerButtonView()
    }
    
    func configureDinnerButtonView () {
        
        let pickMealButton = PickMealButton()
      
        stackView.addArrangedSubview(pickMealButton)
        
//        NSLayoutConstraint.activate([
//            pickMealButton.widthAnchor.constraint(equalToConstant: 150)
//        ])
        
        pickMealButton.addTarget(self, action: #selector(pickMeal), for: .touchUpInside)
    }
    
    func configureSitOrGoSegControlView (){
        let items = ["Restaurant", "Fast Food"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
    func configureDistanceCategoryLabelView () {
        let distanceLabel = CategoryLabel(title: "Distance From Me (mi)")
        stackView.addArrangedSubview(distanceLabel)
    }
}

//MARK: - Map Query

extension MainViewController {
//    func mapQuery (){
//        let mapQuery = MKLocalPointsOfInterestRequest(center: currentLocation?.coordinate, radius: <#T##CLLocationDistance#>)
//    }
}

