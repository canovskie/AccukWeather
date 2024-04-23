import SwiftUI
struct AnimatedGradientView: View {
    @State private var colors: [Color] = [.white, .blue]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .topTrailing)
            .animation(Animation.easeInOut(duration: 2).repeatForever())
            .onAppear {
                self.colors = [.blue, .white]
            }
    }
}
struct ForecastTabView: View {
    var body: some View {
        AnimatedGradientView()
            .edgesIgnoringSafeArea(.all)

    }
}
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastTabView()
    }
}
