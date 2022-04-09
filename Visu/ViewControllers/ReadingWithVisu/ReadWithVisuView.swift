//
//  ReadWithVisuView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct ReadWithVisuView: View {

    @State private var showDetailScreen: Bool = false

    var body: some View {
        ZStack {

            // Navigation
            NavigationLink(destination: VoiceDetectionActivatedView(), isActive: $showDetailScreen) {
                EmptyView()
            }

            Color("green")
            VStack {

                Spacer()
                Image("image_read_with_visu_text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("image_visu_with_book")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal,20)

                VisuButton(title: "START") {
                    print("login button clicked")
                    rotateViewForVoiceDetectionView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showDetailScreen = true
                    }
                }
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
                .padding(.bottom,Constant.screenWidth * 0.15)
                .padding(.top,20)
                .padding(.horizontal,40)
            }
            .frame(width: Constant.screenWidth)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    func rotateViewForVoiceDetectionView() {
        AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

struct ReadWithVisuView_Previews: PreviewProvider {
    static var previews: some View {
        ReadWithVisuView()
    }
}
