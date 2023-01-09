//
//  Authentication.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated: Bool = false
    @Published var userEmail: String = ""

    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
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
                return NSLocalizedString("The email or password was entered incorrectly", comment: "")
            case .invalidEmail:
                return NSLocalizedString("Incorrect email. Please try again", comment: "")
            case .invalidPassword:
                return NSLocalizedString("The password must consist only of English letters and numbers", comment: "")
            case .userAlreadyExists:
                return NSLocalizedString("Such a user is already registered", comment: "")
            case .userNotFound:
                return NSLocalizedString("No such user was found", comment: "")
            case .samePassword:
                return NSLocalizedString("You entered the same password as before. Please come up with another one", comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
