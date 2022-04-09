//
//  WelcomeView.swift
//  Visu
//
//  Created by iMac on 04/03/22.
//

import SwiftUI

struct WelcomeView: View {

    @State private var showDetailScreen: Bool = false
    @EnvironmentObject var sessionProtocol: SessionProtocolImplementation
    var body: some View {

        ZStack {

            // Navigation
            NavigationLink(destination: StartView(), isActive: $showDetailScreen) {
                EmptyView()
            }

            Color("green")

            VStack {
                Image("image_welcome_text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constant.screenHeight * 0.2)

                Image("visu2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300,height: Constant.screenHeight * 0.5)
            }.frame(width: Constant.screenWidth)

            ZStack {
                VStack {
                    Spacer()
                    VisuButton(title: "NEXT") {
                        print("login button clicked")
                        showDetailScreen = true
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
                    .padding(.bottom,50)
                    .padding(.horizontal,40)
                }
            }

        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(SessionProtocolImplementation())
    }
}
