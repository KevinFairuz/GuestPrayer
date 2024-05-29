import AVFoundation

class AVAudioPlayerWrapper: ObservableObject {
    var player: AVAudioPlayer?

    init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
            print("Audio session configured successfully.")
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    func printDirectoryContents(folder: String) {
        guard let resourcePath = Bundle.main.resourcePath else {
            print("Resource path not found")
            return
        }
        let folderPath = (resourcePath as NSString).appendingPathComponent(folder)
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: folderPath)
            print("Contents of \(folderPath): \(files)")
        } catch {
            print("Error reading contents of directory: \(folderPath): \(error.localizedDescription)")
        }
    }

    func playSound(named name: String, in folder: String) {
        printDirectoryContents(folder: folder)

        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3", subdirectory: folder) else {
            print("Audio file \(name).mp3 not found in folder \(folder)")
            return
        }

        print("Playing sound from URL: \(url)")
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            print("Playing sound: \(name).mp3 from folder \(folder)")
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    func stopSound() {
        player?.stop()
    }
}
