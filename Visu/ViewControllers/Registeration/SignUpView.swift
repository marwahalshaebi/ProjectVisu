//
//  SignUpView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {

    @State var nameText: String = ""
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @StateObject private var signupModel = SignUpModelImplementation(
        service: SignUpProtocolImplementation()
    )
    
    // show next screen
    @State private var showDetailScreen: Bool = false
    @State private var showSignInScreen: Bool = false


    var body: some View {
        ZStack{

            // Navigation
            NavigationLink(destination: WelcomeView(), isActive: $showDetailScreen) {
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
                        print("sign up button clicked")
                        signupModel.register()
                        if case .successfull = signupModel.state{
                            print("signing you in")
                            showDetailScreen = true
                        }
                        
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
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
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
