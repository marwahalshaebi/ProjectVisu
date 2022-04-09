//
//  PlayTrackView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//
import SwiftUI

struct PlayTrackView: View {
    @StateObject private var RCModel = RoboCatViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                Color("green").edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarHidden(true)
    }
}
 
struct PlayTrackView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTrackView()
    }
}
