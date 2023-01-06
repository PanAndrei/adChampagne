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
    
    var body: some View {
        VStack {
            Text("tes54t".localized)
                .onTapGesture {
                    UIApplication.shared.endEditing() // for test
                }
            
            TextField("Email Adress".localized, text: $loginVM.credentials.email) // only email
                .keyboardType(.emailAddress)
            
            SecureField("Password".localized, text: $loginVM.credentials.password) // delete all // only letters and nums
                .keyboardType(.emailAddress)
            
            if loginVM.showProgressView {
                ProgressView()
            }
            
            Button("Log in".localized) {
//                loginVM.testLogin()
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginVM.loginDisabled)
            .padding(24)
            
            Button("register".localized) {
                isShowingRegisterForm.toggle()
            }
            .sheet(isPresented: $isShowingRegisterForm) {
                RegisterView()
            }
            
            Button("restore password".localized) {
                isShowingRstorePassForm.toggle()
            }
            .sheet(isPresented: $isShowingRstorePassForm) {
                RestorePasswordView()
            }
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            Alert(title: Text("invalid login".localized), message: Text(error.localizedDescription)) // to fix
        }
    }
}

struct LogingView_Previews: PreviewProvider {
    static var previews: some View {
        LogingView()
    }
}


struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authentication: Authentication
    
//    @StateObject var loginVM: LoginViewModel
    @StateObject var registerVM: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Dismiss")
            }

            
            TextField("Email Adress".localized, text: $registerVM.credentials.email) // only email
                .keyboardType(.emailAddress)
            
            SecureField("Password".localized, text: $registerVM.credentials.password) // delete all // only letters and nums
                .keyboardType(.emailAddress)
            
            if registerVM.showProgressView {
                ProgressView()
            }
            
            Button {
//                registerVM.saveUser()
                registerVM.register { success in
                    authentication.updateValidation(success: success)
                }
            } label: {
                 Text("save data")
            }
            .disabled(registerVM.saveDisabled)
            
            
            
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(registerVM.showProgressView)
        .alert(item: $registerVM.error) { error in
            Alert(title: Text("invalid login".localized), message: Text(error.localizedDescription)) // to fix
        }
    }
}

struct RestorePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var restorePassVM: RestorePasswordViewModel = RestorePasswordViewModel()
    
    var body: some View {
        VStack {
            Text("restore password".localized)
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Dismiss")
            }
            
            TextField("Email Adress".localized, text: $restorePassVM.credentials.email) // only email
                .keyboardType(.emailAddress)
            
            SecureField("Password".localized, text: $restorePassVM.credentials.password) // delete all // only letters and nums
                .keyboardType(.emailAddress)
            
            if restorePassVM.showProgressView {
                ProgressView()
            }
            
            Button {
//                registerVM.saveUser()
                restorePassVM.restorePassword()
            } label: {
                 Text("restore pass data")
            }
            .disabled(restorePassVM.restoreDisabled)
            
            if restorePassVM.passwordWasChanged {
                Text("password was changed")
            }
            
        }
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(restorePassVM.showProgressView)
        .alert(item: $restorePassVM.error) { error in
            Alert(title: Text("invalid login".localized), message: Text(error.localizedDescription)) // to fix
        }
        .onChange(of: restorePassVM.passwordWasChanged) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
