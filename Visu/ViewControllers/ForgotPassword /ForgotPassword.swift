//
//  ForgotPassword.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-24.
//

import SwiftUI
import Firebase

struct ForgotPassword: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var FPmodel = ForgotPasswordModelImplementation(
        service: ForgotPasswordProtocolImplementation()
    )
    @State private var navigation: Int? = nil
    @State var emailText: String = ""
    @State private var showDetailScreen = false
    var body: some View {
        ZStack{

            // Navigation
            NavigationLink(destination: SignInView(), isActive: $showDetailScreen) {
                EmptyView()
            }

            Color("green")


            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 10) {
                    VisuTextField(title: "EMAIL", text: $FPmodel.email)

                    VisuButton(title: "RESET PASSWORD") {
                        FPmodel.sendPasswordReset()
                        presentationMode.wrappedValue.dismiss()
                        print("emailSent")
                        
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.blue.opacity(0.03), radius: 5, x: 5, y: 5)
                    .padding(.top,40)
                }
                Spacer()

                ZStack(alignment: .top) {
                    Image("visu1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: (Constant.screenWidth - 50))

                 
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,40)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
