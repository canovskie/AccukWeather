import SwiftUI

class ForecastViewModel: ObservableObject {
    @ObservedObject var locationManager: LocationManager
    private let weatherService: WeatherServiceProtocol
    @Published var weatherData: WeatherForecast?
    @Published var shouldShowNotConnected: Bool = false
    @Published var forecastItem: ForecastItem?
    
    
    init(locationManager: LocationManager = LocationManager(),
         weatherData: WeatherForecast? = nil,
         weatherService: WeatherServiceProtocol = WeatherService()) {
        self.locationManager = locationManager
        self.weatherData = weatherData
        self.weatherService = weatherService
        self.forecastItem = forecastItem
        locationManager.delegate = self
    }

    
    
    

    func onAppear() {
        checkInternetConnection()
        fetchData()
    }
    
    
    
    private func fetchData() {
        guard let userLocation = locationManager.userLocation else {
            print("User location not available.")
            return
        }
        
        let coord = Coord(lon: userLocation.coordinate.longitude,
                          lat: userLocation.coordinate.latitude)
        
        weatherService.getForecast(coordinates: coord) { (result: Result<WeatherForecast, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherData = data
                }
                
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    private func checkInternetConnection() {
        shouldShowNotConnected = !NetworkMonitor.isConnectedToInternet()
    }
}

extension ForecastViewModel: LocationManagerDelegate {
    func didUpdateLocation() {
        fetchData()
    }
}
