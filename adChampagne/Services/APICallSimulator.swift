//
//  APICallSimulator.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import Foundation

class APICallSimulator {
    static let shared = APICallSimulator()
    
    func login(credentials: Credentials, completinon: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if credentials.password == "password" {
                completinon(.success(true))
            } else {
                completinon(.failure(.invalidCredentials))
            }
        }
    }
}
