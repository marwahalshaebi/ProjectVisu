//
//  LoginCredentials.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-17.
//

import Foundation

// MARK: variables
struct SigninCredentials{
    var email: String
    var password: String
}

// MARK: constructor
extension SigninCredentials {
    static var new: SigninCredentials {
        SigninCredentials(email: "", password: "")
    }
}
