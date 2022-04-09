//
//  ContentView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-23.
//

import SwiftUI

struct GetStartedView: View {

    @State private var showDetailScreen: Bool = false

    var body: some View {
        NavigationView {
            ZStack {

                // Navigation
                NavigationLink(destination: SigninSignup(), isActive: $showDetailScreen) {
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
                        showDetailScreen = true
                    })
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
                        .padding(.horizontal,40)
                        .offset(y: -35)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
