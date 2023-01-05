//
//  APICallSimulator.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import Foundation

class APICallSimulator {
    static let shared = APICallSimulator()
    
    enum APIError: Error {
        case error
    }
    
    func login(credentials: Credentials, completinon: @escaping (Result<Bool, APIError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if credentials.password == "password" {
                completinon(.success(true))
            } else {
                completinon(.failure(APIError.error))
            }
        }
    }
}
