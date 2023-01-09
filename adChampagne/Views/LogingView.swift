//
//  LogingView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

struct LogingView: View {
    @EnvironmentObject var authentication: Authentication
    
    @StateObject var loginVM = LoginViewModel()
    @State private var isShowingRegisterForm = false
    @State private var isShowingRstorePassForm = false
    @State private var isEditingEmail = false
    @State private var isEditingPassword = false
    
    var body: some View {
        VStack {
            AnimatedGreetingView(text: "Login", startTime: 0.1)
                .padding(.bottom, 50)
            
            CustomTextField(fieldName: "Email Adress", editingText: $loginVM.credentials.email, isEditing: $isEditingEmail)
            
            CustomTextField(fieldName: "Password", isSecretField: true, editingText: $loginVM.credentials.password, isEditing: $isEditingPassword)
            
            if loginVM.showProgressView {
                ProgressView()
            }
            
            Button("Login") {
                loginVM.login { success in
                    authentication.userEmail = loginVM.credentials.email
                    authentication.updateValidation(success: success)
                }
            }
            .font(.system(size: 18, weight: .bold))
            .disabled(loginVM.loginDisabled)
            .padding(24)
            
            registrationButtons
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            Alert(title: Text(""), message: Text(error.localizedDescription), dismissButton: .default(Text("Try again")))
        }
    }
    
    private var registrationButtons: some View {
        VStack {
            Button("Don't have an account? Sign up.") {
                isShowingRegisterForm.toggle()
            }
            .sheet(isPresented: $isShowingRegisterForm) {
                RegisterView()
            }
            .padding(.top, 36)
            .foregroundColor(.pink)
            
            Button("Forgot your password?") {
                isShowingRstorePassForm.toggle()
            }
            .sheet(isPresented: $isShowingRstorePassForm) {
                RestorePasswordView()
            }
            .padding(.top, 18)
            .foregroundColor(.purple)
            .opacity(0.6)
        }
    }
}

