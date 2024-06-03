//
//  ForecastView.swift
//  AccukWeather
//
//  Created by Can on 10.05.2024.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel = ForecastViewModel()
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            VStack {
    
                if let weatherData = viewModel.weatherData {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(weatherData.city.name), \(weatherData.city.country)")
                                .font(.headline)
                            Spacer()
                            Text("Population: \(weatherData.city.population)")
                                .font(.subheadline)
                        }
                        .padding()
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Button("Today"){
                                    
                                }.font(.title)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 2.0)
                                        .onEnded { _ in
                                            self.isActive = true
                        
                                        }
                                )
                                
                                NavigationLink(destination: SutlacView(), isActive: $isActive) {
                                    EmptyView()
                                }
                                    
                                
                                ForEach(Array(weatherData.list.prefix(8).enumerated()), id: \.element.dt) { index, forecastItem in
                                    ForecastDailyCell(forecastItem: forecastItem, time: Double(index * 3))
                                }
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("Tomorrow")
                                    .font(.title)
                                    .padding(.horizontal)
                                
                                ForEach(Array(weatherData.list.dropFirst(8).prefix(8).enumerated()), id: \.element.dt) { index, forecastItem in
                                    ForecastDailyCell(forecastItem: forecastItem, time: Double(index * 3))
                                }
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("3 Days Later")
                                    .font(.title)
                                    .padding(.horizontal)
                                
                                ForEach(Array(weatherData.list.dropFirst(16).prefix(8).enumerated()), id: \.element.dt) { index, forecastItem in
                                    ForecastDailyCell(forecastItem: forecastItem, time: Double(index * 3))
                                }
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("4 Days Later")
                                    .font(.title)
                                    .padding(.horizontal)
                                
                                ForEach(Array(weatherData.list.dropFirst(24).prefix(8).enumerated()), id: \.element.dt) { index, forecastItem in
                                    ForecastDailyCell(forecastItem: forecastItem, time: Double(index * 3))
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                } else {
                    if viewModel.shouldShowNotConnected {
                        Text("No internet connection.")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        Text("Loading...")
                            .font(.headline)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    ForecastView()
}
