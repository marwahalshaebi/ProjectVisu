//
//  SignUpDetails.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import Foundation

struct SignUpDetails{
    // MARK: variables
    var email: String
    var password: String
    var name: String
    var readingScore: Int
    var findRoboCatScore: Int
}

extension SignUpDetails {
    // MARK: Class constructor 
    static var new: SignUpDetails {
        SignUpDetails(email: "", password: "", name: "", readingScore: 0, findRoboCatScore: 0)
    }
}
