import Foundation
import SwiftUI

enum StageType {
    case lafadz
    case sholawat
    case doa
}

class StageIndicatorViewModel: ObservableObject {
    @Published var currentStage: Int = 0
    @Published var questionAnswered: Bool = false
    @Published var selectedAnswer: Answer?
    @Published var score: Int = 0
    var stageResults: [Bool] = []
    var stageType: StageType
    var audioPlayer: AVAudioPlayerWrapper
    let maxQuestionsPerStage = 5
    @Published var scoreDisplayed: Bool = false
    @Published var didFinishAllStages: Bool = false

    var totalStages: Int {
        switch stageType {
        case .lafadz:
            return 5
        case .sholawat:
            return 5
        case .doa:
            return 5
        }
    }

    init(stageType: StageType) {
        self.stageType = stageType
        self.audioPlayer = AVAudioPlayerWrapper()
        self.stageResults = Array(repeating: false, count: totalStages)
    }

    func nextStage() {
        if currentStage < maxQuestionsPerStage - 1 {
            currentStage += 1
            questionAnswered = false
            selectedAnswer = nil
        } else {
            didFinishAllStages = true
        }
    }

    func resetStages() {
        currentStage = 0
        questionAnswered = false
        selectedAnswer = nil
    }

    func answerQuestion(answer: Answer?) {
        guard !questionAnswered else { return }
        questionAnswered = true
        if let answer = answer {
            selectedAnswer = answer
            if answer.isCorrect {
                stageResults[currentStage] = true
                score += 20
            } else {
                stageResults[currentStage] = false
            }
        } else {
            stageResults[currentStage] = false
        }
        if currentStage == maxQuestionsPerStage - 1 {
            didFinishAllStages = true
        }
    }

    func indicatorColor(for index: Int) -> Color {
        if index < currentStage {
            return stageResults[index] ? .green : .red
        } else if index == currentStage && questionAnswered {
            return stageResults[index] ? .green : .red
        }
        return .gray
    }

    func playCurrentStageSound() {
        let folderName: String
        let soundName: String

        switch stageType {
        case .lafadz:
            folderName = "LafadzAudio"
            soundName = "stageLafadz\(currentStage + 1)"
        case .sholawat:
            folderName = "SholawatAudio"
            soundName = "stageSholawat\(currentStage + 1)"
        case .doa:
            folderName = "DoaAudio"
            soundName = "stageDoa\(currentStage + 1)"
        }

        print("Playing sound: \(soundName) from folder: \(folderName)")
        audioPlayer.playSound(named: soundName, in: folderName)
    }
}
