//
//  SessionUserDetails.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import Foundation

// MARK: this what i will be passing around to other class to identify current user 
struct SessionUserDetails {
    let name: String
    let email: String
    let readingScore: Int
    let findRoboCatScore: Int
}
