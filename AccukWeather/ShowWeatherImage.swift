extension TodayTabViewModel {
    func showWeatherImage() {
        guard let weatherMain = weatherData?.weather?.first?.main else {
            weatherImageName = "ic_cloud"
            return
        }
        
        switch weatherMain {
        case "Thunderstorm":
            weatherImageName = "ic_cloud_lightning"
        case "Drizzle":
            weatherImageName = "ic_rain"
        case "Snow":
            weatherImageName = "ic_snow"
        case "Clear":
            weatherImageName = isNightTime() ? "ic_moon" : "ic_sun"
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
            weatherImageName = "ic_mist"
    
            
        case "Rain":
            if let rainType = weatherData?.weather?.first?.description {
                switch rainType {
                case "light rain","moderate rain", "heavy instensity rain", "very heavy rain", "extreme rain":
                    weatherImageName = "ic_cloud_rain"
                case "freezing rain":
                    weatherImageName = "ic_snow"
                case "light intensity shower rain", "shower rain", "heavy intensity shower rain", "ragged shower rain":
                    weatherImageName = "ic_rain_showers"
                default: weatherImageName = "ic_cloud_rain"
                }
            }
            
        case "Clouds":
            if let cloudType = weatherData?.weather?.first?.description {
                switch cloudType {
                case "few clouds":
                    weatherImageName = isNightTime() ? "ic_few_clouds_n" : "ic_few_clouds_d"
                case "scattered clouds":
                    weatherImageName = "ic_broken_clouds"
                default: weatherImageName = "ic_cloud"
                }
            }
        default:
            weatherImageName = "ic_sun"
        }
        
        
        func isNightTime() -> Bool {
            guard let sunrise = weatherData?.sys?.sunrise,
                  let sunset = weatherData?.sys?.sunset,
                  let currentTime = weatherData?.dt else {
                return false
            }
            return currentTime < sunrise || currentTime > sunset
        }
        
    }
}
