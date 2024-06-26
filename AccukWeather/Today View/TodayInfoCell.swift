//
//  TodayInfoCell.swift
//  AccukWeather
//
//  Created by Can on 10.05.2024.
//

import SwiftUI

struct TodayInfoCell: View {
    @StateObject var viewModel = TodayViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text("\(viewModel.weatherData?.weather?.first?.main ?? "N/A")")
                .font(.system(size: 72))
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)

            Image("\(viewModel.weatherImageName)-Dark")
                .scaleEffect(1.5)
                .aspectRatio(contentMode: .fit)
                .padding(.bottom)

            Text("\(viewModel.temperature)")
                .fontWeight(.bold)
                .font(.title)
            
            if let placemark = viewModel.locationManager.userPlacemark {
                Text("\(placemark.locality ?? "Bilinmiyor"), \(placemark.country ?? "Bilinmiyor")")
                    .font(.footnote)
                    .foregroundStyle(viewModel.isNightTime() ? .gray : .black)
            }
            Divider()
                .padding()
        }
        .padding()
    }
}

#Preview {
    TodayInfoCell(
        viewModel: TodayViewModel(weatherService: WeatherServiceMocker())
    )
}
