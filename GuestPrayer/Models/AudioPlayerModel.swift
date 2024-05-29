import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    
    private init() {} // Private initializer to prevent external instantiation
    
    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Audio file \(name).mp3 not found")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
