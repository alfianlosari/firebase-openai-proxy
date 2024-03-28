//
//  AuthenticationView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//


import SwiftUI

struct AuthenticationView: View {
    
    @Binding var authState: AuthenticationState

    @State var authType = AuthenticationType.login
    
    var body: some View {
        ZStack {
            SplashScreenView(imageName: authType.assetBackgroundName)
            VStack(spacing: 32) {
                LogoTitle()
                if (!authState.isAuthenticating) {
                    AuthenticationFormView(authState: $authState, authType: $authType)
                } else {
                    ProgressView()
                }
                
            }
            .offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
        }
        
    }
    
}
