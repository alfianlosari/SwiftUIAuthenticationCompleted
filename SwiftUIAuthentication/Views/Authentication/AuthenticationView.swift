//
//  AuthenticationView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//


import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var authState: AuthenticationState

    @State var authType = AuthenticationType.login
    
    var body: some View {
        ZStack {
            SplashScreenView(imageName: authType.assetBackgroundName)
            VStack(spacing: 32) {
                LogoTitle()
                if (!authState.isAuthenticating) {
                    AuthenticationFormView(authType: $authType)
                } else {
                    ProgressView()
                }
                
                SignInAppleButton {
                    self.authState.login(with: .signInWithApple)
                }
                .frame(width: 130, height: 44)
            }
            .offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
        }
        
    }
    
}
