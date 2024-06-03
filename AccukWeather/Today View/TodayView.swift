import SwiftUI
import CoreLocation

struct TodayView: View {
    @StateObject var viewModel = TodayViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: viewModel.gradientColors()), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TodayInfoCell()
                WeatherInfoCell()
            }.foregroundColor(viewModel.isNightTime() ? .white : .black)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct TodayTabView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
