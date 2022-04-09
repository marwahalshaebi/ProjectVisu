//
//  SignUpProtocol.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
// Combine will help with handling errors well

import Combine
import Foundation
import FirebaseDatabase
import Firebase

// enums will allow to specify the keys i want to use to refer users to the real time data base. Enums can be interperted as JSON objects
enum SignUpKeys: String {
    case name
    case email
    case readingScore
    case findRoboCatScore
}

// Any publisher will rerturn a publisher we can subscribe to, Void will be the successful state. and error will be used for testing and debugging
protocol SignUpProtocol {
    func register(with details: SignUpDetails) -> AnyPublisher<Void, Error>
}

final class SignUpProtocolImplementation: SignUpProtocol {
    func register (with details: SignUpDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                
                Auth.auth ()
                    .createUser (withEmail: details.email,
                                 password: details.password) { res, error in
                        if let err = error {
                            promise (.failure(err))
                        }
                        else {
                            if let uid = res?.user.uid {
                                let values = [SignUpKeys.name.rawValue: details.name,
                                              SignUpKeys.email.rawValue: details.email,
                                              SignUpKeys.readingScore.rawValue: details.readingScore,
                                              SignUpKeys.findRoboCatScore.rawValue: details.findRoboCatScore] as [String : Any]
                                
                                Database.database().reference().child("users").child(uid).updateChildValues(values){ error, ref in
                                    if let err = error {
                                        promise(.failure(err))
                                    }
                                    else{
                                        promise(.success(()))
                                    }
                                }
                            }
                            else{
                                promise(.failure(NSError(domain: "invalid user id", code: 0, userInfo: nil) ))
                            }
                        }
                    }
            }
        }
        .receive(on: RunLoop.main) // recieving on the main thread to manipulate ui
        .eraseToAnyPublisher()
    }
}
