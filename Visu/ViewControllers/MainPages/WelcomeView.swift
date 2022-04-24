//
//  WelcomeView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-04.

import SwiftUI

struct WelcomeView: View {
    
    // MARK: variables and state objects
    @State private var showNextScreen: Bool = false
    @State private var showMenu: Bool = false
    @EnvironmentObject var session: SessionProtocolImplementation
    var body: some View {

        ZStack {

            // MARK: NAVIGATION
            
            NavigationLink(destination: StartView().environmentObject(session), isActive: $showNextScreen) {
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
                        showNextScreen = true
                    }
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                    .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                    .padding(.bottom,50)
                    .padding(.horizontal,40)
                }
            }
            
            // MARK: SIDE MENU VIEW AND BACK BUTTON
            
            GeometryReader{ _ in
                
                HStack{
                    Spacer()
                    SideMenu()
                        .environmentObject(session)
                        .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 0.4), value: showMenu)
                }
                
            }
            .background(Color.black.opacity(showMenu ? 0.5 : 0))
            
            Button(action: {
                self.showMenu.toggle()
            }, label: {
                if showMenu {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.white)
                }
                else {
                    Image(systemName: "text.justify")
                        .font(.title)
                        .foregroundColor(Color("black"))
                }
            })
            .frame(width: 23, height: 20)
            .position(x: Constant.screenWidth - 50, y: 60)
            
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
