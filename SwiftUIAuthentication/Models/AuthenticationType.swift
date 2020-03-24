//
//  AuthenticationType.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

enum AuthenticationType: String {
    case login
    case signup
    
    var text: String {
        rawValue.capitalized
    }
    
    var assetBackgroundName: String {
        self == .login ? "login" : "signup"
    }

    var footerText: String {
        switch self {
        case .login:
            return "Not a member, signup"
            
        case .signup:
            return "Already a member? login"
        }
    }
}
