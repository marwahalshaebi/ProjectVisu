//
//  SignUpModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-24.
//

import Foundation
import Combine

enum SignUpState{
    case successfull
    case failed(error: Error)
    case na
}
protocol SignUpModel{
    func register()
    var errorOccured: Bool { get }
    var service: SignUpProtocol { get }
    var state: SignUpState { get }
    var userDetails: SignUpDetails { get }
    init(service: SignUpProtocol)
}

final class SignUpModelImplementation: ObservableObject, SignUpModel {
    @Published var errorOccured: Bool = false
    let service: SignUpProtocol
    @Published var state: SignUpState = .na
    var userDetails: SignUpDetails = SignUpDetails.new
    private var subscriptions = Set<AnyCancellable>()
    

    init(service: SignUpProtocol) {
        self.service = service
        setupErrorHandling()
    }
    
    // registering a user
    func register() {
        service.register(with: userDetails)
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

private extension SignUpModelImplementation{
    
    func setupErrorHandling(){
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
                              