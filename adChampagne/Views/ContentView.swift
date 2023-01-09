//
//  ContentView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        if authentication.isValidated {
            AuthorizedView()
                .transition(.slide)
        } else {
            LogingView()
                .transition(.slide)
        }
    }
}
