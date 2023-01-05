//
//  adChampagneApp.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

@main
struct adChampagneApp: App {
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                AuthorizedView() //
                    .environmentObject(authentication)
            } else {
                LogingView()
                    .environmentObject(authentication)
            }
        }
    }
}
