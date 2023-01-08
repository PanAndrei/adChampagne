//
//  RestorePasswordViewModel.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 08.01.2023.
//

import Foundation

class RestorePasswordViewModel: ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var error: Authentication.AuthenticationError?
    @Published var passwordWasChanged: Bool = false
    
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
