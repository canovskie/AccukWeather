//
//  ForecastService.swift
//  AccukWeather
//
//  Created by Furkan Kaynar on 11.05.24.
//

import Foundation

protocol WeatherServiceProtocol {
    func getToday(coordinates: Coord,
                     completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
    func getForecast(coordinates: Coord,
                     completion: @escaping (Result<WeatherForecast, NetworkError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    func getToday(coordinates: Coord,
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
    
    func getForecast(coordinates: Coord,
                     completion: @escaping (Result<WeatherForecast, NetworkError>) -> Void) {
        guard let lat = coordinates.lat,
              let lon = coordinates.lon else {
                  return
              }

        let url = ForecastRouter.getForecast(lat: String(lat), lon: String(lon)).fullUrl
        NetworkingManager.shared.fetchData(from: url,
                                           httpMethod: "GET",
                                           completion: completion)
    }
}

class WeatherServiceMocker: WeatherServiceProtocol {
    func getToday(coordinates: Coord, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        completion(.success(WeatherResponse.mock()))
    }
    func getForecast(coordinates: Coord, completion: @escaping (Result<WeatherForecast, NetworkError>) -> Void) {
        completion(.success(WeatherForecast.mock()))
    }
}
