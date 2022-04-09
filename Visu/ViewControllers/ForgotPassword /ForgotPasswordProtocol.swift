//
//  PasswordResetProtocol.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-24.
//

// this class is in charge of password resetting for user's, sends an email to users to reset from firebase database
import Combine
import Foundation
import FirebaseAuth

protocol ForgotPasswordProtocol {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>
}
final class ForgotPasswordProtocolImplementation: ForgotPasswordProtocol {
    
    // Firebase documentation
    
    func sendPasswordReset (to email: String) -> AnyPublisher<Void, Error> {
        Deferred {
             Future { promise in
                 
                 Auth
                     .auth()
                      .sendPasswordReset (withEmail: email) { error in
                         if let err = error {
                              promise(.failure(err))
                           } else {
                             promise (.success(()))
                           }
                      }
             }
        }
        .eraseToAnyPublisher()
    }
}
