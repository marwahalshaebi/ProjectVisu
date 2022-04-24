//
//  LoginProtocol.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import Foundation
import Combine
import FirebaseAuth

protocol SigninProtocol{
    func signin(with credentials: SigninCredentials) -> AnyPublisher<Void, Error>
}

final class SigninProtocolImplementation: SigninProtocol {
    func signin(with credentials: SigninCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                // Firebase documentation
                Auth.auth().signIn(withEmail: credentials.email,
                            password: credentials.password) { res, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success (()))
                        }
                    }
                }
            }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
