import SwiftUI

struct ScoreView: View {
    var score: Int

    var body: some View {
        Text("Score: \(score)")
            .font(.title)
            .foregroundColor(.white)
            .padding(.top, 20)
    }
}
