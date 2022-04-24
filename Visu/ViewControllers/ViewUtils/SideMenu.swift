//
//  Side.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-04-23.
//

import SwiftUI

struct SideMenu: View {
    // MARK: variables and state objects
    var fontWeight: Font.Weight = .semibold
    var font: Font = .headline
    @EnvironmentObject var session: SessionProtocolImplementation
    @State private var navigation: Int? = nil
    
    var body: some View {
        VStack{
            
            // MARK: NAVIGATION
            NavigationLink(tag: 1, selection: $navigation) {
                UserProfile()
                    .environmentObject(session)
            } label: { EmptyView() }
            
            Text("SETTINGS")
                .font(font)
                .fontWeight(fontWeight)
                .foregroundColor(.white)
                .padding()
            
            Divider()
                .frame(width: 120, height: 2)
                .background(Color.white)
                .padding(.horizontal, 10)
                .blur(radius: 0.5)
                
            
            Button(action: {
                navigation = 1
            }, label: {
                Text("PROFILE")
                    .font(font)
                    .fontWeight(fontWeight)
                    .foregroundColor(.white)
            })
            .padding()
            Button(action: {
                session.logout()
            }, label: {
                Text("LOGOUT")
                    .font(font)
                    .fontWeight(fontWeight)
                    .foregroundColor(.white)
            })
            
            Spacer()
            
            
        }
        .padding(.vertical, 60)
        .padding(.horizontal, 30)
        .background(Color("greenButton"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
            .environmentObject(SessionProtocolImplementation())
    }
}
