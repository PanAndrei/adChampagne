//
//  Authentication.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated: Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        // password contains not only num lett
        
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("password or email wrong", comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
