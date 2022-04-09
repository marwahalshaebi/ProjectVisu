//
//  TrackRoboCatView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct TrackRoboCatView: View {

    @State private var showDetailScreen: Bool = false

    var body: some View {
        ZStack{

            // Navigation
            NavigationLink(destination: PlayTrackView(), isActive: $showDetailScreen) {
                EmptyView()
            }

            Color("green")

            VStack {
                Spacer()
                Image("image_trackRoboCat_text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constant.screenHeight * 0.3)

                VStack(spacing: 0) {
                    Image("image_visu_robocat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300,height: Constant.screenHeight * 0.5)
                        .offset(y: -35) // becasue image has blank part on top
                }
                Spacer()
            }.frame(width: Constant.screenWidth)

            ZStack {
                VStack {
                    Spacer()
                    VisuButton(title: "START") {
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

struct TrackRoboCat_Previews: PreviewProvider {
    static var previews: some View {
        TrackRoboCatView()
    }
}
