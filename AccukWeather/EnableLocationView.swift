import SwiftUI

struct EnableLocationView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        Button(action: {
            locationManager.requestWhenInUseAuthorization()
        }) {
            Text("Enable Location")
        }
    }
    
    
}

#Preview {
    EnableLocationView()
}
