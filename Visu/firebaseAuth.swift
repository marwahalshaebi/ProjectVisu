//
//  firebaseAuth.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import SwiftUI
import FirebaseAuth
import Firebase

// back up authentication logic I implemented referenced from Firebase documentation 

class firebaseAuth: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn = false
     var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self]
            result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
        signedIn = true
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self]
            result, error in
            guard result != nil, error == nil else{ 
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
}
