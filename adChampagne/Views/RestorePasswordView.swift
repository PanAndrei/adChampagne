//
//  RestorePasswordView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 09.01.2023.
//

import SwiftUI

struct RestorePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var restorePassVM: RestorePasswordViewModel = RestorePasswordViewModel()
    
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
                AnimatedGreetingView(text: "Recover Password", startTime: 0.3)
                
                CustomTextField(fieldName: "Email Adress", editingText: $restorePassVM.credentials.email, isEditing: $isEditingEmail)
                
                CustomTextField(fieldName: "Password", isSecretField: true, editingText: $restorePassVM.credentials.password, isEditing: $isEditingPassword)
                
                if restorePassVM.showProgressView {
                    ProgressView()
                }
                
                Button {
                    restorePassVM.restorePassword()
                } label: {
                     Text("Reset Password")
                }
                .disabled(restorePassVM.restoreDisabled)
                .padding(.top, 16)
                
                if restorePassVM.passwordWasChanged {
                    Text("The password has been successfully changed")
                }
                
            }
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .padding()
        .disabled(restorePassVM.showProgressView)
        .alert(item: $restorePassVM.error) { error in
            Alert(title: Text(""), message: Text(error.localizedDescription), dismissButton: .default(Text("Try again")))
        }
        .onChange(of: restorePassVM.passwordWasChanged) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

