//
//  ForecastRouter.swift
//  AccukWeather
//
//  Created by Furkan Kaynar on 10.05.24.
//

import Foundation

enum ForecastRouter {
    case getWeather(lat: String, lon: String)
    case getForecast(lat: String, lon: String)
    
    var fullUrl: String {
        switch self {
        case .getWeather(let lat, let lon):
            return "\(AppConstants.baseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(AppConstants.apiKey)&units=metric"
            
        case .getForecast(let lat,let lon):
            return "\(AppConstants.baseURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(AppConstants.apiKey)&units=metric"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getWeather:
            return "GET"
        case .getForecast:
            return "GET"
        }
    }
}
