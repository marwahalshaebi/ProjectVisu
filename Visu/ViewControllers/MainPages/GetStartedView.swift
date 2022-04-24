//
//  ContentView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-23.
//

import SwiftUI

struct GetStartedView: View {

    @State private var showNextScreen: Bool = false

    var body: some View {
            ZStack {

                //MARK: NAVIGATION
                
                NavigationLink(destination: SigninSignup(), isActive: $showNextScreen) {
                    EmptyView()
                }

                Color("green").edgesIgnoringSafeArea(.all)

                VStack {
                    Image("title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 310, height: 150)
                        .offset(x: 3, y: -200)
                        .padding()
                }

                VStack {
                    Spacer()

                    VisuButton(title: "GET STARTED",action: {
                        showNextScreen = true
                    })
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                        .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                        .padding(.horizontal,40)
                        .offset(y: -35)
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
