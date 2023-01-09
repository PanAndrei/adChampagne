//
//  AuthorizedView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

struct AuthorizedView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello,  \(authentication.userEmail) !")
                    .font(.system(size: 22, weight: .bold))
            }
            .navigationTitle("Main Page")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("log out") {
                        authentication.updateValidation(success: false)
                    }
                }
            }
        }
    }
}
