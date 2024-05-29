////
////  simpen.swift
////  GuestPrayer-IpadOS
////
////  Created by Kevin Fairuz on 26/05/24.
////
//
//import Foundation
//import SwiftUI
//import AVFoundation
//
//class StageIndicatorViewModel: ObservableObject {
//    @Published var currentStage: Int = 0
//    @Published var selectedAnswer: Answer?
//    @Published var questionAnswered: Bool = false
//    @Published var score: Int = 0 // Add score property
//    var stageType: StageType
//    var audioPlayer = AudioPlayer.shared
//
//    private var stageResults: [Bool] = Array(repeating: false, count: 5)
//
//    init(stageType: StageType) {
//        self.stageType = stageType
//    }
//

//

//
//    func nextStage() {
//        if currentStage < 4 {
//            currentStage += 1
//            questionAnswered = false
//            selectedAnswer = nil
//            playCurrentStageSound()
//        } else {
//            // Handle end of stages
//        }
//    }
//
//    func playCurrentStageSound() {
//        let soundName = "stage\(currentStage + 1)"
//        audioPlayer.playSound(named: soundName)
//    }
//
//    
//}

//Audi0
//func loadAudioFiles() {
//    let folderURL = URL(fileURLWithPath: "./AudioAssets", isDirectory: true)
//    do {
//        let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
//        audioFiles = fileURLs.filter { $0.pathExtension == "mp3" }
//    } catch {
//        print("Error loading audio files: \(error.localizedDescription)")
//    }
//}
//
//func playNextAudio() {
//    if currentAudioIndex < audioFiles.count {
//        let audioURL = audioFiles[currentAudioIndex]
//        do {
//            player = try AVAudioPlayer(contentsOf: audioURL)
//            player?.play()
//        } catch {
//            print("Couldn't load file \(audioURL): \(error.localizedDescription)")
//        }
//        currentAudioIndex += 1
//    } else {
//        print("No more audio files to play.")
//    }
//}
//import SwiftUI
//
//struct StageView: View {
//    @StateObject private var stageIndicatorViewModel: StageIndicatorViewModel
//    @StateObject private var answerViewModel: AnswerViewModel
//    @State private var navigateToFinalView = false
//    @State private var timerProgress: CGFloat = 1.0
//    @State private var audioProgress: CGFloat = 0.0
//    @State private var timer: Timer?
//    @State private var audioTimer: Timer?
//    @State private var showAlert = false
//    @State private var score: Int = 0
//    @State private var selectedAnswer: Answer?
//    @State private var navigateToHome = false
//
//    init(stageType: StageType) {
//        _stageIndicatorViewModel = StateObject(wrappedValue: StageIndicatorViewModel(stageType: stageType))
//        _answerViewModel = StateObject(wrappedValue: AnswerViewModel())
//    }
//
//    var body: some View {
//        VStack {
//            if stageIndicatorViewModel.didFinishAllStages {
//                TotalScoreView(viewModel: stageIndicatorViewModel)
//            } else {
//                GeometryReader { geometry in
//                    ZStack {
//                        VStack {
//                            Spacer()
//                            StageIndicatorView(viewModel: stageIndicatorViewModel)
//
//                            TimerProgressView(timerProgress: $timerProgress)
//                                .onAppear {
//                                    startTimer()
//                                }
//
//                            QuestionTextView()
//
//                            AnswerButtonsView(viewModel: stageIndicatorViewModel, answerViewModel: answerViewModel, selectedAnswer: $selectedAnswer) { answer in
//                                answerQuestion(answer: answer)
//                            }
//
//                            Spacer()
//                            if stageIndicatorViewModel.questionAnswered {
//                                if stageIndicatorViewModel.currentStage == stageIndicatorViewModel.totalStages - 1 {
//                                    Button("Home") {
//                                        navigateToHome = true
//                                        NotificationCenter.default.post(name: .navigateToHome, object: nil)
//                                    }
//                                    .padding(.horizontal)
//                                    .padding(.horizontal)
//                                } else {
//                                    NextPageButton(action: nextStage)
//                                        .padding(.horizontal)
//                                }
//                            }
// 
//                            ScoreView(score: score)
//
//                            Spacer()
//                        }
//                    }
//                }
//                .onAppear {
//                    answerViewModel.loadAnswers(for: stageIndicatorViewModel.currentStage, stageType: stageIndicatorViewModel.stageType)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1-second delay
//                        print("Playing current stage sound")
//                        stageIndicatorViewModel.playCurrentStageSound()
//                        startAudioProgressTimer()
//                    }
//                    // Lower background music volume when stage starts
//                    BackgroundMusicPlayer.shared.stopBackgroundMusic()
//                }
//                .onDisappear {
//                    // Restore background music volume when leaving stage
//                    BackgroundMusicPlayer.shared.setVolume(1.0)
//                }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Time's Up"), message: Text("Waktu Telah Habis"), dismissButton: .default(Text("Next Page"), action: {
//                        nextStage()
//                    }))
//                }
//                .background(
//                    createLinearGradientView()
//                )
//                .shadow(radius: 10)
//            }
//        }.onReceive(stageIndicatorViewModel.$didFinishAllStages) { didFinishStages in
//            if didFinishStages {
//                navigateToFinalView = true
//            }
//        }
//        .sheet(isPresented: $stageIndicatorViewModel.didFinishAllStages) {
//            VStack {
//                TotalScoreView(viewModel: stageIndicatorViewModel)
//            }
//        }
//
//
//    }
//    
//
//    func startTimer() {
//        timer?.invalidate()
//        timerProgress = 1.0
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//            if self.timerProgress > 0 {
//                self.timerProgress -= 0.01 / 2
//            } else {
//                self.timer?.invalidate()
//                self.showAlert = true
//                self.answerQuestion(answer: nil)
//            }
//        }
//    }
//
//    func startAudioProgressTimer() {
//        audioTimer?.invalidate()
//        audioProgress = 0.0
//        guard let player = stageIndicatorViewModel.audioPlayer.player else {
//            print("No audio player available")
//            return
//        }
//        audioTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//            if player.isPlaying {
//                self.audioProgress = CGFloat(player.currentTime / player.duration)
//            } else {
//                self.audioTimer?.invalidate()
//            }
//        }
//    }
//
//    func answerQuestion(answer: Answer?) {
//        stageIndicatorViewModel.answerQuestion(answer: answer)
//        if let answer = answer, answer.isCorrect {
//            score += 20
//            selectedAnswer = answer
//        }
//        // Menghentikan audio jika sedang diputar
//            stageIndicatorViewModel.audioPlayer.player?.stop()
//        BackgroundMusicPlayer.shared.playBackgroundMusic(named: "backsound", volume: 0.5)
//        
//    }
//
//    func nextStage() {
//        stageIndicatorViewModel.nextStage() // Maju ke ronde berikutnya
//        selectedAnswer = nil // Reset jawaban yang dipilih
//        startTimer() // Mulai timer untuk ronde baru
//        BackgroundMusicPlayer.shared.stopBackgroundMusic()
//        // Set ulang indeks pertanyaan berdasarkan ronde yang sedang dimuat
//        switch stageIndicatorViewModel.currentStage {
//        case 0:
//            answerViewModel.currentQuestionIndex = 0
//        case 1:
//            answerViewModel.currentQuestionIndex = 1
//        case 2:
//            answerViewModel.currentQuestionIndex = 2
//        case 3:
//            answerViewModel.currentQuestionIndex = 3
//        case 4:
//            answerViewModel.currentQuestionIndex = 4
//        default:
//            break
//        }
//        
//        // Muat jawaban baru untuk ronde berikutnya
//        answerViewModel.loadAnswers(for: stageIndicatorViewModel.currentStage, stageType: stageIndicatorViewModel.stageType)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1-second delay
//            print("Playing current stage sound in nextStage")
//            stageIndicatorViewModel.playCurrentStageSound() // Mainkan suara untuk ronde baru
//            startAudioProgressTimer() // Mulai timer progres audio untuk ronde baru
//        }
//    }
//
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StageView(stageType: .lafadz)
//    }
//}
// stage indicator
//import SwiftUI
//
//enum StageType {
//    case lafadz
//    case sholawat
//    case doa
//}
//
//class StageIndicatorViewModel: ObservableObject {
//    @Published var currentStage: Int = 0
//    @Published var questionAnswered: Bool = false
//    @Published var selectedAnswer: Answer?
//    @Published var score: Int = 0
//    var stageResults: [Bool] = []
//    var stageType: StageType
//    var audioPlayer: AVAudioPlayerWrapper
//    let maxQuestionsPerStage = 5
//    @Published var scoreDisplayed: Bool = false
//    @Published var didFinishAllStages: Bool = false
//
//    var totalStages: Int {
//        switch stageType {
//        case .lafadz:
//            return 5
//        case .sholawat:
//            return 5
//        case .doa:
//            return 5
//        }
//    }
//
//    init(stageType: StageType) {
//        self.stageType = stageType
//        self.audioPlayer = AVAudioPlayerWrapper()
//        self.stageResults = Array(repeating: false, count: totalStages)
//    }
//  func nextStage() {
//        if currentStage < totalStages - 1 {
//            currentStage += 1
//        } else {
//            didFinishAllStages = true
//        }
//    }
//
//    func resetStages() {
//        currentStage = 0
//        questionAnswered = false
//        selectedAnswer = nil
//    }
//
//    func answerQuestion(answer: Answer?) {
//        guard !questionAnswered else { return }
//        questionAnswered = true
//        if let answer = answer {
//            selectedAnswer = answer
//            if answer.isCorrect {
//                stageResults[currentStage] = true
//                score += 20
//            } else {
//                stageResults[currentStage] = false
//            }
//        } else {
//            stageResults[currentStage] = false
//            
//        }
//    }
//
//    func indicatorColor(for index: Int) -> Color {
//        if index < currentStage {
//            return stageResults[index] ? .green : .red
//        } else if index == currentStage && questionAnswered {
//            return stageResults[index] ? .green : .red
//        }
//        return .gray
//    }
//
//    func playCurrentStageSound() {
//        let folderName: String
//        let soundName: String
//
//        switch stageType {
//        case .lafadz:
//            folderName = "LafadzAudio"
//            soundName = "stageLafadz\(currentStage + 1)"
//        case .sholawat:
//            folderName = "SholawatAudio"
//            soundName = "stageSholawat\(currentStage + 1)"
//        case .doa:
//            folderName = "DoaAudio"
//            soundName = "stageDoa\(currentStage + 1)"
//        }
//
//        print("Playing sound: \(soundName) from folder: \(folderName)")
//        audioPlayer.playSound(named: soundName, in: folderName)
//    }
//}
