//
//  RegisterView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 09.01.2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authentication: Authentication
    
    @StateObject var registerVM: RegisterViewModel = RegisterViewModel()
    
    @State private var isEditingEmail = false
    @State private var isEditingPassword = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancell")
                    }
                    
                    Spacer()
                }
                .padding(8)
                
                Spacer()
            }
            
            VStack {
                AnimatedGreetingView(text: "Sign Up", startTime: 0.3)
                
                CustomTextField(fieldName: "Email Adress", editingText: $registerVM.credentials.email, isEditing: $isEditingEmail)
                
                CustomTextField(fieldName: "Password", isSecretField: true, editingText: $registerVM.credentials.password, isEditing: $isEditingPassword)
                
                if registerVM.showProgressView {
                    ProgressView()
                }
                
                Button {
                    registerVM.register { success in
                        authentication.userEmail = registerVM.credentials.email
                        authentication.updateValidation(success: success)
                    }
                } label: {
                     Text("sign up")
                }
                .disabled(registerVM.saveDisabled)
                .padding(.top, 16)
            }
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .padding()
        .disabled(registerVM.showProgressView)
        .alert(item: $registerVM.error) { error in
            Alert(title: Text(""), message: Text(error.localizedDescription), dismissButton: .default(Text("Try again")))
        }
    }
}
