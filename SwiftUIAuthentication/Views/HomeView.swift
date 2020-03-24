//
//  HomeView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 22/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    
    @State var isLoading = false
    @State var error: NSError?
    let url = URL(string: "https://alfianlosari.com")!

    var body: some View {
        NavigationView {
            ZStack {
                WebView(url: url, isLoading: $isLoading, error: $error)
                    .opacity(!isLoading && error == nil ? 1 : 0)
                
                if self.isLoading {
                    ProgressView()
                } else if self.error != nil {
                    Text(error!.localizedDescription)
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("Xcoding with Alfian", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: signoutTapped, label: {
                Image(systemName: "person.circle")
                Text("Logout")
            }))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
    
    private func signoutTapped() {
        authState.signout()
    }
}
