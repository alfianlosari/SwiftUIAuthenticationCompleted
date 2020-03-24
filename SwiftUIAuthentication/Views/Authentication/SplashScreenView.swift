//
//  SplashScreenView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {
    
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(1/1, contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}
