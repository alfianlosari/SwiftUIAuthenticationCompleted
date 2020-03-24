//
//  ProgressView.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 21/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit
import SwiftUI

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.startAnimating()
    }
}
