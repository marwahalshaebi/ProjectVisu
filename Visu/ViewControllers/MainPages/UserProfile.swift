//
//  UserProfile.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-04-23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct UserProfile: View {
    
    // MARK: variables and state objects
    @State private var navigation: Int? = nil
    var fontWeight: Font.Weight = .semibold
    var font: Font = .headline
    @EnvironmentObject var session: SessionProtocolImplementation
    @State private var score: Int = 0
    @State private var robocatScore: Int = 0
    @State private var readingScore: Int = 0
    @State private var name: String = ""
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    let uid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    
    // MARK: VIEW
    var body: some View {
        ZStack {
            
            // MARK: NAVIGATION
            NavigationLink(tag: 1, selection: $navigation) {
                WelcomeView()
                    .environmentObject(session)
            } label: { EmptyView() }
            
            Color("green")
            VStack{
                BackButton(action: { dismiss() })
            }
            
            VStack {
                
                Spacer()
                Image("visu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constant.screenWidth - 50)
                    .offset(x: 20) // static to fit image well.
            }
            
            VStack(spacing: 40) {

                Text(".. Hello \(name) !")
                    .font(.title)
                    .fontWeight(fontWeight)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                HStack{
                    Image(systemName: "envelope")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("\(email)")
                        .foregroundColor(.white)
                        .font(font)
                        .fontWeight(fontWeight)
                }
                HStack{
                    Image("robocat")
                        .resizable()
                        .frame(width: 37, height: 33)
                    Text(": \(robocatScore)    ")
                        .foregroundColor(.white)
                        .font(font)
                        .fontWeight(fontWeight)
                    Image("book")
                        .resizable()
                        .frame(width: 37, height: 33)
                    Text(": \(readingScore)")
                        .foregroundColor(.white)
                        .font(font)
                        .fontWeight(fontWeight)
                }
            }
            .padding(.horizontal,40)
        }
        
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            
            // FETCH USER'S DATA TO DISPLAY. WORKS MUCH MORE BETTER THAN PASSING THE SESSION ENVIRONMENT OBJECT
            ref.child("users").child(uid!).getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if let dictionary = snapshot.value as? [String: Any]{
                robocatScore = dictionary["findRoboCatScore"] as! Int
                readingScore = dictionary["readingScore"] as! Int
                name = dictionary["name"] as! String
                email = dictionary["email"] as! String
            }
        })
        }
    }
}
    

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
            .environmentObject(SessionProtocolImplementation())
    }
}
