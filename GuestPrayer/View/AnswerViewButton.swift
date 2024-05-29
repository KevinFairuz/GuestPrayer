import SwiftUI

struct AnswerButtonsView: View {
    @ObservedObject var viewModel: StageIndicatorViewModel
    @ObservedObject var answerViewModel: AnswerViewModel
    @Binding var selectedAnswer: Answer?
    var answerAction: (Answer) -> Void

    var body: some View {
        VStack {
            ForEach(0..<2) { row in
                HStack {
                    ForEach(answerViewModel.answers.prefix(4).indices.dropFirst(row * 2).prefix(2), id: \.self) { index in
                        VStack(alignment: .leading) {
                            Button(action: {
                                answerAction(answerViewModel.answers[index])
                            }) {
                                Text(answerViewModel.answers[index].text)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(answerButtonColor(for: answerViewModel.answers[index])) // Menggunakan fungsi answerButtonColor
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                            .disabled(viewModel.questionAnswered)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }

    func answerButtonColor(for answer: Answer) -> Color {
        if let selectedAnswer = viewModel.selectedAnswer {
            if viewModel.questionAnswered && answer.id == selectedAnswer.id {
                return selectedAnswer.isCorrect ? Color.green : Color.red
            }
        }
        return Color(hex: 0x187C89)
    }
}

