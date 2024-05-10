//
//  ForecastService.swift
//  AccukWeather
//
//  Created by Furkan Kaynar on 11.05.24.
//

import Foundation

protocol ForecastServiceProtocol {
    func getForecast(coordinates: Coord,
                     completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
}

class ForecastService: ForecastServiceProtocol {
    func getForecast(coordinates: Coord,
                     completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let lat = coordinates.lat,
              let lon = coordinates.lon else {
                  return
              }
        
        let url = ForecastRouter.getWeather(lat: String(lat), lon: String(lon)).fullUrl
        NetworkingManager.shared.fetchData(from: url,
                                           httpMethod: "GET",
                                           completion: completion)
    }
}

class ForecastServiceMocker: ForecastServiceProtocol {
    func getForecast(coordinates: Coord, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        completion(.success(WeatherResponse.mock()))
    }
}
