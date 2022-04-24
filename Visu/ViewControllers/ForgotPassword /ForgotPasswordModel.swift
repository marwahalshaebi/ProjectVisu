//
//  ForgotPasswordModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-24.
//

import Combine
import Foundation
import Firebase

// protocol is similar to static classes, the definitions that follow the protocl must be defined
protocol ForgotPasswordModel {
    func sendPasswordReset ()
    var service: ForgotPasswordProtocol { get }
    var email: String { get }
    init(service: ForgotPasswordProtocol)
}
final class ForgotPasswordModelImplementation: ObservableObject, ForgotPasswordModel {
    
    // MARK: variables
    @Published var email: String = ""
    let service: ForgotPasswordProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: ForgotPasswordProtocol) {
        self.service = service
    }
    
    // similar to sign up/registeratiuon logic 
    func sendPasswordReset () {
        service.sendPasswordReset(to: email)
            .sink { res in
                
                switch res {
                case .failure(let err):
                    print ("Failed: \(err)")
                default: break
                }
            }receiveValue: {
                print("Sent Password Reset Request!")
            }
            .store(in: &subscriptions)
    }
}
