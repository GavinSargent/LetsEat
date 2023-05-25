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
    
    let locationManager = LocationManager()
    
    let foodPickerView = PickerView(tag: 0)
    let distancePickerView = PickerView(tag: 1)
    
    let stackView = UIStackView()
    
    var restaurantName = ""
    var restaurantNumber = ""
    var selectedRestaurant: MKMapItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureViewController()
        configureViews()
    }

    
    private func configureViewController () {
        
        
        foodPickerView.delegate = self
        foodPickerView.dataSource = self
        
        distancePickerView.delegate = self
        distancePickerView.dataSource = self
    }
    
    @objc func pickMeal () {

        
        locationManager.mapQuery(){ result in
            switch result {
            case .success(let restaurants):
                let randomRestaurant =  restaurants.randomElement()
                self.selectedRestaurant = randomRestaurant
                self.restaurantName = (randomRestaurant?.name)!
                self.restaurantNumber = (randomRestaurant?.phoneNumber)!
                self.beginResultViewController()
            case .failure(_):
                self.createNoResultAlert()
            }
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
                return Constants.typesOfFood[row]
            } else {
                return Constants.distance[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 && pickerView.tag == 1 {
            return 1
        } else {
            if pickerView.tag == 0 {
                return Constants.typesOfFood.count
            } else {
                return Constants.distance.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if component == 1 {
                switch row {
                case 0:
                    locationManager.selectedDistance = 5
                    locationManager.selectedDistanceMeters = 4046.00
                case 1:
                    locationManager.selectedDistance = 10
                    locationManager.selectedDistanceMeters = 16093
                case 2:
                    locationManager.selectedDistance = 25
                    locationManager.selectedDistanceMeters = 40233.00
                default:
                    return
                }
            }
        } else if pickerView.tag == 0 {
            switch row {
            case 0:
                locationManager.selectedFood = "Mexican"
            case 1:
                locationManager.selectedFood = "American"
            case 2:
                locationManager.selectedFood = "Asian"
            case 3:
                locationManager.selectedFood = "Italian"
            case 4:
                locationManager.selectedFood = "Greek"
            case 5:
                locationManager.selectedFood = "Indian"
            default:
                return
            }
        }
    }
    
}

//MARK: - Configuring Views

extension MainViewController {
    
    private func configureViews () {
        
        let mainTitleLabel = TitleLabel()
        
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
        stackView.addArrangedSubview(distancePickerView)
        configureSitOrGoSegControlView()
        configureDinnerButtonView()
    }
    
    func configureDinnerButtonView () {
        
        let pickMealButton = PickMealButton()
      
        stackView.addArrangedSubview(pickMealButton)
        
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
        
        segmentedControl.addTarget(self, action: #selector(sitOrGoControlDidChange(_:)), for: .valueChanged)
    }
    
    @objc func sitOrGoControlDidChange (_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            locationManager.selectedSitOrGo = "Restaurant"
        case 1:
            locationManager.selectedSitOrGo = "Fast Food"
        default:
            locationManager.selectedSitOrGo = "Restaurant"
        }
    }
    
    func beginResultViewController () {
        let resultScreen = ResultViewController()
        resultScreen.restaurantName = restaurantName
        resultScreen.restaurantNumber = restaurantNumber
        resultScreen.selectedRestaurant = selectedRestaurant!
        navigationController?.pushViewController(resultScreen, animated: true)
    }
}

//MARK: - Alerts
extension MainViewController {
    public func createLocationAlert () {
        let alert = UIAlertController(title: "Location Services Not Allowed", message: "Location services have been blocked for this app. To allow location service go to Settings>TempRestaurantAppName>Location> While Using the App ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    public func createNoResultAlert () {
        let alert = UIAlertController(title: "No Restaurants Found", message: "No restaurants matching your search could be found. Try changing one or more of the fields and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
