//
//  ContentView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 22/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthenticationState
     
     var body: some View {
         Group {
             if authState.loggedInUser != nil {
                 HomeView()
             } else {
                 AuthenticationView(authType: .login)
             }
         }
         .animation(.easeInOut)
         .transition(.move(edge: .bottom))
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
