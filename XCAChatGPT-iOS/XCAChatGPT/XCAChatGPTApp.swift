//
//  XCAChatGPTApp.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 01/02/23.
//

import SwiftUI

@main
struct XCAChatGPTApp: App {
    
    @State var authState = AuthenticationState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authState.loggedInUser != nil {
                    HomeView(authState: $authState)
                } else {
                    AuthenticationView(authState: $authState, authType: .login)
                }
            }
            .animation(.easeInOut)
            .transition(.move(edge: .bottom))
        }
    }
}



