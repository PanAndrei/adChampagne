//
//  LogingView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

struct LogingView: View {
    @EnvironmentObject var authentication: Authentication
    @StateObject private var loginVM = LoginViewModel()
    
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
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginVM.loginDisabled)
            .padding(24)
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


