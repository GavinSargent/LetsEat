//
//  PickerViewManager.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/24/23.
//

import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
//    static let sharedLM = LocationManager()
    
    var selectedDistance: Int = 5
    var selectedDistanceMeters: Double = 4046.00
    var selectedFood = "Mexican"
    var selectedSitOrGo = "Restaurant"
    var randomRestaurant: MKMapItem? = nil

    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // creates the location from the users last updated location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // makes sure the user has allowed location services
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            break
//            self.mainViewController.createLocationAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}

//MARK: - Map Query
extension LocationManager {
    
    //queries the Apple Map to find a restaurant based on inputted criteria
    
    func mapQuery (completionHandler: @escaping (Result<[MKMapItem], Error>) -> Void){

        let pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.restaurant])
        let searchRequest = MKLocalSearch.Request()
        searchRequest.pointOfInterestFilter = pointOfInterestFilter
        searchRequest.naturalLanguageQuery = "\(selectedFood), \(selectedSitOrGo)"
        
        searchRequest.region = createRegion()
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            if response.mapItems.count > 0 {
                completionHandler(.success(response.mapItems))
            } else {
                completionHandler(.failure(error!))
                return
            }
        }
    }
      
// Make the location based off of phone current location
    
    func createRegion () -> MKCoordinateRegion{
        let center = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: selectedDistanceMeters, longitudinalMeters: selectedDistanceMeters)
        
        return region
    }

}



