import SwiftUI

struct HomeView: View {
    @State private var isGameActive = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {

                    Image("bg-mosque")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                        .padding(.top, 40)

                    VStack {
                        Spacer()

                        // Main Image
                        Image("mascotIslamic")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .padding(.top, geometry.size.height * 0.1)

                        Spacer()

                        // Title
                        Text("iqro")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.bottom, 50)

                        // Buttons
                        VStack(spacing: 20) {
                            NavigationLink(destination: StageView(stageType: .lafadz)) {
                                Text("Stage Lafadz")
                                    .frame(width: 200, height: 50)
                                    .background(Color(hex: 0x187C89))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }

                            NavigationLink(destination: StageView(stageType: .doa)) {
                                Text("Stage Doa")
                                    .frame(width: 200, height: 50)
                                    .background(Color(hex: 0x187C89))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }

                            NavigationLink(destination: StageView(stageType: .sholawat)) {
                                Text("Stage Sholawat")
                                    .frame(width: 200, height: 50)
                                    .background(Color(hex: 0x187C89))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                        }

                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }.background(
                createLinearGradientView()
            )
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            BackgroundMusicPlayer.shared.playBackgroundMusic(named: "backsound")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
