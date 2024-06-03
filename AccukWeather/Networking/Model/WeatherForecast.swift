//
//  WeatherForecast.swift
//  AccukWeather
//
//  Created by Can on 17.05.2024.
//

import Foundation


struct WeatherForecast: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}

struct ForecastItem: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

extension WeatherForecast {
    static func mock() -> WeatherForecast {
        let coord = Coord(lon: -0.13, lat: 51.51)
        let weather = Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        let main = Main(temp: 15.0, feels_like: 14.0, temp_min: 13.0, temp_max: 16.0, pressure: 1012, humidity: 77, sea_level: 1012, grnd_level: 1008)
        let wind = Wind(speed: 3.5, deg: 200, gust: 5.0)
        let clouds = Clouds(all: 10)
        let rain = Rain(oneHour: 0.0)
        let sys = Sys(type: 1, id: 1414, country: "GB", sunrise: 1638433868, sunset: 1638478668)
        
        let forecastItem = ForecastItem(
            dt: 1638470434,
            main: main,
            weather: [weather],
            clouds: clouds,
            wind: wind,
            visibility: 10000,
            pop: 0.1,
            rain: rain,
            sys: sys,
            dtTxt: "2023-05-17 12:00:00"
        )

        let city = City(id: 2643743, name: "London", coord: coord, country: "GB", population: 8787892, timezone: 0, sunrise: 1638433868, sunset: 1638478668)
        
        let weatherForecast = WeatherForecast(cod: "200", message: 0.0, cnt: 1, list: [forecastItem], city: city)
        
        return weatherForecast
    }
}
extension ForecastItem {
    static func mock() -> ForecastItem {
        WeatherForecast.mock().list.first!
    }
}

