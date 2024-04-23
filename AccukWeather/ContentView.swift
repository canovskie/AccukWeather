import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            TodayTabView()
                .tabItem {
                    Image("ic_today")
                    Text("Today")
                }
            ForecastTabView()
                .tabItem {
                    Image("ic_forecast")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
