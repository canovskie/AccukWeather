import SwiftUI

class TodayTabViewModel: ObservableObject {
    @ObservedObject var locationManager = LocationManager()
    @Published var weatherData: WeatherResponse?
    @Published var coord: Coord?
    @Published var isRainLoaded = false
    
    func fetchData() {
        guard let userLocation = locationManager.userLocation else {
            print("User location not available.")
            return
        }
        
        coord = Coord(lon: userLocation.coordinate.longitude, lat: userLocation.coordinate.latitude)
        
        if let coord = coord {
            let apiKey = "3967467e559273a99c41b5f88e60238b"
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coord.lat ?? 0)&lon=\(coord.lon ?? 0)&appid=\(apiKey)"
            
            NetworkingManager.shared.fetchData(from: urlString) { (result: Result<WeatherResponse, NetworkError>) in
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
    }

    var temperatureInCelsius: String {
        if let temperatureKelvin = weatherData?.main?.temp {
            let temperatureCelsius = temperatureKelvin - 273.15
            return String(format: "%.1f°C", temperatureCelsius)
        } else {
            return "N/A"
        }
    }

    func calculateDailyRainfall() -> Double {
        guard let hourlyRainfall = weatherData?.rain?.oneHour else {
            return 0
        }
        return hourlyRainfall * 24
    }
}
