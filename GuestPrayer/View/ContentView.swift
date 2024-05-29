//import SwiftUI
//
//struct ContentView: View {
//    @State private var navigateToHome = false
//
//    var body: some View {
//        if navigateToHome {
//            // Tampilkan tampilan Home jika navigateToHome diatur menjadi true
//            HomeView()
//        } else {
//            // Tampilkan tampilan lain jika navigateToHome false
//            StageView(stageType: .lafadz)
//                .onReceive(NotificationCenter.default.publisher(for: .navigateToHome)) { _ in
//                    // Tindakan untuk menavigasi ke tampilan Home
//                    navigateToHome = true
//                }
//        }
//    }
//}
//
//
//
//extension Notification.Name {
//    static let navigateToHome = Notification.Name("navigateToHome")
//}
