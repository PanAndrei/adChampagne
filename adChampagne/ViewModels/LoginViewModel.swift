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

class RegisterViewModel: ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var error: Authentication.AuthenticationError?
    
    var saveDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
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

class RestorePasswordViewModel: ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var error: Authentication.AuthenticationError?
    //
    @Published var passwordWasChanged: Bool = false
    //
    
    var restoreDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func restorePassword() {
        showProgressView = true
        APICallSimulator.shared.restorePassword(credentials: credentials) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                passwordWasChanged = true
            case .failure(let changeError):
                credentials = Credentials()
                error = changeError
            }
        }
    }
}
