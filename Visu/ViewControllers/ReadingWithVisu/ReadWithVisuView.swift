//
//  ReadWithVisuView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct ReadWithVisuView: View {
    // MARK: variables and state objects
    @State private var showNextScreen: Bool = false
    @State private var showMenu: Bool = false
    @EnvironmentObject var session: SessionProtocolImplementation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            ZStack {
                
                // MARK: NAVIGATION
                NavigationLink(destination: ReadingExercise(), isActive: $showNextScreen) {
                    EmptyView()
                }
                
                Color("green")
                VStack {
                    
                    Spacer()
                    Image("image_read_with_visu_text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("image_visu_with_book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal,20)
                    
                    VisuButton(title: "START") {
                        print("START CLICKED")
                        rotateViewForVoiceDetectionView()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showNextScreen = true
                        }
                    }
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 5, y: 5)
                    .padding(.bottom,Constant.screenWidth * 0.15)
                    .padding(.top,20)
                    .padding(.horizontal,40)
                }
                .frame(width: Constant.screenWidth)
                
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
    // MARK: FUNC TO ROTATE VIEW
    func rotateViewForVoiceDetectionView() {
        AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

struct ReadWithVisuView_Previews: PreviewProvider {
    static var previews: some View {
        ReadWithVisuView()
            .environmentObject(SessionProtocolImplementation())
    }
}
