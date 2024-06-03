//
//  ForecastDailyCell.swift
//  AccukWeather
//
//  Created by Can on 17.05.2024.
//

import SwiftUI

struct ForecastDailyCell: View {
    let forecastItem: ForecastItem
    var time: Double
    
    var temperature: String {
        if let temperature = forecastItem.main.temp {
            return String(format: "%.0f°C", temperature)
        } else {
            return "N/A"
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: weatherIcon(for: forecastItem.weather.first?.main ?? ""))
                .font(.title)
                .padding()
            
            VStack(alignment: .leading) {
                Text("\(forecastItem.weather.first?.description.capitalized ?? "")")
                    .font(.title2)
                Text(String(format: "%.2f", time))
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("\(temperature)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .padding()
        .background(Color.secondary.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private func weatherIcon(for condition: String) -> String {
        switch condition {
        case "Clear":
            return "sun.max.fill"
        case "Clouds":
            return "cloud.fill"
        case "Rain":
            return "cloud.rain.fill"
        case "Thunderstorm":
            return "cloud.bolt.fill"
        case "Snow":
            return "snow"
        case "Mist":
            return "cloud.fog.fill"
        default:
            return "questionmark"
        }
    }
}

#Preview {
    ForecastDailyCell(forecastItem: .mock(), time: 0)
}

