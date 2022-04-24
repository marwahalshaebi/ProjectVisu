//
//  SignUpView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    // MARK: variables and state objects
    @State var nameText: String = ""
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @StateObject private var signupModel = SignUpModelImplementation(
        service: SignUpProtocolImplementation()
    )
    @Environment(\.dismiss) var dismiss
    
    // show next screen
    @State private var showNextScreen: Bool = false
    @State private var showSignInScreen: Bool = false


    var body: some View {
            ZStack{
                
                // MARK: NAVIGATION
                
                NavigationLink(destination: WelcomeView(), isActive: $showNextScreen) {
                    EmptyView()
                }
                NavigationLink(destination: SignInView(), isActive: $showSignInScreen) {
                    EmptyView()
                }
                
                Color("green")
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        VisuTextField(title: "NAME", text:  $signupModel.userDetails.name)
                        VisuTextField(title: "EMAIL", text: $signupModel.userDetails.email)
                        VisuTextField(title: "PASSWORD", text:  $signupModel.userDetails.password,securefeild: true)
                        VisuButton(title: "SIGN UP") {
                            print("-- Sign up button clicked")
                            signupModel.register()
                            // check if sign up was successfull before moving in the next view
                            if case .successfull = signupModel.state{
                                print("-- Signing user in")
                                showNextScreen = true
                            }
                            
                        }
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                        .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                        .padding(.top,40)
                    }
                    Spacer()
                    
                    ZStack(alignment: .top) {
                        Image("visu1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (Constant.screenWidth - 50))
                        
                        Button {
                            print("Already a member? Login clicked")
                            showSignInScreen = true
                            
                        } label: {
                            Text("Already a member? Login")
                                .padding(16)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal,40)
                // Handle registeration errors
                // TODO: handle password requirements. Implemented strong password protoccols
                .alert(isPresented: $signupModel.errorOccured,
                       content: {
                    if case .failed(let error) = signupModel.state {
                        return Alert(title: Text("Error"),
                                     message: Text(error.localizedDescription))
                    }
                    else{
                        return Alert(title: Text("Error"),
                                     message: Text("Uh oh, something went wrong."))
                    }
                    
                })
                
                BackButton(action: {
                    dismiss()
                })

            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
