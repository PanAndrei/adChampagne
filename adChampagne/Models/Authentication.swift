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
        // no such password
        // credentials not saved
//        case credentialsNotSaved
        case invalidEmail
        case invalidPassword
        case userAlreadyExists
        case userNotFound
        case samePassword
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("password or email wrong", comment: "") // cahge
//            case .credentialsNotSaved:
//                return NSLocalizedString("credentials not saved", comment: "") // cahge
            case .invalidEmail:
                return NSLocalizedString("email invalid", comment: "")
            case .invalidPassword:
                return NSLocalizedString("password must contains only nums and let", comment: "")
            case .userAlreadyExists:
                return NSLocalizedString("user already exists", comment: "")
            case .userNotFound:
                return NSLocalizedString("Cannot find user", comment: "")
            case .samePassword:
                return NSLocalizedString("You took same password^ get another", comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
