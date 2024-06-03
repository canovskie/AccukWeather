import SwiftUI

extension TodayViewModel {
    
    func showWeatherImage() {
        guard let weatherMain = weatherData?.weather?.first?.main else {
            weatherImageName = "ic_cloud"
            return
        }
        
        switch weatherMain {
        case "Thunderstorm":
            weatherImageName = "TodayThunderstorm"
        case "Drizzle":
            weatherImageName = "TodayShowers"
        case "Snow":
            weatherImageName = "TodaySnow"
        case "Clear":
            weatherImageName = isNightTime() ? "TodayMoon" : "TodaySun"
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
            weatherImageName = "TodayMist"
        case "Rain":
            if let rainType = weatherData?.weather?.first?.description {
                switch rainType {
                case "light rain","moderate rain", "heavy instensity rain", "very heavy rain", "extreme rain":
                    weatherImageName = "TodayRain"
                case "freezing rain":
                    weatherImageName = "TodaySnow"
                case "light intensity shower rain", "shower rain", "heavy intensity shower rain", "ragged shower rain":
                    weatherImageName = "TodayShowers"
                default: weatherImageName = "TodayRain"
                }
            }
        case "Clouds":
            if let cloudType = weatherData?.weather?.first?.description {
                switch cloudType {
                case "few clouds":
                    weatherImageName = isNightTime() ? "TodayFewCloudsMoon" : "TodayFewCloudsSun"
                case "scattered clouds":
                    weatherImageName = "TodayBrokenClouds"
                default: weatherImageName = "TodayCloudy"
                }
            }
        default:
            weatherImageName = "ic_sun"
        }
    }
}
