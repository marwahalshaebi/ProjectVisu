//
//  SignInView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignInView: View {
    // MARK: variables and state objects
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State private var showNextScreen: Bool = false
    @State private var showRegisteration = false
    @State private var showForgotPassword = false
    @State private var showSignup = false
    @Environment(\.dismiss) var dismiss
    @StateObject private var signinModel = SigninModelImplementation(
        service: SigninProtocolImplementation()
    )
    // MARK: VIEW
    
    var body: some View {
            ZStack{
                
                // MARK: NAVIGATION
                NavigationLink(destination: WelcomeView(), isActive: $showNextScreen) {
                    EmptyView()
                }
                NavigationLink(destination: ForgotPassword(), isActive: $showForgotPassword) {
                    EmptyView()
                }
                NavigationLink(destination: SignUpView(), isActive: $showSignup) {
                    EmptyView()
                }
                
                Color("green")
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        VisuTextField(title: "EMAIL", text: $signinModel.credentials.email)
                        VisuTextField(title: "PASSWORD", text: $signinModel.credentials.password, securefeild: true)
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            print("Forgot Password clicked")
                            showForgotPassword = true
                        } label: {
                            Text("Forgot Password?")
                                .foregroundColor(.black)
                                .font(.headline)
                        }.padding(.top,8)
                    }
                    
                    VisuButton(title: "LOGIN") {
                        print("login button clicked")
                        signinModel.signin()
                        if case .successfull = signinModel.state{
                            print("signing you in")
                            showNextScreen = true
                            
                        }
                    }
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 4, y: 4)
                    .shadow(color: Color.blue.opacity(0.1), radius: 5, x: 4, y: 4)
                    .padding(.top,40)
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            print("New Here? Register clicked")
                            showSignup = true
                        } label: {
                            Text("New Here? Register")
                                .foregroundColor(.white)
                        }
                        .offset(y: 10)
                        
                        Image("visu1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (Constant.screenWidth - 50))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal,40)
                // HANDLE LOGIN ERRORS
                .alert(isPresented: $signinModel.errorOccured,
                       content: {
                    if case .failed(let error) = signinModel.state {
                        return Alert(title: Text("Error"),
                                     message: Text(error.localizedDescription))
                    }
                    else{
                        return Alert(title: Text("Error"),
                                     message: Text("Uh oh, something went wrong."))
                    }
                    
                })
                
                // MARK: dismiss view
                BackButton(action: {
                    dismiss()
                })
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            
        
    }
    
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
