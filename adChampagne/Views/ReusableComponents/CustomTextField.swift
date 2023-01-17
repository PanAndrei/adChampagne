//
//  CustomTextField.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 09.01.2023.
//

import SwiftUI

struct CustomTextField: View {
    let fieldName: String
    let isSecretField: Bool
    @Binding var textInformation: String
    @Binding var isEditing: Bool
    
    init(fieldName: String, isSecretField: Bool = false, editingText: Binding<String>, isEditing: Binding<Bool>) {
        self.fieldName = fieldName
        self.isSecretField = isSecretField
        self._textInformation = editingText
        self._isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldName)
                .scaleEffect((self.textInformation == "" && self.isEditing == false) ? 1 : 0.75)
                .offset(y: (self.textInformation == "" && self.isEditing == false ) ? 35 : 0)
                .animation(.spring())
            
            if isSecretField {
                SecureField("", text: $textInformation)
                    .keyboardType(.emailAddress)
            } else {
                TextField("", text: $textInformation)
                    .keyboardType(.emailAddress)
            }
            
            Divider()
        }
        .onTapGesture {
            self.isEditing.toggle()
                            if (self.isEditing == false) {
                                UIApplication.shared.endEditing()
                            }
        }
    }
}

// test
