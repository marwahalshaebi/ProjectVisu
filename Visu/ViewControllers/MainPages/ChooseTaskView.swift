//
//  ChooseTaskView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct ChooseTaskView: View {
    
    // MARK: variables and state objects
    @State private var navigation: Int? = nil
    @State private var showMenu: Bool = false
    @EnvironmentObject var session: SessionProtocolImplementation
    @Environment(\.dismiss) var dismiss
    
    // MARK: VIEW
    var body: some View {
        ZStack{

            // MARK: NAVIGATION 
            NavigationLink(tag: 1, selection: $navigation) {
                TrackRoboCatView().environmentObject(session)
            } label: { EmptyView() }


            NavigationLink(tag: 2, selection: $navigation) {
                ReadWithVisuView().environmentObject(session)
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
                    self.navigation = 1
                }
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
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
                    self.navigation = 2
                }
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
            }
            .frame(height: Constant.screenHeight * 0.55)
            .padding(.horizontal,40)
            
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
        .navigationBarBackButtonHidden(true)
    }
}

struct ChooseTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTaskView().environmentObject(SessionProtocolImplementation())
    }
}
