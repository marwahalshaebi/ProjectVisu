//
//  StartView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct StartView: View {
    
    
    // MARK: variables and state objects
    @State private var showTasks: Bool = false
    @State private var showMenu: Bool = false
    @EnvironmentObject var session: SessionProtocolImplementation
    @Environment(\.dismiss) var dismiss
    
    // MARK: VIEW
    var body: some View {

        ZStack{

            // MARK: NAVIGATION
            NavigationLink(destination: ChooseTaskView().environmentObject(session), isActive: $showTasks) {
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
                        print("start button clicked")
                        showTasks.toggle()
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
            
            BackButton(action: {
                dismiss()
            })

        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(SessionProtocolImplementation())
    }
}
