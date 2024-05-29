import SwiftUI
import Lottie

struct TotalScoreView: View {
    let score: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var animationView = LottieAnimationView(name: "finish")

    var body: some View {
        VStack {

            Text("Total Score: \(score)")
                .font(.largeTitle)
                .padding()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Home")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
