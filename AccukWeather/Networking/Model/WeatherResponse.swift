import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
    let sea_level: Int?
    let grnd_level: Int?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Rain: Codable {
    let oneHour: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

extension WeatherResponse {
    static func mock() -> WeatherResponse {
        let coord = Coord(lon: -0.13, lat: 51.51)
        let weather = Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        let main = Main(temp: 213.34, feels_like: 279.44, temp_min: 281.15, temp_max: 285.37, pressure: 1023, humidity: 76, sea_level: 1023, grnd_level: 1021)
        let wind = Wind(speed: 2.1, deg: 350, gust: nil)
        let clouds = Clouds(all: 0)
        let sys = Sys(type: 2, id: 2019646, country: "GB", sunrise: 1638433868, sunset: 1638478668)

        let weatherResponse = WeatherResponse(coord: coord, weather: [weather], base: "stations", main: main, visibility: 10000, wind: wind, rain: nil, clouds: clouds, dt: 1638470434, sys: sys, timezone: 0, id: 2643743, name: "London", cod: 200)
        return weatherResponse
    }
}
