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
                
                // MARK: NAVIGATION
                
                NavigationLink(tag: 1, selection: $navigation) {
                    SignUpView()
                } label: { EmptyView() }
                
                
                NavigationLink(tag: 2, selection: $navigation) {
                    SignInView()
                } label: { EmptyView() }
                
                NavigationLink(tag: 3, selection: $navigation) {
                    GetStartedView()
                } label: { EmptyView() }
        
                
                Color("green")
                

                VStack {
                    Spacer()
                    Image("visu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constant.screenWidth - 50)
                        .offset(x: 20) // static to fit image to screen.
                }
                
                VStack(spacing: 40) {
                    VisuButton(title: "SIGN UP", action: {
                        navigation = 1})
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                    .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                    
                    VisuButton(title: "SIGN IN",backgroundColor: Color(Constant.Color.lightGreen),action: {
                        navigation = 2
                    })
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                    .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                }
                .padding(.horizontal,40)
              
                
                BackButton(action: {
                    navigation = 3
                })
                
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
        
    }
}

struct SigninSignup_Previews: PreviewProvider {
    static var previews: some View {
        SigninSignup()
    }
}
