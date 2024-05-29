import SwiftUI

struct QuestionTextView: View {
    var body: some View {
        Text("What is the correct answer?")
            .font(.title)
            .padding()
            .foregroundColor(.white)
    }
}

struct TimerProgress: View {
    @Binding var timerProgress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.blue)
                .frame(width: geometry.size.width * timerProgress, height: 10)
        }
        .frame(height: 10)
        .padding(.horizontal)
    }
}
