import SwiftUI
import CoreLocation

struct TodayTabView: View {
    @StateObject var viewModel = TodayTabViewModel()
    init(){
    }
    var body: some View {
        Group {
            if let weatherData = viewModel.weatherData {
                if isConnectedToInternet() {
                    VStack {
                        
                        if let placemark = viewModel.locationManager.userPlacemark {
                            Text("Konum: \(placemark.locality ?? "Bilinmiyor"), \(placemark.country ?? "Bilinmiyor")")
                                .padding()
                        }
                        Text("Temperature: \(viewModel.temperatureInCelsius)")
                        Text("Description: \(weatherData.weather?.first?.description ?? "N/A")")
                        Text("Humidity: \(weatherData.main?.humidity ?? 0)%")
                        Text("Prericipation: \(viewModel.calculateDailyRainfall()) mm")
                        Text("Rüzgar Hızı: \(weatherData.wind?.speed ?? 0, specifier: "%.2f") m/s")
                        
                    }
                }
            } else {
                Text("Please Connect to Internet.")
            }
        }.onAppear(){viewModel.fetchData()}
    }
}

struct TodayTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

