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
    @State private var isEditingPasswird = false
    
    var body: some View {
        VStack {
            AnimatedGreetingView(text: "Login", startTime: 0.1)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading) {
                Text("Email Adress")
                    .scaleEffect((self.loginVM.credentials.email == "" && self.isEditingEmail == false) ? 1 : 0.75)
                    .offset(y: (self.loginVM.credentials.email == "" && self.isEditingEmail == false ) ? 35 : 0)
                    .animation(.spring())
                
                TextField("", text: $loginVM.credentials.email)
                    .keyboardType(.emailAddress)
                
                Divider()
            }
            .onTapGesture {
                self.isEditingEmail.toggle()
                                if (self.isEditingEmail == false) {
                                    UIApplication.shared.endEditing()
                                }
            }
            
            VStack(alignment: .leading) {
                Text("Password")
                    .scaleEffect((self.loginVM.credentials.password == "" && self.isEditingPasswird == false) ? 1 : 0.75)
                    .offset(y: (self.loginVM.credentials.password == "" && self.isEditingPasswird == false ) ? 35 : 0)
                    .animation(.spring())
                
                SecureField("", text: $loginVM.credentials.password)
                    .keyboardType(.emailAddress)
                
                Divider()
            }
            .onTapGesture {
                self.isEditingPasswird.toggle()
                                if (self.isEditingPasswird == false) {
                                    UIApplication.shared.endEditing()
                                }
            }
            
            if loginVM.showProgressView {
                ProgressView()
            }
            
            Button("Login") {
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .font(.system(size: 18, weight: .bold))
            .disabled(loginVM.loginDisabled)
            .padding(24)
            
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
        .autocapitalization(.none)
        .autocorrectionDisabled()
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            Alert(title: Text(""), message: Text(error.localizedDescription), dismissButton: .default(Text("Try again")))
        }
    }
}

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authentication: Authentication
    
    @StateObject var registerVM: RegisterViewModel = RegisterViewModel()
    
    @State private var isEditingEmail = false
    @State private var isEditingPasswird = false
    
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
                
                VStack(alignment: .leading) {
                    Text("Email Adress")
                        .scaleEffect((self.registerVM.credentials.email == "" && self.isEditingEmail == false) ? 1 : 0.75)
                        .offset(y: (self.registerVM.credentials.email == "" && self.isEditingEmail == false ) ? 35 : 0)
                        .animation(.spring())
                    
                    TextField("", text: $registerVM.credentials.email)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                }
                .onTapGesture {
                    self.isEditingEmail.toggle()
                                    if (self.isEditingEmail == false) {
                                        UIApplication.shared.endEditing()
                                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .scaleEffect((self.registerVM.credentials.password == "" && self.isEditingPasswird == false) ? 1 : 0.75)
                        .offset(y: (self.registerVM.credentials.password == "" && self.isEditingPasswird == false ) ? 35 : 0)
                        .animation(.spring())
                    
                    SecureField("", text: $registerVM.credentials.password)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                }
                .onTapGesture {
                    self.isEditingPasswird.toggle()
                                    if (self.isEditingPasswird == false) {
                                        UIApplication.shared.endEditing()
                                    }
                }
                
                if registerVM.showProgressView {
                    ProgressView()
                }
                
                Button {
                    registerVM.register { success in
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

struct RestorePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var restorePassVM: RestorePasswordViewModel = RestorePasswordViewModel()
    
    @State private var isEditingEmail = false
    @State private var isEditingPasswird = false
    
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
                
                VStack(alignment: .leading) {
                    Text("Email Adress")
                        .scaleEffect((self.restorePassVM.credentials.email == "" && self.isEditingEmail == false) ? 1 : 0.75)
                        .offset(y: (self.restorePassVM.credentials.email == "" && self.isEditingEmail == false ) ? 35 : 0)
                        .animation(.spring())
                    
                    TextField("", text: $restorePassVM.credentials.email)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                }
                .onTapGesture {
                    self.isEditingEmail.toggle()
                                    if (self.isEditingEmail == false) {
                                        UIApplication.shared.endEditing()
                                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .scaleEffect((self.restorePassVM.credentials.password == "" && self.isEditingPasswird == false) ? 1 : 0.75)
                        .offset(y: (self.restorePassVM.credentials.password == "" && self.isEditingPasswird == false ) ? 35 : 0)
                        .animation(.spring())
                    
                    SecureField("", text: $restorePassVM.credentials.password)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                }
                .onTapGesture {
                    self.isEditingPasswird.toggle()
                                    if (self.isEditingPasswird == false) {
                                        UIApplication.shared.endEditing()
                                    }
                }
                
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
