import SwiftUI

struct StageIndicatorView: View {
    @ObservedObject var viewModel: StageIndicatorViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Circle()
                    .fill(viewModel.indicatorColor(for: index))
                    .frame(width: 60, height: 60)
                if index <= 3 {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 15, height: 10)
                }
            }
        }
        .padding(.top, 40)
        
        
    }
    

}

struct TimerProgressView: View {
    @Binding var timerProgress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color(hex: 0x187C89))
                .frame(width: geometry.size.width * timerProgress, height: 10)
        }
        .frame(height: 10)
        .padding(.horizontal)
    }
}

struct NextPageButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Next Page")
                .frame(width: 200)
                .padding()
                .background(Color(hex: 0x011E37))
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.title2)
        }
    }
}
