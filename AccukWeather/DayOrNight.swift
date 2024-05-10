import SwiftUI

enum Theme {
    case light
    case dark
    
    // Tema rengine göre metin rengini döndüren hesaplanmış bir özellik
    var textColor: Color {
        switch self {
        case .light:
            return Color.black
        case .dark:
            return Color.white
        }
    }
    
    // Tema rengine göre arka plan gradyan renklerini döndüren işlev
    func gradientColors() -> [Color] {
        switch self {
        case .light:
            return [.blue, .white]
        case .dark:
            return [.blue, .black]
        }
    }
    
    // Mevcut zamanın gece zamanında olup olmadığını kontrol eden işlev
    func isNightTime(sunrise: Double, sunset: Double, currentTime: Double) -> Bool {
        switch self {
        case .light:
            return currentTime < sunrise || currentTime > sunset
        case .dark:
            return false // Dark temada her zaman gece olacak şeklinde varsayıyoruz
        }
    }
}
