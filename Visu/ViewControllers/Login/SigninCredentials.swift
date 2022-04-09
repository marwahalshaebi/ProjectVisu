//
//  LoginCredentials.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-17.
//

import Foundation

struct SigninCredentials{
    var email: String
    var password: String
}

extension SigninCredentials {
    static var new: SigninCredentials {
        SigninCredentials(email: "", password: "")
    }
}
