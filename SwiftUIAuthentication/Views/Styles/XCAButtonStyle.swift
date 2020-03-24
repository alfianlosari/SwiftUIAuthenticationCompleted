//
//  XCAButtonStyle.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 22/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct XCAButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 44)
            .foregroundColor(Color.white)
            .background(Color.black)
            .cornerRadius(8)
    }
}

