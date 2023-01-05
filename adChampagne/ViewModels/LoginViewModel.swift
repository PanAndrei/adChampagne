//
//  LoginViewModel.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var error: Authentication.AuthenticationError?
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        APICallSimulator.shared.login(credentials: credentials) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                credentials = Credentials()
                error = authError
                completion(false)
            }
        }
    }
}
