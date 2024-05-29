import SwiftUI

struct StageView: View {
    @StateObject private var stageIndicatorViewModel: StageIndicatorViewModel
    @StateObject private var answerViewModel: AnswerViewModel
    @State private var navigateToFinalView = false
    @State private var timerProgress: CGFloat = 1.0
    @State private var audioProgress: CGFloat = 0.0
    @State private var timer: Timer?
    @State private var audioTimer: Timer?
    @State private var showAlert = false
    @State private var score: Int = 0
    @State private var selectedAnswer: Answer?
    @State private var navigateToHome = false

    init(stageType: StageType) {
        _stageIndicatorViewModel = StateObject(wrappedValue: StageIndicatorViewModel(stageType: stageType))
        _answerViewModel = StateObject(wrappedValue: AnswerViewModel())
    }

    var body: some View {
        VStack {
            if navigateToHome {
                HomeView()
            } else if navigateToFinalView {
                TotalScoreView(score: stageIndicatorViewModel.score)
                    .onTapGesture {
                        navigateToHome = true
                    }
            } else {
                GeometryReader { geometry in
                    ZStack {
                        VStack {
                            Spacer()
                            StageIndicatorView(viewModel: stageIndicatorViewModel)

                            TimerProgressView(timerProgress: $timerProgress)
                                .onAppear {
                                    startTimer()
                                }

                            QuestionTextView()

                            AnswerButtonsView(viewModel: stageIndicatorViewModel, answerViewModel: answerViewModel, selectedAnswer: $selectedAnswer) { answer in
                                answerQuestion(answer: answer)
                            }

                            Spacer()
                            if stageIndicatorViewModel.questionAnswered {
                                if stageIndicatorViewModel.currentStage == stageIndicatorViewModel.maxQuestionsPerStage - 1 {
                                    Button("Home") {
                                        navigateToHome = true
                                    }
                                    .padding(.horizontal)
                                } else {
                                    NextPageButton(action: nextStage)
                                        .padding(.horizontal)
                                }
                            }

                            ScoreView(score: score)

                            Spacer()
                        }
                    }
                }
                .onAppear {
                    answerViewModel.loadAnswers(for: stageIndicatorViewModel.currentStage, stageType: stageIndicatorViewModel.stageType)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1-second delay
                        print("Playing current stage sound")
                        stageIndicatorViewModel.playCurrentStageSound()
                        startAudioProgressTimer()
                    }
                    // Lower background music volume when stage starts
                    BackgroundMusicPlayer.shared.stopBackgroundMusic()
                }
                .onDisappear {
                    // Restore background music volume when leaving stage
                    BackgroundMusicPlayer.shared.setVolume(1.0)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Time's Up"), message: Text("Waktu Telah Habis"), dismissButton: .default(Text("Next Page"), action: {
                        nextStage()
                    }))
                }
                .background(
                    createLinearGradientView()
                )
                .shadow(radius: 10)
            }
        }
        .onReceive(stageIndicatorViewModel.$didFinishAllStages) { didFinishStages in
            if didFinishStages {
                navigateToFinalView = true
            }
        }
    }

    func startTimer() {
        timer?.invalidate()
        timerProgress = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if self.timerProgress > 0 {
                self.timerProgress -= 0.01 / 2
            } else {
                self.timer?.invalidate()
                self.showAlert = true
                self.answerQuestion(answer: nil)
            }
        }
    }

    func startAudioProgressTimer() {
        audioTimer?.invalidate()
        audioProgress = 0.0
        guard let player = stageIndicatorViewModel.audioPlayer.player else {
            print("No audio player available")
            return
        }
        audioTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if player.isPlaying {
                self.audioProgress = CGFloat(player.currentTime / player.duration)
            } else {
                self.audioTimer?.invalidate()
            }
        }
    }

    func answerQuestion(answer: Answer?) {
        stageIndicatorViewModel.answerQuestion(answer: answer)
        if let answer = answer, answer.isCorrect {
            score += 20
            selectedAnswer = answer
        }
        // Menghentikan audio jika sedang diputar
        stageIndicatorViewModel.audioPlayer.player?.stop()
        BackgroundMusicPlayer.shared.playBackgroundMusic(named: "backsound", volume: 0.5)
    }

    func nextStage() {
        stageIndicatorViewModel.nextStage() // Maju ke ronde berikutnya
        if !stageIndicatorViewModel.didFinishAllStages {
            selectedAnswer = nil // Reset jawaban yang dipilih
            startTimer() // Mulai timer untuk ronde baru
            BackgroundMusicPlayer.shared.stopBackgroundMusic()
            // Set ulang indeks pertanyaan berdasarkan ronde yang sedang dimuat
            switch stageIndicatorViewModel.currentStage {
            case 0:
                answerViewModel.currentQuestionIndex = 0
            case 1:
                answerViewModel.currentQuestionIndex = 1
            case 2:
                answerViewModel.currentQuestionIndex = 2
            case 3:
                answerViewModel.currentQuestionIndex = 3
            case 4:
                answerViewModel.currentQuestionIndex = 4
            default:
                break
            }

            // Muat jawaban baru untuk ronde berikutnya
            answerViewModel.loadAnswers(for: stageIndicatorViewModel.currentStage, stageType: stageIndicatorViewModel.stageType)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1-second delay
                print("Playing current stage sound in nextStage")
                stageIndicatorViewModel.playCurrentStageSound() // Mainkan suara untuk ronde baru
                startAudioProgressTimer() // Mulai timer progres audio
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(stageType: .lafadz)
    }
}
