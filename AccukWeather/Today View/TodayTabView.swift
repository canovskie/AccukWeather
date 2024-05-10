import SwiftUI
import CoreLocation

struct TodayTabView: View {
    @StateObject var viewModel = TodayTabViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: viewModel.gradientColors()), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TodayInfoCell()
                WeatherInfoCell()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct TodayTabView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTabView()
    }
}
