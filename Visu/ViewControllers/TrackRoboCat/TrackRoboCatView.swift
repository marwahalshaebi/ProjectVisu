//
//  TrackRoboCatView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI

struct TrackRoboCatView: View {
    // MARK: variables and state objects
    @State private var showNextScreen: Bool = false
    @State private var showMenu: Bool = false
    @EnvironmentObject var session: SessionProtocolImplementation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack{
                
                // Navigation
                NavigationLink(destination: PlayTrackView(), isActive: $showNextScreen) {
                    EmptyView()
                }
                
                Color("green")
                
                VStack {
                    Spacer()
                    Image("message_robocat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constant.screenHeight * 0.3)
                    
                    VStack(spacing: 0) {
                        Image("image_visu_robocat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300,height: Constant.screenHeight * 0.5)
                            .offset(y: -35) // Remove's image blank part on top
                    }
                    Spacer()
                }
                .frame(width: Constant.screenWidth)
                
                ZStack {
                    VStack {
                        Spacer()
                        VisuButton(title: "START") {
                            print("START CLICKED")
                            rotateRoboCatView()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.showNextScreen = true
                            }
                        }
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 5, y: 5)
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
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: FUNC TO ROTATE VIEW

func rotateRoboCatView() {
    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    UINavigationController.attemptRotationToDeviceOrientation()
}

struct TrackRoboCat_Previews: PreviewProvider {
    static var previews: some View {
        TrackRoboCatView()
            .environmentObject(SessionProtocolImplementation())
    }
}
