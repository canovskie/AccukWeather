import SwiftUI
import CoreLocation

struct TodayTabView: View {
    @StateObject var viewModel = TodayTabViewModel()
    var body: some View {
        Group {
           
                VStack {
                    if let placemark = viewModel.locationManager.userPlacemark {
                        Text("Konum: \(placemark.locality ?? "Bilinmiyor"), \(placemark.country ?? "Bilinmiyor")")
                            .padding()
                    }
                    Image("\(viewModel.weatherImageName)")
                    Text("Temperature: \(viewModel.temperature)")
                    Text("Description: \(viewModel.weatherData?.weather?.first?.description ?? "N/A")")
                    Text("Main: \(viewModel.weatherData?.weather?.first?.main ?? "N/A")")
                    Text("Humidity: \(viewModel.weatherData?.main?.humidity ?? 0)%")
                    Text("Prericipation: \(viewModel.calculateDailyRainfall()) mm")
                    Text("Rüzgar Hızı: \(viewModel.weatherData?.wind?.speed ?? 0, specifier: "%.2f") m/s")
                }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}


struct TodayTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
