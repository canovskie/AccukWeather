import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            TodayTabView()
                .tabItem {
                    Image("TabBarToday-Light")
                    Text("Today")
                }
            ForecastView()
                .tabItem {
                    Image("TabBarForecast-Dark")
                    Text("Forecast")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
