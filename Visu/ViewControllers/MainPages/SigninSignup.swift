//
//  SigninSignup.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-23.
//

import SwiftUI

struct SigninSignup: View {

    @State private var navigation: Int? = nil

    var body: some View {
        ZStack {

            // Navigation
            NavigationLink(tag: 1, selection: $navigation) {
                SignUpView()
            } label: { EmptyView() }


            NavigationLink(tag: 2, selection: $navigation) {
                SignInView()
            } label: { EmptyView() }


            Color("green")

            VStack {
                Spacer()
                Image("visu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constant.screenWidth - 50)
                    .offset(x: 20) // static to fit image well.
            }

            VStack(spacing: 40) {
                VisuButton(title: "SIGN UP",backgroundColor: Color(Constant.Color.lightGreen),action: {
                    navigation = 1
                })
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)

                VisuButton(title: "SIGN IN",backgroundColor: Color(Constant.Color.lightGreen),action: {
                    navigation = 2
                })
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.5), radius: 3, x: 5, y: 5)
            }
            .padding(.horizontal,40)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SigninSignup_Previews: PreviewProvider {
    static var previews: some View {
        SigninSignup()
    }
}
