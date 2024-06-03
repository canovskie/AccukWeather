import SwiftUI

struct TodayFootnoteTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct WeatherInfoCell: View {
    @StateObject var viewModel = TodayViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay(
                        Image("TodayPressure\(viewModel.themeSuffix)")
                    )
                Text("\(viewModel.weatherData?.main?.pressure ?? 0)")
                Text("Pressure")
                    .modifier(TodayFootnoteTextStyle())
            }.padding()
            
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay(
                        Image("TodayHumidity\(viewModel.themeSuffix)")
                    )
                
                Text("\(viewModel.weatherData?.main?.humidity ?? 0)%")
                Text("Humidity")
                    .modifier(TodayFootnoteTextStyle())
            }.padding()
            
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay(
                        Image("TodayPrecipitation\(viewModel.themeSuffix)")
                            .scaleEffect(0.8)
                    )
                
                Text("\(viewModel.calculateDailyRainfall(), specifier: "%.2f") mm")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Text("Prericipation")
                    .modifier(TodayFootnoteTextStyle())
                
            }.padding()
            
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay(
                        Image("TodayWindSpeed\(viewModel.themeSuffix)")
                    )
                
                Text("\(viewModel.weatherData?.wind?.speed ?? 0, specifier: "%.2f") m/s")
                Text("Wind Speed")
                    .modifier(TodayFootnoteTextStyle())
            }.padding()
        }
    }
}

struct WeatherInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoCell()
    }
}
