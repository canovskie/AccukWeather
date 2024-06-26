import SwiftUI
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdateLocation()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var userPlacemark: CLPlacemark?
    
    var delegate: LocationManagerDelegate?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
            delegate?.didUpdateLocation()
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Geocode error: \(error.localizedDescription)")
                    return
                }
                guard let placemark = placemarks?.first else {
                    print("Can't Find Location.")
                    return
                }
                self.userPlacemark = placemark
            }
        }
    }
    
    func requestWhenInUseAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
}
