import SwiftUI

class TodayViewModel: ObservableObject {
    @ObservedObject var locationManager: LocationManager
    private let weatherService: WeatherServiceProtocol
    @Published var weatherData: WeatherResponse? {
        didSet {
            showWeatherImage()
            updateThemeSuffix()
        }
    }
    @Published var isRainLoaded = false
    @Published var shouldShowNotConnected: Bool = false
    @Published var weatherImageName: String
    @Published var themeSuffix: String
    
    
    var temperature: String {
        if let temperature = weatherData?.main?.temp {
            return String(format: "%.0f°C", temperature)
        } else {
            return "N/A"
        }
    }
    
    init(locationManager: LocationManager = LocationManager(),
         weatherData: WeatherResponse? = nil,
         weatherService: WeatherServiceProtocol = WeatherService(),
         isRainLoaded: Bool = false) {
        self.locationManager = locationManager
        self.weatherData = weatherData
        self.weatherService = weatherService
        self.isRainLoaded = isRainLoaded
        weatherImageName = ""
        themeSuffix = "-Light"
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
        
        weatherService.getToday(coordinates: coord) { (result: Result<WeatherResponse, NetworkError>) in
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
    
    func calculateDailyRainfall() -> Double {
        guard let hourlyRainfall = weatherData?.rain?.oneHour else {
            return 0
        }
        return hourlyRainfall * 24
    }
    
    func isNightTime() -> Bool {
        guard let sunrise = weatherData?.sys?.sunrise,
              let sunset = weatherData?.sys?.sunset,
              let currentTime = weatherData?.dt else {
            return false
        }
        return currentTime < sunrise || currentTime > sunset
    }
    
    private func updateThemeSuffix() {
        themeSuffix = isNightTime() ? "-Dark" : "-Light"
    }
    
    func gradientColors() -> [Color] {
        if isNightTime() {
            return [.blue, .black]

        } else {
            return [.blue, .white, .white]

        }
    }
}

extension TodayViewModel: LocationManagerDelegate {
    func didUpdateLocation() {
        fetchData()
        showWeatherImage()
    }
}
