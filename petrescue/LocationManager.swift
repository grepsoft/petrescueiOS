//
//  LocationManager.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-21.
//

import Foundation
import CoreLocation
import Combine

struct LatLong: Codable {
    let lat: Double
    let long: Double
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    var userLatitude: Double {
        return self.lastLocation?.coordinate.latitude ?? 0.0
    }
    
    var userLongitude: Double {
        return self.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    func latLong()-> LatLong {
        return LatLong(lat: userLatitude, long: userLongitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        logger.debug("\(self.statusString)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        //logger.debug("\(location)")
    }
}
