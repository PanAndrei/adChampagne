//
//  RegisterViewModel.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 08.01.2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var error: Authentication.AuthenticationError?
    
    var saveDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
        // git test
    }
    
    func register(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        APICallSimulator.shared.registerUser(credentials: credentials) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let regError):
                credentials = Credentials()
                error = regError
                completion(false)
            }
        }
    }
}
