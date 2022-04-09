//
//  ChooseTaskView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct ChooseTaskView: View {

    @State private var navigation: Int? = nil

    var body: some View {
        ZStack{

            // Navigation
            NavigationLink(tag: 1, selection: $navigation) {
                TrackRoboCatView()
            } label: { EmptyView() }


            NavigationLink(tag: 2, selection: $navigation) {
                ReadWithVisuView()
            } label: { EmptyView() }

            Color("green")
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image("robocat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100,height: 100)
                    Spacer().frame(width: 25)
                }
                .offset(y: 22)

                VisuButton(title: "TRACK ROBOCAT") {
                    print("track robocat clicked")
                    self.navigation = 1
                }
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
                Spacer()


                HStack {
                    Image("book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100,height: 100)
                    Spacer()
                }
                .offset(x: -10,y: 22)

                VisuButton(title: "READ WITH VISU") {
                    print("read with visu clicked")
                    self.navigation = 2
                }
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
            }
            .frame(height: Constant.screenHeight * 0.55)
            .padding(.horizontal,40)

        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ChooseTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTaskView()
    }
}
