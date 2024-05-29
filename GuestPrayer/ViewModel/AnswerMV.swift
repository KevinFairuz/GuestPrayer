import SwiftUI

class AnswerViewModel: ObservableObject {
    @Published var answers: [Answer] = []
    @Published var selectedAnswer: Answer?
    var currentQuestionIndex = 0
    
    func loadAnswers(for stage: Int, stageType: StageType) {
        // Example data, replace with actual data loading logic
        if stageType == .lafadz {
            switch currentQuestionIndex {
            case 0:
                answers = [
                    Answer(text: "Tasbih", isCorrect: true ),
                    Answer(text: "Tahsin", isCorrect: false),
                    Answer(text: "Takbir", isCorrect: false),
                    Answer(text: "Ta'awudz", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 1:
                answers = [
                    Answer(text: "Tahmid", isCorrect: true),
                    Answer(text: "Tawasul", isCorrect: false),
                    Answer(text: "Takbir", isCorrect: false),
                    Answer(text: "Tahlil", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 2:
                answers = [
                    Answer(text: "Takbir", isCorrect: true),
                    Answer(text: "Tawasul", isCorrect: false),
                    Answer(text: "Tasbih", isCorrect: false),
                    Answer(text: "Tahmid", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 3:
                answers = [
                    Answer(text: "Tahlil", isCorrect: true),
                    Answer(text: "Tasbih", isCorrect: false),
                    Answer(text: "Tahmid", isCorrect: false),
                    Answer(text: "Tawasul", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 4:
                answers = [
                    Answer(text: "Istighfar", isCorrect: true),
                    Answer(text: "Dzikir", isCorrect: false),
                    Answer(text: "Tauhid", isCorrect: false),
                    Answer(text: "Tasbih", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            default:
                break
            }
        }
        else if stageType == .sholawat {
            switch currentQuestionIndex {
            case 0:
                answers = [
                    Answer(text: "Sholawat Tibbil Qulub", isCorrect: true),
                    Answer(text: "Sholawat Nariyah", isCorrect: false),
                    Answer(text: "Sholawat Jibril", isCorrect: false),
                    Answer(text: "Sholawat ", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 1:
                answers = [
                    Answer(text: "Correct Answer", isCorrect: true),
                    Answer(text: "Wrong Answer 1", isCorrect: false),
                    Answer(text: "Wrong Answer 2", isCorrect: false),
                    Answer(text: "Wrong Answer 3", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 2:
                answers = [
                    Answer(text: "Correct Answer", isCorrect: true),
                    Answer(text: "Wrong Answer 1", isCorrect: false),
                    Answer(text: "Wrong Answer 2", isCorrect: false),
                    Answer(text: "Wrong Answer 3", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 3:
                answers = [
                    Answer(text: "Correct Answer", isCorrect: true),
                    Answer(text: "Wrong Answer 1", isCorrect: false),
                    Answer(text: "Wrong Answer 2", isCorrect: false),
                    Answer(text: "Wrong Answer 3", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers
            case 4:
                answers = [
                    Answer(text: "Correct Answer", isCorrect: true),
                    Answer(text: "Wrong Answer 1", isCorrect: false),
                    Answer(text: "Wrong Answer 2", isCorrect: false),
                    Answer(text: "Wrong Answer 3", isCorrect: false)
                ].shuffled() // Randomizes the order of the answers

            default:
                break
            }

 
        }
    }
    func nextQuestion() {
        currentQuestionIndex += 1
    }

    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
}

