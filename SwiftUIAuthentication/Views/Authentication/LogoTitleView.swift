//
//  LogoTitleView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

//

import SwiftUI

struct LogoTitle: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
            
            Text("Xcoding with Alfian")
                .font(.custom("SF-Pro", size: 30))
                .lineLimit(2)
            
            Text("Mobile Dev Articles & Tutorials")
                .font(.headline)
            
        }
        .foregroundColor(.white)
    }
}

