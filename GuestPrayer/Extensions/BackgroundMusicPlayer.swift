import AVFoundation

class BackgroundMusicPlayer {
    static let shared = BackgroundMusicPlayer()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playBackgroundMusic(named name: String, volume: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Background music file \(name).mp3 not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = volume
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    func setVolume(_ volume: Float) {
        audioPlayer?.volume = volume
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
