//
//  StartView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct StartView: View {

    @State private var showDetailScreen: Bool = false

    var body: some View {
        ZStack{

            // Navigation
            NavigationLink(destination: ChooseTaskView(), isActive: $showDetailScreen) {
                EmptyView()
            }

            Color("green")

            VStack {
                Spacer()
                Image("image_start_text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constant.screenHeight * 0.3)

                Image("visu4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300,height: Constant.screenHeight * 0.5)
                    .offset(y: -50) // becasue image has blank part on top
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

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
