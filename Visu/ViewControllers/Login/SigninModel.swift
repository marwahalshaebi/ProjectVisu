//
//  LoginModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import Foundation
import Combine
enum SigninState {
    case successfull
    case failed (error: Error)
    case na
}
protocol SigninModel {
    func signin()
    var service: SigninProtocol { get }
    var state: SigninState { get }
    var credentials: SigninCredentials { get }
    var errorOccured: Bool { get }
    init(service: SigninProtocol)
    
}

// observable object class to be used as a state object to update ui
final class SigninModelImplementation: ObservableObject, SigninModel {
    @Published var errorOccured: Bool = false
    @Published var state: SigninState = .na
    @Published var credentials: SigninCredentials = SigninCredentials.new
    
    private var subscriptions = Set<AnyCancellable>()
    let service: SigninProtocol
    
    init(service: SigninProtocol) {
        self.service = service
        setupErrorSubscriptions()
    }
    // signing in a user, Firebase and Combine documentation, inspo https://stackoverflow.com/questions/68844655/ios-swiftui-main-thread-1-exc-bad-access-code-2-address-0x7ffee1a57ff0
    func signin() {
        service.signin(with: credentials)
            .sink { [weak self] res in
                
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                    self?.state = .successfull
                }
                .store(in: &subscriptions)
    }
}

// handle sign in errors, Firebase documentation, Combine authentication tutorials 
private extension SigninModelImplementation {
    func setupErrorSubscriptions () {
        $state
             .map { state -> Bool in
                 switch state {
                 case .successfull,
                       .na:
                     return false
                 case .failed:
                     return true
                 }
             }
             .assign(to: &$errorOccured)
    }
}
