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
                Text("Hello, test!")
            }
            .navigationTitle("name test")
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

struct AuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizedView()
    }
}
