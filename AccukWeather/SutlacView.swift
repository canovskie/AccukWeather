import SwiftUI

struct SutlacView: View {
    @State private var isCooking: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Sütlaç Tarifi")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Malzemeler:")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("1 su bardağı pirinç")
                        .foregroundColor(.white)
                    Text("1 litre süt")
                        .foregroundColor(.white)
                    Text("1 su bardağı toz şeker")
                        .foregroundColor(.white)
                    Text("1 çay kaşığı vanilya özütü")
                        .foregroundColor(.white)
                    Text("Tarçın (isteğe bağlı)")
                        .foregroundColor(.white)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Yapılış:")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("1. Pirinci yıkayın ve süzün.")
                        .foregroundColor(.white)
                    Text("2. Bir tencereye pirinci ve sütü ekleyin, kaynatın.")
                        .foregroundColor(.white)
                    Text("3. Kaynadıktan sonra ocağın altını kısın ve ara sıra karıştırarak pirinçler yumuşayana kadar pişirin.")
                        .foregroundColor(.white)
                    Text("4. Şeker ve vanilya özütünü ekleyip karıştırın, 5 dakika daha pişirin.")
                        .foregroundColor(.white)
                    Text("5. Sütlaçı kaselere boşaltın, oda sıcaklığına gelene kadar bekletin.")
                        .foregroundColor(.white)
                    Text("6. İsteğe bağlı olarak üzerine tarçın serperek servis yapın.")
                        .foregroundColor(.white)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        self.isCooking.toggle()
                    }
                }) {
                    Text(self.isCooking ? "Pişirme Durdur" : "Pişirmeye Başla")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding()
                .shadow(radius: 5)
                
                if isCooking {
                    Image(systemName: "flame.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.orange)
                        .padding()
                }
            }
        }
    }
}

struct SynthwaveSutlacRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SutlacView()
    }
}
