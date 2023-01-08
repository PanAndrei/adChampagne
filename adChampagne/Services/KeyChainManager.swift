//
//  KeyChainManager.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import Foundation

class KeyChainManager {
    func saveUser(email: String, password: String) {
        guard !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return print("Username field empty") }
        guard !password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return print("Password field empty") }
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: password.data(using: .utf8)!,
        ]
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print(attributes)
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }
    
    func updatePassword(email: String, newPassword: String) {
        guard !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return print("Username field empty") }
        guard !newPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return print("Password field empty") }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
        ]
        
        let attributes: [String: Any] = [kSecValueData as String: newPassword.data(using: .utf8)!]
        
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            print("Password has been changed")
        } else {
            print("Something went wrong trying to update the password")
        }
    }
    
    func checkIfPasswordIsValidated(email: String, enteredPassword: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            print("we are here")
            if let existingItem = item as? [String: Any],
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return password == enteredPassword
            }
            return false
        } else {
            print("Something went wrong trying to find the user in the keychain")
            return false
        }
    }
    
    func checkIfUserExists(email: String) -> Bool {
        guard !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
