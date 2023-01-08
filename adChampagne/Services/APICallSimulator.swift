//
//  APICallSimulator.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import Foundation

class APICallSimulator {
    let manager = KeyChainManager()
    
    static let shared = APICallSimulator()
    
    func login(credentials: Credentials, completinon: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if manager.checkIfPasswordIsValidated(email: credentials.email, enteredPassword: credentials.password) {
                completinon(.success(true))
            } else {
                completinon(.failure(.invalidCredentials))
            }
        }
    }
    
    func registerUser(credentials: Credentials, completinon: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if !checkIfEmailIsValidate(email: credentials.email) {
                completinon(.failure(.invalidEmail))
            } else if !checkIfPasswordIsValidate(password: credentials.password) {
                completinon(.failure(.invalidPassword))
            } else if manager.checkIfUserExists(email: credentials.email) {
                completinon(.failure(.userAlreadyExists))
            } else {
                manager.saveUser(email: credentials.email, password: credentials.password)
                completinon(.success(true))
            }
        }
    }
    
    func restorePassword(credentials: Credentials, completinon: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if !manager.checkIfUserExists(email: credentials.email) {
                completinon(.failure(.userNotFound))
            } else if !checkIfPasswordIsValidate(password: credentials.password) {
                completinon(.failure(.invalidPassword))
            } else if manager.checkIfPasswordIsValidated(email: credentials.email, enteredPassword: credentials.password) {
                completinon(.failure(.samePassword))
            } else {
                manager.updatePassword(email: credentials.email, newPassword: credentials.password)
                completinon(.success(true))
            }
        }
    }
    
    private func checkIfPasswordIsValidate(password: String) -> Bool {
        password.matches("^[a-z0-9_-]{3,15}$")
    }
    
    private func checkIfEmailIsValidate(email: String) -> Bool {
        email.matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
}
