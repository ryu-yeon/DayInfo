//
//  LocationHelper.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/07.
//

import Foundation
import CoreLocation
import Combine

final class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let pass = PassthroughSubject<(Double, Double), Never>()
    
    @Published var manager =  CLLocationManager()
    
    override init() {
        super.init()
        self.configureLocationManger()
    }
    
    func configureLocationManger() {
        manager.delegate = self
        
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation: CLLocation = locations.first else { return }
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        pass.send((latitude, longitude))
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
